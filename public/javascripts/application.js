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
		
	var deal_timer = setInterval(function()
	{
		featured_deal($("#right-arrow").attr("href"));
	}, 8000);
	
	function featured_deal(position)
	{
		if (position == 1)
		{
		  $("#deal-1").animate({left: "7px"}, 300 );
			$("#deal-2").animate({left: "807px"	}, 300 );
			$("#deal-3").animate({left: "1607px"	}, 300 );
			$("#button-1, #button-2, #button-3").removeClass("active inactive").addClass("inactive");
			$("#button-1").removeClass("inactive").addClass("active");
			$("#left-arrow").attr("href", "3");
			$("#right-arrow").attr("href", "2");
		}
		else if (position == 2)
		{
		  $("#deal-1").animate({left: "-793px"}, 300 );
			$("#deal-2").animate({left: "7px"	}, 300 );
			$("#deal-3").animate({left: "807px"	}, 300 );
			$("#button-1, #button-2, #button-3").removeClass("active inactive").addClass("inactive");
			$("#button-2").removeClass("inactive").addClass("active");
			$("#left-arrow").attr("href", "1");
			$("#right-arrow").attr("href", "3");
		}
		else if (position == 3)
		{
		  $("#deal-1").animate({left: "-1593px"}, 300 );
			$("#deal-2").animate({left: "-793px"	}, 300 );
			$("#deal-3").animate({left: "7px"	}, 300 );
			$("#button-1, #button-2, #button-3").removeClass("active inactive").addClass("inactive");
			$("#button-3").removeClass("inactive").addClass("active");
			$("#left-arrow").attr("href", "2");
			$("#right-arrow").attr("href", "1");
		}
	}
			
	$('#button-1').click(function()
	{
		clearInterval(deal_timer);
		featured_deal(1);
		return false;
	});

	$('#button-2').click(function()
	{
		clearInterval(deal_timer);
		featured_deal(2);
		return false;
	});

	$('#button-3').click(function()
	{
		clearInterval(deal_timer);
		featured_deal(3);
		return false;
	});
	
	$("#left-arrow").click(function()
	{
		clearInterval(deal_timer);
		featured_deal($("#left-arrow").attr("href"));
		return false;
	});

	$("#right-arrow").click(function()
	{
		clearInterval(deal_timer);
		featured_deal($("#right-arrow").attr("href"));
		return false;
	});
	
	var mobile_deal_timer = setInterval(function()
	{
		mobile_featured_deal($('span#deal-counter').attr('class'));
	}, 8000);
	
	function mobile_featured_deal(position)
	{
		if (position == 1)
		{
			$("#feature-1, #feature-2, #feature-3").hide();
			$("#feature-1").show();
			$("#mobile-btn-1, #mobile-btn-2, #mobile-btn-3").removeClass("active inactive").addClass("inactive");
			$("#mobile-btn-1").removeClass("inactive").addClass("active");
			$("#deal-counter").attr("class", "2");
		}
		else if (position == 2)
		{
			$("#feature-1, #feature-2, #feature-3").hide();
			$("#feature-2").show();
			$("#mobile-btn-1, #mobile-btn-2, #mobile-btn-3").removeClass("active inactive").addClass("inactive");
			$("#mobile-btn-2").removeClass("inactive").addClass("active");
			$("#deal-counter").attr("class", "3");
		}
		else if (position == 3)
		{
			$("#feature-1, #feature-2, #feature-3").hide();
			$("#feature-3").show();
			$("#mobile-btn-1, #mobile-btn-2, #mobile-btn-3").removeClass("active inactive").addClass("inactive");
			$("#mobile-btn-3").removeClass("inactive").addClass("active");
			$("#deal-counter").attr("class", "1");
		}
	}
	
	
	$("#mobile-btn-1").click(function()
	{
		clearInterval(mobile_deal_timer);
		mobile_featured_deal(1);
		return false;
	});

	$("#mobile-btn-2").click(function()
	{
		clearInterval(mobile_deal_timer);
		mobile_featured_deal(2);
		return false;
	});

	$("#mobile-btn-3").click(function()
	{
		clearInterval(mobile_deal_timer);
		mobile_featured_deal(3);
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
