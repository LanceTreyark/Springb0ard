
TEST 2 10:40PM 10.12.25

ssh root@85.9.197.13
ssh tony@85.9.197.13



-----------------------------------------------------------
Here is the raw DKIM public key prior to reformatting for easy DNS:
---
p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsycieMbJxAQXzW4QNTaWoZAQG1uYmBSIfodvlMjWoRr17EpXEoxNZGAlFsRZ9TTJB/Dy7Niy5gNr4kGLKmSlnqkD32ybUIyvGmaP6D7pf4/nD20z8ePKWliyTOiLlVndFQq2WCxErJHf7i7KI035P1oNzTLYap8vC8E2IvZjzwEu86jIYFjSLDBip8Eur571nLb1ULZ2LyOrjLkFJhR5xDiwzGRvdO3KChuvAuSEblSp5DCM8OPPWZ7K6mReUmlC/ZiM8gDVsUt+yZDH71E9nDaPH7WNeqM1BNVmekD/rVT8rL7Q8m7ebZWSNw6BkCzWajZifgtXUdeOHMfyR8ZjFQIDAQAB
-----------------------------------------------------------

-------------------------------------------------------------------------------------
| Here are your email DNS Records:                                                  |
| TYPE.........HOST.............ANSWER................................TTL......PRIO |
| A              @               85.9.197.13                        300       N/A
| A             WWW              85.9.197.13                        300       N/A
| A             mail             85.9.197.13                        300       N/A
| MX             @               mail.vc-miami.com                  300       N/A
| TXT            @              PASTE_SPF_RECORD_HERE                300       N/A
| TXT            @              PASTE_DKIM_KEYS_HERE                 300       N/A
| TXT          _dmarc          PASTE_DMARC_RECORD_HERE               300       N/A
|------------------------------------------------------------------------------------|
|        Copy and paste this into the ANSWER field for your SPF Record:              |
|------------------------------------------------------------------------------------|
v=spf1 ip4:85.9.197.13 -all
|------------------------------------------------------------------------------------|
|         Copy and paste this into the ANSWER field for your DKIM Keys:              |
| Omit any text before 'default._domain..' sometimes there is an '-e' don't add that |
|------------------------------------------------------------------------------------|
-e default._domainkey IN TXT  ( "v=DKIM1; h=sha256; k=rsa; "
"p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsycieMbJxAQXzW4QNT"
"aWoZAQG1uYmBSIfodvlMjWoRr17EpXEoxNZGAlFsRZ9TTJB/Dy7Niy5gNr4kGLKm"
"SlnqkD32ybUIyvGmaP6D7pf4/nD20z8ePKWliyTOiLlVndFQq2WCxErJHf7i7KI0"
"35P1oNzTLYap8vC8E2IvZjzwEu86jIYFjSLDBip8Eur571nLb1ULZ2LyOrjLkFJh"
"R5xDiwzGRvdO3KChuvAuSEblSp5DCM8OPPWZ7K6mReUmlC/ZiM8gDVsUt+yZDH71"
"E9nDaPH7WNeqM1BNVmekD/rVT8rL7Q8m7ebZWSNw6BkCzWajZifgtXUdeOHMfyR8"
"ZjFQIDAQAB")
|------------------------------------------------------------------------------------|
|        Copy and paste this into the ANSWER field for your DMARC Record:            |
|------------------------------------------------------------------------------------|
v=DMARC1; p=quarantine; rua=mailto:donnie@vc-miami.com; ruf=mailto:donnie@vc-miami.com; sp=none; aspf=r; adkim=r; pct=100;
|------------------------------------------------------------------------------------|
|                                   NOTE:                                            |
|      You need to set reverse DNS (PTR) on your server's host admin portal          |
|------------------------------------------------------------------------------------|
| IP ADDRESS...............REVERSE DNS NAME.................ATTACHED TO              |
| 85.9.197.13            mail.vc-miami.com          mail.vc-miami.com
--------------------------------------------------------------------------------------



















/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

TEST 1 7PM 10.12.25


ssh root@209.94.60.200
ssh james@209.94.60.200

                                                                                                                                         
-----------------------------------------------------------
Here is the raw DKIM public key prior to reformatting for easy DNS:
---
p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2dtC7ygtfBJESxRxjTq0vqE+SzCN5mwMQ4ryTaRufmJKnI7d5Y1FRKcdfk+WF1cv9bNAc6/Z44Y7eavChwCQoTX8iyAQ6UePr7zSfXLJtatyC/EGa/izTmB3mOCLCfFgLECvjlxqp3iYnA9H7bKPKXxA96VdjKIgyK/+uykOJpvrsn/4kX1BJ1PfeCLKS4cisu6HnrIKJBWJGGcbdVg8tjEuaE4U6ITe5WCiOVHCjnPFK1mtrdAXOT+3UtWEwFw0Csgaky5m6QEwM0mlX8A0LrrD3hLm3qV9XrLNRGW1w5FSKq0dtuMKwvW8QbjwyEzcjAHZwbi62xEdHX/bJY3CgQIDAQAB
-----------------------------------------------------------

-------------------------------------------------------------------------------------
| Here are your email DNS Records:                                                  |
| TYPE.........HOST.............ANSWER................................TTL......PRIO |
| A              @               209.94.60.200                        300       N/A
| A             WWW              209.94.60.200                        300       N/A
| A             mail             209.94.60.200                        300       N/A
| MX             @               mail.sentinelxp.com                  300       N/A
| TXT            @              PASTE_SPF_RECORD_HERE                300       N/A
| TXT            @              PASTE_DKIM_KEYS_HERE                 300       N/A
| TXT          _dmarc          PASTE_DMARC_RECORD_HERE               300       N/A
|------------------------------------------------------------------------------------|
|        Copy and paste this into the ANSWER field for your SPF Record:              |
|------------------------------------------------------------------------------------|
v=spf1 ip4:209.94.60.200 -all
|------------------------------------------------------------------------------------|
|         Copy and paste this into the ANSWER field for your DKIM Keys:              |
| Omit any text before 'default._domain..' sometimes there is an '-e' don't add that |
|------------------------------------------------------------------------------------|
-e default._domainkey IN TXT  ( "v=DKIM1; h=sha256; k=rsa; "
"p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2dtC7ygtfBJESxRxjT"
"q0vqE+SzCN5mwMQ4ryTaRufmJKnI7d5Y1FRKcdfk+WF1cv9bNAc6/Z44Y7eavChw"
"CQoTX8iyAQ6UePr7zSfXLJtatyC/EGa/izTmB3mOCLCfFgLECvjlxqp3iYnA9H7b"
"KPKXxA96VdjKIgyK/+uykOJpvrsn/4kX1BJ1PfeCLKS4cisu6HnrIKJBWJGGcbdV"
"g8tjEuaE4U6ITe5WCiOVHCjnPFK1mtrdAXOT+3UtWEwFw0Csgaky5m6QEwM0mlX8"
"A0LrrD3hLm3qV9XrLNRGW1w5FSKq0dtuMKwvW8QbjwyEzcjAHZwbi62xEdHX/bJY"
"3CgQIDAQAB")
|------------------------------------------------------------------------------------|
|        Copy and paste this into the ANSWER field for your DMARC Record:            |
|------------------------------------------------------------------------------------|
v=DMARC1; p=quarantine; rua=mailto:admin@sentinelxp.com; ruf=mailto:admin@sentinelxp.com; sp=none; aspf=r; adkim=r; pct=100;
|------------------------------------------------------------------------------------|
|                                   NOTE:                                            |
|      You need to set reverse DNS (PTR) on your server's host admin portal          |
|------------------------------------------------------------------------------------|
| IP ADDRESS...............REVERSE DNS NAME.................ATTACHED TO              |
| 209.94.60.200            mail.sentinelxp.com          mail.sentinelxp.com
--------------------------------------------------------------------------------------





error :
# List of domains (maptype:mapname allowed) that this machine considers
# itself the final destination for.
mydestination = , , localhost., localhost

should be :
mydestination = $myhostname, localhost.$mydomain, localhost, sentinelxp.com












ERROR:
sed: -e expression #1, char 49: unknown option to `s'
Check the Dovecot configuration

# 2.4.1-4 (7d8c0e5759): /etc/dovecot/dovecot.conf
# Pigeonhole version 2.4.1-4 (0a86619f)
doveconf: Fatal: Error in configuration file /etc/dovecot/conf.d/20-imap.conf line 55: Garbage after '{'

Restart dovecot

Job for dovecot.service failed because the control process exited with error code.
See "systemctl status dovecot.service" and "journalctl -xeu dovecot.service" for details.

Install mailutils




This command "sudo sed -i 's|^mail_home *= *.*/.*|mail_home = /home/%{user|username}/Maildir|' /etc/dovecot/conf.d/10-mail.conf" failed to rewrite this:
mail_home = /home/%{user|username}
to this:
mail_home = /home/%{user|username}/Maildir

Cause:
The regex *.*/.* means “match any path that contains a / and another / after it.”
Your actual line (/home/%{user|username}) only has one /, so it didn’t match.

Replace w/
sudo sed -i 's|^mail_home *= */home/%{user|username}|mail_home = /home/%{user|username}/Maildir|' /etc/dovecot/conf.d/10-mail.conf
