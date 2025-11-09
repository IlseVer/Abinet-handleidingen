# SSH-sleutel aanmaken
> ⚠️ **Belangrijk:** Deel **nooit** je *private key*!    
> Bewaar ze veilig op je eigen computer en upload ze **nooit** naar GitHub of andere platforms.


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

De publieke sleutel (`.pub`) kopieer je naar de server (meestal naar `~/.ssh/authorized_keys`).

![SSH key aanmaken](images/ssh-key-aanmaken.gif)
---

## 📂 Sleutels verplaatsen (indien nodig)

De net aangemaakte sleutels staan normaal gezien automatisch in de map **.ssh**.
Indien niet, verplaats **beide** bestanden (private en public key) naar die map:

* Windows: `C:\Users\<naam>\.ssh\`
* Linux/macOS: `~/.ssh/`

---
# Met SSH te verbinden via een config op Windows:
## ⚙️ SSH-configuratiebestand maken

---

### 🔹 **1. Open Verkenner**

Ga naar:

```
C:\Users\<jouw_naam>\.ssh
```

---
### 🔹 **2. Maak (of open) bestand `config`** (bijv. met Kladblok)

Plak dit erin (pas aan waar nodig):

```ssh
Host projectnaam
    HostName 89.168.87.161      # IP-adres van je server
    User ubuntu                 # gebruikersnaam
    Port 22
    IdentityFile C:\Users\<jouw_naam>\.ssh\id_ed25519  # pad naar je private key
    IdentitiesOnly yes

```

### 🔹 **3. Sla het bestand op als `config` in je map:**
 Sla het bestand op **zonder bestandsextensie** (dus **niet `.txt`** of iets anders)

```
C:\Users\<jouw_naam>\.ssh\config
```

---

## 🔹 **4. Open PowerShell of Git Bash**

Typ:

```bash
ssh projectnaam
```

---

# Plaats je ** publieke sleutel* in de Vault


[https://vault.vives.live/](https://vault.vives.live/)
## 🔹 **5. Klaar **

Je logt nu automatisch in met de juiste key — geen IP of `-i` meer nodig.

---


