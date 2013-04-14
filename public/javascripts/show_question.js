var question = {
    edit_answer: function(b) {
        $(b).observe("click", function(g) {
            var i = $(b).up(".answer");
            var h = $(i).readAttribute("id").strip();
            var j = $(i).readAttribute("id").split("_")[1];

            var a = "<div id='edit_answer_div' class='span-15 prepend-top push-1'><br /><label class='span-15' id='edit_your_answer'>Edit Your Answer</label><br /><textarea id='answer' rows='25' cols='10' class='span-14 mceEditor'>" + $$("#" + h + " .content")[0].innerHTML.strip() + "</textarea><br /><input type=button id='update_answer' value='Update Your Answer'></input>&nbsp;&nbsp;<a href='#' id='hide_edit_answer'>Cancel</a><span id='char_left' class='right append-1'>enter atleast 15 characters</span><br/><br/></div>";

            Element.replace($(i), a);
            tinyMCE.execCommand("mceAddControl", false, "answer");

            $("edit_answer_div").show();
            $$("a.edit_answer").each(function(c) {
                $(c).hide();
            });

            $("update_answer").observe("click", function(d) {
     	        var c = tinyMCE.activeEditor.getContent().strip();
				var c_length = c.stripTags().length;
				c = c.gsub("<p>&nbsp;</p>","", "gim").strip();
                var e = $("question_id").getValue();
                if ( (c_length <= 15) || (c.length <= 15) ) {
                    $("char_left").setStyle("color:red;");
                } else {
					$("update_answer").disable();
	                new Ajax.Request("/questions/update_answer", {
	                    method: "post",
	                    parameters: {
	                        answer: c,
	                        question_id: e,
	                        answer_id: j
	                    },
	                    onSuccess: function(f) {
	                        $$(".edit_answer").each(function(l) {
	                            $(l).show();
	                        });
	                        tinyMCE.execCommand("mceRemoveControl", false, "answer");
	                    },
	                    onFailure: function(f) {
	                        alert("There is a problem in updating your answer. We have noted the problem. Please try again later.");
	                        $("update_answer").enable();
	                    }
	                  });
                     d.stop();
                }
            });
            $("hide_edit_answer").observe("click", function(c) {
                question.hide_edit_answer(i);
                tinyMCE.execCommand("mceRemoveControl", false, "answer");
                c.stop();
            });
            g.stop();
        })
    },

	show_message:function(b,msg){
		if ( Prototype.Browser.WebKit === true){
		 	$(b).insert({ after: msg});
		}else{
			$(b).up("table.rating").insert({ top: msg});
		}
	},
	
	hide_message:function(element){
		if (Prototype.Browser.Webkit == false){
			$(element).up('table.rating > div.errorMessage').observe("click", function(event1){
				$(element).up(".answer").down("table.rating > div.errorMessage").remove();
				event1.stop();
			});
		} else {
			$(element).up('div.errorMessage').observe("click", function(event1){
				$(element).up('div.errorMessage').remove();
				event1.stop();
			});
		}
	},
	
    new_question: function() {
    },

    post_answer: function() {
        if ($("answer") !== null) {
            $("submit_answer").observe("click", function(d) {
                var f = tinyMCE.activeEditor.getContent().strip();
				var f_length = f.stripTags().length;
				f = f.gsub("<p>&nbsp;</p>","", "gim").strip();
                var e = $("question_id").getValue();
                if ( (f_length <= 15) || (f.length <= 15) ) {
                    $("char_left").setStyle("color:red;");
                } else {
                    $("submit_answer").disable();
                    new Ajax.Request("/questions/post_answer", {
                        method: "post",
                        parameters: {
                            answer: f,
                            question_id: e
                        },
                        onSuccess: function(a) {
                            tinyMCE.execCommand("mceRemoveControl", false, "answer");
                        },
                        onFailure: function(a) {
                            $("submit_answer").enable();
                            alert("There is a problem in posting your answer. We have noted the problem. Please try again later.");
                        }
                    });
                }
                d.stop();
            });
        }
    },

    delete_answer: function(b) {
        $(b).observe("click", function(d) {
          var a = $(b).up(".answer").readAttribute("id").split("_")[1];
            //$(b).up(".answer").hide();
            new Ajax.Request("/questions/delete_answer", {
                method: "post",
                parameters: {
                    answer_id: a
                },
                onSuccess: function(c) {
				  	new Effect.SlideUp($(b).up(".answer"));
                    tinyMCE.execCommand("mceAddControl", false, "answer");
                },
                onFailure: function(c) {
                    alert("There is a problem in deleteing your answer. We have noted the problem. Please try again later.");
                }
            });
            d.stop();
        });
    },
	
    hide_edit_answer: function(b) {
        Element.replace($("edit_answer_div"), $(b));
        $$(".edit_answer").each(function(a) {
            $(a).show();
        })
    },

    hide_answer: function() {
        $("answer_div").remove();
    },

    show_comment: function(b) {
        $(b).observe("click", function(a) {
            $(b).next(".comments").toggle();
            if ( $(b).next(".comment_span") !== undefined){
				$(b).next(".comment_span").toggle();
			}
            a.stop();
        });
    },

    add_comment: function(b) {
        $(b).observe("click", function(a) {
            $(b).next(".comments").toggle();
            if ( $(b).next(".comment_span") !== undefined){
				$(b).next(".comment_span").toggle();
			}
			a.stop();
        });
    },

    submit_comment: function(b) {
        $(b).observe("click", function(f) {
            var e = $(b).up(0).down(0).getValue().strip();
            var a = $(b).up("div.answer").readAttribute("id").split("_")[1].strip();
            if (e.length > 0) {
                $(b).disable();
                new Ajax.Request("/questions/add_comment", {
                    method: "post",
                    parameters: {
                        answer_id: a,
                        content: e
                    },
                    onSuccess: function(c) {
                        $(b).up(0).down(0).setValue(" ");
                    },
                    onFailure: function(c) {
                        alert("Sorry, we were not able to add your comment due to a problem. Please try again later.")
                    }
                });
                $(b).enable();
            }
            f.stop();
        });
    },

    browse_question: function() {
        if ($("latest_q") !== null) {["open_questions","top_questions"].each(function(b) {
                $(b).hide();
            });
			["open_q","top_q"].each(function(b) {
                $(b).removeClassName("selected");
            });
            $("latest_q").addClassName("selected");
            $("questions_list").show();
        }
    },

    open_question: function() {
        if ($("open_q") !== null) {["questions_list","top_questions"].each(function(b) {
                $(b).hide()
            });
			if ( $("open_questions").innerHTML.strip() === ""){
	            new Ajax.Request("/questions/open_question", {
	                method: "POST",
	                parameters: {},
	                onSuccess: function(b) {},
	                onFailure: function(b) {
	                    alert("We are having in retrieving open questions. Please try again later.");
	                }
	            });
			}
			["latest_q","top_q"].each(function(b) {
                $(b).removeClassName("selected")
            });
            $("open_q").addClassName("selected");
            $("open_questions").show();
        }
    },

    top_questions: function() {
        if ($("top_q") !== null) {["questions_list","open_questions"].each(function(b) {
                $(b).hide()
            });
			if ( $("top_questions").innerHTML.strip() === ""){
	            new Ajax.Request("/questions/top_questions", {
	                method: "POST",
	                parameters: {},
	                onSuccess: function(b) {},
	                onFailure: function(b) {
	                    alert("We are having in retrieving open questions. Please try again later.");
	                }
	            });
			}
			["latest_q","open_q"].each(function(b) {
                $(b).removeClassName("selected")
            });
            $("top_q").addClassName("selected");
            $("top_questions").show();
        }
    },

	set_flag: function(){
		new Ajax.Request('/questions/set_flag',{
			method: 'POST',
			parameters: {
				question_id: $F("question_id"),
				flagged: $F("flagged")
			},
			onSuccess:function(response){
				
			},
			onFailure:function(response){
                alert("Due to a problem, we are unable to flag the question. We have noted your problem. Please try again later");
			}
		});
	},
	
    load_related_stuff: function() {
        if ( $$("#question_detail > #question_title")[0] !== undefined) {
            var b = $("question_title").innerHTML.strip();
            new Ajax.Request("/questions/load_related_stuff", {
                method: "POST",
                parameters: {
                    title: b,
                    q_id: $F("question_id").strip()
                },
                onSuccess: function(a) {},
                onFailure: function(a) {}
            });
        }
    },
	
	increase_answer_rating: function(element){
		var answer_id = $(element).up(5).readAttribute("id").split("_")[1];
		var current_rating = $(element).up(2).next().down(0);
		new Ajax.Request("/a_increase_rating", {
			method:"GET",
			parameters:{
				answer_id:answer_id
			},
			onSuccess:function(response){
				if ( response.responseText === "-2000" ) {
						var msg = "<div class='errorMessage span-7' style='position:absolute;padding-left:10px;z-index:1000;'> <span class='mainMessage' style='text-decoration:underline;'>You have already rated this answer.</span><br/><a href='#' class='close'> Click on the box to close</a></div>";
		            	question.show_message( element, msg );
						$$(".close").each(function(element){
							question.hide_message(element);
						});
				} else {
					current_rating.innerHTML = response.responseText;
				}
				
				new Effect.Highlight(current_rating);
			},
			onFailure:function(response){
				alert("Oops! We are not able to update the rating now. Please try again later");
			}
		});
	},
	
	decrease_answer_rating: function(element){
		var answer_id = $(element).up(5).readAttribute("id").split("_")[1];
		var current_rating = $(element).up(2).previous().down(0);
		new Ajax.Request("/a_decrease_rating", {
			method:"GET",
			parameters:{
				answer_id:answer_id
			},
			onSuccess:function(response){
				if ( response.responseText === "-2000" ) {
					if ( question !== null ){
						var msg = "<div class='errorMessage span-7' style='position:absolute;padding-left:10px;z-index:1000;'><span class='mainMessage' style='text-decoration:underline;'> You have already rated this answer.</span><br/><a href='#' class='close'> Click on the box to close</a></div>";
		            	question.show_message( element, msg );
						$$(".close").each(function(element){
							question.hide_message(element);
						});
					}
				} else {
					current_rating.innerHTML = response.responseText;
				}
				new Effect.Highlight(current_rating);
			},
			onFailure:function(response){
				alert("Oops! We are not able to update the rating now. Please try again later");
			}
		});	
	},
	
	increase_rating: function(element){
		var question_id;
		if ( $("question_id") !== null ){
			question_id = $F("question_id");
		} else {
			question_id = $(element).up("li.question").readAttribute("id").split("_")[1];
		}
		
		var current_rating = $(element).up(2).next(0).down(0);
		new Ajax.Request("/q_increase_rating", {
			method:"GET",
			parameters:{
				question_id:question_id
			},
			onSuccess:function(response){
				if ( response.responseText === "-2000" ) {
					var msg = "<div class='errorMessage span-7' style='position:absolute;padding-left:10px;z-index:1000;'> <span class='mainMessage' style='text-decoration:none;text-decoration:underline;'>You have already rated this question.</span><br/><a href='#' class='close'> Click on the box to close</a></div>";
		            	question.show_message( element, msg );
						$$(".close").each(function(element){
							question.hide_message(element);
						});
				} else {
					current_rating.innerHTML = response.responseText;
				}
				new Effect.Highlight(current_rating);
			},
			onFailure:function(response){
				alert("Oops! We are not able to update the rating now. Please try again later");
			}
		});
	},
	
	decrease_rating: function(element){
		var question_id;
		if ( $("question_id") !== null ){
			question_id = $F("question_id");
		} else {
			question_id = $(element).up("li.question").readAttribute("id").split("_")[1];
		}
		var current_rating = $(element).up(2).previous(0).down(0);
		
		new Ajax.Request("/q_decrease_rating", {
			method:"GET",
			parameters:{
				question_id:question_id
			},
			onSuccess:function(response){
				if ( response.responseText === "-2000" ) {
						var msg = "<div class='errorMessage span-7' style='position:absolute;padding-left:10px;z-index:1000;'> <span class='mainMessage' style='text-decoration:none;background-color:yellow;'>You have already rated this question.</span><br/><a href='#' class='close'> Click on the box to close</a></div>";
		            	question.show_message( element, msg );
						$$(".close").each(function(element){
							question.hide_message(element);
						});
				} else {
					current_rating.innerHTML = response.responseText;
				}
				new Effect.Highlight(current_rating);
			},
			onFailure:function(response){
				alert("Oops! We are not able to update the rating now. Please try again later");
			}
		});
	},
	
	follow: function(){
		["follow_question","unfollow_question"].each(function(element){
			if ( $(element) !== null ) {
				$(element).observe("click", function(event){
					new Ajax.Request("/questions/follow", {
						method:"POST",
						parameters:{
							question_id:$F("question_id")
						},		
						onSuccess: function(response){
						},
						onFailure:function(response){
							alert("Oops! Please try again later");
						}
					});
					event.stop();
				});
			}
		});
	},
	
	show_answer_help: function(){
	},
	
	show_description: function(element){
		var answer_id = $(element).up('.answer').readAttribute("id").split("_")[1];
		var description = $("answer_"+answer_id).down("input.full_desc").getValue();
		var show_desc = "<p class='rounded-corners show_full_desc span-6'>"+description+"</p>";
		$(element).insert( { bottom: show_desc } );
	},
	
	hide_description: function(element){
		var answer_id = $(element).up('.answer').readAttribute("id").split("_")[1];
		Element.remove( $(element).up('.answer').down(".show_full_desc") );
	},
	
	edit_description: function(element){
		$(element).observe("click", function(event){
			//show a dialog with a text area and a submit description button and a cancel button
			// on submit, the description is updated in the db, in the page hidden element and truncated element and then the
			// dialog box is removed.
			// on cancel, dialog box is removed.no changes in the UI
			var full_desc = $(element).up(".answer").down(".full_desc").getValue().strip();
			var answer_id = $(element).up(".answer").readAttribute("id").split("_")[1];
			var edit_desc_dialog = "<div id='edit_desc_dialog' class='span-8 rounded-corners' style='position:fixed;top:"+$(document).viewport.getWidth()/5.5+"px;left:"+$(document).viewport.getHeight()/1.5+"px;'><h4 class='heading' style='padding:5px;'>Edit your bio</h4><textarea id='new_bio'>"+full_desc+"</textarea><br/><a href='#' id='submit_desc' class='button'/>Update Bio</a><a href='#' class='cancel'>Cancel</a></div>";
			if ( $('edit_desc_dialog') === null ){
				$$("body")[0].insert({ top:edit_desc_dialog});
				
				$("edit_desc_dialog").down("a.cancel").observe("click",function(event1){
					$("edit_desc_dialog").remove();
					$(element).show();
					event1.stop();
				});
								
				$("edit_desc_dialog").down("a.button").observe("click", function(event2){
					var new_edit_bio = $("new_bio").getValue().strip();
					new Ajax.Request("/user_registrations/add_description",{
						method:'GET',
						parameters:{ description: new_edit_bio },
						onSuccess: function(response){
							$("edit_desc_dialog").remove();
							$("answer_"+answer_id).down("span.description").innerHTML = new_edit_bio.truncate(20);
							$("user_full_desc_"+answer_id).setValue(new_edit_bio);							
							if (new_edit_bio.length == 0){
								$(element).update("Add Bio");
							} else{
								$(element).update("Edit Bio");
							}
							$(element).show();
						},
						onFailure: function(response){
							alert("Oops! We are not able to update your description. Problem is on our side. Please try again later");
						}
					});
					event2.stop();
				});
			}
			$(element).hide();
			event.stop();
		});
	},
	
	add_description: function(element){
		
	},
	
    houseKeeping: function() {
        question.post_answer();
        question.browse_question();

        if ($("new_question") !== null) {
            question.new_question();
        }

        $$(".edit_answer").each(function(b) {
            question.edit_answer(b);

			$(b).observe("mouseover", function(event){
				var edit_answer_help = "<span class='span-3 show_edit_answer rounded-corners' style='text-decoration:none;'>edit your answer</span>";
				if ( $(event.element()).up(0).down(".show_edit_answer") == undefined ){
					$(event.element().up(0)).insert({top:edit_answer_help});
				}
			});
			
			$(b).observe("mouseout", function(event){
				if ( $(event.element()).up(0).down(".show_edit_answer") != undefined ){
 					$(event.element()).up(0).down(".show_edit_answer").remove();
				}
			});
        });

        $$(".delete_answer").each(function(b) {
            question.delete_answer(b);
			$(b).observe("mouseover", function(event){
				var delete_answer_help = "<span class='span-3 show_delete_answer rounded-corners' style='text-decoration:none;'>delete your answer</span>";
				if ( $(event.element()).up(0).down(".show_delete_answer") == undefined ){
					$(event.element().up(0)).insert({top:delete_answer_help});
				}
			});
			
			$(b).observe("mouseout", function(event){
				if ( $(event.element()).up(0).down(".show_delete_answer") != undefined ){
 					$(event.element()).up(0).down(".show_delete_answer").remove();
				}
			});
        });
		
        $$(".show_comments").each(function(b) {
            question.show_comment(b);
        });

        $$(".submit_comment").each(function(b) {
            question.submit_comment(b);
        });

        $$(".owner").each(function(b) {
			$(b).observe("click", function(event){
				var msg = "<div class='errorMessage span-7' style='position:absolute;padding-left:10px;z-index:1000;'> <span class='mainMessage' style='text-decoration:underline;'> You cannot vote for your own stuff.</span><br/><a href='#' class='close'> Click on the box to close</a></div>";
            	question.show_message(b,msg);
				$$(".close").each(function(element){
					question.hide_message(element);
				});
				event.stop();
			});
        });

		$$(".nosignin").each(function(b) {
			$(b).observe("click", function(event){
				var msg = "<div class='errorMessage span-7' style='position:absolute;padding-left:10px;z-index:1000;'> <span class='mainMessage' style='text-decoration:underline;'>You have to sign in before voting.</span><br/><a href='#' class='close'> Click on the box to close</a></div>";
            	question.show_message(b,msg);
				$$(".close").each(function(element){
					question.hide_message(element);
				});
				event.stop();
			});
        });
		
        $$(".add_comment").each(function(b) {
            question.add_comment(b);
        });

        if ($("latest_q") !== null) {
            $("latest_q").observe("click", function(b) {
                question.browse_question();
                b.stop();
            });
        }
		if ( ( $("flag") !== null )  && ( $("flag") !== undefined ) ){
			$("flag").observe("click", function(event){
				question.set_flag();
				event.stop();
			});
		}
		
        if ($("open_q") !== null) {
            $("open_q").observe("click", function(b) {
                question.open_question();
                b.stop();
            })
        }

        if ($("top_q") !== null) {
            $("top_q").observe("click", function(b) {
                question.top_questions();
                b.stop();
            })
        }

		$$(".q_increase_rating").each(function(element){
			$(element).observe("click", function(event){
				question.increase_rating(element);
				event.stop();
			});
		});
		
		
		$$(".q_decrease_rating").each(function(element){
			$(element).observe("click", function(event){
				question.decrease_rating(element);
				event.stop();
			});
		});
		
		$$(".a_increase_rating").each(function(element){
			$(element).observe("click", function(event){
				question.increase_answer_rating(element);
				event.stop();
			});
		});
		
		$$(".a_decrease_rating").each(function(element){
			$(element).observe("click", function(event){
				question.decrease_answer_rating(element);
				event.stop();
			});
		});
		
		
		$$("span.description").each(function(element){
			if( $(element).innerHTML.strip().length > 0 ){
				$(element).observe('mouseout', function(event){
					question.hide_description(element);
					event.stop();
				});
			
				$(element).observe('mouseover', function(event){
					question.show_description(element);
					event.stop();
				});
			}
		});
		
		$$("a.edit_desc").each(function(element){
			question.edit_description(element);
		});
		
		$$("a.add_desc").each(function(element){
			question.edit_description(element);
		});
		
		
        if ($("question_title") !== null) {
            $("question_title").observe("blur", function(b) {
                if ($("question_title").getValue().length > 100) {
                    if ($("title_comment") === null) {
                        $("question_title").insert({
                            after: "<span id='title_comment'>Title is too long to be useful.Can you shorten it?</span>"
                        })
                    } else {
                        $("title_comment").update("Title is too long to be useful.Can you shorten it?");
                    }
                } else if( ( $("question_title").getValue().length !== 0 ) && ($("question_title").getValue().length < 5) ){
                    if ($("title_comment") === null) {
                        $("question_title").insert({
                            after: "<span id='title_comment'>Title is too short to be useful.Can you describe it more?</span>"
                        })
                    } else {
                        $("title_comment").update("Title is too short to be useful.Can you describe it more?");
                    }
				} else {
                    if ($("title_comment") !== null) {
                        $("title_comment").remove();
                    }
                }
            });
        }

    }
};

question.houseKeeping();
