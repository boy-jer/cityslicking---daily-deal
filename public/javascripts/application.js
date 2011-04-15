jQuery(function()
{
	
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
