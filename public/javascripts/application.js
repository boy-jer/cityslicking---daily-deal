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
	
	$('a#sign-in').click(function()
	{
		lightbox('/sign-in');
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
