# jQuery Tiny Pub/Sub - v0.7 - 10/27/2011
# http://benalman.com/
# Copyright (c) 2011 "Cowboy" Ben Alman; Licensed MIT, GPL
(($) ->
  o = $({})
  $.subscribe = -> o.on.apply(o, arguments)
  $.unsubscribe = -> o.off.apply(o, arguments)
  $.publish = -> o.trigger.apply(o, arguments)
)(jQuery)

window.simplebanana = simplebanana = {}

is_signed_in = -> $('#signup').css('display') == 'none'

deal_is_over = -> $("#time_remaining h2").text() == "It's over!"

confirm_popover = ->
  bg = $('<div id="buy_confirm_bg"></div>')
  dialog = $('<div id="buy_confirm_dialog"></div>')
  text = $("<h2>Are you sure you want to buy this deal?</h2>")
  buy = $('<a href="/buyit" class="buy" data-remote="true" data-method="post">Yes!</a>')
  close = $('<a href="#" class="close">No, thanks.</a>')
  bg.css('z-index', 10)
  dialog.css('z-index', 11)
  text.css('z-index', 12)
  buy.css('z-index', 12)
  close_popover = (e) ->
    if e.target == this
      bg.remove()
      dialog.remove()
  close.click(close_popover)
  bg.click(close_popover)
  text.appendTo(dialog)
  buy.appendTo(dialog)
  close.appendTo(dialog)
  bg.append(dialog)
  $("body").prepend(bg)

click_buy = ->
  confirm_popover() if is_signed_in() and !deal_is_over()
  false

$.subscribe('refreshed_main_content',
  -> $("#buy_now").click(click_buy) if $('#buy_now').length > 0
)

simplebanana.update_quantity = update_quantity = {}
update_quantity.should_run = false
update_quantity.start_stop = ->
  if $('#quantity_remaining').length > 0 and not this.should_run
    # should run and not already running
    this.should_run = true
    this.func()
  else
    this.should_run = false
update_quantity.func = ->
  should_run = this.should_run
  send_request = (cb)->
    $.get("/quantity", cb)
    false
  update_dom = (data)->
    num = data.quantity
    elem = $("#quantity_remaining h2 span")
    elem.text(num)
    setTimeout((-> update_quantity.func()), 3000) if num > 0 and should_run
    false
  send_request(update_dom)
  false

$.subscribe('refreshed_main_content',
  -> update_quantity.start_stop()
)

simplebanana.update_purchased_deals = update_purchased_deals = {}
update_purchased_deals.should_run = false
update_purchased_deals.start_stop = ->
  if $('#deal_codes').length > 0
    this.should_run = true
    this.func()
  else
    this.should_run = false
update_purchased_deals.func = ->
  should_run = this.should_run
  send_request = (cb)->
    $.get("/purchased_deals", cb, 'json')
    false
  update_dom = (data) ->
    update_deal_code = (dom_id, name) ->
      name_elem = $("##{dom_id}").children('.name')
      if name_elem.text() !=  name
        name_elem.css('display', 'none').text(name).fadeIn(500)
    update_deal_code(dom_id, name) for dom_id, name of data
    setTimeout((-> update_purchased_deals.func()), 3000) if should_run
    false
  send_request(update_dom)

$.subscribe('refreshed_main_content',
  -> update_purchased_deals.start_stop()
)

simplebanana.update_time_remaining =  update_time_remaining = {}
update_time_remaining.should_run = false
update_time_remaining.deal_end_time = undefined
update_time_remaining.start_stop = ->
  if $('#end_on_unix_time').length > 0
    this.deal_end_time = $('#end_on_unix_time').text()
    if not this.should_run  # not already running
      this.should_run = true
      this.func()
  else
    this.should_run = false
update_time_remaining.func = ->
  current_time = (new Date()).getTime()/1000
  end_time = this.deal_end_time
  time_diff = end_time - current_time
  units = (Math.floor(time_diff / div % 60).toString() for div in [3600, 60, 1])
  units = (((if unit.length < 2 then "0" else "") + unit) for unit in units)
  time_left = (units[0] + units[1] + units[2]) > 0
  if time_left
    time_string = "#{units[0]}:#{units[1]}:#{units[2]}"
    $("#time_remaining .highlight").text(time_string)
    setTimeout((-> update_time_remaining.func()), 1000) if this.should_run
  else
    $("#time_remaining h2").text("It's over!")
  false

$.subscribe('refreshed_main_content',
  -> update_time_remaining.start_stop()
)

simplebanana.refresh_box = (box_id, new_html) ->
  remove = -> $(this).remove()
  box = $(box_id)
  old_stuff = box.children('div')
  new_stuff = $(new_html).children('div')
  box.height(old_stuff.height())
  box.css('position', 'relative')
  old_stuff.css('position', 'absolute')
  new_stuff.css('position', 'absolute')
  old_stuff.fadeOut(300, remove)
  new_stuff
    .hide()
    .appendTo(box)
    .fadeIn(600)
  trigger_event = ->
    $.publish('refreshed_main_content') if box_id == '#main_content'
  $(box).animate({height: new_stuff.height()}, 600, trigger_event)

$.subscribe('refreshed_main_content',
  -> simplebanana.form_validations() if $('#deal_create_form').length > 0
)

$.subscribe('refreshed_main_content',
  -> simplebanana.deal_expander() if $('#recent_deals').length > 0
)

$(->
  $.publish('refreshed_main_content')
)

$.subscribe('refreshed_main_content',
  -> console.log('refreshed_main_content')
)