any.control("any-date").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control).css("white-space", "nowrap");
        o.config = any.control(control).config;
        o.$editElement = jQuery('input', control);

        o.options = {};
        o.options.dateFormat = any.meta.dateFormat.toLowerCase().replace("yyyy", "yy");
        o.options.showOn = "none";
        o.options.showButtonPanel = true;
        o.options.showAnim = "slideDown";
        o.options.changeYear = true;
        o.options.changeMonth = true;
        o.options.showOtherMonths = true;
        o.options.selectOtherMonths = true;

        if (o.$editElement.length == 0) {
            o.$editElement = jQuery('<input>').prop("type", "text").attr("maxlength", any.meta.dateFormat.length);
            o.$editElement.css({ "padding-left": "1px", "padding-right": "1px", "margin-left": "0px", "margin-right": "0px", "text-align": "center", "vertical-align": "middle", "width": "70px", "ime-mode": "disabled" });
            if (o.config("input.readOnly") == true) {
                o.$editElement.attr("readOnly", true);
            }
            o.$editElement.appendTo(o.$control);
        }

        jQuery(window).resize(function() {
            o.$editElement.datepicker("hide");
        });

        o.$editElement.focus(function() {
            o.currentValue = any.date(o.$editElement.val()).toString();
        });

        o.$editElement.blur(function() {
            if (jQuery('div#ui-datepicker-div').is(':visible') == true) {
                return;
            }
            var minDate = o.$editElement.datepicker("option", "minDate");
            if (minDate != null && any.date(o.$editElement.val()).toDate() < any.date(minDate).toDate()) {
                setValue("");
            } else {
                setValue(any.text.nvl(any.date(o.$editElement.val()).toString(), o.currentValue));
            }
        });

        if (o.config("image.picker") == null) {
            o.config("image.picker", any.home + "/controls/any-date/images/date-picker.gif");
        }

        if (o.config("image.remove") == null) {
            o.config("image.remove", any.home + "/controls/any-date/images/date-remove.gif");
        }

        jQuery('<img>').attr("src", any.meta.contextPath + o.config("image.picker")).appendTo(control)
            .css({ "position": "relative", "margin-left": "2px", "cursor": "pointer", "vertical-align": "middle", "display": "inline" }).hide()
            .click(function() {
                    if (this.disabled == true) {
                        return;
                    }
                    if (jQuery('div#ui-datepicker-div').is(':visible') == true && jQuery('div#ui-datepicker-div')[0]["attached-picker"] == this) {
                        return;
                    }
                    jQuery('div#ui-datepicker-div')[0]["attached-picker"] = this;
                    o.$editElement.datepicker("show");
                }
            );

        jQuery('<img>').attr("src", any.meta.contextPath + o.config("image.remove")).appendTo(control)
            .css({ "position": "relative", "margin-left": "2px", "cursor": "pointer", "vertical-align": "middle", "display": "inline" }).hide()
            .click(function() {
                    if (this.disabled == true) {
                        return;
                    }
                    setValue("");
                    focus();
                }
            );

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("focus", focus);
        o.$control.defineMethod("select", select);
        o.$control.defineMethod("setOption", setOption);
        o.$control.defineMethod("addElementEvent", addElementEvent);

        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("time", { get: getTime, set: setTime });
        o.$control.defineProperty("date", { get: getDate });
        o.$control.defineProperty("text", { get: getText });
        o.$control.defineProperty("min", { get: getMin, set: setMin });
        o.$control.defineProperty("max", { get: getMax, set: setMax });
        o.$control.defineProperty("readOnly", { get: getReadOnly, set: setReadOnly });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        any.control(control).initialize();

        addElementEvent("onSelect", function(dateText, inst) {
            setValue(any.date(dateText).toString());
        });

        addElementEvent("beforeShow", function(input, inst) {
            any.blocker().start();
        });

        addElementEvent("onClose", function(dateText, inst) {
            setValue(any.date(dateText).toString());
            any.blocker().stop();
        });

        o.$editElement.datepicker(o.options);
    })();

    function element()
    {
        return o.$editElement;
    }

    function focus()
    {
        o.$editElement.focus();
    }

    function select()
    {
        o.$editElement.select();
    }

    function setOption()
    {
        any.copyArguments(o.options, arguments);
    }

    function addElementEvent(key, func)
    {
        func.origin = o.options[key];

        o.options[key] = function()
        {
            if (func.origin != null) {
                func.origin.apply(this, arguments);
            }

            func.apply(this, arguments);
        };
    }

    function parseValue(val)
    {
        if (typeof(val) === "string" && any.text.startsWith(val, "{") && any.text.endsWith(val, "}")) {
            val = eval(val.substr(1, val.length - 2));
        }

        return val;
    }

    function getValue()
    {
        return any.date(o.$editElement.val()).toString();
    }

    function setValue(val)
    {
        if (typeof(val) === "number") {
            val = any.date(new Date(val)).toString();
        } else {
            val = parseValue(val);
        }

        o.$editElement.val(any.date(val).toDisplay());

        if (o.currentValue != val) {
            o.$control.fire("onChange");
        }

        o.currentValue = val;

        resetDisplay();
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
        var val = o.$editElement.val();

        if (val == "") {
            return null;
        }

        return any.date(val).toDate();
    }

    function getText()
    {
        if (o.readOnly == true) {
            return any.text.empty(o.$editElement.val(), o.currentValue);
        }

        return o.$editElement.val();
    }

    function getMin()
    {
        return any.text.nvl(o.$editElement.datepicker("option", "minDate"), o.options.minDate);
    }

    function setMin(val)
    {
        o.$editElement.datepicker("option", "minDate", o.options.minDate = any.date(parseValue(val)).toDate());
    }

    function getMax()
    {
        return any.text.nvl(o.$editElement.datepicker("option", "maxDate"), o.options.maxDate);
    }

    function setMax(val)
    {
        o.$editElement.datepicker("option", "maxDate", o.options.maxDate = any.date(parseValue(val)).toDate());
    }

    function getReadOnly()
    {
        return o.readOnly;
    }

    function setReadOnly(val)
    {
        o.readOnly = (String(val).toLowerCase() == "readonly" || any.object.toBoolean(val, true));
        resetDisplay();
    }

    function getDisabled()
    {
        return o.disabled;
    }

    function setDisabled(val)
    {
        o.disabled = (String(val).toLowerCase() == "disabled" || any.object.toBoolean(val, true));
        resetDisplay();
    }

    function resetDisplay()
    {
        if (o.readOnly == true) {
            if (o.$readElement == null) {
                o.$readElement = jQuery('<' + o.$control.tag().toLowerCase() + '>').appendTo(control).hide();
            }
            o.$editElement.hide();
            jQuery('img', control).hide();
            o.$readElement.prop({ "innerText": getText(), "disabled": o.disabled }).attr({ "title": getText() }).show();
        } else {
            if (o.$readElement != null) {
                o.$readElement.hide();
            }
            o.$editElement.prop({ "disabled": o.disabled }).show();
            jQuery('img', control).css({ cursor: o.disabled ? "default" : "pointer" }).fadeTo(0, o.disabled ? 0.3 : 1).prop({ "disabled": o.disabled });
            jQuery('img', control).show();
        }
    }
});
