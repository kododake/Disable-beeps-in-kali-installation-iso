# Disable-beeps-in-kali-installation-iso
Edit the Kali Linux iso file and create an iso file with the two **beeps** that are heard during installation **disabled**.
<br>
Please install **Xorriso** beforehand.
```
$ sudo apt install xorriso
```
```
$ chmod +x kali-nobeep.sh
```

#### Usage: 

```
$ sudo ./kali-nobeep.sh "kali.iso"
```

When you finish, the iso file will be in the directory where you executed it.
