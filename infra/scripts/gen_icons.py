#!/usr/bin/env python3
"""
Generate PWA icons for Conjiweb.
Run: python3 infra/scripts/gen_icons.py
Requires: Pillow (pip install Pillow)
"""
import sys
try:
    from PIL import Image, ImageDraw, ImageFont
except ImportError:
    print("Install Pillow: pip install Pillow")
    sys.exit(1)

import os

OUTPUT_DIR = os.path.join(os.path.dirname(__file__), "../../apps/web/public")
os.makedirs(OUTPUT_DIR, exist_ok=True)

BG_COLOR = (124, 106, 247)      # accent purple
TEXT_COLOR = (255, 255, 255)


def make_icon(size: int, filename: str):
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    # Rounded rect background
    radius = size // 6
    draw.rounded_rectangle([0, 0, size - 1, size - 1], radius=radius, fill=BG_COLOR)

    # Text "W3"
    font_size = size // 3
    try:
        font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", font_size)
    except Exception:
        font = ImageFont.load_default()

    text = "W3"
    bbox = draw.textbbox((0, 0), text, font=font)
    tw = bbox[2] - bbox[0]
    th = bbox[3] - bbox[1]
    x = (size - tw) // 2
    y = (size - th) // 2
    draw.text((x, y), text, fill=TEXT_COLOR, font=font)

    path = os.path.join(OUTPUT_DIR, filename)
    img.save(path, "PNG")
    print(f"  Created: {path}")


if __name__ == "__main__":
    print("Generating PWA icons...")
    make_icon(192, "icon-192.png")
    make_icon(512, "icon-512.png")
    make_icon(180, "apple-touch-icon.png")
    make_icon(32,  "favicon.png")
    print("Done.")
