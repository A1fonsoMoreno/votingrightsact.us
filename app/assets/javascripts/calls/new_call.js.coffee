$ ->

  loadRepresentativeInfo = (data) ->
    $("#call-box, form.new_call").removeClass "is-hidden"
    $("#rep-info .rep-image-container img").prop "src", data.image_url
    $("#rep-info p.person").html data.fullname
    $("#rep-info p.stat a.facebook").prop "href", data.facebook_url
    $("#rep-info p.stat a.website").prop "href", data.website
    $("#rep-info p.stat a.telephone").prop("href", "tel:" + data.phone).html data.phone
    $("#rep-info p.stat a.twitter").prop "href", "https://twitter.com/intent/tweet?text=As%20your%20constituent%20I%20ask%20you%20vote%20to%20pass%20the%20Voting%20Rights%Ammendment%20Act%20%40" + data.twitter_id
    $("#call_legislator_id").val data.id

  if $.cookie('representativeInfo')?
    $("form.zipcode-form").addClass("is-hidden")
    repInfo = JSON.parse($.cookie('representativeInfo'))
    loadRepresentativeInfo(repInfo)
  else
    $("form.zipcode-form").asyncify (data) ->
      $(this).addClass "is-hidden"
      loadRepresentativeInfo(data)
      $.cookie('representativeInfo', JSON.stringify(data))

  $("form.new_call").asyncify ->
    $(this).addClass "is-hidden"
    $(this).closest("#call-box").find("div.survey-form").removeClass "is-hidden"
    return
