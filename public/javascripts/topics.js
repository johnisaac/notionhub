document.observe('click', function(event){
	if ( event.findElement("#follow_topic")){
		
		new Ajax.Request("/topics/follow_topic", {
			method:"POST",
			parameters:{
				topic_id:$F("topic_id")
			},		
			onSuccess: function(response){				
				if ( response.responseText == "1"){
					var unfollow_topic = "<a href='#' id='unfollow_topic'>Unfollow Topic</a>"
					$(event.element()).replace(unfollow_topic);

					$("unfollow_topic").observe("click", function(event1){
						var follow_topic = "<a href='#' id='follow_topic'>Follow Topic</a>"
						$(event1.element()).replace(follow_topic);
						event1.stop();
					});
				} else{
					alert("You are already following this topic");
				}
			},
			onFailure:function(response){
				alert("Oops! Please try again later");
			}
		});
		

		event.stop();
	}
	
	if ( event.findElement("#unfollow_topic")){
		
		new Ajax.Request("/topics/unfollow_topic", {
			method:"POST",
			parameters:{
				topic_id:$F("topic_id")
			},		
			onSuccess: function(response){
				if ( response.responseText == "1"){
			
				var follow_topic = "<a href='#' id='follow_topic'>Follow Topic</a>"
				$(event.element()).replace(follow_topic);

				$("unfollow_topic").observe("click", function(event1){
					var follow_topic = "<a href='#' id='follow_topic'>Unfollow Topic</a>"
					$(event1.element()).replace(follow_topic);
					event1.stop();
				});
				} else{
					alert("You are not following this topic");
				}				
			},
			onFailure:function(response){
				alert("Oops! Please try again later");
			}
		});
		
		event.stop();
	}
	
	if ( event.findElement("#edit_topics")){
		$$("li.topics").each(function(element){
			$(element).insert({
				bottom:"<a href='#' class='delete_topic'>X</a>"
			})
		});
		
		var edit_topics_div = "<div id='edit_topics_div'><input type=text id='topic_name' size='40' autocomplete='off'/><div class='autocomplete' id='topics_list' style='display:none'></div><a href='#' id='done_topics'>done</a></div>";
		
		$(event.element()).replace(edit_topics_div);
		
		var topics_list = [
		  'ABBA',
		  'AC/DC',
		  'Aerosmith',
		  'America',
		  'Bay City Rollers',
		  'Black Sabbath',
		  'Boston',
		  'David Bowie',
		  'Can',
		  'The Carpenters',
		  'Chicago',
		  'The Commodores',
		  'Crass',
		  'Deep Purple',
		  'The Doobie Brothers',
		  'Eagles',
		  'Fleetwood Mac',
		  'Haciendo Punto en Otro Son',
		  'Heart',
		  'Iggy Pop and the Stooges',
		  'Journey',
		  'Judas Priest',
		  'KC and the Sunshine Band',
		  'Kiss',
		  'Kraftwerk',
		  'Led Zeppelin',
		  'Lindisfarne (band)',
		  'Lipps, Inc',
		  'Lynyrd Skynyrd',
		  'Pink Floyd',
		  'Queen',
		  'Ramones',
		  'REO Speedwagon',
		  'Rhythm Heritage',
		  'Rush',
		  'Sex Pistols',
		  'Slade',
		  'Steely Dan',
		  'Stillwater',
		  'Styx',
		  'Supertramp',
		  'Sweet',
		  'Three Dog Night',
		  'The Village People',
		  'Wings (fronted by former Beatle Paul McCartney)',
		  'Yes'
		];
		
		new Autocompleter.Local('topic_name', 'topics_list', topics_list, { });
		
		
		$('topics_list').observe('click',function(add_event){
			var new_topic_text = $(add_event.element()).innerHTML.stripTags();
			var new_topic = "<li class='topics left'><a href='#'>"+new_topic_text+"</a><a href='#' class='delete_topic'>X</a></li>"
			$("question_topics").insert({
				bottom:new_topic
			});
			
			topics_list = topics_list.without(new_topic);
			$('topic_name').clear();
			add_event.stop();
		});
		
		$("done_topics").observe('click', function(done_event){
			$$("li.topics  a.delete_topic").each(function(element){
				$(element).remove();
			});
			
			$("edit_topics_div").replace("<a href='#' id='edit_topics'>edit</a>");
			done_event.stop();
		});
		
		$$("a.delete_topic").each(function(delete_element){
			$(delete_element).observe('click', function(delete_event){
				$(delete_event.element()).up("li.topics").remove();
				delete_event.stop();
			});
		});
		
		event.stop();
	}
	
});

