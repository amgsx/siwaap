---
title: Custom PDF Fonts
---
# Custom PDF Fonts

## Adding a Custom Font to the PDF Generator

The fonts that siwapp deploys per default for the pdf engine are only these five:

  - __DejaVuSansMono:__ This font is used when the following css font-families are specified:
    - `monospace`
    - `courier`
  - __DejaVuSans:__ Used for the following font-families:
    - `sans-serif`
    - `helvetica`
  - __DejaVuSansCondensed:__ Used for the following font-family:
    - `sans-serif-condensed`
  - __DejaVuSans-ExtraLight:__ Used for the following font-family:
    - `sans-serif-extralight`
  - __DejaVuSerif:__ Used for the following font-families:
    - `times`
    - `times-roman`
    - `serif`
  - __DejaVuSerifCondensed:__ Used for the following font-families:
    - `serif-condensed`
  - __Symbol__
  - __ZapfDingbats__

Those fonts are free to use, and also are unicode-friendly.

You may want to add your own font to your pdf engine, because you need a particular currency sign to be rendered by example. It's very tricky, but we'll give it a shot here.

### Locate the font you want in TrueType

The first thing you need to is -obviously- locate the font you want in true type format.

### Transform your font into a .ufm file

You need to transform your .ttf file into an .ufm one. In order to do that , you need certain program called "ttf2ufm". Depending on which system you're using, you may need one of these two packages:

  - __Windows__: download [ttf2ufm.exe](/downloads/ttf2ufm.exe.zip)
  - __Linux__: download [ttf2ufm-src.zip](/downloads/ttf2ufm-src.zip) package. When you unzip it, you'll get the source files along with a `Makefile` to build the binary. A `ttf2pt1` binary is also provided, but it may not run in your linux distribution.

Once you've got your conversion program, run the following command:

__Linux:__

```
$ ttf2pt1 -a downloaded_font.ttf
Using language 'latin1' for Unicode fonts
Auto-detected front-end parser 'ttf'
(use ttf2pt1 -p? to get the full list of available front-ends)
Processing file downloaded_font.ttf
Some font name strings are in Unicode, may not show properly
Creating file downloaded_font.t1a
numglyphs = 399
Glyph 218 has the same name as 163: (endash), changing to _d_218
Glyph 221 has the same name as 135: (bullet), changing to _d_221
Found Unicode Encoding
Guessed italic angle: 0.000000
FontName downloaded_font-Light
Finished - font files created
```

(__NOTE:__ the output may vary)

__Windows:__

It's pretty much the same than linux. Access a terminal and execute:

```
ttf2ufm -a downloaded_font.ttf
```

Once you've run the command, you'll get four files:

- the original __downloaded_font.ttf__ file
- downloaded_font.t1a
- downloaded_font.afm
- __downloaded_font.ufm__

The files you'll need are only the `.ufm` and `.ttf` ones. The `.ufm` file is the unicode-enabled font. The `.ttf` file is needed to set the metrics of the font right.

### Put the fonts in the right place

Now you need to put your recently created downloaded_font.ufm along with your downloaded_font.ttf on the right place in your siwapp server. Locate the folder 'data/fonts' which should be filled with "afm", "ttf" and "ufm" font files, __and a dompdf_font_family_cache.dist file__ which we'll talk about later.

Put your two new font files in the data/fonts directory.

__NOTE:__ the same process should be taken for the `bold`, `italic` and `bolditalic` versions of the font. Wherever you find your true type font of choice, you should be able to find and download the bold, italic and bolditalic versions of it.

### Tell DomPDF which css fonts to translate to the new installed fonts

The pdf generator uses a map file to tell which font to apply when it finds a certain css font-family specification (as told at the beginning of this wiki).

This map file is located in the very same directory the fonts are, and is called __dompdf_font_family_cache.dist__

This is how the file looks:

```
array (
  'sans-serif' => array (
    'normal' => DOMPDF_FONT_DIR . 'LiberationSans-Regular',
    'bold' => DOMPDF_FONT_DIR . 'LiberationSans-Bold',
    'italic' => DOMPDF_FONT_DIR . 'LiberationSans-Italic',
    'bold_italic' => DOMPDF_FONT_DIR . 'LiberationSans-BoldItalic'
  ),
  'times' => array (
    'normal' => DOMPDF_FONT_DIR . 'LiberationSerif-Regular',
    'bold' => DOMPDF_FONT_DIR . 'LiberationSerif-Bold',
    'italic' => DOMPDF_FONT_DIR . 'LiberationSerif-Italic',
    'bold_italic' => DOMPDF_FONT_DIR . 'LiberationSerif-BoldItalic'
  ),
  'times-roman' => array (
    'normal' => DOMPDF_FONT_DIR . 'LiberationSerif-Regular',
    'bold' => DOMPDF_FONT_DIR . 'LiberationSerif-Bold',
    'italic' => DOMPDF_FONT_DIR . 'LiberationSerif-Italic',
    'bold_italic' => DOMPDF_FONT_DIR . 'LiberationSerif-BoldItalic'
  ),
  'courier' => array (
    'normal' => DOMPDF_FONT_DIR . 'LiberationMono-Regular',
    'bold' => DOMPDF_FONT_DIR . 'LiberationMono-Bold',
    'italic' => DOMPDF_FONT_DIR . 'LiberationMono-Italic',
    'bold_italic' => DOMPDF_FONT_DIR . 'LiberationMono-BoldItalic'
  ),
  'helvetica' => array(
    'normal' => DOMPDF_FONT_DIR.'LiberationSans-Regular',
    'bold'   => DOMPDF_FONT_DIR.'LiberationSans-Bold',
    'italic' => DOMPDF_FONT_DIR.'LiberationSans-Italic',
    'bold_italic' => DOMPDF_FONT_DIR.'LiberationSans-BoldItalic'
  ),
  'zapfdingbats' => array (
    'normal' => DOMPDF_FONT_DIR . 'ZapfDingbats',
    'bold' => DOMPDF_FONT_DIR . 'ZapfDingbats',
    'italic' => DOMPDF_FONT_DIR . 'ZapfDingbats',
    'bold_italic' => DOMPDF_FONT_DIR . 'ZapfDingbats'
  ),
  'symbol' => array (
    'normal' => DOMPDF_FONT_DIR . 'Symbol',
    'bold' => DOMPDF_FONT_DIR . 'Symbol',
    'italic' => DOMPDF_FONT_DIR . 'Symbol',
    'bold_italic' => DOMPDF_FONT_DIR . 'Symbol'
  ),
  'serif' => array (
    'normal' => DOMPDF_FONT_DIR . 'LiberationSerif-Regular',
    'bold' => DOMPDF_FONT_DIR . 'LiberationSerif-Bold',
    'italic' => DOMPDF_FONT_DIR . 'LiberationSerif-Italic',
    'bold_italic' => DOMPDF_FONT_DIR . 'LiberationSerif-BoldItalic'
  ),
  'monospace' => array (
    'normal' => DOMPDF_FONT_DIR . 'LiberationMono-Regular',
    'bold' => DOMPDF_FONT_DIR . 'LiberationMono-Bold',
    'italic' => DOMPDF_FONT_DIR . 'LiberationMono-Italic',
    'bold_italic' => DOMPDF_FONT_DIR . 'LiberationMono-BoldItalic'
  ),
  'fixed' => array (
    'normal' => DOMPDF_FONT_DIR . 'LiberationMono-Regular',
    'bold' => DOMPDF_FONT_DIR . 'LiberationMono-Bold',
    'italic' => DOMPDF_FONT_DIR . 'LiberationMono-Italic',
    'bold_italic' => DOMPDF_FONT_DIR . 'LiberationMono-BoldItalic'
  )
)

/* The proper way for web browser environment independent font handling in html/css is,
 * to defining a font search path ending in serif, sans-ser
.....(more babbling)
*/
```

You can see it's a php array with the mappings between the font-family and the installed unicode font.

  - Say you want your "downloaded_font" to be used when you specify the css font-family "my-font".
  - Say you have the four (regular, bold, bolditalic) versions of the font in  .ufm and .ttf format
  - You need to make the following changes to your dompdf_font_family_cache.dist

__Before__

```
  ....
  'fixed' => array (
   'normal' => DOMPDF_FONT_DIR . 'LiberationMono-Regular',
   'bold' => DOMPDF_FONT_DIR . 'LiberationMono-Bold',
   'italic' => DOMPDF_FONT_DIR . 'LiberationMono-Italic',
   'bold_italic' => DOMPDF_FONT_DIR . 'LiberationMono-BoldItalic'
  )
)

/* The proper way for web browser environment independent font handling in html/css is,
 * to defining a font search path ending in serif, sans-ser
.....(more babbling)
*/
```

__After__

```
 'fixed' => array (
    'normal' => DOMPDF_FONT_DIR . 'LiberationMono-Regular',
    'bold' => DOMPDF_FONT_DIR . 'LiberationMono-Bold',
    'italic' => DOMPDF_FONT_DIR . 'LiberationMono-Italic',
    'bold_italic' => DOMPDF_FONT_DIR . 'LiberationMono-BoldItalic'
  ),                                               # <------ WATCH IT!!! a comma has been introduced
  'my-font' => array(
    'normal' => DOMPDF_FONT_DIR.'downloaded_font',  # <------- new line
    'bold'  => DOMPDF_FONT_DIR.'downloaded_font-bold', # new line
    'italic' => DOMPDF_FONT_DIR.'downloaded_font-italic',  # new line
    'bold_italic' => DOMPDF_FONT_DIR.'downloaded_font-bolditalic' # new line
   ) # new line
)

/* The proper way for web browser environment independent font handling in html/css is,
 * to defining a font search path ending in serif, sans-ser
.....(more babbling)
*/
```

### Clean up the cache
After you've done all this, remove the contents of the "cache" folder

### Off you go

From now on, you can use, when building your printing template, the font-family `my-font`, and domPdf will translate it into the form you just downloaded.
