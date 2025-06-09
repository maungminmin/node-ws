# Install

> **Notice：** Remember to change the `yourdomain` Change to your real domain name

```bash 
curl -Ls https://raw.githubusercontent.com/frankiejun/node-ws/refs/heads/main/setup.sh > setup.sh && chmod +x setup.sh && ./setup.sh yourdomain
```

> webhostmost Currently only manual uploads are possible index.js, package.json, cron.sh Then the panel starts! 

### View the node 
https://yourdomain/youruuid

### About keeping alive 
By default, Nezha and nodes are automatically kept alive (webhostmost keeps Nezha alive and keeps nodes alive to a certain extent), and no special processing is required on your part. 

 # Node-ws Description
Toys and containers for node environment, based on node third-party ws library, integrated with Nezha probe service, you can add environment variables by yourself
* Environment variables set by PaaS platform
| Variable name | Required | Default value | Remarks |
| ------------ | ------ | ------ | ------ |
| UUID | No |de04add9-5c68-6bab-950c-08cd5320df33| Nezha v1 is enabled, please modify UUID|
| PORT | No | 3000 | Listening port |
| NEZHA_SERVER | No | | Nezha v1 fill-in form: nz.abc.com:8008 Nezha v0 fill-in form: nz.abc.com|
| NEZHA_PORT | No | | Nezha v1 does not have this variable, v0 agent port| 
| NEZHA_KEY | No | |  NZ_CLIENT_SECRET of Nezha v1 or agent port of v0 |
| NAME | No | | Node name prefix, for example: Glitch |
| DOMAIN | Yes | | Domain name assigned by the project or reversed domain name, excluding https:// prefix |
| AUTO_ACCESS | No | true | Whether to enable automatic access to keep alive, false is off, true is on, and DOMAIN variable must be filled in at the same time |

* js obfuscator address: https://obfuscator.io 

[![Powered by DartNode](https://dartnode.com/branding/DN-Open-Source-sm.png)](https://dartnode.com "Powered by DartNode - Free VPS for Open Source")
