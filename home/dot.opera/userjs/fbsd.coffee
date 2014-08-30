###
// ==UserScript==
// @include http://forums.freebsd.org/*
// @include https://forums.freebsd.org/*
// ==/UserScript==
###

window.addEventListener 'load', ->
	s = document.createElement 'script'
	s.src = 'http://code.jquery.com/jquery-2.1.0.min.js'
	s.onload= go
	document.body.appendChild s

go = ->
	### 1. Remove `last post by ...' in topic overview ###
	$('.topics .row .icon dt')
		.css('line-height', '35px')
		.each ->
			link = $(this).find('.topictitle')[0].outerHTML
			unread = $(this).find('img[title="View first unread post"]').parent()
			if unread.length > 0
				unread = unread.attr('class', 'first-unread').html('(First unread)')[0].outerHTML
			else
				unread = ''
			$(this).html "#{link} #{unread}"

	### 9. Allow to mark forum as read by doubleclicking the icon ###
	$('#page-body').on 'dblclick', '.topiclist.forums dl', (e) ->
		return if e.offsetX > 0
		return if $(this).css('background-image').match('freebsd_topic_read')?

		id = $(this).find('.forumtitle').attr('href').match(/f=(\d+)/)[1]
		hash = $('a[accesskey=m]').attr('href').match(/hash=(.*)&/)[1]
		jQuery.ajax
			url: "/viewforum.php?hash=#{hash}&f=#{id}&mark=topics"
			success: => $(this).css 'background-image', 'url("/styles/freebsd/imageset/freebsd_topic_read.gif")'

