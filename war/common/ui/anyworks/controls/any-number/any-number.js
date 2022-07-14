any.control("any-number").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.config = any.control(control).config;
        o.$editElement = jQuery('input', control);
        o.format = {};

        var type = any.text.blank(o.$control.attr("type"), "number");

        if (o.$editElement.length == 0) {
            o.$editElement = jQuery('<input>').attr("type", type).appendTo(o.$control);
        } else if (typeof(o.$editElement.attr("type")) === "undefined" && type.toLowerCase() == "number") {
            o.$editElement = o.$editElement.clone().attr("type", type).appendTo(o.$control);
            o.$control.children(':first').remove();
        }

        o.$editElement.css({ "padding-left": "1px", "padding-right": "1px", "margin-left": "0px", "margin-right": "0px", "ime-mode": "disabled", "vertical-align": "middle", "text-align": "right" });
        o.$editElement.css(any.object.parse({}, o.$control.attr("element-style"), ";", ":"));

        if (o.$control.tag() == "DIV") {
            o.$control.css("padding-right", any.elementWidthGap(o.$control, 'input'));
            o.$editElement.width("100%");
        }

        o.$editElement.css(any.object.parse({}, o.$control.attr("element-style"), ";", ":"));

        o.$editElement.change(function() {
            window.setTimeout(function() {
                o.$control.fire("onChange");
            });
        });

        o.$editElement.keypress(function(event) {
            if (function() {
                var charCode = (event.charCode || event.keyCode);
                if (charCode >= 48 && charCode <= 57) {
                    return true;
                }
                if (charCode == 9 || charCode == 38 || charCode == 40) {
                    return true;
                }
                if (charCode == "-".charCodeAt(0) && String(this.value).indexOf("-") == -1 && (o.format.min == null || Number(o.format.min) < 0)) {
                    return true;
                }
                if (charCode == ".".charCodeAt(0) && String(this.value).indexOf(".") == -1 && Number(o.format.digits) > 0) {
                    return true;
                }
                return false;
            }() != true) {
                any.event(event).preventDefault();
            }
        });

        o.$editElement.keyup(function(event) {
            if (o.$editElement.val() == "" || isValid(any.text.replaceAll(o.$editElement.val(), ",", "")) == true) {
                o.$editElement.removeClass("any-invalid");
            } else {
                o.$editElement.addClass("any-invalid");
            }
        });

        o.$editElement.focus(function() {
            var val = any.text.unformatNumber(this.value, o.format.thousandsSeparator);
            if (this.value != val) {
                this.value = val;
            }
            jQuery(this).select();
        });

        o.$editElement.blur(function() {
            o.$editElement.removeClass("any-invalid");
            if (formatValue() != true) {
                o.$control.fire("onChange");
            }
        });

        o.$control.copyAttr("title", o.$editElement);
        o.$control.copyAttr("size", o.$editElement);
        o.$control.copyAttr("maxlength", o.$editElement);
        o.$control.copyAttr("placeholder", o.$editElement);

        if (o.$control.hasAttr("maxByte")) {
            o.$editElement.attr("maxlength", o.$control.attr("maxByte"));
        }

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("focus", focus);
        o.$control.defineMethod("select", select);

        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("text", { get: getText });
        o.$control.defineProperty("min", { get: getMin, set: setMin });
        o.$control.defineProperty("max", { get: getMax, set: setMax });
        o.$control.defineProperty("step", { get: getStep, set: setStep });
        o.$control.defineProperty("digits", { get: getDigits, set: setDigits });
        o.$control.defineProperty("thousandsSeparator", { get: getThousandsSeparator, set: setThousandsSeparator });
        o.$control.defineProperty("readOnly", { get: getReadOnly, set: setReadOnly });
        o.$control.defineProperty("readOnly2", { get: getReadOnly2, set: setReadOnly2 });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        any.control(control).initialize();
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

    function getValue()
    {
        var val = o.$editElement.val();

        if (val == null || val == "") {
            return val;
        }

        var txt = any.text(val).trim();

        if (o.$editElement.prop("type") == "number") {
            return txt.toNumber();
        }

        return txt.replaceAll(",", "").toString();
    }

    function setValue(val)
    {
        var orgValue = o.currentValue;

        if (formatValue(val) != true) {
            val = "";
        }

        if (o.currentValue != orgValue) {
            o.$control.fire("onChange");
        }

        resetDisplay();
    }

    function getText()
    {
        return o.$editElement.val();
    }

    function getMin()
    {
        return o.format.min;
    }

    function setMin(val)
    {
        if (o.$editElement.prop("type") == "number") {
            o.$editElement.attr("min", val);
        }

        o.format.min = Number(val);

        formatValue();
    }

    function getMax()
    {
        return o.format.max;
    }

    function setMax(val)
    {
        if (o.$editElement.prop("type") == "number") {
            o.$editElement.attr("max", val);
        }

        o.format.max = Number(val);

        formatValue();
    }

    function getStep()
    {
        return o.format.step;
    }

    function setStep(val)
    {
        if (o.$editElement.prop("type") == "number") {
            o.$editElement.attr("step", val);
        }

        o.format.step = Number(val);
    }

    function getDigits()
    {
        return o.format.digits;
    }

    function setDigits(val)
    {
        o.format.digits = Number(val);
        formatValue();
    }

    function getThousandsSeparator()
    {
        return o.format.thousandsSeparator;
    }

    function setThousandsSeparator(val)
    {
        o.format.thousandsSeparator = val;
        formatValue();
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

    function formatValue(val)
    {
        if (val == null) {
            val = o.$editElement.val();
        }

        var num = (String(val) == "" ? "" : any.text.replaceAll(any.text.trim(val), ",", ""));

        if (o.readOnly != true && num != "" && isValid(num) != true) {
            num = any.text.nvl(o.currentValue, "");
        }

        if (any.text.isEmpty(num) != true) {
            num = Number(num);
        }

        o.$editElement.val(any.text.formatNumber(num, Number(o.format.digits), o.$editElement.prop("type") == "number" ? "" : o.format.thousandsSeparator));

        o.currentValue = num;

        resetDisplay();

        return true;
    }

    function isValid(num)
    {
        if (isNaN(num)) {
            return false;
        }

        num = Number(num);

        if (o.format.min != null && o.format.min > num) {
            return false;
        }
        if (o.format.max != null && o.format.max < num) {
            return false;
        }

        if (o.format.min == null || o.format.step == null) {
            return true;
        }

        var stepPow = function() {
            var stepStr = String(o.format.step);
            if (stepStr.indexOf(".") != -1) {
                return Math.pow(10, stepStr.substr(stepStr.indexOf(".") + 1).length);
            }
            return 1;
        }();

        return (num * stepPow - o.format.min * stepPow) % (o.format.step * stepPow) == 0;
    }

    function resetDisplay()
    {
        if (o.readOnly == true) {
            if (o.$readElement == null) {
                o.$readElement = jQuery('<' + o.$control.tag().toLowerCase() + '>').css({ "text-align": o.$editElement.css("text-align") }).appendTo(control).hide();
            }
            o.$editElement.hide();
            var text;
            if (o.$editElement.prop("type") == "number") {
                text = any.text.formatNumber(getValue(), Number(o.format.digits), o.format.thousandsSeparator);
            } else {
                text = o.$control.prop("text");
            }
            o.$readElement.prop({ "innerText": text, "disabled": o.disabled }).attr({ "title": text }).show();
            o.$control.css("padding-right", "0px");
        } else {
            if (o.$readElement != null) {
                o.$readElement.hide();
            }
            o.$editElement.prop({ "readOnly": o.readOnly2, "disabled": o.disabled }).show();
            o.$control.css("padding-right", o.config("padding-right"));
        }
    }
});
