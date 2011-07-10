jQuery(function()
{

	var deal_timer = setInterval(function()
	{
		featured_deal($("#right-arrow").attr("href"));
	}, 8000);
	
	function featured_deal(position)
	{
		var f_count = $('#feature-count').attr('class');
		var left 	= parseInt(position) - 1;
		var right = parseInt(position) + 1;
		if (position == 1) 	 { left = f_count; }
		if (right > f_count) { right = 1; 		 }
		
		if (position == 1)
		{
		  $("#deal-1").animate({left: "7px"			}, 300 );
			$("#deal-2").animate({left: "807px"	  }, 300 );
			$("#deal-3").animate({left: "1607px"	}, 300 );
			$("#deal-4").animate({left: "2407px"	}, 300 );
			$("#deal-5").animate({left: "3207px"	}, 300 );
			$("#deal-6").animate({left: "4007px"	}, 300 );
			$("#deal-7").animate({left: "4807px"	}, 300 );
		}
		else if (position == 2)
		{
			$("#deal-1").animate({left: "-793px"	}, 300 );
			$("#deal-2").animate({left: "7px"	  	}, 300 );
			$("#deal-3").animate({left: "807px"	  }, 300 );
			$("#deal-4").animate({left: "1607px"	}, 300 );
			$("#deal-5").animate({left: "2407px"	}, 300 );
			$("#deal-6").animate({left: "3207px"	}, 300 );
			$("#deal-7").animate({left: "4007px"	}, 300 );
		}
		else if (position == 3)
		{
			$("#deal-1").animate({left: "-1593px"	}, 300 );
			$("#deal-2").animate({left: "-793px"	}, 300 );
			$("#deal-3").animate({left: "7px"			}, 300 );
			$("#deal-4").animate({left: "807px"		}, 300 );
			$("#deal-5").animate({left: "1607px"	}, 300 );
			$("#deal-6").animate({left: "2407px"	}, 300 );
			$("#deal-7").animate({left: "3207px"	}, 300 );
		}
		else if (position == 4)
		{
			$("#deal-1").animate({left: "-2393px"	}, 300 );
			$("#deal-2").animate({left: "-1593px"	}, 300 );
			$("#deal-3").animate({left: "-793px"	}, 300 );
			$("#deal-4").animate({left: "7px"			}, 300 );
			$("#deal-5").animate({left: "807px"		}, 300 );
			$("#deal-6").animate({left: "1607px"	}, 300 );
			$("#deal-7").animate({left: "2407px"	}, 300 );
		}
		else if (position == 5)
		{
			$("#deal-1").animate({left: "-3193px"	}, 300 );
			$("#deal-2").animate({left: "-2393px"	}, 300 );
			$("#deal-3").animate({left: "-1593px"	}, 300 );
			$("#deal-4").animate({left: "-793px"	}, 300 );
			$("#deal-5").animate({left: "7px"			}, 300 );
			$("#deal-6").animate({left: "807px"		}, 300 );
			$("#deal-7").animate({left: "1607px"	}, 300 );
		}
		else if (position == 6)
		{
			$("#deal-1").animate({left: "-3993px"	}, 300 );
			$("#deal-2").animate({left: "-3193px"	}, 300 );
			$("#deal-3").animate({left: "-2393px"	}, 300 );
			$("#deal-4").animate({left: "-1593px"	}, 300 );
			$("#deal-5").animate({left: "-793px"	}, 300 );
			$("#deal-6").animate({left: "7px"			}, 300 );
			$("#deal-7").animate({left: "807px"		}, 300 );
		}
		else if (position == 7)
		{
			$("#deal-1").animate({left: "-4793px"	}, 300 );
			$("#deal-2").animate({left: "-3993px"	}, 300 );
			$("#deal-3").animate({left: "-3193px"	}, 300 );
			$("#deal-4").animate({left: "-2393px"	}, 300 );
			$("#deal-5").animate({left: "-1593px"	}, 300 );
			$("#deal-6").animate({left: "-793px"	}, 300 );
			$("#deal-7").animate({left: "7px"			}, 300 );
		}
		
		$("#left-arrow").attr("href", left);
		$("#right-arrow").attr("href", right);
		$("#button-1, #button-2, #button-3, #button-4, #button-5, #button-6, #button-7").removeClass("active inactive").addClass("inactive");
		$("#button-" + position).removeClass("inactive").addClass("active");
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

	$('#button-4').click(function()
	{
		clearInterval(deal_timer);
		featured_deal(4);
		return false;
	});
	
	$('#button-5').click(function()
	{
		clearInterval(deal_timer);
		featured_deal(5);
		return false;
	});
	
	$('#button-6').click(function()
	{
		clearInterval(deal_timer);
		featured_deal(6);
		return false;
	});
	
	$('#button-7').click(function()
	{
		clearInterval(deal_timer);
		featured_deal(7);
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
		$("#feature-1, #feature-2, #feature-3, #feature-4, #feature-5, #feature-6, #feature-7").hide();
		$("#feature-" + position).show();
		$("#mobile-btn-1, #mobile-btn-2, #mobile-btn-3, #mobile-btn-4, #mobile-btn-5, #mobile-btn-6, #mobile-btn-7").removeClass("active inactive").addClass("inactive");
		$("#mobile-btn-" + position).removeClass("inactive").addClass("active");

		var f_count = $('#feature-count').attr('class');
		var next 		= parseInt(position) + 1;
		if (next > f_count) { next = 1 };
		$("#deal-counter").attr("class", next);
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

	$("#mobile-btn-4").click(function()
	{
		clearInterval(mobile_deal_timer);
		mobile_featured_deal(4);
		return false;
	});
	
	$("#mobile-btn-5").click(function()
	{
		clearInterval(mobile_deal_timer);
		mobile_featured_deal(5);
		return false;
	});
	
	$("#mobile-btn-6").click(function()
	{
		clearInterval(mobile_deal_timer);
		mobile_featured_deal(6);
		return false;
	});
	
	$("#mobile-btn-7").click(function()
	{
		clearInterval(mobile_deal_timer);
		mobile_featured_deal(7);
		return false;
	});
		
});