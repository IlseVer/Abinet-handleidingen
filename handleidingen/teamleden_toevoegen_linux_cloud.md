# Teamlid toevoegen en gedeelde projectmap instellen (handmatig)

Dit document beschrijft hoe je als **ubuntu-beheerder** teamleden toevoegt aan de server, hun SSH-sleutels instelt en toegang geeft tot de gedeelde map `/srv/<projectmap>`.

> **Als voorbeeld wordt hier gewerkt met:**
> - `teamabinet` = gedeelde map  
> - `teamabinetgroup` = gedeelde groep  
>
> **Vervang deze namen telkens door jullie eigen gekozen namen**.


---

## 1. Mappenstructuur en groep aanmaken + rechten instellen 

1. **Log in als beheerder**
   voor Oracle is dit ubuntu | voor Linode is dit root | kijk je provider na 
     
     ```bash
     ssh ubuntu@<server-ip>
     ```
  
2. **Zorg dat je de public key (.pub) van je teamlid hebt**
 
     Bijvoorbeeld: `ilse.pub`
  
3. **Maak de gedeelde groep aan**:(Eenmalig)


     ```bash
     sudo groupadd teamabinetgroup
     ```

     Alle teamleden delen dezelfde werkomgeving via `/srv/teamabinet`.
  
4. **Maak de gedeelde map aan:**(Eenmalig)
  
     ```bash
     sudo mkdir -p /srv/teamabinet
     sudo chown ubuntu:teamabinetgroup /srv/teamabinet
     sudo chmod 2775 /srv/teamabinet
     sudo chmod g+s /srv/teamabinet
     ```
  
     > Nieuwe bestanden erven automatisch de groep `teamabinetgroup`.
  

---

## 2. Gebruiker toevoegen

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

## 3. SSH-toegang instellen

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

## 4. Gedeelde map koppelen

1. **Maak een snelkoppeling(symlink) in de home directory**
  
     ```bash
     sudo -u ilse ln -s /srv/teamabinet /home/ilse/teamabinet
     ```
  
2. **Controleer de rechten**
  
     ```bash
     ls -ld /srv/teamabinet
     ```
     De map moet de volgende permissiestructuur hebben:
      ```bash
     drwxrwsr-x 3 ubuntu teamabinetgroup 4096 Nov  9 16:45 /srv/teamabinet
     ```
---

## 5. Controle & test
Log eerst uit als beheerder en log nu in met je eigen naam

1. **Test SSH-login**
  
     ```bash
     ssh ilse@<server-ip>
     ```

     Gebruik voor de **eerste login** het wachtwoord dat je van de beheerder hebt ontvangen.

   Wijzig daarna je wachtwoord en bewaar het veilig in de **Vault**. **Niet vergeten!**
   
   (laat daar eventueel een sterk wachtwoord genereren).

   Het wachtwoord wijzigen doe je met:

    ```bash
     passwd ilse
     ```
   
3. **Controleer groepslidmaatschap**
  
     ```bash
     id ilse
     ```
  
4. **Controleer gedeelde map**
  
     ```bash
     sudo -u ilse ls /srv/teamabinet
     ```
  


**Pas als dit alles werkt --> ga verder**

---
## 6. Zet root-login via SSH uit (aanbevolen)

1. **Open SSH-configuratie:**
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```

2. **Zoek:**
   ```nginx
   PermitRootLogin yes
   ```

3. **Wijzig naar:**
   ```nginx
   PermitRootLogin no
   ```

4. **Zorg ook dat deze aan staat (default is goed):**
   ```nginx
   PasswordAuthentication no
   ```

5. **Sla op en herstart SSH:**
   ```bash
   sudo systemctl restart ssh
   ```

## 7. Controleer dat login werkt

   Sluit je sessie en probeer opnieuw:
   ```bash
   ssh ilse@<server-ip>
   ```

**Als dat werkt: je server is correct ingesteld.**

---


