Spree Openpay
==============

Add spree_openpay to your Gemfile:

```ruby
gem 'spree_openpay', github: 'elliotmx/spree_openpay_premium', branch: 'master'
```

Then run:

```shell
bundle
bundle exec rails g spree_openpay:install
```

##Setup Openpay Payments

You need to go to [Openpay](https://www.openpay.mx/), create an account and retrieve your ID, private and public api keys.

On the spree application admin side go to:

/admin/payment_methods/new

    In the provider box,choose one of the following options depending on your needs:

     Spree::BillingIntegration::OpenpayGateway::Card

     Spree::BillingIntegration::OpenpayGateway::Cash

     Spree::BillingIntegration::OpenpayGateway::Bank

     Spree::BillingIntegration::OpenpayGateway::MonthlyPayment

    On the auth token field, add your Openpay private key.

    On the public auth token field, add your Openpay public private key.
    
    On the openpay field, add your Openpay Merchant ID.

**Important Note:** If the payment method's test mode is active, then you will be using the sandbox testing URL for Openpay.

###Source Methods

Spree Openpay currently supports four different methods:

####Card
>Card method will let you pay using your credit or debit card. More info: More info: [Openpay Card](https://www.openpay.mx/docs/save-card.html)
**Important Note:** At least you need to create this payment method.

####Cash
>Cash method will generate a bar code with the order information so you'll be able to take it to your nearest Paynet store to pay it. More info: [Openpay Cash](https://www.openpay.mx/docs/store-charge.html)

####Bank
>Bank method will let you generate a deposit or transfer reference.

####Monthly Payment
>This method will let you pay using your credit card with a monthly payment schema.

**Important Note:** If you want to support all source methods, you'll need to create a payment method for each one.

**Important Note:** This extension only works with ruby 2.0+.

**Important Note:** Openpay only supports Credit Cards and Cash Payments.

**Important Note:** Openpay customers will be created after the first checkout's step.

**Important Note:** Only Openpay total refunds available.

# About the Author

[ELLIOT](http://elliot.mx/)

## Contributors
  * Jonathan Garay
  * Fernando Cuauhtemoc Barajas Chavez
  * Herman Moreno
  * Edwin Cruz
  * Carlos A. Muñiz Moreno
  * Chalo Fernandez
  * Guillermo Siliceo
  * Jaime Victoria
  * Jorge Pardiñas
  * Juan Carlos Rojas
  * Leo Fischer
  * Manuel Vidaurre
  * Marco Medina
  * Mumo Carlos
  * Sergio Morales
  * Steven Barragan
  * Ulices Barajas
  * bishma-stornelli
  * Raul Contreras Arredondo
  * AngelChaos26
