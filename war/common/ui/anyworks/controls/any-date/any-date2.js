any.control("any-date2").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.$picker1 = jQuery('<span>').control("any-date").appendTo(control);
        o.$space = jQuery('<span>').text(" ~ ").appendTo(control);
        o.$picker2 = jQuery('<span>').control("any-date").appendTo(control);
        o.$period = jQuery('<span>').hide().css("margin-left", "2px").appendTo(control);

        control.isObjectValueSet = true;

        if (o.$control.hasAttr("bind")) {
            var dsId = o.$control.attr("bind").split(":")[0];
            if (o.$control.hasAttr("id1")) {
                o.$control.attr("bind1", dsId + ":" + o.$control.attr("id1"));
            }
            if (o.$control.hasAttr("id2")) {
                o.$control.attr("bind2", dsId + ":" + o.$control.attr("id2"));
            }
        }

        o.$picker1.element().enter(function() {
            resetDateRange(jQuery(this).val(), null);
        });

        o.$picker1.on("onChange", function() {
            resetDateRange(jQuery(this).val(), null);
            o.$control.fire("onChange");
        });

        o.$picker2.element().enter(function() {
            resetDateRange(null, jQuery(this).val());
        });

        o.$picker2.on("onChange", function() {
            resetDateRange(null, jQuery(this).val());
            o.$control.fire("onChange");
        });

        o.$control.defineMethod("element1", element1);
        o.$control.defineMethod("element2", element2);
        o.$control.defineMethod("focus", focus);
        o.$control.defineMethod("select", select);
        o.$control.defineMethod("setDateRange", setDateRange);

        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("value1", { get: getValue1, set: setValue1 });
        o.$control.defineProperty("value2", { get: getValue2, set: setValue2 });
        o.$control.defineProperty("time", { get: getTime, set: setTime });
        o.$control.defineProperty("time1", { get: getTime1, set: setTime1 });
        o.$control.defineProperty("time2", { get: getTime2, set: setTime2 });
        o.$control.defineProperty("readOnly", { get: getReadOnly, set: setReadOnly });
        o.$control.defineProperty("periods", { set: setPeriods });
        o.$control.defineProperty("period", { set: setPeriod });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        any.control(control).initialize();
    })();

    function element1()
    {
        return o.$picker1.element();
    }

    function element2()
    {
        return o.$picker2.element();
    }

    function focus()
    {
        if ((o.$picker1.val() == null || o.$picker1.val() == "") || (o.$picker2.val() != null && o.$picker2.val() != "")) {
            o.$picker1.focus();
        } else {
            o.$picker2.focus();
        }
    }

    function select()
    {
        if ((o.$picker1.val() != null && o.$picker1.val() != "") || (o.$picker2.val() == null || o.$picker2.val() == "")) {
            o.$picker1.select();
        } else {
            o.$picker2.select();
        }
    }

    function setDateRange(minDate, maxDate)
    {
        o.dateRange = { minDate: minDate, maxDate: maxDate };

        if (minDate != null) {
            o.$picker1.element().datepicker("option", "minDate", any.date(minDate).toDate());
            o.$picker2.element().datepicker("option", "minDate", any.date(minDate).toDate());
        }

        if (maxDate != null) {
            o.$picker1.element().datepicker("option", "maxDate", any.date(maxDate).toDate());
            o.$picker2.element().datepicker("option", "maxDate", any.date(maxDate).toDate());
        }
    }

    function resetDateRange(minDate, maxDate)
    {
        if (o.dateRange != null && o.dateRange.minDate != null && any.text.isEmpty(minDate) == true) {
            minDate = o.dateRange.minDate;
        }

        if (minDate != null) {
            o.$picker2.element().datepicker("option", "minDate", any.date(minDate).toDate());
        }

        if (o.dateRange != null && o.dateRange.maxDate != null && any.text.isEmpty(maxDate) == true) {
            maxDate = o.dateRange.maxDate;
        }

        if (maxDate != null) {
            o.$picker1.element().datepicker("option", "maxDate", any.date(maxDate).toDate());
        }
    }

    function getValue()
    {
        if (o.$control.hasAttr("id1") && o.$control.hasAttr("id2")) {
            var val = {};
            val[o.$control.attr("id1")] = getValue1();
            val[o.$control.attr("id2")] = getValue2();
            return val;
        } else {
            var val = [];
            val.push(getValue1());
            val.push(getValue2());
            return val;
        }
    }

    function setValue(val)
    {
        if (arguments.length < 1) {
            return;
        }

        var val1, val2;

        if (jQuery.type(val) == "object") {
            val1 = val[o.$control.attr("id1")];
            val2 = val[o.$control.attr("id2")];
        } else if (jQuery.type(val) == "array") {
            val1 = val[0];
            val2 = (val.length >= 2 ? val[1] : null);
        } else {
            val1 = val;
            val2 = val;
        }

        setValue1(val1);
        setValue2(val2);
    }

    function getValue1()
    {
        return o.$picker1.val();
    }

    function setValue1(val)
    {
        o.$picker1.val(val);
    }

    function getValue2()
    {
        return o.$picker2.val();
    }

    function setValue2(val)
    {
        o.$picker2.val(val);
    }

    function getTime()
    {
        if (o.$control.hasAttr("id1") && o.$control.hasAttr("id2")) {
            var val = {};
            val[o.$control.attr("id1")] = getTime1();
            val[o.$control.attr("id2")] = getTime2();
            return val;
        } else {
            var val = [];
            val.push(getTime1());
            val.push(getTime2());
            return val;
        }
    }

    function setTime(val)
    {
        if (arguments.length < 1) {
            return;
        }

        var val1, val2;

        if (jQuery.type(val) == "object") {
            val1 = val[o.$control.attr("id1")];
            val2 = val[o.$control.attr("id2")];
        } else if (jQuery.type(val) == "array") {
            val1 = val[0];
            val2 = (val.length >= 2 ? val[1] : null);
        } else {
            val1 = val;
            val2 = val;
        }

        setTime1(val1);
        setTime2(val2);
    }

    function getTime1()
    {
        return o.$picker1.prop("time");
    }

    function setTime1(val)
    {
        o.$picker1.prop("time", val);
    }

    function getTime2()
    {
        return o.$picker2.prop("time");
    }

    function setTime2(val)
    {
        o.$picker2.prop("time", val);
    }

    function setPeriods(val)
    {
        var periods = val.split(",");

        for (var i = 0, ii = periods.length; i < ii; i++) {
            var period = any.text.trim(periods[i]);
            var num = any.text.toNumber(period);
            var part = period.replace(num, "").substr(0, 1).toUpperCase();

            jQuery('<button>').text(any.message("any.date.period." + part, period).arg(num))
                .addClass("space")
                .attr({ "size": "small" })
                .data({ "period-num": num, "period-part": part })
                .control("any-button")
                .appendTo(o.$period)
                .click(function() {
                    var $this = jQuery(this);
                    resetPeriod($this.data("period-num"), $this.data("period-part"));
                }
            );
        }

        o.$period.css("display", "");
    }

    function setPeriod(val)
    {
        var num = any.text.toNumber(val);
        var part = val.replace(num, "").substr(0, 1).toUpperCase();

        resetPeriod(num, part);
    }

    function resetPeriod(num, part)
    {
        setValue1(any.date().add(num * (-1), { "D": "date", "W": "week", "M": "month", "Y": "year" }[part]).add(1, "date").toString());
        setValue2(any.date().toString());
    }

    function getReadOnly()
    {
        return o.readOnly;
    }

    function setReadOnly(val)
    {
        o.readOnly = (String(val).toLowerCase() == "readonly" || any.object.toBoolean(val, true));

        o.$picker1.prop("readOnly", o.readOnly);
        o.$picker2.prop("readOnly", o.readOnly);
    }

    function getDisabled()
    {
        return o.disabled;
    }

    function setDisabled(val)
    {
        o.disabled = (String(val).toLowerCase() == "disabled" || any.object.toBoolean(val, true));

        o.$picker1.prop("disabled", o.disabled);
        o.$picker2.prop("disabled", o.disabled);
        o.$space.prop("disabled", o.disabled);
        o.$period.children('button').prop("disabled", o.disabled);
    }
});
