# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
	$ ->
  	$('.item').click ->
  		videoId = $(this).data('video-id')
  		videoType = $(this).data('video-type')
  		$('#osx-modal-title').html($(this).data('title'))

  		$('#osx-modal-data').html($(this).data('body'))

  		switch videoType
  			when 'YoutubeVideo' then $('#osx-modal-data').prepend('<iframe width="400" height="315" src="//www.youtube.com/embed/' + videoId + '"' + 'frameborder="0" allowfullscreen></iframe>')

  			when 'VimeoVideo' then $('#osx-modal-data').prepend('<iframe src="http://player.vimeo.com/video/'+ videoId + '"' + 'width="400" height="315" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>')
