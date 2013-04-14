var manage = {
	"description": "",
    show_questions: function() {["account", "links"].each(function(a) {
            $(a).hide()
        });["account_label", "link_label"].each(function(a) {
            $(a).removeClassName("selected")
        });
        $("question_label").addClassName("selected");
        $("questions").show();
        new Ajax.Request("/questions/get_questions", {
            method: "POST",
            onSuccess: function(a) {},
            onFailure: function(a) {
                alert("Error");
            }
        })
    },

	change_photo:function(){
		$("upload_photo").observe("click", function(event){
			var user_photo;
			new Ajax.Request('/user_registrations/user_photo',{
				method:'GET',
				onSuccess: function(a){
					
				},
				onFailure: function(a){
					alert("Currently not able to retrieve your photo, Please try again later.");
				}
			});
			event.stop();
		});
	},

    show_links: function() {["questions", "account"].each(function(a) {
            $(a).hide()
        });["account_label", "question_label"].each(function(a) {
            $(a).removeClassName("selected")
        });
        $("link_label").addClassName("selected");
        new Ajax.Request("/links/get_links", {
            method: "POST",
            onSuccess: function(a) {},
            onFailure: function(a) {
                alert("Error")
            }
        });
        $("links").show()
    },

	add_description: function(){
		if ( ( $("desc_content") !== null ) && ( $("desc_content") !== undefined ) ) {
			$("description").update("<textarea id='desc_detail' class='span-10'>"+$("desc_content").innerHTML.strip()+"</textarea><input type='button' id='submit_desc' value='Submit Bio' />");
		} else {
			$("description").update("<textarea id='desc_detail' class='span-10'></textarea><input type='button' id='submit_desc' value='Submit Bio' />");
		}
		$("submit_desc").observe("click", function(event){
			if ( $F("desc_detail").strip().length > 0 ){
				new Ajax.Request("/user_registrations/add_description",{
					method:'GET',
					parameters:{ description: $F("desc_detail").strip() },
					onSuccess: function(response){},
					onFailure: function(response){
						alert("Oops! We are not able to update your description. Problem is on our side. Please try again later");
					}
				});
			}
			event.stop();
		});
	},
	
    show_account: function() {
		["links", "questions"].each(function(a) {
	            $(a).hide();
	    });

		["question_label", "link_label"].each(function(a) {
	            $(a).removeClassName("selected");
	    });
	    $("account_label").addClassName("selected");
	    $("account").show();
    },

    house_keeping: function() {
		["questions", "links"].each(function(a) {
            $(a).hide()
        });
        $("account_label").observe("click", function(a) {
            manage.show_account();
            a.stop()
        });
        $("question_label").observe("click", function(a) {
            manage.show_questions();
            a.stop()
        });
        $("link_label").observe("click", function(a) {
            manage.show_links();
            a.stop()
        });

		$("add_description") && $("add_description").observe("click", function(event1){	manage.add_description();event1.stop();	});
		
		$("description").observe("mouseover", function(event){
			$("edit_description") && $("edit_description").show();
		});
		
		$("description").observe("mouseout", function(event){
			$("edit_description") && $("edit_description").hide();
		});

		$("edit_description") && $("edit_description").hide();
		
		$("upload_photo") && manage.change_photo();
		
        $("account").show();
		
		if ( ( $("edit_description") !== null ) && ( $("edit_description") !== undefined) ) {
			$("edit_description").observe("click", function(event){
				manage.add_description();
			});
		}
		
        $("account_label").addClassName("selected");["account_label", "question_label", "link_label"].each(function(a) {
            $(a).observe("mouseover", function(b) {
                if ($(a).hasClassName("selected") === false) {
                    $(a).addClassName("hovered")
                }
            });
            $(a).observe("mouseout", function(b) {
                if ($(a).hasClassName("hovered") === true) {
                    $(a).removeClassName("hovered")
                }
            })
        })
    }
};
manage.house_keeping();