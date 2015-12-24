---
title: Unicode support for PDF in legacy siwapp
---
# {{ page.title }}

The siwapp's pdf generator comes from the well known library called [dompdf](https://github.com/dompdf/dompdf). That library is not perfect, particularly regarding unicode character support.

That being said, all our slavic users have been suffering for this. The just can not get their characters right when generating pdf.

We're seriously thinking in changing pdf generator but, in the meantime, we've managed to sort this out for the development version. Any siwapp with a changeset number greater than 1716 should be able to generate pdfs with proper Cyrillic alphabet, to say the least.

Anyway, if you happen to have a siwapp whose version number is lower than 0.3.2, then your pdf generator doesn't have this feature enabled, so here are a couple of somehow messy instructions on how to achieve that. Really hope it helps.


__Create a new directory__. It's going to be called _fonts_ and it will be under the _data_ directory of your siwapp directory tree. This directory is where your fonts will live.

```
$ cd /wherever/your/siwapp/lives
$ cd data
$ mkdir fonts
```

__Download the fonts__. Download them [here](/downloads/dompdf_fonts.zip) (it's a zip file), uncompress them, and put them in the _fonts_ directory you just created on previous step.

You should have fonts archives with the following extensions per each font name:

- `.ttf`
- `.afm`
- `.ufm`

And a file called `dompdf_font_family_cache.dist`.

__Modify your `apps/siwapp/config/siwappConfiguration.class.php` file__.

Locate the following lines:

```
public function configure()
{
    if(!defined("DOMPDF_FONT_CACHE"))
        define("DOMPDF_FONT_CACHE", sfConfig::get('sf_upload_dir').DIRECTORY_SEPARATOR.'pdf_fonts_cache');
```

and replace them by:

```
public function configure()
{
    // enable utf support
    define("DOMPDF_UNICODE_ENABLED",true);
    define("DOMPDF_FONT_DIR", sfConfig::get('sf_data_dir').DIRECTORY_SEPARATOR.'fonts/');
    if(!defined("DOMPDF_FONT_CACHE"))
        define("DOMPDF_FONT_CACHE", sfConfig::get('sf_upload_dir').DIRECTORY_SEPARATOR.'pdf_fonts_cache');
```

(you just actually added some lines).

__Delete all files in your `cache/` directory__ and that should be all!
