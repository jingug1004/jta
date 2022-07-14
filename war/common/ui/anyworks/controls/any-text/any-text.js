any.control("any-text").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.config = any.control(control).config;
        o.$editElement = jQuery('input', control);

        var type = any.text.blank(o.$control.attr("type"), "text");

        if (o.$editElement.length == 0) {
            o.$editElement = jQuery('<input>').attr("type", type).appendTo(o.$control);
        } else if (typeof(o.$editElement.attr("type")) === "undefined") {
            o.$editElement = o.$editElement.clone().attr("type", type).appendTo(o.$control);
            o.$control.children(':first').remove();
        }

        o.$editElement.css({ "padding-left": "1px", "padding-right": "1px", "margin-left": "0px", "margin-right": "0px", "vertical-align": "middle" });

        if (o.$control.tag() == "DIV") {
            o.$control.css("padding-right", any.elementWidthGap(o.$control, 'input'));
            o.$editElement.width("100%");
        }

        if (type != "text") {
            o.$editElement.css({ "ime-mode": "disabled" });
        }

        o.$editElement.css(any.object.parse({}, o.$control.attr("element-style"), ";", ":"));

        o.$editElement.change(function() {
            o.$control.fire("onChange");
        });

        o.$editElement.blur(function() {
            formatValue();
        });

        initPlaceHolder(o.$control.attr("placeholder"));

        o.$control.copyAttr("title", o.$editElement);
        o.$control.copyAttr("size", o.$editElement);
        o.$control.copyAttr("maxlength", o.$editElement);

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("focus", focus);
        o.$control.defineMethod("select", select);

        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("text", { get: getText, set: setText });
        o.$control.defineProperty("maxByte", { get: getMaxByte, set: setMaxByte });
        o.$control.defineProperty("format", { get: getFormat, set: setFormat });
        o.$control.defineProperty("mask", { get: getMask, set: setMask });
        o.$control.defineProperty("readOnly", { get: getReadOnly, set: setReadOnly });
        o.$control.defineProperty("readOnly2", { get: getReadOnly2, set: setReadOnly2 });

        if (type == "email") {
            o.$control.defineProperty("checkValid", { get: getCheckValidEmail }).attr("valid-enable", true);
        }

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
        var txt;
        if (o.mask == null) {
            txt = o.$editElement.val();
        } else {
            try {
                txt = o.$editElement.mask("value");
            } catch(e) {
                txt = o.$editElement.val();
            }
        }
        switch (o.$editElement.css("text-transform").toLowerCase()) {
            case "uppercase": return txt.toUpperCase();
            case "lowercase": return txt.toLowerCase();
        }
        return txt;
    }

    function setValue(val)
    {
        if (o.mask == null) {
            o.$editElement.val(val);
        } else {
            try {
                o.$editElement.mask("value", val);
            } catch(e) {
                o.$editElement.val(val);
            }
        }
        if (o.currentValue != val) {
            o.$control.fire("onChange");
        }
        o.currentValue = val;
        formatValue();
        resetDisplay();
    }

    function getText()
    {
        var txt = o.$editElement.val();
        if (o.mask != null) {
            try {
                txt = any.text.replaceAll(txt, o.$editElement.mask("option", "placeholder"), "");
            } catch(e) {
            }
        }
        switch (o.$editElement.css("text-transform").toLowerCase()) {
            case "uppercase": txt = txt.toUpperCase(); break;
            case "lowercase": txt = txt.toLowerCase(); break;
        }
        return txt;
    }

    function setText(val)
    {
        o.$editElement.val(val);
        formatValue();
        resetDisplay();
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

    function getReadOnly2()
    {
        return o.readOnly2;
    }

    function setReadOnly2(val)
    {
        o.readOnly2 = any.object.toBoolean(val, true);
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

    function getMaxByte()
    {
        return o.maxByte;
    }

    function setMaxByte(val)
    {
        o.maxByte = val;
        any.control.util.maxbyte.setMessage(o);
    }

    function getFormat()
    {
        return o.format;
    }

    function setFormat(val)
    {
        o.format = val;
        formatValue();
        resetDisplay();
    }

    function getMask()
    {
        return o.mask;
    }

    function setMask(val)
    {
        o.mask = val;
        jQuery(function() {
            o.$editElement.mask({ mask: val, clearEmpty: false });
        });
        resetDisplay();
    }

    function formatValue()
    {
        if (o.format == null) {
            return;
        }

        var val = o.$editElement.val();

        if (val != "") {
            o.$editElement.val(any.text.format(val, o.format));
        }
    }

    function getCheckValidEmail()
    {
        var val = getValue();

        if (val == "") {
            return true;
        }

        if (/[^@]+@[A-Za-z0-9_\-]+\.[A-Za-z]+/.test(val)) {
            return true;
        }
        if (/[^@]+@[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+\.[A-Za-z]+/.test(val)) {
            return true;
        }
        if (/[^@]+@[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+\.[A-Za-z]+/.test(val)) {
            return true;
        }

        any.dialog(true).alert(any.message("any.valid.email", "E-Mail address is not in the correct format.").toString()).ok(function() {
            focus();
        });

        return false;
    }

    function resetDisplay()
    {
        if (o.$placeholder != null) {
            o.$placeholder.showHide(o.$editElement.val() == "");
        }

        if (o.readOnly == true) {
            if (o.$readElement == null) {
                o.$readElement = jQuery('<' + o.$control.tag().toLowerCase() + '>').appendTo(control).hide();
            }
            o.$editElement.hide();
            o.$readElement.css({ "text-align": o.$editElement.css("text-align") }).prop({ "innerText": getText(), "disabled": o.disabled }).attr("title", getText()).show();
            o.$control.css("padding-right", "0px");
        } else {
            if (o.$readElement != null) {
                o.$readElement.hide();
            }
            o.$editElement.prop({ "readOnly": o.readOnly2, "disabled": o.disabled }).show();
            o.$control.css("padding-right", o.$control.tag() == "DIV" ? any.elementWidthGap(o.$control, 'input') : "0px");
        }

        any.control.util.maxbyte.setMessage(o);
    }
});
