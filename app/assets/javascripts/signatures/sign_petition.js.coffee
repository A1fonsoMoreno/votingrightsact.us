$ ->
  setSignatureId = (id) ->
    $("#call_signature_id").val id
    $.cookie "signature", id

  if $.cookie('signature')
    $('form.petition-form').addClass('is-hidden')
    $(".petition-submitted").show().removeClass('is-hidden')
    setSignatureId $.cookie('signature')

  else
    $("form.petition-form").asyncify (data) ->
      containerHeight = $(this).height()

      $(this).fadeOut("slow").addClass("is-hidden")
      $(".petition-submitted")
        .height(containerHeight)
        .fadeIn("slow")
        .removeClass("is-hidden")

      setSignatureId data.secure_key
      return
