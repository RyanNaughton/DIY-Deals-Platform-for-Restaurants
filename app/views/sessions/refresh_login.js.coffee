
<% if @should_refresh_main %>
simplebanana.refresh_box("#main_content", "<%= escape_javascript(render "restaurants/main_content") %>")
<% end %>

<% if logged_in? %>
$("#signup").animate({opacity:0},500).slideUp(700)
<% else %>
$("#signup").animate({opacity:1},500).slideDown(700)
<% end %>

<% if is_admin? %>
add_to_page = (data) ->
  $(data).hide().appendTo('#right_bar').animate({opacity:1},500).slideDown()
$.get('/twitter_display', {}, add_to_page, 'html')
<% else %>
$("#twitter").animate({opacity:0},500).slideUp(500, (-> $(this).remove()))
<% end %>

simplebanana.refresh_box('#login', "<%= escape_javascript(render "restaurants/login") %>")

