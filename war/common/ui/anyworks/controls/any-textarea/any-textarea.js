any.control("any-textarea").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.$editElement = jQuery('textarea', control);

        if (o.$editElement.length == 0) {
            o.$editElement = jQuery('<textarea>').appendTo(o.$control);
        }

        if (jQuery.browser.msie != true) {
            o.$editElement.css("resize", o.$control.tag() == "DIV" ? "vertical" : "none");
        }

        o.$editElement.css({ "margin-top": "0px", "margin-bottom": "0px" });

        o.$editElement.css(any.object.parse({}, o.$control.attr("element-style"), ";", ":"));

        if (o.$control.tag() == "DIV") {
            o.$control.css("padding-right", any.elementWidthGap(o.$control, 'textarea'));
            o.$editElement.width("100%");
        }

        initPlaceHolder(o.$control.attr("placeholder"));

        o.$control.copyAttr("wrap", o.$editElement);

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("focus", focus);
        o.$control.defineMethod("select", select);

        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("rows", { get: getRows, set: setRows });
        o.$control.defineProperty("maxByte", { get: getMaxByte, set: setMaxByte });
        o.$control.defineProperty("readOnly", { get: getReadOnly, set: setReadOnly });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        any.control(control).initialize();
    })();

    function element()
    {
        return o.$editElement;
    }

    function initPlaceHolder(placeholderText)
    {
        if (placeholderText == null || placeholderText == "") {
            return;
        }

        if (o.$editElement.hasAttr("placeholder") == true) {
            o.$control.copyAttr("placeholder", o.$editElement);
            return;
        }

        o.$placeholder = jQuery('<span>').text(placeholderText).appendTo(o.$control.css({ "position": "relative" }));
        o.$placeholder.css({ "position": "absolute", "top": "2px", "left": "4px", "color": "gray" });

        o.$editElement.focus(function() {
            o.$placeholder.hide();
        }).blur(function() {
            o.$placeholder.showHide(o.$editElement.val() == "");
        });
    }

    function focus()
    {
        o.$editElement.focus();
    }

    function select()
    {
        o.$editElement.select();
    }

    function getValue()
    {
        return o.$editElement.val();
    }

    function setValue(val)
    {
        o.$editElement.val(val);
        resetDisplay();
    }

    function getRows()
    {
        return o.$editElement.prop("rows");
    }

    function setRows(val)
    {
        o.$editElement.prop("rows", val);
    }

    function getMaxByte()
    {
        return o.maxByte;
    }

    function setMaxByte(val)
    {
        o.maxByte = val;
        any.control.util.maxbyte.setMessage(o);
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
        if (o.$placeholder != null) {
            o.$placeholder.showHide(o.$editElement.val() == "");
        }

        if (o.readOnly == true) {
            if (o.$readElement == null) {
                o.$readElement = jQuery('<pre>').appendTo(control).hide();
            }
            o.$editElement.hide();
            o.$readElement.prop({ "innerText": o.$control.prop("value"), "disabled": o.disabled }).show();
        } else {
            if (o.$readElement != null) {
                o.$readElement.hide();
            }
            o.$editElement.prop({ "disabled": o.disabled }).show();
        }

        any.control.util.maxbyte.setMessage(o);
    }
});
