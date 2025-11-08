# 🧩 Stappenplan: Nieuwe teamleden toevoegen op Oracle Linux (handmatig)

Dit document beschrijft hoe je als **ubuntu-beheerder** teamleden toevoegt aan de server, hun SSH-sleutels instelt en toegang geeft tot de gedeelde map `/srv/teamabinet`.
Of gebruik het script: [add_team_member.sh](/scripts/add_team_member.sh)

---

## ⚙️ Voorbereiding

1. **Log in als beheerder**
  
  ```bash
  ssh ubuntu@<server-ip>
  ```
  
2. **Zorg dat je de public key (.pub) van je teamlid hebt**
  Bijvoorbeeld: `ilse.pub`
  
3. **Maak de gedeelde groep aan**:(Eenmalig)
  
  ```bash
  sudo groupadd teamabinet
  ```
  
4. **Maak de gedeelde map aan:**(Eenmalig)
  
  ```bash
  sudo mkdir -p /srv/teamabinet
  sudo chown ubuntu:teamabinet /srv/teamabinet
  sudo chmod 2775 /srv/teamabinet
  sudo chmod g+s /srv/teamabinet
  ```
  
  ➕ Nieuwe bestanden erven automatisch de groep `teamabinet`.
  

---

## 👤 Gebruiker toevoegen

1. **Maak de gebruiker aan**
  
  ```bash
  sudo adduser ilse
  ```
  
2. **Voeg de gebruiker toe aan de gedeelde groep**
  
  ```bash
  sudo usermod -aG teamabinet ilse
  ```
  
3. **(Optioneel)** Geef sudo-rechten als de gebruiker beheerder is
  
  ```bash
  sudo usermod -aG sudo ilse
  ```
  

---

## 🔑 SSH-toegang instellen

1. **Maak SSH-map aan**
  
  ```bash
  sudo mkdir -p /home/ilse/.ssh
  ```
  
2. **Voeg public key toe**
  
  ```bash
  sudo nano /home/ilse/.ssh/authorized_keys
  ```
  
  ➕ Plak de inhoud van de `.pub` file (één regel).
  
3. **Zet juiste rechten**
  
  ```bash
  sudo chmod 700 /home/ilse/.ssh
  sudo chmod 600 /home/ilse/.ssh/authorized_keys
  sudo chown -R ilse:ilse /home/ilse/.ssh
  ```
  

---

## 📂 Gedeelde map koppelen

1. **Maak een snelkoppeling in de home directory**
  
  ```bash
  sudo -u ilse ln -s /srv/teamabinet /home/ilse/teamabinet
  ```
  
2. **Controleer de rechten**
  
  ```bash
  ls -ld /srv/teamabinet
  ```
  

---

## 🔍 Controle & test

1. **Controleer groepslidmaatschap**
  
  ```bash
  id ilse
  ```
  
2. **Controleer gedeelde map**
  
  ```bash
  sudo -u ilse ls /srv/teamabinet
  ```
  
3. **Test SSH-login**
  
  ```bash
  ssh ilse@<server-ip>
  ```
  

---

## ✅ Samenvatting

| Stap | Doel | Belangrijkste commando’s |
| --- | --- | --- |
| Voorbereiding | Groep + map aanmaken | `groupadd`, `mkdir`, `chmod` |
| Gebruiker aanmaken | Nieuw account | `adduser`, `usermod -aG teamabinet` |
| SSH instellen | Public key toevoegen | `mkdir .ssh`, `nano authorized_keys` |
| Permissies zetten | Toegang beveiligen | `chmod 700/600`, `chown` |
| Symlink maken | Gemak voor gebruiker | `ln -s /srv/teamabinet` |
| Testen | Alles controleren | `id`, `ssh`, `ls` |

---

© Projectteam Abinetinfra
