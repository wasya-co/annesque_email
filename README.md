
Annesque email is an email client and a customer relationship management (CRM) suite. It is built on the annesque framework, which is a collection of ruby-on-rails engines, react apps, and certain other components.

<p align="center">
  <img src="images/marble-hero-4.600x153.jpg" alt="Annesque Hero" width="600">
</p>

The email client allows advanced functionality for a sophisticated email user. Filters, reminders, templates, as well as an AI capability.

The suite integrates with gmail, allowing you to check your mailbox less, and receive less spam. Check out our tutorials and common use cases.

<p align="center">
  <img src="images/leads-0w.600x377.jpg" alt="Annesque Leads" width="600">
</p>

See the full list of features: [annesque-email.wasyaco.com/features](https://annesque-email.wasyaco.com/features?utm_campaign=github)

Since email data is highly sensitive, we recommend users to setup their instances of annesque crm on-premises, on their own hardware. This allows you to fully control your data, and not give it away to any provider.

Having said that, Wasya Co offers ruby hosting for our apps. We can host the Annesque suite for you, and take care of all configuration requirements. This option is especially appropriate for users who anticipate filing feature requests. We will develop features according to your specification, and deploy them on your instance.

You can rent a cloud-hosted instance of annesque suite with our hosting plan - we offer production-grade deployments starting at $35/mo. See our hosting plans: [wasyaco.com/hosting](https://wasyaco.com/hosting?utm_campaign=github)

Note: If you *are* using the instructions and they are unclear, drop us a line and we'll be happy to work with you to update the instructions.

System Requirements: we find that it works on a 2Gb of RAM under light load.

# Build (optional)

Build the docker image:

```
  docker build . -f Dockerfile-ruby275    -t piousbox/ruby275-nginx:0.0.16
  docker push piousbox/ruby275-nginx:0.0.16
```

# Install

We assume that we're running on Ubuntu all around. And our development machines are mac os x, where instead of `apt` we use `brew`.

## Ansible Setup

You can skip this section and move on to Production-Grade Application Install if you install docker and nginx on your server manually.

We provide an ansible "shortcut" to setup the "bare-metal" server. This method is actually more complicated than doing it manually, but it uses basic infrastructure-as-code automation, so it may be worth the effort for some users.

The repo containing ansible code is the same one, and you would clone it on your development machine rather than the (presumably empty) Ubuntu 22 or 24 remote server.

```
  git clone git@github.com:wasya-co/annesque_email.git
```

Ansible runs on python so installing python locally is required. On a mac os x development laptop, we recommend this method that allows multiple python versions: [wasyaco.com/blog/install-python](https://wasyaco.com/blog/install-python?utm_campaign=github)

Install ansible:

```
  pip install ansible
```

Now, let's wire your server config. This involves an ssh key and an ip.

```
  cp inventory.yml-example inventory.yml
```

Modify the inventory file to point at your remote server, and reference the right ssh key.

A note on naming. We play it safe and for a domain like annesque-demo.wasyaco.com we would write <my-host> as `annesque_demo_wasyaco_com`. It is consistent and non-surprizing. You may be more consistent replacing only dots with underscores and write your slugs as e.g. annesque-demo_wasyaco_com, however, we've found that to be error-prone.

Next, define your app variables in the vars file:

```
  cp vars/example-site.yml vars/my-host.yml
```

Now you can run some playbooks to set up your remote server. Run this in order:

```
  ansible-playbook -i inventory.yml --limit $myhost playbooks/setup-ubuntu.yml
  ansible-playbook -i inventory.yml --limit $myhost playbooks/install-docker.yml
  ansible-playbook -i inventory.yml --limit $myhost playbooks/prepare-postal.yml
  ansible-playbook -i inventory.yml --limit $myhost playbooks/setup-proxy-vsite.yml --extra-vars "@vars/$myhost.yml"
```


## Production-Grade Application Install

If you were following along, by now the load balancer aka proxy has been setup, and we can focus on installing the actual application. We'll still use docker for this one. You can run the application without docker - although that's an advanced topic and if you need it, you probably know how to do it already. Feel free to reach out if you need these specific instructions.

Clone the repo and run it:

```
  ## on your remote server:
  mkdir -p /opt/projects ; cd /opt/projects
  git clone git@github.com:wasya-co/annesque_email.git
  cd annesque_email
  docker compose up -d
```

This brings up several services:
* application
* redis
* mongo
* localstack

The application is exposed on port 9002 by default.

If everything worked well, the client should not be available at your domain, as specified in vars/$myhost.yml .


<p align="center">
  <img src="images/login-0w.600x377.jpg" alt="Annesque Leads" width="600">
</p>

## Postal Install

We use [Postal](https://docs.postalserver.io/) for email sending and receiving. You can refer to their own documentation for more details.

If you used our ansible scripts above, all you have to do is run:
```
  postal bootstrap postal.yourdomain.com
```

If not - the setup instructions for postal are as follows.

Postal requires a few packages:
```
  apt install -y git curl jq
```

Get the postal installer:
```
  git clone https://github.com/postalserver/install /opt/postal/install
  sudo ln -s /opt/postal/install/bin/postal /usr/bin/postal
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

Finally, install postal:
```
  postal bootstrap postal.yourdomain.com
  ## review and change values in /opt/postal/config/postal.yml
  postal initialize
  postal make-user
  postal start
  postal status
```

And run Caddy:
```
docker run -d \
   --name postal-caddy \
   --restart always \
   --network host \
   -v /opt/postal/config/Caddyfile:/etc/caddy/Caddyfile \
   -v /opt/postal/caddy-data:/data \
   caddy
```



## DNS Records

To work properly, you'll need to configure a number of DNS records for your Postal installation. We assume ipv4 only, and the ip address of the host is `192.168.1.3`.

### A Records

This one is required:

| Type | Hostname               | Value       |
|------|------------------------|-------------|
| A    | postal.your-domain.com | 192.168.1.3 |

These are optional as they are an 'alternative' to an MX record pointing to `postal.your-domain.com`. Make sure that the values in `postal.yml` match: do you have `mx` or `mx1`? I encourage skipping these to reduce complexity.

| Type | Hostname                   | Value       |
|------|----------------------------|-------------|
| A    | mx1.postal.your-domain.com | 192.168.1.3 |
| A    | mx2.postal.your-domain.com | 192.168.1.3 |

### SPF Record

You can configure a global SPF record for your mail server which means domains don't need to each individually reference your server IPs.

You may wish to replace `~all` with `-all` to make the SPF record stricter.

| Type | Hostname                   | Value       |
|------|----------------------------|-------------|
| TXT  | @                          | v=spf1 ip4:192.168.1.3 ~all |

Either the above (preferred), or this:

| Type | Hostname                   | Value       |
|------|----------------------------|-------------|
| TXT  | spf.postal.your-domain.com | v=spf1 ip4:192.168.1.3 ~all |

Or:

| Type | Hostname                   | Value       |
|------|----------------------------|-------------|
| TXT  | @                          | v=spf1 a mx include:spf.postal.your-domain.com ~all |




### Return path

The return path domain is the default domain that is used as the `MAIL FROM` for all messages sent through a mail server. You should add DNS records as below.

| Type | Hostname                   | Value       |
|------|----------------------------|-------------|
| A    | rp.postal.your-domain.com  | 192.168.1.3 |
| MX   | rp.postal.your-domain.com  | 192.168.1.3 |
| TXT  | rp.postal.your-domain.com  | v=spf1 a mx include:spf.postal.your-domain.com ~all |
| TXT  | postal._domainkey.rp.postal.your-domain.com  | value from `postal default-dkim-record` |

The postal UI will give you the exact value for the DKIM record.

### Route domain

If you wish to receive incoming e-mail by forwarding messages directly to routes in Postal, you'll need to configure a domain for this just to point to your server using an MX record. I think this is optional.

| Type | Hostname                      | Value       |
|------|-------------------------------|-------------|
| MX   | routes.postal.your-domain.com | 10 postal.your-domain.com |

### Click and Open Tracking

If you would like to make use of Click and Open Tracking then you should set up these records however you also need to make changes to not show an error page to them. You can read more on the [Click & Open Tracking page](https://docs.postalserver.io/features/click-and-open-tracking). This is optional.

| Type | Hostname                      | Value       |
|------|-------------------------------|-------------|
| A    | track.postal.your-domain.com  | 192.168.1.3 |


### Example Postal Configuration

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

Actually when you click "add somain" in postal, it gives you the same instructions.


## Further Steps

In production, you may want to (1) schedule automatic ssl renewal, (2) backups, and (3) uptime monitoring.

In production, you may want to substitute localstack s3 with actual aws s3 storage.

## Development-Grade Setup

The development-grade setup is suitable for individuals who expect to contribute to the development of the application. It is a more complex setup than the one for production.

