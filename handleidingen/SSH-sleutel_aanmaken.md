# SSH-sleutel aanmaken

⚠️ **Belangrijk:** Deel **nooit** je *private key*!    

Bewaar ze veilig op je eigen computer en upload ze **nooit** naar GitHub of andere platforms.


## 1. Gebruik de terminal of PowerShell en voer uit:

```bash
ssh-keygen -t ed25519 -C "jouw_email@example.com"
```

Wil je zelf een bestandsnaam voor de key kiezen? Gebruik `-f`:

**Windows:**

```powershell
ssh-keygen -t ed25519 -C "jouw_email@example.com" -f .ssh/mijn_nieuwe_key
```

**Linux / macOS:**

Of met eigen bestandsnaam:

```bash
ssh-keygen -t ed25519 -C "jouw_email@example.com" -f ~/.ssh/mijn_nieuwe_key
```

![SSH key aanmaken](images/ssh-key-aanmaken.gif)
---

## 2. Sleutels verplaatsen (indien nodig)

De net aangemaakte sleutels staan normaal gezien automatisch in de map **.ssh**.
Indien niet, verplaats **beide** bestanden (private en public key) naar die map:

* Windows: `C:\Users\<naam>\.ssh\`
* Linux/macOS: `~/.ssh/`

---
# ⚙️ SSH-configuratiebestand maken
Een config-bestand laat je verbinden met een alias in plaats van een IP-adres of -i-optie.
---

### 🔹 **1. Ga naar de map `.ssh`**

---
### 🔹 **2. Maak (of open) bestand `config`** (bijv. met Notepad)

Plak dit erin (pas aan waar nodig):

```ssh
Host projectnaam
    HostName 89.168.87.161      # IP-adres van je server
    User ubuntu                 # gebruikersnaam
    Port 22
    IdentityFile C:\Users\<jouw_naam>\.ssh\id_ed25519  # pad naar je private key
    IdentitiesOnly yes
```
**Linux/macOS-gebruikers**: 
- pas het pad aan, bv.
```
IdentityFile ~/.ssh/id_ed25519
```
- Stel de juiste rechten in
```
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```  
  
### 🔹 **3. Sla het bestand op als `config` in je map:**
 Sla het bestand op **zonder bestandsextensie** (dus **niet `.txt`** of iets anders)

```
C:\Users\<jouw_naam>\.ssh\config
```

---

## 🔹 **4. Open PowerShell of terminal**

Typ:

```bash
ssh projectnaam
```

---

# Publieke sleutel in de Vault plaatsen

[https://vault.vives.live/](https://vault.vives.live/)

1. Open je publieke sleutel (het bestand dat eindigt op `.pub`) met een teksteditor.  
2. Kopieer de volledige inhoud.  
3. Voeg die toe in je **Vault** (bijv. als *SSH Public Key*).

Zo blijft je sleutel veilig bewaard en kun je ze later makkelijk terugvinden.


![](images/public-key.png)
## 🔹 **5. Klaar **

Je logt nu automatisch in met de juiste key — geen IP of `-i` meer nodig.

---


