function loadScript(b){var a;var c;c=$$("head")[0];if(c){a=new Element("script",{type:"text/javascript",src:b});c.wrap(a)}}var notification={showMessage:function(a){$("notification").update(a);$("notification").addClassName("message");window.setTimeout(notification.hideMessage(),5000)},hideMessage:function(){$("notification").update(" ");$("notification").removeClassName("message")}};
var application={
	setActive:function(a){
		$$("#features a").each(function(b){
			$(b).removeClassName("active-current");
		});
		//$(a).addClassName("active-current");
	},
	
	fbLike:function(){
		var fbButton = "<iframe src='http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fexample.com%2Fpage%2Fto%2Flike&amp;layout=button_count&amp;show_faces=false&amp;width=450&amp;action=like&amp;font=lucida+grande&amp;colorscheme=light&amp;height=21' scrolling='no' frameborder='0' style='border:none; overflow:hidden; width:450px; height:21px;' allowTransparency='true'></iframe>";
		$("social").insert({top:fbButton});
	}
};

// on mouse over on login, show login using fb,
// login using email as a bottom div
document.observe("dom:loaded", function(home_event) {
	$$("#drop_down_span a.login_method").each(function(element){
		$(element).hide();
	});
	
	$$("#drop_down_span a.drop_down").each(function(element){
		$(element).hide();
	});
	
	$("login") && $("login").observe("mouseover", function(event){
		$("login") && $("login").addClassName("hovered");
		$("user_name") && $("user_name").addClassName("hovered");
		
		$$("#drop_down_span a.drop_down").each(function(element){
			if ( ( $(element).id !== "login" ) && ( $(element).id !== "user_name" ) ){
				$(element).show();
			}
		});
		
		event.stop();
	});
	
	$$("#drop_down_span a.drop_down").each(function(element){
		
		$(element).observe("mouseover", function(event){
			$("login") && $("login").addClassName("hovered");
			$$("#drop_down_span a.drop_down").each(function(element){
				$(element).show();
			});
			
			event.stop();
		});
		
		$(element).observe("mouseout", function(event){
			$("login") && $("login").addClassName("hovered");
			$$("#drop_down_span a.drop_down").each(function(element){
				$(element).hide();
			});
			$("login") && $("login").removeClassName("hovered");
			
			event.stop();
		});
		
	});
	
	$("login") && $("login").observe("mouseout", function(event){
		$("login") && $("login").removeClassName("hovered");
		$("user_name") && $("user_name").removeClassName("hovered");
		
		$$("#drop_down_span a.drop_down").each(function(element){
			if ( ( $(element).id !== "login" ) && ( $(element).id !== "user_name" ) ){
				$(element).hide();
			}
		});
		
		event.stop();
	});

	$("search_button").observe("click", function(event){	
		if ( $F("query").length > 0 ){
			location.replace("http://notionhub.com/search/?query="+$F("query"));
		} else {
			var search_msg = "<div class='span-8 push-12 rounded-corners' id='search_msg'><div>You have to enter some search term.</div>";
			$("tagline").insert({bottom: search_msg});
		}
		
		event.stop();
	});
});