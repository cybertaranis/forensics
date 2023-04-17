# phone-analysis

Evaluate "MOBILedit Forensic Express"

## Android

### Screenshot
Button Off+Volume Low

### Extract text messages and call log

Use Android application `SMS backup restore` and configure backup location in preferences

### Access FS via USB

1. Set Developper mode:
https://www.carlcare.com/global/tips-detail/how-to-enable-or-disable-developer-options-android/
Developer Option: Default enable file transfer via USB

2. File Access

Via Nautilus:
```shell
ls /run/user/1000/gvfs/
```

Via Android file transfer
```shell
mkdir ~/PHONE && aft-mtp-mount ~/PHONE
# umount ~/PHONE
```

Then use
```shell
rsync -r /run/user/1000/gvfs/mtp:host=A-gold_BV9500Plus_BV9500PEEA0029410/Espace\ de\ stockage\ interne\ partagé /data/phone
```
Disable developper mode

3. View backup

Use https://www.synctech.com.au/sms-backup-restore/view-backup/
or offline: https://mattj.io/sms-backup-reader/

TRICKS: Check the Downloads directory

## IPhone

### Perform a iPhone backup through `Finder`

TODO Clear space on MacBook

### Extract text messages and call log

- `TouchCopy` TODO Buy LICENCE
- https://pilabor.com/blog/2022/01/access-and-recover-files-from-an-iphone-on-linux/
