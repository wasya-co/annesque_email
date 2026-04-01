
## Ansible Setup

You can skip this section and move on to Production-Grade Application Install if you install docker and nginx on your server manually.

We provide an ansible "shortcut" to setup the "bare-metal" server. This method is actually more complicated than doing it manually, but it uses basic infrastructure-as-code automation, so it may be worth the effort for some users.

The repo containing ansible code is the same one, and you would clone it on your development machine rather than the (presumably empty) Ubuntu 22 or 24 remote server.

```
  git clone git@github.com:wasya-co/annesque_email.git
```

Ansible runs on python so installing python locally is required. On a mac os x development laptop, we recommend this method that allows multiple python versions: [https://wasyaco.com/blog/install-python?utm_campaign=github](wasyaco.com/blog/install-python)

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

* Back to [Readme.md](Table of Contents).
* Back to [../Readme.md](Main Readme).

