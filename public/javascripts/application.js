jQuery(function()
{
	
	function lightbox(url)
	{
		$('div#lightbox, img#close, div#shadow').toggle('fade');
		$('#lightbox').load(url);
	}
	
	$('img#close').click(function()
	{
		$('div#lightbox, img#close, div#shadow').toggle('fade');
		$('div#lightbox').html('');
	});
	
	$('a.sign-in').click(function()
	{
		lightbox('/sign-in');
		return false;
	});
	
	function toggle_feature(feature)
	{
		if ( $('#feature-1').is(":visible") ) { $('#feature-1').hide('fade'); }
		if ( $('#feature-2').is(":visible") ) { $('#feature-2').hide('fade'); }
		if ( $('#feature-3').is(":visible") ) { $('#feature-3').hide('fade'); }
		$('#feature-' + feature).show('fade');
	}
		
	$('.button-1, .arrow-1').click(function()
	{
		toggle_feature(1);
		return false;
	});

	$('.button-2, .arrow-2').click(function()
	{
		toggle_feature(2);
		return false;
	});

	$('.button-3, .arrow-3').click(function()
	{
		toggle_feature(3);
		return false;
	});
	
	$('a.save').click(function()
	{
		lightbox('/save/deal/' + $(this).attr('href'));
		return false;
	});
		
	$('#current-city').click(function()
	{
		$('#other-cities').toggle("blind");
	});
	
	if ($('#finish-verification').length)
	{
		$.PeriodicalUpdater(
		{
			url: '/optedin', method : 'get', minTimeout: 3000, multiplier: 1.1
		}, function(data)
		{
			$('#finish-verification').html(data);
		});
	}
	
});
