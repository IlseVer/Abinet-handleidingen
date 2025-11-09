# SSH-sleutel aanmaken

## Windows (PowerShell)

Maak een nieuwe sleutel aan:

```bash
ssh-keygen -t ed25519 -C "jouw_email@example.com"
```

Wil je zelf de naam kiezen? Gebruik `-f`:

```bash
ssh-keygen -t ed25519 -C "jouw_email@example.com" -f .ssh/mijn_nieuwe_key
```

## 🐧 Linux / macOS

Nieuwe sleutel aanmaken:

```bash
ssh-keygen -t ed25519 -C "jouw_email@example.com"
```

Of met eigen bestandsnaam:

```bash
ssh-keygen -t ed25519 -C "jouw_email@example.com" -f ~/.ssh/mijn_nieuwe_key
```

💡 De publieke sleutel (`.pub`) kopieer je naar de server (meestal naar `~/.ssh/authorized_keys`).

---

## 📂 Sleutels verplaatsen (indien nodig)

De sleutels staan normaal in de map **.ssh**.
Indien niet, verplaats **beide** bestanden (private en public key) naar die map:

* Windows: `C:\Users\<naam>\.ssh\`
* Linux/macOS: `~/.ssh/`

---

## ⚙️ SSH-configuratiebestand maken

1. Open een teksteditor (bijv. Kladblok).
2. Voeg dit toe en pas aan waar nodig:

```
Host projectnaam
    Port 22
    HostName 89.168.97.161          # IP-adres van je server
    User ubuntu                     # gebruikersnaam
    IdentityFile "C:\Users\ilse_\.ssh\abinet_oracle_vm_key"  # pad naar private key
    PasswordAuthentication no
    IdentitiesOnly yes
```

3. Sla het bestand op als **config** (zonder extensie) in je `.ssh`-map.

---

Wil je dat ik dit omzet in **HTML met kleur en codeblokken**, zodat het perfect past in Odoo (kopieer/plak-klaar)?

