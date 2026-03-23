
Annesque email is an email client and a customer relationship management (CRM) suite. It is built on the annesque framework, which is a collection of ruby-on-rails engines, react apps, and certain other components.

The email client allows advanced functionality for a sophisticated email user. Filters, reminders, templates, as well as an AI capability.

The suite integrates with gmail, allowing you to check your mailbox less, and receive less spam. Check out our tutorials and common use cases.

See the full list of features: https://annesque-email.wasyaco.com/features?utm_campaign=github

Since email data is very sensitive, we recommend users to setup their instances of annesque crm on-premises, on their own hardware. This allows you to fully control your data, and not give it away to any provider.

Having said that, Wasya Co offers ruby hosting for our apps. We can host the Annesque suite for you, and take care of all configuration requirements. This option is especially appropriate for users who anticipate filing feature requests. We will develop features according to your specification, and deploy them on your instance.

You can rent a cloud-hosted instance of annesque suite with our hosting plan - we offer production-grade deployments starting at $35/mo. See our hosting plans: https://wasyaco.com/hosting?utm_campaign=github


# Build (optional)

Build the docker image:

```
  docker build . -f Dockerfile-ruby275    -t piousbox/ruby275-nginx:0.0.16
  docker push piousbox/ruby275:0.0.16
```

# Setup

We assume that we're running on Ubuntu all around. And our development machines are mac os x, where instead of `apt` we use `brew`.

## Ansible Setup

You can skip this section if you install docker and nginx on your server manually. Move on to Production-grade setup.

We provide an ansible "shortcut" to setup the "bare-metal" server. This method is actually more complicated than doing it manually, but it uses basic infrastructure-as-code automation, so it may be worth the effort for some users.

The repo containing ansible code is the same one, and you would clone it on your development machine rather than the (presumably empty) Ubuntu 22 or 24 remote server.

```
  git clone git@github.com:wasya-co/annesque_email.git
```

Ansible runs on python so installing python locally is required. On a mac os x development laptop, we recommend this method that allows multiple python versions: https://wasyaco.com/blog/install-python

Next, you would install ansible:

```
  brew install ansible
```

Next, let's wire your server config. This involves an ssh key and an ip.

_TODO

We play it safe and for a domain like annesque-demo.wasyaco.com we would write <my-host> as `annesque_demo_wasyaco_com`. It is consistent and non-surprizing.

Define your host as so:

```
## inventory.yml
---
ubuntu:
  hosts:
    <my-host>:
      ansible_host: 165.22.174.124
      ansible_user: root
      ansible_ssh_private_key_file: ~/.ssh/mac_id_rsa_2np
```

And define your app as so:

```
## vars/<my-host>.yml
---
app_port: 9002
appliance_slug: annesque_demo_wasyaco_com
origin: annesque-demo.wasyaco.com
```

Now you can run some playbooks to set it up. Run this in order:

```
   ansible-playbook -i inventory.yml --limit <my-host> playbooks/setup-ubuntu.yml
   ansible-playbook -i inventory.yml --limit <my-host> playbooks/install-docker.yml
   ansible-playbook -i inventory.yml --limit <my-host> playbooks/hosted-packagedapp.yml --extra-vars "@vars/<my-host>.yml"
```


## Production-grade setup

We'll still use docker for this one. You can run the application without docker - although that's an advanced topic and if you need it, you probably know how to do it already.

- install docker, nginx.

You can do it yourself pretty easily:

```
  apt install -y docker nginx
```

- clone the repo and run it:

```
  git clone ...
  docker compose up
```

This exposes the application on port 9002 by default. Then,

- setup nginx virtual site

For example:

```
## /etc/nginx/sites-available/<my-host>.conf
server {
  listen 443 ssl;
  server_name <my-host> ;
  include /etc/nginx/conf.d/proxy_headers.conf ;

  location / {
    proxy_pass http://127.0.0.1:9002/;
  }
    ssl_certificate /etc/letsencrypt/live/www-email.wasyaco.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/www-email.wasyaco.com/privkey.pem;
}
```

If everything worked well, the client should not be available at <my-host> domain.

In production, you may want to (1) schedule automatic ssl renewal, (2) backups, and (3) uptime monitoring.


## Development-grade setup

The development-grade setup is suitable for individuals who expect to contribute to the development of the application. It is a more complex setup than the production version.

