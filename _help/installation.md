---
title: Installation Guide
---

# Installation Guide

## Requirements

- UNIX/Linux, Windows XP or later.
- Apache Web Server with URL rewriting module active in configuration.
- MySQL database server 5.0 or higher.
- PHP 5.2 or higher (better 5.2.4 or higher).

In case you plan to use the _recurring invoice_ feature, you need access to a scheduling application within your system (i.e. cron in Linux, or scheduled tasks in Windows).

## Installation

### Get the Source

1. Download the tar.gz or zip package from [the website](/) and unpack it to a local folder of your choice or clone [the git repository](https://github.com/siwapp/siwapp-sf1).
2. Put everything in its place.
3. Upload the contents of the web folder to the document root of your web server (this is the folder where you usually upload your web pages). We will call this the `sf_web_dir`.
4. Upload everything else (`apps`, `cache`, `config`, `data`, `doc`, `lib`, `log`, `plugins`, `symfony`, `test`…) to another directory on your web server, but not inside `sf_web_dir`. Preferably on the parent directory of `sf_web_dir`. We will call this the `sf_root_dir`. If the `cache` and `log` directories do not exist create them and give them (`cache` and `log` only!) write permissions for the web server (the easy way: full rights, `777` in UNIX/Linux).

### Filesystem permissions

The following directories need writing permissions for the web server:

```
sf_root_dir/cache
sf_web_dir/uploads
```

If you want that the installer could write the configuration files, give write permissions to the following files:

```
sf_root_dir/config/databases.yml
sf_web_dir/config.php
```

### Run the installer

Enter the URL of your web server (i.e. http://myhosting.com) in a browser. The installer application should appear.

Follow the instructions on the installer.

### Secure your installation

Remove write permissions to:

```
sf_root_dir/config/databases.yml
sf_web_dir/config.php
```

### Enjoy

That’s it. For a more detailed explanation just continue reading.

## Siwapp Deployment Strategies

Unpacking siwapp files onto a web server can sometimes be challenging. Here are a few tips to help your out.

`sf_root_dir`, `sf_web_dir`… what??

At some point at the siwapp installation instructions or in the community forums, you will be talked about these two _things_ called `sf_root_dir` and `sf_web_dir`. What are these?

### In short terms

`sf_root_dir` is the folder in which siwapp _internal_ folders (`apps/`, `logs/`, `lib/`…) and files are deployed, and `sf_web_dir` is the folder in which the files siwapp needs to be publicly accessed through the web are (`index.php`, `css/`, `js/`…) (wow, that was messy).

### A somehow longer explanation

When you unpack the siwapp package, you get this folder/files structure:

```
LICENSE (this is a file)
symfony (this is a file)
apps/
config/
data/
doc/
lib/
plugins/
test/
web/
```

Only the contents of the _web_ folder needs to be somewhere on a web server `public_html` folder. All the other folders are _internal_ siwapp folders that does not have to be reachable through the web.

`sf_root_dir` is the directory where all the siwapp _internal_ folders are installed. These are the folders siwapp needs to be operative. These folders does not have to be visible in a web server. In fact they should not. These folders are:

```
symfony
apps/
config/
data/
doc/
lib/
plugins/
test/
cache/ (this folder does not come with the installation package. you need to create it yourself)
log/   (this folder does not come with the installation package. you need to create it yourself. It's optional, though)
```

`sf_web_dir` is the directory where the siwapp web folder contents is. This is the only contents that needs to be visible in your web browser. In the default package, this is just the web folder and its contents. This folder is generally located at the same place than the others siwapp internal folders, but it does not have to be like that.

Let's do some _learning by example_.

Say you've decompressed your package in the `/home/jzarate/src/`. Then you should have this structure:

```
/home/jzarate/src/symfony
/home/jzarate/src/apps/
/home/jzarate/src/config/
/home/jzarate/src/data/
/home/jzarate/src/doc/
/home/jzarate/src/lib/
/home/jzarate/src/plugins/
/home/jzarate/src/test/
/home/jzarate/src/web/
/home/jzarate/src/web/config.php
/home/jzarate/src/web/index.php
/home/jzarate/src/web/installer_dev.php
/home/jzarate/src/web/installer.php
/home/jzarate/src/web/pre_installer_code.phpt
/home/jzarate/src/web/pre_installer_instructions.php
/home/jzarate/src/web/siwapp_dev.php
/home/jzarate/src/web/css/
/home/jzarate/src/web/js/
/home/jzarate/src/web/images/
/home/jzarate/src/web/sfFormExtraPlugin/
/home/jzarate/src/web/sfJqueryReloadedPlugin/
/home/jzarate/src/web/uploads/
/home/jzarate/src/web/robots.txt
```

__NOTE:__ I've detailed the contents of the _web_ folder, just to make sure you notice it.

Well, in this particular case:

- Your `sf_root_dir` would be where the siwapp internal folders are, which is /home/jzarate/src
- Your `sf_web_dir` would be where the web contents is, which is /home/jzarate/src/web

### Deployment strategies

The big news is `sf_root_dir` and `sf_web_dir` are decoupled!! They do not need to share the base dir, they just need to have some common path, but not the whole thing!!

Say your shared hosting FTP account has the following structure:

```
/home/basic_users/kelly/
/home/basic_users/kelly/public_html/
/home/basic_users/kelly/stats/
/home/basic_users/kelly/cgi-bin/
```

`public_html` would be the folder whose contents your web server displays.

All these configurations would be acceptable for siwapp:

#### Config Case 1. Just dump the whole thing into your `public_html` dir

If you just unzip the package inside some folder inside your `public_html` directory, you obtain:

```
/home/basic_users/kelly/public_html/siwapp/apps/
/home/basic_users/kelly/public_html/siwapp/config/
/home/basic_users/kelly/public_html/siwapp/lib/
/home/basic_users/kelly/public_html/siwapp/…
/home/basic_users/kelly/public_html/siwapp/web/
/home/basic_users/kelly/public_html/siwapp/web/installer.php
/home/basic_users/kelly/public_html/siwapp/web/…
```

With this config, you should point your browser to `http://yourdomain.com/siwapp/web/`.

The essential variables would be:

- `sf_root_dir` would be `/home/basic_users/kelly/public_html/`
- `sf_web_dir` would be `/home/basic_users/kelly/public_html/web/`

This is highly not recommended. Having all your essential folders publicly available, is not just a _security hole_ , it's turning your site and database into a campus frat house.

#### Config Case 2: Rename your _web_ folder as `public_html`

In this case, you unpack your siwapp folders on the same folder your `public_html` folder is, and then put all the contents of your siwapp _web_ folder into your `public_html` folder:

```
/home/basic_users/kelly/apps/
/home/basic_users/kelly/config/
/home/basic_users/kelly/lib/
/home/basic_users/kelly/…
/home/basic_users/kelly/public_html/installer.php
/home/basic_users/kelly/public_html/siwapp_dev.php
/home/basic_users/kelly/public_html/index.php
/home/basic_users/kelly/public_html/css/
/home/basic_users/kelly/public_html/…
```

With this config, you should point your browser to  `http://yourdomain.com/`.

The essential variables would be:

- `sf_root_dir` would be `/home/basic_users/kelly/`
- `sf_web_dir` would be `/home/basic_users/kelly/public_html/`

The only inconvenience of this config is that you may not like having all your siwapp folders scattered on your home directory, but otherwise it's fine as long as security is concerned.

### Config Case 3: Rename your web folder as `public_html`, bundle the rest in another folder

Put the contents of your _web_ folder in `public_html` and put the siwapp internal folders and files onto another folder within your home directory.

Something like this:

```
/home/basic_users/kelly/siwapp/apps/
/home/basic_users/kelly/siwapp/config/
/home/basic_users/kelly/siwapp/lib/
/home/basic_users/kelly/siwapp/symfony
/home/basic_users/kelly/siwapp/doc/
/home/basic_users/kelly/siwapp/…
/home/basic_users/kelly/public_html/installer.php
/home/basic_users/kelly/public_html/index.php
/home/basic_users/kelly/public_html/siwapp_dev.php
/home/basic_users/kelly/public_html/css/
/home/basic_users/kelly/public_html/js/
/home/basic_users/kelly/public_html/…
```

With this config, you should point your browser to `http://yourdomain.com/`.

The essential variables would be:

- `sf_root_dir` would be `/home/basic_users/kelly/siwapp/`
- `sf_web_dir` would be `/home/basic_users/kelly/public_html/`

This one is quite OK. You have all your siwapp internal folders and files inside a _siwapp_ folder, and all the contents of the siwapp _web_ folder inside your `public_html` folder.

The only drawback is that you may want your `public_html` folder to have other stuff too.

### Config Case 4: Your web folder inside your `public_html`, your internal folders bundled onto another folder

Put the contents of your _web_ folder in a particular folder inside `public_html` and put the siwapp internal folders and files onto another folder within your home directory.

That would look like:

```
/home/basic_users/kelly/siwapp/apps/
/home/basic_users/kelly/siwapp/config/
/home/basic_users/kelly/siwapp/lib/
/home/basic_users/kelly/siwapp/symfony
/home/basic_users/kelly/siwapp/doc/
/home/basic_users/kelly/siwapp/…
/home/basic_users/kelly/public_html/billing/installer.php
/home/basic_users/kelly/public_html/billing/index.php
/home/basic_users/kelly/public_html/billing/siwapp_dev.php
/home/basic_users/kelly/public_html/billing/css/
/home/basic_users/kelly/public_html/billing/js/
/home/basic_users/kelly/public_html/billing/…
```

With this config, you should point your browser to `http://yourdomain.com/billing`.

The essential variables would be:

- `sf_root_dir` would be `/home/basic_users/kelly/siwapp/`
- `sf_web_dir` would be `/home/basic_users/kelly/public_html/billing/`

This one is a good one, too. You've have all your siwapp web files contained on your _billing_ folder at your web server, so you can keep other stuff at it, too.
