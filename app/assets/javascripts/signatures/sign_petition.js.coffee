$ ->
  $("form.petition-form").asyncify (data) ->
    $(this).addClass "is-hidden"
    $(this).closest("div.petition-wrapper").find("p.thank-you-message").fadeIn "slow"
    $("#call_signature_id").val data.id
    return