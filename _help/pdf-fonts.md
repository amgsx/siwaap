---
title: PDF Fonts
---
= PDF: fonts and unicode support =

PDF generation -specially if the intended users are from all around the world- can sometimes be tricky.

We use the [http://code.google.com/p/dompdf/ dompdf] library which, essentially, turns any html-css3 formatted page into a decent pdf, with some [http://dev.siwapp.org/projects/siwapp/wiki/templateTags?version=10#Watchit limitations].

So our pdf generator has to "map" somehow the font-families defined in our html-css3 to font files that can be used to generate a pdf. Also, these fonts need to be unicode friendly for those of you who use non-latin character set.

After lots and lots (and I mean it) of trial and error, we've finally equipped siwapp with the [http://dejavu-fonts.org/ dejavu fonts], and [http://en.wikipedia.org/wiki/Liberation_fonts liberation] because they are free and unicode.

Here you have the doc that we have written on all topics related to pdf, fonts and unicode

  - [wiki:pdfDefaultFonts The default set of fonts] siwapp brings under its arm, and how to access them via css font-family attributes.
  - [wiki:addPdfFonts Add custom pdf fonts] the hard way. Do you have any particular ttf font you want to use? Do you feel courageous? This is your page!
  - [wiki:pdfUnicodeSupport Adding unicode support for legacy siwapp] If you happen to have an old version of siwapp (therefore, an old version of dompdf too), take a look at this.
