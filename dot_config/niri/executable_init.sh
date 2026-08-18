#!/bin/bash

DOTFILES_DIR="/media/Vault/Dotfiles"
NIRI_CONFIG_DIR="$HOME/.config/niri"
NOCTALIA_CONFIG_DIR="$HOME/.config/noctalia"
SCHEMA_DEST="$HOME/.local/share/glib-2.0/schemas"

echo "🚀 Starting Niri/Noctalia initialization..."

# 1. Ensure Local Directories Exist
mkdir -p "$SCHEMA_DEST"
mkdir -p "$HOME/.config"

# 2. Restore Symlinks (if they don't exist)
if [ ! -L "$NIRI_CONFIG_DIR" ]; then
  echo "🔗 Symlinking Niri config..."
  ln -sf "$DOTFILES_DIR/Niri" "$NIRI_CONFIG_DIR"
fi

if [ ! -L "$NOCTALIA_CONFIG_DIR" ]; then
  echo "🔗 Symlinking Noctalia config..."
  ln -sf "$DOTFILES_DIR/Noctalia/" "$NOCTALIA_CONFIG_DIR"
fi

# 3. Restore GSettings Schema
echo "📄 Restoring GSettings schema..."
ln -sf "$NIRI_CONFIG_DIR/schemas/org.freedesktop.appearance.gschema.xml" "$SCHEMA_DEST/"
glib-compile-schemas "$SCHEMA_DEST"

# 4. Ensure Scripts are Executable
chmod +x "$NIRI_CONFIG_DIR/sync-dark-mode.sh"

# 5. Setup KWallet Secret Service Alias
echo "🔐 Setting up KWallet Secret Service alias..."
DBUS_SERVICE_DIR="$HOME/.config/dbus-1/services"
mkdir -p "$DBUS_SERVICE_DIR"
cat > "$DBUS_SERVICE_DIR/org.freedesktop.secrets.service" <<EOF
[D-BUS Service]
Name=org.freedesktop.secrets
Exec=/usr/bin/ksecretd
EOF

echo "ℹ️ Note: Session variables (XDG_CURRENT_DESKTOP, GSETTINGS_SCHEMA_DIR) are managed in niri/cfg/misc.kdl."
echo "✅ Initialization complete! Please restart your shell or log out/in."
