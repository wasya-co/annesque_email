
## DNS Records

To work properly, you'll need to configure a number of DNS records for your Postal installation. We assume ipv4 only, and the ip address of the host is `192.168.1.3`.

When you click "add somain" in postal, it gives you the same instructions.

### A Record(s) (ok)

This one is required:

| Type | Hostname                  | Value       |
|------|---------------------------|-------------|
| A    | postal.your-domain.com    | 192.168.1.3 |
| A    | mx.postal.your-domain.com | 192.168.1.3 |

### SPF Record (ok)

You can configure a global SPF record for your mail server which means domains don't need to each individually reference your server IPs.

You may wish to replace `~all` with `-all` to make the SPF record stricter.

| Type | Hostname                   | Value       |
|------|----------------------------|-------------|
| TXT  | @                          | v=spf1 a mx include:spf.postal.your-domain.com ~all |


### DKIM Record (ok)

The postal setup process will tell you the record to insert, for example:

| Type | Hostname                   | Value       |
|------|----------------------------|-------------|
| TXT  | postal-ILNsdN._domainkey   | v=DKIM1; t=s; h=sha256; p=MIG...QAB; |

### Return path (ok)

The return path domain is the default domain that is used as the `MAIL FROM` for all messages sent through a mail server.

| Type  | Hostname                   | Value       |
|-------|----------------------------|-------------|
| CNAME | psrp                       | rp.postal.your-domain.com |


### MX record(s) (ok)

If you wish to receive incoming e-mail for this domain, you need to add the following MX records to the domain. You don't have to do this and we'll only tell you if they're set up or not. Both records should be priority 10.

| Type  | Hostname                   | Value       |
|-------|----------------------------|-------------|
| MX    | @                          | mx.postal.annesque.com |


### Click and Open Tracking (ok)

If you would like to make use of Click and Open Tracking then you should set up these records however you also need to make changes to not show an error page to them. You can read more on the [Click & Open Tracking page](https://docs.postalserver.io/features/click-and-open-tracking). This is optional.

| Type  | Hostname      | Value       |
|-------|---------------|-------------|
| CNAME | click         | track.postal.your-domain.com |


### Example Postal Configuration (ok)

In your `postal.yml` you should have something that looks like the below to cover the key DNS records.
```
dns:
  mx_records:
    - mx1.postal.example.com
    - mx2.postal.example.com
  spf_include: spf.postal.example.com
  return_path_domain: rp.postal.example.com
  route_domain: routes.postal.example.com
  track_domain: track.postal.example.com
```



Back to [../README.md](README).

