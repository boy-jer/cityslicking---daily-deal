jQuery(function()
{
		
	function lightbox(url)
	{
    window.scrollTo(0,0);
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
	
	$('div#featured-deals a.save-feature').click(function()
	{
		lightbox('/save/feature/' + $(this).attr('href'));
		return false;
	});
	
	$('a.save-deal, div.doc a.save-feature').click(function()
	{
		lightbox('/save/deal/' + $(this).attr('href'));
		return false;
	});
	
	$('a.save-mobile').click(function()
	{
		lightbox('/save/mobile/' + $(this).attr('href'));
		return false;
	});
		
	$('#current-city').click(function()
	{
		$('#other-cities').toggle("blind");
		return false;
	});
	
	$('#admin').click(function()
	{
		$('#admin-links').toggle("blind");
		return false;
	});
	
	$('#next-city-link').click(function()
	{
		$('#other-cities').toggle("blind");
		lightbox('/next-city');
		return false;
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
	
	$('.deal-listing').click(function()
	{
		$(this).slideUp(100);
		$(this).next().slideDown(100);
		return false;
	});

	$('.doc .deal').mouseleave(function()
	{
		$(this).delay(100).slideUp(100);
		$(this).prev().delay(100).slideDown(100);
		return false;
	});
	
	$('#use-physical-address').click(function()
	{
		$('#mailing_street').val($('#physical_street').val());
		$('#mailing_city').val($('#physical_city').val());
		$('#mailing_state').val($('#physical_state').val());
		$('#mailing_zip').val($('#physical_zip').val());
		return false;
	});

	if ($('.share-this-deal').length > 0)
	{
		$('div.share').effect("pulsate", { times:3 }, 1000);
		$('div.share form p input.textfield').select();
	}
	
});
