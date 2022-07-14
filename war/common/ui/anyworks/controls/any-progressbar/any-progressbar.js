any.control("any-progressbar").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.$element = o.$control.children('div');
        o.options = {};

        if (o.$element.length == 0) {
            o.$element = jQuery('<div>').appendTo(control);
        }

        o.$element.css({ "position": "relative" });

        o.$label = o.$element.children('div');

        if (o.$label.length == 0) {
            o.$label = jQuery('<div>').hide().appendTo(o.$element);
        }

        o.$label.addClass("any-progressbar-label").css({ "position": "absolute", "width": "100%", "text-align": "center", "white-space": "nowrap" });

        o.$element.on("progressbarcreate", function(event, ui) {
            o.created = true;
            resetLabelPosition();
            o.$control.fire("onCreate");
        });

        o.defaultLabel = o.$control.attr("defaultLabel");

        if (o.defaultLabel != null && o.defaultLabel != "") {
            setLabel(o.defaultLabel);
        }

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("reset", reset);
        o.$control.defineMethod("getOption", getOption);
        o.$control.defineMethod("setOption", setOption);

        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("label", { get: getLabel, set: setLabel });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        any.control(control).initialize();

        o.$element.progressbar(o.options);

        if (o.value != null) {
            setValue(o.value);
        }

        if (o.disabled == true) {
            o.$element.children('div.ui-progressbar-value').children('div.ui-progressbar-overlay').hide();
            o.$element.progressbar("disable");
        }
    })();

    function element()
    {
        return o.$element;
    }

    function reset()
    {
        if (o.created == true) {
            o.$element.progressbar("destroy").progressbar(o.options);
            o.$label.text("").hide();
            delete(o.value);
        }
    }

    function getOption(name)
    {
        return o.options[name];
    }

    function setOption()
    {
        any.copyArguments(o.options, arguments);
    }

    function getValue()
    {
        return o.value;
    }

    function setValue(val)
    {
        o.value = val;

        if (o.created == true) {
            o.$element.progressbar("value", typeof(o.value) === "number" ? o.value * 100 : o.value);
        }
    }

    function getLabel()
    {
        return o.label;
    }

    function setLabel(label)
    {
        o.label = label;

        o.$label.show().text(o.label);

        resetLabelPosition();
    }

    function resetLabelPosition()
    {
        if (o.$label != null) {
            o.$label.css("top", (o.$element.height() - o.$label.height()) / 2);
        }
    }

    function getDisabled()
    {
        return o.disabled;
    }

    function setDisabled(val)
    {
        if (o.disabled == val) {
            return;
        }

        o.disabled = (String(val).toLowerCase() == "disabled" || any.object.toBoolean(val, true));

        if (o.created == true) {
            o.$element.children('div.ui-progressbar-value').children('div.ui-progressbar-overlay').showHide(o.disabled != true);
            o.$element.progressbar("option", "disabled", o.disabled);
        }

        o.$control.attr("disabled", o.disabled);
    }
});
