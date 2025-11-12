# Teamlid toevoegen en gedeelde projectmap instellen (handmatig)

Dit document beschrijft hoe je als **ubuntu-beheerder** teamleden toevoegt aan de server, hun SSH-sleutels instelt en toegang geeft tot de gedeelde map `/srv/<projectmap>`.
Of gebruik het script: [add_team_member.sh](/scripts/add_team_member.sh)

> **Als voorbeeld wordt hier gewerkt met:**
> - `teamabinet` = gedeelde map  
> - `teamabinetgroup` = gedeelde groep  
>
> **Vervang deze namen telkens door jullie eigen gekozen namen**.


---

## Mappenstructuur en groep aanmaken + rechten instellen

1. **Log in als beheerder**
   voor Oracle is dit ubuntu | voor Linode is dit root | kijk je provider na 
     
     ```bash
     ssh ubuntu@<server-ip>
     ```
  
2. **Zorg dat je de public key (.pub) van je teamlid hebt**
 
     Bijvoorbeeld: `ilse.pub`
  
3. **Maak de gedeelde groep aan**:(Eenmalig)

   Alle teamleden delen dezelfde werkomgeving via `/srv/teamabinet`.

     ```bash
     sudo groupadd teamabinetgroup
     ```
  
4. **Maak de gedeelde map aan:**(Eenmalig)
  
     ```bash
     sudo mkdir -p /srv/teamabinet
     sudo chown ubuntu:teamabinetgroup /srv/teamabinet
     sudo chmod 2775 /srv/teamabinet
     sudo chmod g+s /srv/teamabinet
     ```
  
     > Nieuwe bestanden erven automatisch de groep `teamabinetgroup`.
  

---

## Gebruiker toevoegen

1. **Maak de gebruiker aan**
  
     ```bash
     sudo adduser ilse
     ```
  
2. **Gebruiker toevoegen aan teamgroep**

      Voeg het teamlid toe aan de gedeelde groep `teamabinet`:
     
     ```bash
     sudo usermod -aG teamabinet ilse
     ```
  
4. **(Optioneel)** Geef enkel aan beheerders sudo-rechten:
  
     ```bash
     sudo usermod -aG sudo ilse
     ```
  

---

## SSH-toegang instellen

1. **Maak de SSH-map aan indien nog niet aanwezig**
  
  ```bash
  sudo mkdir -p /home/ilse/.ssh
  ```
  
2. **Voeg de public key toe**
  
  ```bash
  sudo nano /home/ilse/.ssh/authorized_keys
  ```
  
  -  Open het `.pub`-bestand met een **teksteditor**.  
   Kopieer de volledige regel (die begint met `ssh-ed25519` of `ssh-rsa`) en plak die in het geopende bestand(één regel).
   
  -  Sla daarna op en sluit bestand.

  
3. **Stel de juiste rechten in!**
  
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

