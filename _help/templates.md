---
title: PDF Templates
---

# PDF Templates

## So you want to make a printing template?

As you know, siwapp comes with the ability of letting you build your own printing templates, that will be used when printing or building an invoice/estimate PDF.

Here is a quick guide on how to make your own template, and how to access your invoice/estimate particular data, when building the template.

Please keep in mind that everything which is described here, __apply for both invoices and estimates objects__, except when indicated.


  - Go to the _printing templates_ page. In there, you'll find a list of printing templates to use when printing or building PDFs, the one that you mark with the "default template" star, is the one that will be used.
  - You can edit one of the existing templates you may have in that listing (chances are you find only one), or create a new one. My advice is to begin by editing the one template that comes per default with the app.
  - You will then be showed an edition page in which you pretty much have to do html formatting. that's it. __Build the templates using standard html__
  - There are, however, certain extra features; when you are building the html code, you can access to the invoice particular data using the `{% raw %}{{{% endraw %}` and `{% raw %}}}{% endraw %}` special tags, and you can also access to a limited programming logic using the `{% raw %}{%{% endraw %}` and `{% raw %}%}{% endraw %}` special tags.

Below there is a more comprehensive list of these _special tags_ and what you can do with them. Please read carefully.

## Objects and data you have access to when building the template

The template has access to the following objects and properties:

 - __`invoice`__: the invoice itself. From this object these properties can be obtained.
   - `invoice`: if you use `{% raw %}{{invoice}}{% endraw %}`, you will get either the invoice series + invoice number or the '[draft]' string, if the invoice is in draft status
   - `invoice.number` : the number assigned to the invoice. only availabe when the invoice is not in draft state
   - `invoice.customer_name`
   - `invoice.customer_identification`
   - `invoice.customer_email`
   - `invoice.contact_person`
   - `invoice.invoicing_address`
   - `invoice.shipping_address`
   - `invoice.contact_person`
   - `invoice.terms`
   - `invoice.notes`
   - `invoice.base_amount`: The sum of quantity*unitary_cost for all items of the invoice
   - `invoice.discount_amount`: The total amount of the discount for the invoice. Not percent.
   - `invoice.net_amount`: base_amount - discount_amount
   - `invoice.tax_amount`: The total amount of taxes for the invoice. Not percent.
   - `invoice.tax_amount_TAXNAME`: The total amount of taxes for the invoice associated to the tax called TAXNAME. Please note:
      - This is only available for __siwapp higher than 0.3.2__
      - TAXNAME is the name of the a tax you have defined in your settings
      - TAXNAME is always lowercase and "slugified". that is: no whitespace character or non alphanumeric
      - Example: The total tax amount for an invoice corresponding to a tax that you've called __*16% VAT*__ in your settings, would be accessed as `{% raw %}{{invoice.tax_amount_16vat}}{% endraw %}`
   - `invoice.gross_amount`: net_amount + tax_amount
   - `invoice.paid_amount`: the amount that has been paid
   - `invoice.due_amount`: the amount of money that is still due. __not available for estimates__
   - `invoice.issue_date`
   - `invoice.due_date`
   - __`invoice.Items`__: An array with the items associated to this invoice.
 - __`item`__: an Item associated with the invoice. this object is only available within the domain of an iteration over 'invoice.Items'.
   - `item.description`
   - `item.quantity`
   - `item.unitary_cost`
   - `item.discount`: the discount _percent_ to be applied to the item.
   - `item.base_amount`: quantity*unitary_cost for this item
   - `item.discount_amount`: the amount of money to be discounted for that item. Not percent.
   - `item.net_amount`: base_amount - discount_amount
   - `item.tax_amount`: The amount of money to charge as taxes for that item. Not percent.
   - `item.gross_amount`: net_amount + tax_amount
   - `item.taxes_percent`: The taxes for that item, in percent.
   - __`items.Taxes`__: An array with the taxes associated to this item.
 - __`tax`__: a tax associated with an item. this object is only available within the domain of an iteration over `item.Taxes`.
     - `tax.name`
     - `tax.value`: percent.
 - __`settings`__: the user settings.
   - `settings.company_address`
   - `settings.company_email`
   - `settings.company_fax`
   - `settings.company_name`
   - `settings.company_phone`
   - `settings.company_url`
   - `settings.currency`
   - `settings.legal_terms`

### Displaying , using flow control and iterating over object properties

Nothing is easier:

  - To display a property, use {{}}

    ```
    <span>The total cost is: {% raw %}{{invoice.net_amount}}{% endraw %}</span>
    ```

  - To iterate over an array, use `{% raw %}{% for <element_to_be_used_inside_the_loop>  in <array>%} .... {% endfor %}{% endraw %}`:

    ```
    {% raw %}<td class="right">
        {% for tax in item.Taxes %}
            <span class="tax">{{tax.name}}</span>
        {% endfor %}
    </td>{% endraw %}
    ```

  - To evaluate/print a chunk of html based on a condition, use {% raw %}{%if <condition> %} ... {% endif %}{% endraw %}:

    ```
    {% raw %}{% if invoice.discount_amount %}
        <td class="right">{{item.discount_amount|currency}}</td>
    {% endif %}{% endraw %}
    ```

  please note

    - if an attribute is empty, it returns false
    - if an array is empty, it returns false

## Filters

### Syntax

A filter is applied to a certain object property using a _pipeline_ syntax.

```
{% raw %}{{item.discount_amount|currency}}{% endraw %}
```

In this case, the filter _currency_ is applied to the `item.discount_amount` property. It takes the _output_ of `item.discount_amount` as its _input_ argument, and returns something. In this particular case, rounds the number and adds a currency symbol.

  - `{% raw %}{{item.discount_amount}}{% endraw %}` returns: `125.928333`
  - `{% raw %}{{item.discount_amount|currency}}{% endraw %}` returns: `125.93 €`

Filter can take more arguments using parenthesis.

  - `{% raw %}{{invoice.issue_date}}{% endraw %}` returns a _raw date_ : `2009-09-19`
  - `{% raw %}{{invoice.issue_date|date}}{% endraw %}` returns a formatted date ,using a default format according to the user culture: `19/09/2010`
  - `{% raw %}{{invoice.issue_date|date('F')}}{% endraw %}` returns a formatted date, using the format specified by its argument ('F'), according to the user culture: `September 19, 2010 12:00:00 AM CDT`
  - `{% raw %}{{invoice.issue_date|date('F','en_GB')}}{% endraw %}` returns a formatted date, using the format specified by its first argument ('F'), and the culture specified by its second: ('en_GB'): `19 September 2010 00:00:00 CDT`

## The list

These are the available filters. When referring to _first_ argument, we're always talking about the _first parenthesis_ argument (technically speaking, the real _first_ argument is the one you pass to the filter through the _pipelinning_ (|) command).


### date, datetime

This filter applies to a date or datetime object, and returns that date formatted according to the local culture.

  - First argument. If present, it specifies a different formatting. The possible values are:

    ```
    || argument          || description               || output (change with the culture )  ||
    ||  d                || short date pattern        || MM/dd/yyyy                         ||
    || D                 || long date pattern         || dddd, dd MMMM yyyy                 ||
    || F                 || full datetime pattern     || dddd, dd MMMM yyyy HH:mm:ss        ||
    || m, M              || month day pattern         || MMMM dd                            ||
    || r, R              || RFC1123 pattern           || ddd, dd MMM yyyy HH':'mm':'ss 'GMT'||
    || s                 || sortable datetime pattern || yyyy'-'MM'-'dd'T'HH':'mm':'ss      ||
    || t                 || short time pattern        || HH:mm                              ||
    || T                 || long time pattern         || HH:mm:ss                           ||
    || Y                 || year month pattern        || yyyy MMMM                          ||
    ```

  - Second argument. if present, it specifies a different culture. 'en'-like or 'en_GB'-like can be used (see above example in filters syntax)


### format

Simple text to html formatting:

 - Surrounds paragraphs with `<p>` tags, and converts line breaks into `<br />`
 - Two consecutive newlines(`\n\n`) are considered as a paragraph, one newline (`\n`) is considered a linebreak, three or more consecutive newlines are turned into two newlines

```
<li>Address: {% raw %}{{settings.company_address|format}}{% endraw %}</li>
```

### unlink

Turns all links into words, like `<a href="something">else</a>` to `else`.

### nl2br

Transforms `\n` (newline) to `<br/>`.

### currency

Transform a number in the currency defined by the user's settings, using the user's default culture.

  - first argument. The culture to be used when defining the formatting of the number.

    ```
     <td class="right">{% raw %}{{item.unitary_cost|currency}}{% endraw %}</td>
    ```

    returns

    ```
      <td class="right">US$ 232.33</td>
    ```

Please Note that the currency symbol will always be the one defined in the user's settings. Changing the culture will only affect how the number is formatted (how many decimals and stuff like that).

### count

Returns the number of items in an array.

### unhttp

Removes the `http://` or `https://` from a string.

### round

Rounds the number. Default is two decimals. amount of decimals can be indicated as an argument:

```
{% raw %}{{ price|round }}     ## rounds to two decimals
{{ price|round(3) }}  ## rounds to three decimals.{% endraw %}
```

### product_reference

Obtain the product reference associated with that product id

# Watch it!

DomPDF is far from perfect, and it has a few quirks when it comes to render smoothly.

For example, __don't use rowspanned cells.__ When a rowspanned cell is break because a page change, it throws a _Frame not found in cellmap_ exception.
