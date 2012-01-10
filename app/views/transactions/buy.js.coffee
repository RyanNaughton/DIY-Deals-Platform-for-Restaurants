




bg = $("#buy_confirm_bg")
dialog = $("#buy_confirm_dialog")

close = (e) ->
  return false if e.target != this
  console.log("returned close")
  bg.remove()
  dialog.remove()

add_code = ->
  message = $('''<h2>Congratulations!
          Your code is <%= @transaction.deal_code %>.
          Take it to the restaurant to redeem it.</h2>
          <a href="#" class="close">close</a>''')
  message.hide().appendTo(dialog).fadeIn(400)
  console.log("close button")
  console.log($("#buy_confirm_dialog a.close"))
  $("#buy_confirm_dialog a.close").click(close)



dialog.contents().fadeOut(400)
setTimeout(add_code, 400)
