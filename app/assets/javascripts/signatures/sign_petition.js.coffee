$ ->
  if $.cookie('signed') == '1'
    $('form.petition-form').addClass('is-hidden')
    $(".petition-submitted").show().removeClass('is-hidden')
  else
    $("form.petition-form").asyncify (data) ->
      containerHeight = $(this).height()

      $(this).fadeOut("slow").addClass("is-hidden")
      $(".petition-submitted")
        .height(containerHeight)
        .fadeIn("slow")
        .removeClass("is-hidden")
      $("#call_signature_id").val data.id

      $.cookie "signed", "1"
      return
