var search = {
	load_more_questions: function(){
		var next_page = $("next_q_page").getValue().strip();
		var query = $("query").getValue().strip();
		
		new Ajax.Request("/search/load_more_questions",{
			method:"POST",
			parameters:{
				next_q_page: next_page,
				query: query
			},
			onSuccess:function(response){
			},
			onFailure:function(response){
				alert("There is a problem in loading more questions. We have noted the problem. Try reloading the page(Control + R)");			
			}
		});
		
	},
	
	load_more_links: function(){
		var next_page = $("next_l_page").getValue().strip();
		var query = $("query").getValue().strip();
		
		new Ajax.Request("/search/load_more_links",{
			method:"POST",
			parameters:{
				next_l_page: next_page,
				query: query
			},
			onSuccess:function(response){
			},
			onFailure:function(response){
				alert("There is a problem in loading more links. We have noted the problem. Try reloading the page(Control + R)");			
			}
		});
		
	},
	
	list_question_results:function(){
		if ( $("q_results") !== null ){
			$("l_results").removeClassName("selected");
			$("q_results").addClassName("selected");
			$("question_results").show();
			$("link_results").hide();
			$("more_links") && $("more_links").hide();
			$("more_questions") && $("more_questions").show();
		}
	},
	
	list_link_results:function(){
		if ( $("l_results") !== null ){
			$("q_results").removeClassName("selected");
			$("l_results").addClassName("selected");
			$("link_results").show();
			$("question_results").hide();
			$("more_links") && $("more_links").show();
			$("more_questions") && $("more_questions").hide();
		}
	},
	
	house_keeping:function(){
		search.list_question_results();
		if ( $("q_results") !== null ){
			$("q_results").observe("click", function(event){
				search.list_question_results();
				event.stop();
			});
		}
		
		if ( $("l_results") !== null ){
			$("l_results").observe("click", function(event){
				search.list_link_results();
				event.stop();
			});
		}
		
		$("more_links") && $("more_links").observe("click", function(event){
			search.load_more_links();
			event.stop();
			
		});
		
		$("more_questions") && $("more_questions").observe("click", function(event){
			search.load_more_questions();
			event.stop();
			
		});
		
		["q_results","l_results"].each(function(element){
			if ( $(element) !== null ) {
				$(element).observe("mouseover", function(event){
					if ( $(element).hasClassName("selected") === false ){
						$(element).addClassName("hovered");
					}
				});
			
				$(element).observe("mouseout", function(event){
					if ( $(element).hasClassName("hovered") === true ){
						$(element).removeClassName("hovered");
					}
				});
			}
		});
	}
};

search.house_keeping();