---
title: Default PDF Fonts
---
## The fonts you can count on for your PDF.

### The default set of PDF fonts bundled with siwapp

Siwapp comes with a default set of pdf fonts that are applied to your final pdf according to the fonts specified via css in your printing template.

These are the fonts and the css font-families they are related to:

  - __Default fonts:__ Liberation
    - __LiberationMono:__ This font is used when the following css font-families are specified:
      - `monospace`
      - `courier`
    - __LiberationSans:__ This font is used when the following css font-families are specified
      - `sans-serif`
      - `helvetica`
    - __LiberationSerif:__ This font is used when the following css font-families are specified:
      - `times`
      - `times-roman`
      - `serif`
  - __Wider character range but very heavy:__ DejaVu
    - __DejaVuSansMono:__ This font is used when the following css font-families are specified:
      - `monospace-dejavu`
      - `courier-dejavu`
    - __DejaVuSans:__ Used for the following font-families:
      - `sans-serif-dejavu`
      - `helvetica-dejavu`
    - __DejaVuSansCondensed:__ Used for the following font-family:
      - `sans-serif-condensed`
    - __DejaVuSans-ExtraLight:__ Used for the following font-family:
      - `sans-serif-extralight`
    - __DejaVuSerif:__ Used for the following font-families:
      - `times-dejavu`
      - `times-roman-dejavu`
      - `serif-dejavu`
    - __DejaVuSerifCondensed:__ Used for the following font-families:
      - `serif-condensed`
- __Non Unicode core fonts:__
These are fonts that every pdf reader is supposed to have. but they are not unicode by default.
    - __Helvetica:__ accesed through the `helvetica-raw` font-family
    - __Times:__ accessed through the `times-raw` font-family
    - __Courier:__ accessed through the `courier-raw` font-family

If you don't need any cyrillic or the kind character, and you only use latin-type fonts, then you can use these in order to get extra-light pdf files.

- __Symbol__
- __ZapfDingbats__

As you can see, there are only twelve font-families of interest:

  - `serif`
  - `serif-condensed`
  - `serif-dejavu`
  - `sans-serif`
  - `sans-serif-condensed`
  - `sans-serif-dejavu`
  - `sans-serif-extralight`
  - `monospace`
  - `monospace-dejavu`

### The special `condensed`, `extralight`, `-dejavu`, `-raw` fonts

The `serif-condensed` and `sans-serif-condensed` will give you a font which is a _condensed_ version of the standard one (either `serif` or `sans-serif`. you may find it useful if you need to keep your pdf not too big.

Also, there is an 'extralight' version of the sans-serif font.

The '-dejavu' suffix will use the DejaVu font , which is heavier but with wider character support

The '-raw' suffix will use the non-unicode but extra light core fonts.

In order to use any of these variants, you just need to specify it as a font-family.


### Excuse Me?

Long story short.

- The basic core fonts (Helvetica, Courier, Time, Zapdingats , Symbol) fonts that the pdf generator comes with by default are no unicode. However, since those are fonts that are mandatory on any pdf reader, the generated pdf file is extra-light (around 30k). If you don't need fancy character supports these are for you. They are accessed when specifying the '-raw' suffix in the font family css definition. i.e.
    - `times-raw, times-roman-raw, serif-raw`
    - `sans-serif-raw, helvetica-raw`
    - `courier-raw, monospace-raw, fixed-raw`
- Our pdf generator comes bundled with "Liberation" and "DejaVu" unicode fonts. The default font to use is "Liberation" whenever you specify times, times-roman, sans-serif, helvetica, courier, monospace or fixed font families in your css , these fonts are used. Since the fonts needs to be embedded in the resulting pdf file, it's size will increase by the size of the font. Typically a pdf file will be 150 - 300 kb . The font-families that will map to these fonts are:
    - `courier, monospace, fixed`
    - `times, times-roman, serif`
    - `helvetica, sans-serif`
- There are some cases in which you may need some very weird character. DejaVu is for you then. These fonts have a very wide character range. The drawback is they are very heavy. The same pdf which used to be 45kb when using core fonts (the ones with the '-raw' suffix), 150-300 kb when using Liberation fonts (the ones that are applied when no suffix is specified), will now be 1.4mb!!! The font-families that will map to these fonts are:
    - `courier-dejavu, monospace-dejavu, fixed-dejavu`
    - `times-dejavu, times-roman-dejavu, serif-dejavu,serif-condensed`
    - `helvetica-dejavu, sans-serif-dejavu, sans-serif-extralight, sans-serif-condensed`

#### html compatibility

Say you want to use one of the  non-standard css name for a font-family in a template, because you want to use a particular font in the rendered pdf. When you use that very same template to print an invoice from the browser, your browser won't understand that special font-family , you'll need to specify a browser-compatible alternative.

If you use

```html
<style>
div.header {
  font-family: helvetica-dejavu;
}
</style>

<div class#"header">I've got helvetica style</div>
```

When rendering the pdf, you'll get a pretty 'sans-serif' dejavu font, but if you use that template for showing the invoice in a browser, the browser won't be able to find a suitable font.

If you use

```html
<style>
div.header {
  font-family: helvetica-dejavu, helvetica;
}
</style>
<div class#"header">I've got helvetica style</div>
```

You still get your dejavu font when rendering pdf and, when using the browser, it will jump to the alternate specified font, which is "helvetica" and everybody will be happy!
