any.control("any-multiselect").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.config = any.control(control).config;
        o.options = {};

        o.options.multiple = true;

        if (o.$control.hasAttr("header")) {
            if (String(o.$control.attr("header")).toLowerCase() != "true") {
                o.options.header = o.$control.attr("header");
            } else {
                o.options.header = true;
            }
        } else {
            o.options.header = false;
        }

        o.options.selectedList = (o.$control.hasAttr("selectedList") ? o.$control.attr("selectedList") : 4);

        if (o.$control.hasAttr("noneSelectedText")) {
            o.options.noneSelectedText = o.$control.attr("noneSelectedText");
        }

        if (o.$control.hasAttr("selectedText")) {
            o.options.selectedText = o.$control.attr("selectedText");
        }

        o.options.position = { my: "center top", at: "center bottom", collision: "flipfit", within: window };

        control.isReady = !o.$control.hasAttr("codeData");

        o.$editElement = jQuery('select', control);

        if (o.$editElement.length == 0) {
            o.$editElement = jQuery('<select>').appendTo(o.$control);
        }

        o.$editElement.on("multiselectbeforeopen", function(event, ui) {
            jQuery('div.ui-multiselect-menu').width(o.$button.width());
            any.blocker().start();
        });

        o.$editElement.on("multiselectclose", function(event, ui) {
            any.blocker().stop();
        });

        any.control.util.codedata.setDefault(o, "codeData");

        o.$control.copyAttr("title", o.$editElement);

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("getOption", getOption);
        o.$control.defineMethod("setOption", setOption);
        o.$control.defineMethod("setCodeDataObject", setCodeDataObject);
        o.$control.defineMethod("addItem", addItem);
        o.$control.defineMethod("getItem", getItem);
        o.$control.defineMethod("reset", reset);

        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("text", { get: getText });
        o.$control.defineProperty("codeData", { get: getCodeData, set: setCodeData });
        o.$control.defineProperty("includeCodes", { get: getIncludeCodes, set: setIncludeCodes });
        o.$control.defineProperty("excludeCodes", { get: getExcludeCodes, set: setExcludeCodes });
        o.$control.defineProperty("depend", { get: getDepend, set: setDepend });
        o.$control.defineProperty("readOnly", { get: getReadOnly, set: setReadOnly });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        any.control(control).initialize();

        jQuery(window).resize(function() {
            o.$editElement.multiselect("close");
        });

        o.initialized = true;

        reset();

        setDefaultValue();
    })();

    function element()
    {
        return o.$editElement;
    }

    function getOption(name)
    {
        return o.options[name];
    }

    function setOption()
    {
        any.copyArguments(o.options, arguments);
    }

    function setCodeDataObject(codeDatas)
    {
        o.$editElement[0].options.length = 0;

        any.control.util.codedata.setObject(o, any.control.util.codedata.getFiltered(codeDatas, o.includeCodes, o.excludeCodes));

        o.$editElement[0].options.selectedIndex = -1;

        reset();

        o.codeDatas = codeDatas;

        control.isReady = true;

        setDefaultValue();
    }

    function addItem(code, text, data)
    {
        var opt = new Option(text, code);

        opt.title = text;
        opt.data = data;

        o.$editElement[0].options.add(opt);

        if (o.initialized == true && control.isReady == true) {
            reset();
        }
    }

    function getItem(code)
    {
        if (o.$editElement.length == 0) {
            return null;
        }

        for (var i = 0, ii = o.$editElement[0].options.length; i < ii; i++) {
            if (o.$editElement[0].options[i].value == code) {
                return o.$editElement[0].options[i];
            }
        }
    }

    function reset()
    {
        o.$editElement.multiselect(o.options).multiselect("widget").hide();

        o.$button = o.$control.children('button').css("vertical-align", "middle");

        if (o.$control.tag() == "DIV") {
            o.$button.css("width", "100%");
        } else {
            o.$button.removeCss("width");
        }

        resetDisplay();
    }

    function getValue()
    {
        if (o.initialized != true) {
            return;
        }

        return o.$editElement.multiselect("getChecked").map(function() {
            return this.value;
        }).get().join(o.$control.hasAttr("valueSeparator") ? o.$control.attr("valueSeparator") : ",");
    }

    function setValue(val)
    {
        if (o.initialized != true || control.isReady != true) {
            o.defaultValue = val;
            return;
        }
        o.$editElement.multiselect("uncheckAll");
        var vals = String(val).split(o.$control.hasAttr("valueSeparator") ? o.$control.attr("valueSeparator") : ",");
        for (var i = 0, ii = vals.length; i < ii; i++) {
            o.$editElement.multiselect("widget").find('input:checkbox[value="' + vals[i] + '"]').click();
        }
        o.$editElement.val(vals);
        o.$control.fire("onChange");
        resetDisplay();
    }

    function getText()
    {
        if (o.initialized != true) {
            return;
        }

        return o.$editElement.multiselect("getChecked").map(function() {
            return this.title;
        }).get().join(o.$control.hasAttr("textSeparator") ? o.$control.attr("textSeparator") : ", ");
    }

    function getCodeData()
    {
        return o.codeData;
    }

    function setCodeData(val)
    {
        any.codedata(control).get(val);
        o.codeData = val;
    }

    function getIncludeCodes()
    {
        return o.includeCodes;
    }

    function setIncludeCodes(includeCodes)
    {
        o.includeCodes = any.control.util.codedata.getFilterValues(includeCodes);

        if (o.codeDatas != null) {
            setCodeDataObject(o.codeDatas);
        }
    }

    function getExcludeCodes()
    {
        return o.excludeCodes;
    }

    function setExcludeCodes(excludeCodes)
    {
        o.excludeCodes = any.control.util.codedata.getFilterValues(excludeCodes);

        if (o.codeDatas != null) {
            setCodeDataObject(o.codeDatas);
        }
    }

    function getDepend()
    {
        return o.depend == null || o.depend.ids == null ? null : o.depend.ids.join(",");
    }

    function setDepend(val, codeData)
    {
        if (codeData != null) {
            o.codeData = codeData;
        }

        any.control.util.codedata.setDepend(o, val);
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

    function setDefaultValue()
    {
        if (control.isReady == true && o.defaultValue != null && o.$editElement[0].options.length > 0) {
            setValue(o.defaultValue);
            o.defaultValue = null;
        }
    }

    function resetDisplay()
    {
        if (o.readOnly == true) {
            if (o.$readElement == null) {
                o.$readElement = jQuery('<' + o.$control.tag().toLowerCase() + '>').appendTo(control).hide();
            }
            if (o.$button != null) {
                o.$button.hide();
            }
            o.$readElement.prop({ "innerText": getText(), "disabled": o.disabled }).attr({ "title": getText() }).show();
        } else {
            if (o.$readElement != null) {
                o.$readElement.hide();
            }
            if (o.$button != null) {
                o.$button.show();
            }
            if (o.initialized == true) {
                if (o.disabled == true) {
                    o.$editElement.multiselect("disable");
                } else {
                    o.$editElement.multiselect("enable");
                }
            }
        }
    }
});
