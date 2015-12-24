---
title: SMTP Settings
---

# {{ page.title }}

This article is just to point out how to change settings in yous siwapp's messaging system. Whereto, and howto.

This is going to be raw, dirty & quick.

## Where

The file is `/<your sf_root_dir>/apps/siwapp/config/factories.yml`.

inside the file, locate the __mailer__ subsection. it should be under both __prod__ and __dev__ section:

```
prod:
  logger:
    ......
    ......

  mailer:         ### <-- THIS IS IT! WHEN IN 'PRODUCTION' ENVIRONMENT.
    param:
      delivery_strategy: realtime

cli:
  .....
  .....

dev:
  mailer:                                  ### <-- THIS IS IT! WHEN IN 'DEVELOPMENT' ENVIROMENT.
    param:
      delivery_strategy: single_address
      delivery_address:  havetnet@gmail.com
```

Please note that __indentation is important__, these kind of config files need it badly.

As you can see, you can find 'mailer' configuration info in two sections:

  - `prod:`: this is the _production_ mode. This is the mode used when you run siwapp without debug information. Tipically, the urls, in this mode are `http://your.server.name/yoursubdomain/dashboard` or `http://your.server.name/index.php/dashboard`
  - `dev:`: this is the _development_ mode. This is used when developing and debug is activated in this. Typically , the urls in this mode looks like `http://your.server.name/yoursubdomain/siwapp_dev.php/dashboard`


When you change the `mailer:` settings in the production mode, __be sure to clean the contents of the cache folder afterwards__.

## SMTP

SMTP is the default siwapp messaging system. We use that because it's the most common and most likely to be available.

However, sometimes the default settings (which are localhost as smtp server and 25 as smtp port) are not good enough.

### How

Just add a few extra parameters:

```
...
prod:
...
  mailer:
    param:
      delivery_strategy: realtime
      transport:                    # THIS LINE IS NEW
        param:                      # THIS LINE IS NEW
          host:     your.smtp.host  # THIS LINE IS NEW
          port:     your.smtp.port  # THIS LINE IS NEW
          encryption:               # THIS LINE IS NEW
          username:                 # THIS LINE IS NEW
          password:                 # THIS LINE IS NEW
...

```

The lines are pretty self-explanatory.

As you have noticed, the "encryption", "username" and "password" fields are left empty. You can put them or not. most of the time you don't need this, but some smtp servers may need them:
  - `encryption:`  if the smtp server needs encryption. can be 'ssl' or 'tls'.
  - `username:` the smtp username, if needed
  - `password:` the smtp server password.


### Gmail to the rescue

As an example, let's see how this would look like when using gmail's smtp servers.


```
...
prod:
  ...
  mailer:
    param:
      delivery_strategy: realtime
      transport:
        param:
          host: smtp.gmail.com
          port: 465
          encryption: ssl
          username: your_gmail_username@gmail.com
          password: your_gmail_password
```

## Sendmail

You may want, however, use your server's own sendmail. In this case, you need to instruct siwapp to do that, by changing the 'transport: class:' parameter.

### How

```
...
prod:
...
  mailer:
    param:
      delivery_strategy: realtime
      transport:                            # THIS LINE IS NEW!!!!
        class: Swift_SendmailTransport      # THIS LINE IS NEW!!!!
...

```


## Mail

If you want to use the native PHP mail() function to send messages.

### How
```
...
prod:
...
  mailer:
    param:
      delivery_strategy: realtime
      transport:
        class: Swift_MailTransport
```


There you go!
