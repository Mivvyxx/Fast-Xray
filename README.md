# Fast-Xray

Languages   
[Русский](READMEru.md)  
[English](README.md)

Bash script that automatically install and update xray

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

After installation xray will be avalibale from PATH
```bash
xray --config /path/to/config.json
```

## Usage specifics

Xray will be installed to /usr/bin

Version check works with github versions instead of "xray version" command

You have to have "unzip" util
