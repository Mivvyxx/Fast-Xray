# Fast-Xray

Языки   
[Русский](READMEru.md)  
[English](README.md)

Bash скрипт, который автоматически обновляет и устанавливает xray

## Install & Launch

In 1 command
```bash
curl -s https://github.com/Mivvyxx/Fast-Xray/releases/latest/download/update.sh | sudo sh
```
or
```bash
curl -O https://github.com/Mivvyxx/Fast-Xray/releases/latest/download/update.sh
chmod +x update.sh
sudo sh update.sh
```

После установки, xray будет доступен из PATH
```bash
xray --config /path/to/config.json
```

## Usage specifics

Xray будет установлен в /usr/bin

Проверка версий работает с версиями github релизов, вместо "xray version"

Вы обязаны иметь "unzip"
