#!/bin/bash
# =========================================
# Teamlid aanmaken op Oracle Linux
# Gebruik: sudo ./add_team_member.sh <username> <public_key_file> [sudo]
# =========================================
# voorbeeld:
#   sudo ./add_team_member.sh ilse /home/ubuntu/keys/ilse.pub sudo
# =========================================

TEAMGROUP="teamabinet"
SHAREDIR="/srv/${TEAMGROUP}"

# Controleer argumenten
if [ $# -lt 2 ]; then
    echo "Gebruik: $0 <gebruikersnaam> <pad_naar_public_key> [sudo]"
    exit 1
fi

USERNAME=$1
PUBKEY=$2
GIVESUDO=$3

# 1. Controleer of de groep bestaat
if ! getent group "$TEAMGROUP" >/dev/null; then
    echo "➕ Groep $TEAMGROUP bestaat nog niet, aanmaken..."
    groupadd "$TEAMGROUP"
fi

# 2. Maak gebruiker aan (als die nog niet bestaat)
if id "$USERNAME" >/dev/null 2>&1; then
    echo "⚠️  Gebruiker $USERNAME bestaat al, overslaan."
else
    echo "👤 Gebruiker $USERNAME aanmaken..."
    adduser --disabled-password --gecos "" "$USERNAME"
fi

# 3. Voeg gebruiker toe aan projectgroep
usermod -aG "$TEAMGROUP" "$USERNAME"

# 4. Maak SSH-map aan
echo "🔑 SSH configureren..."
sudo -u "$USERNAME" mkdir -p "/home/$USERNAME/.ssh"
cat "$PUBKEY" | sudo tee "/home/$USERNAME/.ssh/authorized_keys" >/dev/null
chmod 700 "/home/$USERNAME/.ssh"
chmod 600 "/home/$USERNAME/.ssh/authorized_keys"
chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.ssh"

# 5. Sudo (optioneel)
if [ "$GIVESUDO" == "sudo" ]; then
    echo "🛠️  Voeg $USERNAME toe aan sudoers..."
    usermod -aG sudo "$USERNAME"
fi

# 6. Gedeelde map voorbereiden
if [ ! -d "$SHAREDIR" ]; then
    echo "📁 Gedeelde map $SHAREDIR aanmaken..."
    mkdir -p "$SHAREDIR"
    chown ubuntu:"$TEAMGROUP" "$SHAREDIR"
    chmod 2775 "$SHAREDIR"
    chmod g+s "$SHAREDIR"
fi

# 7. Symlink in de home directory van de gebruiker
echo "🔗 Symlink naar gedeelde map maken..."
sudo -u "$USERNAME" ln -sf "$SHAREDIR" "/home/$USERNAME/$TEAMGROUP"

echo "✅ Klaar! Gebruiker $USERNAME toegevoegd aan $TEAMGROUP."
echo "   - Home: /home/$USERNAME"
echo "   - Shared: $SHAREDIR"
[ "$GIVESUDO" == "sudo" ] && echo "   - Heeft sudo-rechten."
