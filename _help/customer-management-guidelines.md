---
title: Customer Management Guidelines
---

# {{ page.title }}

Since customers management have been through several phases in siwapp, the end result is kind of a mixture between two approaches. We believe it's _the best of both worlds_ (Hanna Montana Dixit).

## The _name slug_

Internally, each customer object has a _name_slug_ field. the _name_slug_ is a compacted version of the name, without spaces and tricky characters. This way:

  - _Smith and Co._ would produce the _smithandco_ name_slug
  - _Smith and !Co_ will also produce the same _smithandco_ name_slug

## Database restrictions

The customer's name has to be unique. You can not have two customers with the same name.

__Attention__ The customer's name_slug has to be unique, also, but -since you're not seeing it directly- , the error message in case you are _duplicating_ a customer's name_slug will be that your customer's name is _too close_ to one already existing in the db. This means that the customer's name you're trying to add generates a slug that already exists in the db. In that case, you should try to slightly modify your customer's name, so it generates a different slug.

## Invoice Editing

When editing/creating an Invoice, when you start typing in the _customer's name_ input, the system will show you possible matches within its database, if you choose one of them, the system will automatically fill the other customer inputs, and will associate the invoice being created/edited with that customer.

If you modify some way the customer's name, the system will try to find a customer in the db that has that same name (or a very similar one -in the _name_slug_ sense-, and if it can finds it, it will re-establish a link between the invoice being edited and the found customer object. If the system can't find it, then it will create a new customer for the occasion.

__All the other editing on the invoice customer's fields doesn't go on the customers _permanent record___ any other thing customer-related that you may edit afterwards, will keep -of course- in the invoice you're editing them at, but will not go to the associated customers object. So, say:

   - __You create a customer A__: as previously discussed, you can do this either by going to the customer's tab and clicking on _new customer_, or simply by using a brand new customer's name in an invoice edition/creation page.
   - __You associate this customer A  to an invoice__: as previously discussed, you can do this on one step (by creating an invoice in which customer's name input there is a brand new customer name), or in two, (by creating the customer, then creating an invoice, and -when typing the customer's name- choosing the customer 'A' from those the system is offering).
   - __Afterwards__:
     - If you change the customer name for another one of the ones offered by the system, the invoice will be related to the customer described by that changed name. All customer's fields will be updated with that recently chosen customer's data. You may then save your invoice with your new customers details, or edit them a little more. __The customer relationship with the invoice is determined by the customer's name, all the other fields doesn't matter__
     - If you change any other customer's data, those changes will not go to the customer table, but will remain in that particular invoice you're editing them at. The relationship remains the same. __If your customers module is disabled, then the associated customer object is changed accordingly to the new data inputed at the invoice's customer fields__
     - If you make up a complete new customer's name, a new customer object will be created, and the invoice will be associated to it
