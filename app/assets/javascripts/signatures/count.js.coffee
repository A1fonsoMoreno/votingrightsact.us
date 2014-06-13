$ ->
  loadSignatureCount = ->
    $.getJSON "/signatures/count", (data) ->
      $("#signature_count").html data.count
      return
    return

  loadSignatureCount()
  setInterval loadSignatureCount, 5000
  return