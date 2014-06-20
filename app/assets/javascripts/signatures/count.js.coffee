$ ->

  loadSignatureCount = ->
    $.getJSON "/signatures/count", (data) ->
      $(".signature-count").html(data.count)
      $(".petition-count").removeClass("is-hidden")

  loadSignatureCount()
  setInterval loadSignatureCount, 120000
  return
