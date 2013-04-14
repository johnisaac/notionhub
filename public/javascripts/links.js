var links = {
    edit_link: function(c) {
        var a = $(c).up(".link").readAttribute("id").split("_")[1];
        var f = $(c).up(".link").down(".link_title").down(0).innerHTML.strip();
        var d = $(c).up(".link").down(".link_title").down(0).readAttribute("href").strip();
        var e = $(c).up(".link").down(".link_details").down(0).innerHTML.strip();
        var g = $(c).up(0).down(".time_ago").innerHTML.strip();
		var rating = $(c).up(".link").down("table.rating td.link_rating").innerHTML.strip();
		var old_block = $("link_"+a);
        var b = "<li id=edit_link_" + a + " class='span-15 edit_link rounded-corners'><input type='hidden' id='link_value' value="+rating+" /><input type=text class='span-15' style='height:20px' value='" + f + "' ></input><br /><input type=text class='span-12' value=" + d + " ></input><br /><br /><br /><input type=button class='update_link' value='Update Link'></input><a href='#' class='cancel_link'>Cancel</a></li>";
        Element.replace($("link_" + a), b);
        $$(".cancel_link").each(function(h) {
            $(h).observe("click", function(i) {
                var j = {
                    id: a,
                    title: f,
                    URL: d,
                    owner: e,
                    time_ago: g,
					rating: rating
                };
                links.replace_link(j);
                i.stop();
            })
        });

        $$(".update_link").each(function(h) {
            $(h).observe("click", function(i) {
                var j = {
                    id: a,
                    title: $(h).up(0).down(1).getValue().strip(),
                    URL: $(h).up(0).down(3).getValue().strip(),
                    owner: e,
                    time_ago: "just now",
					rating: rating
                };

                new Ajax.Request("/links/" + j.id, {
                    method: "PUT",
                    parameters: {
                        id: j.id,
                        title: j.title,
                        URL: j.URL
                    },
                    onSuccess: function(k) {
						links.replace_link(j);
                        new Effect.Highlight($("link_" + j.id))
                    },
                    onFailure: function(k) {
                        alert("Due to a problem, we are unable to update your link. We have noted your problem. Please try again later")
                    }
                });
                i.stop();
            });
        });
    },

    replace_link: function(b) {
		var table = "<table class='rating span-1' cellpadding='0' cellspacing='0'><tr><td>"+
					"<a href='#'><img alt='Up' class='left span-1 owner' src='/images/up.png' title='You cannot vote for your link' /></a></td></tr>"+
					"<tr><td class='link_rating' style='padding-left:10px;font-weight:bold;'>"+b.rating+"</td></tr><tr><td>"+
					"<a href='#'><img alt='Down' class='left span-1 owner'  src='/images/down.png' title='You cannot vote for your link' /></a></td></tr>"+
					"</table>";
	
        var a = "<li id=link_" + b.id + " class='span-15 link rounded-corners'>"+table+"<span class='link_title span-13'><a href='" + b.URL + "'>" + b.title + "</a></span><br/><span class='link_details span-13'><a href='#' class='left link_owner'>" + b.owner + "</a><span class='time_ago'>" + b.time_ago + " </span><a href='#' class='link_edit'>Edit </a><a href='#' class='link_delete'>Delete</a><a href="+"/links/"+b.id+" class='link_comments right'>Discuss</a></span></li>"; 
        Element.replace($("edit_link_" + b.id), a);
		$$("#link_"+b.id+" .owner").each(function(b) {
			$(b).observe("click", function(event){ 
				var msg = "<div class='errorMessage span-7' style='position:absolute;padding-left:10px;z-index:1000;'> You cannot vote for your own link.<br/><a href='#' class='close'> Click on the box to close</a></div>"
				links.show_message(b,msg);
				$$(".close").each(function(element){
					links.hide_message(element);
				});
				event.stop();
			});
		});

		$$("#link_"+b.id+" .link_edit").each(function(a) {
			$(a).observe("click", function(b) {
		     	links.edit_link($(b).element());
		     	b.stop();
		 	})
		});

		$$("#link_"+b.id+" .link_delete").each(function(a) {
			$(a).observe("click", function(b) {
		     	links.delete_link($(b).element());
		     	b.stop();
		 	})
		});
    },

	set_flag: function(){
		new Ajax.Request('/links/set_flag',{
			method: 'POST',
			parameters: {
				link_id: $F("link_id"),
				flagged: $F("flagged")
			},
			onSuccess:function(response){
				
			},
			onFailure:function(response){
                alert("Due to a problem, we are unable to flag the link. We have noted your problem. Please try again later");
			}
		});
	},
	
	show_message:function(b,msg){
		if ( Prototype.Browser.WebKit === true){
		 	$(b).up("table.rating").insert({ after: msg});
		}else{
			$(b).up("table.rating").insert({ top: msg});
		}
	},
	
	hide_message:function(element){
		if (Prototype.Browser.Webkit == false){
			$(element).up('table.rating > div.errorMessage').observe("click", function(event1){
				$(element).up("table.rating > div.errorMessage").remove();
				event1.stop();
			});
		} else {
			$(element).up('div.errorMessage').observe("click", function(event1){
				$(element).up('div.errorMessage').remove();
				event1.stop();
			});
		}	
	},
	
    delete_link: function(a) {
        var b = $(a).up(1).readAttribute("id").split("_")[1];
        new Ajax.Request("/links/" + b, {
            method: "DELETE",
            parameters: {
                id: b
            },
            onSuccess: function(c) {
                new Effect.SlideUp($(a).up(1));
                $(a).up(1).remove()
            },
            onFailure: function(c) {
                alert("Due to a problem, we are unable to delete your link. We have noted your problem. Please try again later")
            }
        })
    },

	increase_rating: function(element){
		var link_id;
		if ( $("link_id") !== null ){
			link_id = $F("link_id");
		} else {
			link_id = $(element).up("li.link").readAttribute("id").split("_")[1];
		}

		var current_rating = $(element).up(2).next(0).down(0);
		new Ajax.Request("/l_increase_rating", {
			method:"GET",
			parameters:{
				link_id:link_id
			},
			onSuccess:function(response){
				if ( response.responseText === "-2000" ) {
						var msg = "<div class='errorMessage span-7' style='position:absolute;padding-left:10px;z-index:1000;'> You have already rated this link.<br/><a href='#' class='close'> Click on the box to close</a></div>";
		            	links.show_message( element, msg );
						$$(".close").each(function(element){
							links.hide_message(element);
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
		var link_id;
		if ( $("link_id") !== null ){
			link_id = $F("link_id");
		} else {
			link_id = $(element).up("li.link").readAttribute("id").split("_")[1];
		}

		var current_rating = $(element).up(2).previous(0).down(0);
		new Ajax.Request("/l_decrease_rating", {
			method:"GET",
			parameters:{
				link_id:link_id
			},
			onSuccess:function(response){
				if ( response.responseText === "-2000" ) {
						var msg = "<div class='errorMessage span-7' style='position:absolute;padding-left:10px;z-index:1000;'> You have already rated this link.<br/><a href='#' class='close'> Click on the box to close</a></div>";
		            	links.show_message( element, msg );
						$$(".close").each(function(element){
							links.hide_message(element);
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
	
    post_comment: function() {
        var b = $F("new_comment").strip();
        var a = $("link_id").getValue();
        if (b.length > 0) {
            new Ajax.Request("post_comment", {
                method: "POST",
                parameters: {
                    link_id: a,
                    content: b
                },
                onSuccess: function(d) {
                    var c = "<li class='link_comment span-14'><span class='content'>" + b + "</span><span class='link_user'><a href='#'>You</a></span><span class='time_ago'>  less than a minute</span></li><hr class='dull'/>";
                    $("link_comments").insert({
                        bottom: c
                    });
                    new Effect.Highlight($$("#link_comments li.link_comment").last());
                    $("new_comment").setValue(" ")
                },
                onFailure: function(c) {
                    alert("There is a problem in adding your comment. We have noted the problem. Try reloading the page(Control + R)")
                }
            })
        }
    },

    load_related_stuff: function() {
        if ( $("link_content") !== null ) {
            var a = $("link_content").innerHTML.strip();
            new Ajax.Request("/links/load_related_stuff", {
                method: "POST",
                parameters: {
                    title: a,
                    id: $F("link_id").strip()
                },
                onSuccess: function(b) {},
                onFailure: function(b) {}
            })
        }
    },

	top_rated_links: function(){
		if ($("top_l") !== null) {["links_list"].each(function(b) {
                $(b).hide()
            });
			if ( $("top_links").innerHTML.strip() === ""){
	            new Ajax.Request("/links/top_links", {
	                method: "POST",
	                parameters: {},
	                onSuccess: function(b) {},
	                onFailure: function(b) {
	                    alert("We are having in retrieving top links. Please try again later.");
	                }
	            });
			}
			["latest_l"].each(function(b) {
                $(b).removeClassName("selected")
            });
            $("top_l").addClassName("selected");
            $("top_links").show();
        }
	},
	
	browse_links: function(){
		if ($("latest_l") !== null) {["top_links"].each(function(b) {
                $(b).hide();
            });
			["top_l"].each(function(b) {
                $(b).removeClassName("selected");
            });
            $("latest_l").addClassName("selected");
            $("links_list").show();
        }
	},
	
    house_keeping: function() {
		links.browse_links();

        if ($("new_comment") !== null) {
            $("new_comment").setValue(" ")
        }
        $$(".link_delete").each(function(a) {
            $(a).observe("click", function(b) {
                links.delete_link($(a));
                b.stop()
            })
        });

		if ( ( $("flag") !== null )  && ( $("flag") !== undefined ) ){
			$("flag").observe("click", function(event){
				links.set_flag();
				event.stop();
			});
		}
		
		$$(".l_increase_rating").each(function(element){
			$(element).observe("click", function(event){
				links.increase_rating(element);
				event.stop();
			});
		});
		
		$$(".l_decrease_rating").each(function(element){
			$(element).observe("click", function(event){
				links.decrease_rating(element);
				event.stop();
			});
		});
		
		if ($("latest_l") !== null) {
            $("latest_l").observe("click", function(b) {
                links.browse_links();
                b.stop();
            });
        }

        if ($("top_l") !== null) {
            $("top_l").observe("click", function(b) {
                links.top_rated_links();
                b.stop();
            });
        }
		
		["latest_l", "top_l"].each(function(b) {
            if ($(b) !== null) {
                $(b).observe("mouseover", function(a) {
                    if ($(b).hasClassName("selected") === false) {
                        $(b).addClassName("hovered");
                    }
                });
                $(b).observe("mouseout", function(a) {
                    if ($(b).hasClassName("hovered") === true) {
                        $(b).removeClassName("hovered");
                    }
                })
            }
        });

		$$(".owner").each(function(b) {
			$(b).observe("click", function(event){ 
				var msg = "<div class='errorMessage span-7' style='position:absolute;padding-left:10px;z-index:1000;'> You cannot vote for your own link.<br/><a href='#' class='close'> Click on the box to close</a></div>"
            	links.show_message(b,msg);
				$$(".close").each(function(element){
					links.hide_message(element);
				});
				event.stop();
			});
        });
		
		$$(".nosignin").each(function(b) {
			$(b).observe("click", function(event){
				var msg = "<div class='errorMessage span-7' style='position:absolute;padding-left:10px;z-index:1000;'> You have to sign in before voting.<br/><a href='#' class='close'> Click on the box to close</a></div>";
            	links.show_message(b,msg);
				$$(".close").each(function(element){
					links.hide_message(element);
				});
				event.stop();
			});
        });
		
        $$(".link_edit").each(function(a) {
            $(a).observe("click", function(b) {
                links.edit_link($(b).element());
                b.stop();
            })
        });

        if ($("submit_comment") !== null) {
            $("submit_comment").observe("click", function(a) {
                links.post_comment()
            })
        }
    }
};

links.house_keeping();