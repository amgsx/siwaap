---
title: PDF Fonts
---

# {{ page.title }}

PDF generation —specially if the intended users are from all around the world— can sometimes be tricky.

We use the [dompdf](https://github.com/dompdf/dompdf) library which, essentially, turns any html/css formatted page into a decent pdf, with some limitations.

So our pdf generator has to _map_ somehow the font-families defined in our html/css to font files that can be used to generate a pdf. Also, these fonts need to be unicode friendly for those of you who use non-latin character set.

After lots and lots (and I mean it) of trial and error, we have finally equipped siwapp with the [DejaVu](http://dejavu-fonts.org/), and [Liberation](http://en.wikipedia.org/wiki/Liberation_fonts) fonts because they are free and unicode.

Here you have the docs that we have written on all topics related to pdf, fonts and unicode:

  - [The default set of fonts](/help/pdf-fonts/default/) siwapp brings under its arm, and how to access them via css font-family attributes.
  - [How to add custom pdf fonts](/help/pdf-fonts/new/) the hard way. Do you have any particular ttf font you want to use? Do you feel courageous? This is your page!
  - [Adding unicode support for legacy siwapp](/help/pdf-fonts/unicode). If you happen to have an old version of siwapp (therefore, an old version of dompdf too), take a look at this.
