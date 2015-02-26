$ ->

  loadRepresentativeInfo = (data) ->
    $("#call-box, form.new_call, .phone-script-block").removeClass "is-hidden"
    $("#rep-info .rep-image-container img").prop "src", data.image_url
    $("#rep-info p.person").html data.fullname
    $(".legislator-name").html data.fullname
    $("#rep-info p.stat a.facebook").prop "href", data.facebook_url
    $("#rep-info p.stat a.website").prop "href", data.website
    $("#rep-info p.stat a.telephone").prop("href", "tel:" + data.phone).html data.phone
    $("#rep-info p.stat a.twitter").prop "href", "http://twitter.com/intent/tweet?text=As%20your%20constituent%20I%20ask%20you%20vote%20to%20pass%20the%20Voting%20Rights%20Amendment%20Act%202015%20%40" + data.twitter_id
    $("#call_legislator_id").val data.id

  if $.cookie('representativeInfo')?
    $("form.zipcode-form").addClass("is-hidden")
    repInfo = JSON.parse($.cookie('representativeInfo'))
    loadRepresentativeInfo(repInfo)
  else
    $("form.zipcode-form").asyncify
      before: (form) ->
        $(form).find('input[type="submit"]').prop('disabled', true).val('Looking...')

      then: (data) ->
        $(this).addClass "is-hidden"
        loadRepresentativeInfo(data)
        $.cookie('representativeInfo', JSON.stringify(data))

  $("form.new_call").asyncify
    before: (form) ->
      $(form).find('input[type="submit"]').prop('disabled', true).val('Calling...')

    then: (data) ->
      $(this).addClass "is-hidden"
      $(this).closest("#call-box").find(".survey-form").removeClass "is-hidden"
      $("form.call-survey").attr('action', "/calls/#{data.id}")
      return

  $('form.call-survey').asyncify (data) ->
    $('.survey-form').addClass "is-hidden"
    $(this).closest("#call-box").find(".survey-form-response").removeClass "is-hidden"
