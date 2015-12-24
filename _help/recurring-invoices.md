---
title: What are Recurring Invoices?
---
# What are Recurring Invoices?

From a mail conversation, a rough intro to recurring invoices:

> The _recurring invoice_ is not an invoice _per se_ and it does not have any _issue date_ to be defined by the user. When you create a _recurring invoice_ , what you are really creating is a sort of a _automatic invoice generation template_...
>
> When you create a new _recurring invoice_ you define a lot of data invoice-style (items info, customer info, etc..), and also some time parameters (when to start, periodicity, etc...); the start time define when the system should start to create invoices based on the pattern defined by the recurring you just created (that is, customer and items data), and the periodicity data define how long the system has to _wait_ until it generates a new invoice with the same inovice data again.
>
> However, the web application can not _schedule_ jobs, because of the nature of a web application itself, so we set up a task to be executed regularly (daily or so). that task checks for the _pending invoices_. The task is run like this:
>
```
/path/to/your/symfony/root/symfony siwapp:create-pending-invoices
```
>
> A _pending invoice_ is an invoice that according to some recurring invoice , should be generated by now. If you run the _create-pending-invoices_ daily, well , then everyday the invoice generation defined in you recurring invoices should occur.


## Let's see an example

You create a recurring invoice called _hosting services_, which has an item called _web server rental_, which has the price of 100$. You want it to have a monthly periodicity, and you set up a start date of April 1, 2010.

Once you've created this recurring, if you run the _create pending invoices_ now, nothing will happen, since the recurring is set to start generating invoices on April 1.

Let's say today is April 1:

- _If you do nothing, nothing will happen_. Although the system is supposed to generate a _hosting services_ invoice , since it does not have a scheduling facility, it won't happen unless it's told to do so.
- If tomorrow, April 2, you issue the _create pending invoices_, then the _system would find 1 pending invoice_ (the _hosting services_ one, which should have been generated on April 1, the day before), so it generates it.
- If you run the task again on April 3, nothing would happen, because there is no invoice that should be generated and hasn't been on any date previous than April 3 .
- _This same reasoning applies if you had run the task on April 1_. the system would find that it should have generate an invoice by April 1 and so it would be listed as _pending_ and generated accordingly.
- If you keep running that task everyday, _nothing would happen until May 1_, because, according to the _one month_ periodicity you set up on the recurring invoice, now it's time to generate another _hosting services_ invoice, so it would be generated.
- If, whatever the reason, you or your cron daemon forgot to run the task on may 1, and run it on may 2 instead, the system would have found out there is one _pending invoice_ and would have generated it.

The _Generate Pending Invoices_ button which appears on your recurring invoices listing, works the same way (__NOTE:__ The button only appears if you do have pending invoices).