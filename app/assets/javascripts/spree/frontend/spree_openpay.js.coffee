#= require_tree .
#= require_self

jQuery ->
  class Spree.Openpay
    currentMethod: null

    constructor: (@form, @gatewayOptions)->
      @methods       = @form.find 'input[name="order[payments_attributes][][payment_method_id]"]'
      @currentMethod = @methods.filter(':checked').val()
      @listenMethodChange()
      @listenSubmit()

    listenSubmit: ->
      @form.on 'submit', (e)=>
        e.preventDefault()
        currentForm = @form
        if @isOpenpayForm(currentForm)
          @processPayment(currentForm)
        else
          @submitForm()

    isOpenpayForm: (form)->
      $('input', form).is("[data-openpay-card='card[name]']")

    generateToken: (form)->
      window.Openpay.token.create(form, @successResponseHandler, @errorResponseHandler)

    processPayment: (form)->
      @generateToken(form)

    processWithInstallments: (form)->
      $.extend(@gatewayOptions, window.Openpay._helpers.parseForm(form))
      window.Openpay.charge.create(@gatewayOptions, @successResponseHandler, @errorResponseHandler)

    cleanForm: ->
      form = @form.clone()
      form.find("li:not(#payment_method_#{@currentMethod})").remove()
      form

    listenMethodChange: ->
      @methods.on 'change', (e)=>
        @currentMethod = e.target.value

    withInstallments: (form)->
      $('select, input', form).is("[data-openpay-card='monthly_installments']")

    submitForm: ->
      @form.off('submit').submit()

    successResponseHandler: (response)=>
      @saveOpenpayResponse(response)
      @submitForm()

    errorResponseHandler: (response)=>
      @saveOpenpayResponse(response)
      @submitForm()

    saveOpenpayResponse: (response)->
      @form.find("input[name='payment_source[#{@currentMethod}][gateway_payment_profile_id]']").val(response.id)
      @form.find("input[name='payment_source[#{@currentMethod}][openpay_response]']").val(JSON.stringify(response))
