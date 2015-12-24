---
title: Troubleshooting
---

# {{ page.title }}

## Instalation issues

Even after following the [wiki:deployment_strategies Siwapp deployment strategies], you could be using a public (or paid) hosting that needs more setup to do for Siwapp to start working.

What to do in these cases?

### 1. Look for your error in the user´s forum

Chances are, you are not the first person experiencing this error. The Siwapp forum holds account of past and current problems other users have when installing the application, and the response they got from the developper team. Search for messages that in the subject have the error that have appeared in your web browser, and read them, looking for issues with characteristics similar to your system (operating system, hosting type, Apache, PHP and MySQL versions, etc.).

Feel free to try the answers you find in your own system (if applicable) , before submitting a new message. Please, state clearly what problem are you having, and what kind of system do you have. Operating System; Apache, Linux and MySQL versions; hosting provider... give as much information as you could of your setup.

### 2. Running the installer in developer mode

If your problem has not been addressed before (or the answers available at the forum doesn't fix your problems), you'll be requested that you provide more information about your particular problem. Usually, this will require that you run the installer in developer mode.

Copy [the following file](/downloads/installer_dev.php) to your web directory, and then call the installer in _developer_ mode, like this:

```
http://your.siwapp.server/installer_dev.php
```

In developer mode, error messages are more specific, and could point the development team about what is causing the trouble.

### 3. Some common error messages

Once you're in development mode, you'll probably get some more self-explanatory error messages. Maybe some of them are on this listing:

  - __stuck in step2 or _undefined function `apache_get_modules()`_ message__: If you get this error on installation step two, then you probably have your PHP engine installed as a `cgi-bin`, not as an Apache module. Use [this file](/downloads/checks.class.php), and put it on `apps/installer/lib/`. Then __empty the `cache`__ directory and restart the installation process.
  - __`Fatal error: Interface 'Doctrine_EventListener_Interface' not found in /xxx/yyy/lib/vendor/symfony/lib/plugins/sfDoctrinePlugin/lib/vendor/doctrine/Doctrine/EventListener.php on line 34`__: It has been reported on occasions that the files under the `/xxx/yyy/lib/vendor/symfony/lib/plugins/sfDoctrinePlugin/lib/vendor/doctrine/Doctrine/EventListener/` directory (`Chain.php`, `Exception.php`, `Interface.php`) come with the `.ph` extension instead of the `.php` one. Change it and you should be fine.
  - __mod rewrite not recognized__: the siwapp installer has a fairly simple method of guessing whenever you have rewriting enabled or not. It just sets one rewrite rule, in the .htaccess file, and access the url defined by that rule in the hope of getting the right content. If your installer says you don't have rewrite enabled, but your host providers says different. It may be due to:
    - Your `file_get_contents` PHP function (which is in which the installer rely to obtain the content) is not working properly.
    - Your Apache server doesn't obey `.htaccess` file: in your virtual host configuration you don't have this directives:

    ```
    AllowOverride All
    ```

    - your host provider is lying ;-)

    Whatever the reason, you may try to fix it or just take your chances and remove that check from the installation application: in order to do that, you need to edit your `web/pre_installation_code.php` file, and comment out these lines:

    ```
    // check for mod_rewrite. test_rewrite1.txt should be rewrited to
    // test_rewrite2.txt
    $installer_url = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
    $rewrite_url = substr($installer_url,0,strrpos($installer_url,'/')+1).
      'test_rewrite1.txt';
    $wrong['rewrite'] = strpos(file_get_contents($rewrite_url), 'test_rewrite2')
      === false;
    ```

## Known issues

### The enterprise logo doesn´t show.

This problem happens when your system tries to open the logo image, but fails to properly do so.

For fixing this, you should have actived the `allow_url_fopen` extension of your PHP.

In your `php.ini`, the following line should be present:

```
allow_url_fopen = On
```
