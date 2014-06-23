$ ->

  loadSignatureCount = ->
    $.getJSON "/signatures/count", (data) ->
      signatureCount = data.count.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      $(".signature-count").html(signatureCount)
      $(".petition-count").removeClass("is-hidden")

  loadSignatureCount()
  setInterval loadSignatureCount, 120000
  return
