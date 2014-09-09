lock = false
started = false
intervalTimer = null
dispatcher = new WebSocketRails(location.host + '/websocket')

channel = dispatcher.subscribe(channel_token)

channel.on_success = (response) ->
  console.log response.message    

channel.on_failure = (response) ->
  console.log response.message

animateOnIdle = (duration=1000) ->
	console.log 'idle animate'
	$('.asphalt').animate({'background-position-y': '+=1000px'},  duration ,'linear', animateOnIdle)


$(document).on 'touchmove', (e)->
	e = e.originalEvent
	e.preventDefault()
	e.stopPropagation()
	if !started
		$('.tap').fadeOut('slow');
		started = true
	if lock 
		return true
	else
		setTimeout ->
			lock = false
		, 500	
		clearInterval(intervalTimer)	
		$('.asphalt').stop().animate({'background-position-y': '+=6000px'}, 1000, 'linear', animateOnIdle )
		
		console.log 'scroll'
		channel.trigger 'mobile.track', 1
		lock = true

