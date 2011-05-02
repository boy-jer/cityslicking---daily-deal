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
	
	function featured_deal(position)
	{
		if (position == 1)
		{
		  $("#deal-1").animate({left: "7px"}, 300 );
			$("#deal-2").animate({left: "787px"	}, 300 );
			$("#deal-3").animate({left: "1567px"	}, 300 );
			$("#button-1, #button-2, #button-3").removeClass("active inactive").addClass("inactive");
			$("#button-1").removeClass("inactive").addClass("active");
			$("#left-arrow").attr("href", "3");
			$("#right-arrow").attr("href", "2");
		}
		else if (position == 2)
		{
		  $("#deal-1").animate({left: "-773px"}, 300 );
			$("#deal-2").animate({left: "7px"	}, 300 );
			$("#deal-3").animate({left: "787px"	}, 300 );
			$("#button-1, #button-2, #button-3").removeClass("active inactive").addClass("inactive");
			$("#button-2").removeClass("inactive").addClass("active");
			$("#left-arrow").attr("href", "1");
			$("#right-arrow").attr("href", "3");
		}
		else if (position == 3)
		{
		  $("#deal-1").animate({left: "-1553px"}, 300 );
			$("#deal-2").animate({left: "-773px"	}, 300 );
			$("#deal-3").animate({left: "7px"	}, 300 );
			$("#button-1, #button-2, #button-3").removeClass("active inactive").addClass("inactive");
			$("#button-3").removeClass("inactive").addClass("active");
			$("#left-arrow").attr("href", "2");
			$("#right-arrow").attr("href", "1");
		}
	}
			
	$('#button-1').click(function()
	{
		featured_deal(1);
		return false;
	});

	$('#button-2').click(function()
	{
		featured_deal(2);
		return false;
	});

	$('#button-3').click(function()
	{
		featured_deal(3);
		return false;
	});
	
	$("#left-arrow").click(function()
	{
		featured_deal($("#left-arrow").attr("href"));
		return false;
	});

	$("#right-arrow").click(function()
	{
		featured_deal($("#right-arrow").attr("href"));
		return false;
	});
	
	$("#mobile-btn-1").click(function()
	{
		$("#feature-1, #feature-2, #feature-3").hide();
		$("#feature-1").show();
		$("#mobile-btn-1, #mobile-btn-2, #mobile-btn-3").removeClass("active inactive").addClass("inactive");
		$("#mobile-btn-1").removeClass("inactive").addClass("active");
		return false;
	});

	$("#mobile-btn-2").click(function()
	{
		$("#feature-1, #feature-2, #feature-3").hide();
		$("#feature-2").show();
		$("#mobile-btn-1, #mobile-btn-2, #mobile-btn-3").removeClass("active inactive").addClass("inactive");
		$("#mobile-btn-2").removeClass("inactive").addClass("active");
		return false;
	});

	$("#mobile-btn-3").click(function()
	{
		$("#feature-1, #feature-2, #feature-3").hide();
		$("#feature-3").show();
		$("#mobile-btn-1, #mobile-btn-2, #mobile-btn-3").removeClass("active inactive").addClass("inactive");
		$("#mobile-btn-3").removeClass("inactive").addClass("active");
		return false;
	});
	
	$('a.save').click(function()
	{
		lightbox('/save/deal/' + $(this).attr('href'));
		return false;
	});

	$('a.tell-a-friend').click(function()
	{
		lightbox('/share/deal/' + $(this).attr('href'));
		return false;
	});
		
	$('#current-city').click(function()
	{
		$('#other-cities').toggle("blind");
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
	
});
