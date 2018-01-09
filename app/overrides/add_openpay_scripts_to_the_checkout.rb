Deface::Override.new(virtual_path: 'spree/checkout/_payment',
                     name: 'openpay_scripts',
                     insert_after: '[data-hook="buttons"]',
                     partial: 'spree/checkout/openpay_scripts')
