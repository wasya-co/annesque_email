
## Postal Install

We use [https://docs.postalserver.io/](Postal Server) for email sending and receiving. You can refer to their own documentation for more details.


This was done by ansible:
```
  apt install -y git curl jq
  ln -s /opt/projects/annesque_email/bin/postal /usr/bin/postal
```

MariaDB is included in our own docker-compose.yml, but you can bring it up separately:
```
docker run -d \
   --name postal-mariadb \
   -p 127.0.0.1:3306:3306 \
   --restart always \
   -e MARIADB_DATABASE=postal \
   -e MARIADB_ROOT_PASSWORD=postal \
   mariadb
```

Be sure to choose a secure password. You'll need to put this in your Postal configuration when you install it so be sure to make a (secure) note of it.

Now you can run:

```
  ## this was done, although needs to re-create encryption keys
  # postal bootstrap postal.yourdomain.com /opt/projects/ansible_email/config/postal
  ## openssl genrsa -out $output_path/signing.key 1024
  ## chmod 644 $output_path/signing.key

```

review and change values in /opt/projects/ansible_email/config/postal/postal.yml

```
  ## not used. this assumes their own docker.
  postal initialize
  postal make-user
  postal start
  postal status

  ## I guess I only need this:
  dc run --rm postal_runner postal initialize
  dc run --rm postal_runner postal make-user

```

And run Caddy:

```
## not used. use nginx.
docker run -d \
   --name postal-caddy \
   --restart always \
   --network host \
   -v /opt/projects/annesque_email/config/postal/Caddyfile:/etc/caddy/Caddyfile \
   -v /opt/projects/annesque_email/volumes/caddy-data:/data \
   caddy
```

= Connect Postal to App =

An HTTP Endpoint must be added to Postal to communicate with the app.

* http://localhost:9002/email/api/messages/from-postal/${POSTAL_API_KEY}

_TODO: The app also needs Postal's SMTP credentials.


* See also [setup_dns.md](setup DNS).
* Back to [Reqdme.md](Table of Contents).
* Back to [../README.md](Main Readme).
