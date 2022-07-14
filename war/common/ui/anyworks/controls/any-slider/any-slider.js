any.control("any-slider").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control).css({ "padding-left": "10px", "padding-right": "10px" });
        o.$element = jQuery('<div>').appendTo(control);
        o.options = {};

        o.$element.slider(o.options).on("slide", function(event, ui) {
            if (o.$label != null) {
                o.$label.text(ui.value);
            }
            o.$control.fire("onChange", [ui.value]);
        });

        o.$control.defineMethod("element", element);

        o.$control.defineProperty("min", { get: getMin, set: setMin });
        o.$control.defineProperty("max", { get: getMax, set: setMax });
        o.$control.defineProperty("step", { get: getStep, set: setStep });
        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("label", { set: setLabel });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        any.control(control).initialize();
    })();

    function element()
    {
        return o.$element;
    }

    function getMin()
    {
        return o.$element.slider("option", "min");
    }

    function setMin(val)
    {
        val = Number(val);

        var prevValue = getValue();

        o.$element.slider("option", "min", val);

        if (val == prevValue) {
            if (o.$label != null) {
                o.$label.text(val);
            }
        } else if (val > prevValue) {
            setValue(val);
        }
    }

    function getMax()
    {
        return o.$element.slider("option", "max");
    }

    function setMax(val)
    {
        val = Number(val);

        var prevValue = getValue();

        o.$element.slider("option", "max", val);

        if (val == prevValue) {
            if (o.$label != null) {
                o.$label.text(val);
            }
        } else if (val < prevValue) {
            setValue(val);
        }
    }

    function getStep()
    {
        return o.$element.slider("option", "step");
    }

    function setStep(val)
    {
        val = Number(val);

        o.$element.slider("option", "step", val);
    }

    function getValue()
    {
        return o.$element.slider("value");
    }

    function setValue(val)
    {
        val = Number(val);

        var prevValue = getValue();

        o.$element.slider("value", val);

        if (o.$label != null) {
            o.$label.text(val);
        }

        if (prevValue != val) {
            o.$control.fire("onChange", [val]);
        }
    }

    function setLabel(pos)
    {
        if (o.$label == null) {
            o.$label = jQuery('<div>').css({ "text-align": "center" });
        }

        if (pos == "top") {
            o.$element.before(o.$label.css({ "margin-top": "0px", "margin-bottom": "5px" }));
        } else if (pos == "bottom") {
            o.$element.after(o.$label.css({ "margin-top": "5px", "margin-bottom": "0px" }));
        } else {
            o.$label.remove();
            o.$label = null;
        }
    }

    function getDisabled()
    {
        return o.disabled;
    }

    function setDisabled(val)
    {
        o.disabled = (String(val).toLowerCase() == "disabled" || any.object.toBoolean(val, true));

        if (o.disabled == true) {
            o.$element.slider("disable");
        } else {
            o.$element.slider("enable");
        }

        if (o.$label != null) {
            o.$label.prop("disabled", o.disabled);
        }
    }
});
