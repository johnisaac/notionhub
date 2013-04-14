var profile = {
	show_questions: function(){
		$("user_questions").show();
		['user_links','user_answers'].each(function(tab){
			$(tab).hide();
		});		
		
		['link_label','answer_label'].each(function(tab){
			$(tab).removeClassName("selected")
		});
		$("question_label").addClassName("selected");
	},
	show_links: function(){
		$("user_links").show();
		['user_answers','user_questions'].each(function(tab){
			$(tab).hide();
		});
		
		['question_label','answer_label'].each(function(tab){
			$(tab).removeClassName("selected")
		});
		$("link_label").addClassName("selected");
	},
	
	show_answers: function(){
		$("user_answers").show();
		['user_links','user_questions'].each(function(tab){
			$(tab).hide();
		});
		['question_label','link_label'].each(function(tab){
			$(tab).removeClassName("selected")
		});
		$("answer_label").addClassName("selected");
	},
	
	house_keeping: function(){
		profile.show_questions();
		$("link_label").observe("click", function(event){
			profile.show_links();
			event.stop();
		});
		
		$("question_label").observe("click", function(event){
			profile.show_questions();
			event.stop();
		});
		
		$("answer_label").observe("click", function(event){
			profile.show_answers();
			event.stop();
		});
		
		["question_label","link_label","answer_label"].each(function(a){
			$(a).observe("mouseover",function(b){
				if($(a).hasClassName("selected")===false){
					$(a).addClassName("hovered");
				}
			});
			
			$(a).observe("mouseout",function(b){
				if($(a).hasClassName("hovered")===true){
					$(a).removeClassName("hovered");
				}
			});
		});
	}
};

profile.house_keeping();