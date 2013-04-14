var date = {
    currentDate: null,
    error: false,
    newDate: function() {
        date.currentDate = new Date();
        return date.currentDate
    },
    checkDate: function() {
        date.newDate();
        if ($("app_deadline_1i").getValue() < date.currentDate.getFullYear()) {
            date.error = true;
	        $("app_deadline_1i").addClassName("errorField");
            return true
        } else {
            if ($("app_deadline_2i").getValue() - 1 < date.currentDate.getMonth()) {
                date.error = true;
		        $("app_deadline_2i").addClassName("errorField");
                return true
            } else {
                if ($("app_deadline_3i").getValue() < date.currentDate.getDate()) {
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
        var a = "<span id='app_university_helptext' class='notice'>Enter your Institute/College/University name.</span>";
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
        var a = "<span id='app_department_helptext' class='notice'>Enter your Major/Specialization/Department.</span>";
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

$("new_app").observe("submit", function(b) {
    $$(".errortext").each(function(c) {
        c.remove()
    });
    $$(".errorField").each(function(c) {
        c.removeClassName("errorField")
    });
    if ( ( date.checkDate() === true) && ( $("deadline_errortext") === null ) ) {
        var a = "<span id='deadline_errortext' class='error'>Deadline you have entered is not valid.</span>";
        $("app_deadline_3i").insert({
            after: a
        });
        b.stop()
    }
    if (($("app_university").getValue() === "") && ($("app_university_errortext") === null)) {
        var a = "<span id='app_university_errortext' class='error'>Hey, you forgot to tell us your Institute name.</span>";
        $("app_university").insert({
            after: a
        });
        $("app_university").addClassName("errorField");
        b.stop()
    }
    if (($("app_department").getValue() === "") && ($("app_department_errortext") === null)) {
        var a = "<span id='app_department_errortext' class='error'>Hey, you forgot to tell us your major.</span>";
        $("app_department").insert({
            after: a
        });
        $("app_department").addClassName("errorField");
        b.stop()
    }
    if ($$(".errorField").size() > 0) {
        b.stop()
    }
});