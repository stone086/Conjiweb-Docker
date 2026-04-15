-- Web Gajim V3 - Prosody Configuration

admins = { "admin@localhost" }

modules_enabled = {
  "roster"; "saslauth"; "tls"; "dialback"; "disco";
  "carbons"; "pep"; "private"; "blocklist";
  "vcard4"; "vcard_legacy";
  "version"; "uptime"; "time"; "ping"; "mam";
  "smacks"; "csi_simple";
  "http_upload"; "http_files";
  "websocket";
  "bosh";
  "admin_adhoc";
}

allow_registration = true
c2s_require_encryption = false

storage = "internal"

archive_expires_after = "1y"

-- HTTP Upload
http_upload_file_size_limit = 104857600 -- 100 MB
http_upload_expire_after = 60 * 60 * 24 * 7 -- 1 week
http_upload_path = "/var/lib/prosody/http_uploads"

-- WebSocket
cross_domain_websocket = true
consider_websocket_secure = true

-- Logging
log = {
  info = "*console";
  warn = "*console";
  error = "*console";
}

-- Virtual Hosts
VirtualHost "localhost"
  authentication = "internal_hashed"

-- MUC Component
Component "conference.localhost" "muc"
  modules_enabled = { "muc_mam" }
  restrict_room_creation = false

-- HTTP Upload Component  
Component "upload.localhost" "http_upload"
