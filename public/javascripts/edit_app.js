var date = {
    currentDate: null,
    error: false,
    newDate: function() {
        currentDate = new Date();
        return currentDate
    },
    checkDate: function() {
        date.newDate();
        if ($("app_deadline_1i").getValue() < currentDate.getFullYear()) {
            date.error = true;
	        $("app_deadline_1i").addClassName("errorField");
            return true
        } else {
            if ($("app_deadline_2i").getValue() - 1 < currentDate.getMonth()) {
                date.error = true;
		        $("app_deadline_2i").addClassName("errorField");
                return true
            } else {
                if ($("app_deadline_3i").getValue() < currentDate.getDate()) {
                    date.error = true;
			        $("app_deadline_3i").addClassName("errorField");
                    return true
                } else {
                    date.error = false;
                    return false
                }
            }
        }
    }
};

$("app_university").observe("focus", function(b) {
    if (($("app_university_helptext") === null) && ($("app_university_errortext") === null)) {
        var a = "<span id='app_university_helptext' class='notice'>Enter your university name.</span>";
        $("app_university").insert({
            after: a
        });
        $("app_university").addClassName("focus")
    }
});

$("app_university").observe("blur", function(a) {
    if ($("app_university_helptext") !== null) {
        $("app_university_helptext").remove();
        $("app_university").removeClassName("focus")
    }
});

$("app_department").observe("focus", function(b) {
    if (($("app_department_helptext") === null) && ($("app_department_errortext") === null)) {
        var a = "<span id='app_department_helptext' class='notice'>Enter your department name.</span>";
        $("app_department").insert({
            after: a
        });
        $("app_department").addClassName("focus")
    }
});

$("app_department").observe("blur", function(a) {
    if ($("app_department_helptext") !== null) {
        $("app_department_helptext").remove();
        $("app_department").removeClassName("focus")
    }
});
$$("form.edit_app")[0].observe("submit", function(c) {
    var a = new Date();
    $$(".errortext").each(function(d) {
        d.remove()
    });

    $$(".errorField").each(function(d) {
        d.removeClassName("errorField")
    });

    if ( (date.checkDate() === true) && ( $("deadline_errortext") === null ) ) {
        var b = "<span id='deadline_errortext' class='error'>Deadline you have entered is not valid.</span>";
        $("app_deadline_3i").insert({
            after: b
        });
        c.stop();
    }

    if (($("app_university").getValue() === "") && ($("app_university_errortext") === null)) {
        var b = "<span id='app_university_errortext' class='error'>Hey, you forgot to tell us your university name.</span>";
        $("app_university").insert({
            after: b
        });
        $("app_university").addClassName("errorField");
        c.stop();
    }

    if (($("app_department").getValue() === "") && ($("app_department_errortext") === null)) {
        var b = "<span id='app_department_errortext' class='error'>Hey, you forgot to tell us your department name.</span>";
        $("app_department").insert({
            after: b
        });
        $("app_department").addClassName("errorField");
        c.stop();
    }
    if ($$(".errorField").size() > 0) {
        c.stop()
    }
});