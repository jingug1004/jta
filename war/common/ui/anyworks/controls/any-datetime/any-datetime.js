any.control("any-datetime").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.$datePicker = jQuery('<span>').control("any-date").appendTo(control);
        o.$space = jQuery('<span>').text(" ").appendTo(control);
        o.$timePicker = jQuery('<span>').control("any-time").appendTo(control);

        o.$control.defineMethod("dateElement", dateElement);
        o.$control.defineMethod("timeElement", timeElement);
        o.$control.defineMethod("focus", focus);

        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("time", { get: getTime, set: setTime });
        o.$control.defineProperty("date", { get: getDate });
        o.$control.defineProperty("readOnly", { get: getReadOnly, set: setReadOnly });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        any.control(control).initialize();
    })();

    function dateElement()
    {
        return o.$datePicker.element();
    }

    function timeElement()
    {
        return o.$timePicker.element();
    }

    function focus()
    {
        if (o.$datePicker.val() == null || o.$datePicker.val() == "") {
            o.$datePicker.focus();
        } else {
            o.$timePicker.focus();
        }
    }

    function getValue()
    {
        return o.$datePicker.val() + " " + o.$timePicker.val();
    }

    function setValue(val)
    {
        if (jQuery.type(val) === "date") {
            o.$datePicker.val(val);
            o.$timePicker.val(val);
        } else if (typeof(val) === "number") {
            var date = new Date(val);
            o.$datePicker.val(date);
            o.$timePicker.val(date);
        } else {
            var date = any.date(val, "yyyymmdd hhiiss").toDate();
            o.$datePicker.val(date);
            o.$timePicker.val(date);
        }
    }

    function getTime()
    {
        var date = getDate();

        if (date == null) {
            return null;
        }

        return date.getTime();
    }

    function setTime(val)
    {
        setValue(val);
    }

    function getDate()
    {
        var date = o.$datePicker.val();
        var time = o.$timePicker.val();

        if (date == "" || time == "") {
            return null;
        }

        return any.date(date + " " + time, "yyyymmdd hhiiss").toDate();
    }

    function getReadOnly()
    {
        return o.readOnly;
    }

    function setReadOnly(val)
    {
        o.readOnly = (String(val).toLowerCase() == "readonly" || any.object.toBoolean(val, true));

        o.$datePicker.prop("readOnly", o.readOnly);
        o.$timePicker.prop("readOnly", o.readOnly);
    }

    function getDisabled()
    {
        return o.disabled;
    }

    function setDisabled(val)
    {
        o.disabled = (String(val).toLowerCase() == "disabled" || any.object.toBoolean(val, true));

        o.$datePicker.prop("disabled", o.disabled);
        o.$timePicker.prop("disabled", o.disabled);
        o.$space.prop("disabled", o.disabled);
    }
});
