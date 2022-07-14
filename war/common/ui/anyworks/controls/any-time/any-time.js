any.control("any-time").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.config = any.control(control).config;
        o.$editElement = jQuery('input', control);

        o.options = {};
        o.options.hourGrid = 4;
        o.options.minuteGrid = 10;
        o.options.timeFormat = any.text.nvl(o.config("options.timeFormat"), "HH:mm:ss");

        if (o.$editElement.length == 0) {
            o.$editElement = jQuery('<input>').attr("type", "text").appendTo(o.$control);
        } else if (typeof(o.$editElement.attr("type")) === "undefined") {
            o.$editElement = o.$editElement.clone().attr("type", "text").appendTo(o.$control);
            o.$control.children(':first').remove();
        }

        o.$editElement.css({ "text-align": "center", "padding-left": "1px", "padding-right": "1px", "margin-left": "0px", "margin-right": "0px", "vertical-align": "middle" });

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("focus", focus);
        o.$control.defineMethod("select", select);
        o.$control.defineMethod("setOption", setOption);

        o.$control.defineProperty("format", { get: getFormat, set: setFormat });
        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("text", { get: getText, set: setText });
        o.$control.defineProperty("readOnly", { get: getReadOnly, set: setReadOnly });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        any.control(control).initialize();

        if (o.$control.tag() == "DIV") {
            o.$control.css("padding-right", any.elementWidthGap(o.$control, 'input'));
            o.$editElement.width("100%");
        } else {
            var allLen = o.options.timeFormat.length;
            var numLen = any.text.replaceAll(o.options.timeFormat, ":", "").length;
            o.$editElement.width((numLen * 8 + (allLen - numLen) * 2) + "px");
        }

        o.$editElement.timepicker(o.options);
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

    function getFormat()
    {
        return o.options.timeFormat;
    }

    function setFormat(fmt)
    {
        o.options.timeFormat = fmt;
    }

    function getValue()
    {
        return any.date(o.$editElement.val(), getDisplayFormat()).toString(getValueFormat());
    }

    function setValue(val)
    {
        o.$editElement.val(any.date(val, getValueFormat()).toString(getDisplayFormat()));
        resetDisplay();
    }

    function getValueFormat()
    {
        return any.text.replaceAll(getDisplayFormat(), ":", "");
    }

    function getDisplayFormat()
    {
        return o.options.timeFormat.toLowerCase().replace("mm", "ii");
    }

    function getText()
    {
        return o.$editElement.val();
    }

    function setText(txt)
    {
        o.$editElement.val(txt);
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
            o.$readElement.prop({ "innerText": getText(), "disabled": o.disabled }).attr({ "title": getText() }).show();
        } else {
            if (o.$readElement != null) {
                o.$readElement.hide();
            }
            o.$editElement.prop({ "disabled": o.disabled }).show();
        }
    }
});
