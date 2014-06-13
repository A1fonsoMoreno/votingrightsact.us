$ ->
  AsynifyForm = init: (form, callback) ->
    $form = $(form)
    $action = $form.prop("action")
    $method = $form.prop("method")
    $form.on "submit", (e) ->
      e.preventDefault()
      $[$method]($action, $form.serialize()).then (data) ->
        callback.call $form, data
        return

      return

    this

  $.fn.asyncify = (callback) ->
    @each ->
      AsynifyForm.init this, callback
      return