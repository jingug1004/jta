any.control("any-buttonset").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);

        control.isReady = (!o.$control.hasAttr("codeData") || o.$control.hasAttr("depend"));

        o.type = any.text.blank(o.$control.attr("type"), "radio");
        o.name = control.id + "_input_" + any.control().newIndex();

        if (control.isReady == true) {
            if (o.$control.data("default-value") != null) {
                setValue(o.$control.data("default-value"));
                o.$control.removeData("default-value");
            }
        }

        o.$control.buttonset();

        any.control.util.codedata.setDefault(o, "codeData");

        o.$control.defineMethod("setCodeDataObject", setCodeDataObject);
        o.$control.defineMethod("clearItem", clearItem);
        o.$control.defineMethod("addItem", addItem);
        o.$control.defineMethod("getValue", getValue);

        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("index", { get: getIndex, set: setIndex });
        o.$control.defineProperty("text", { get: getText });
        o.$control.defineProperty("codeData", { get: getCodeData, set: setCodeData });
        o.$control.defineProperty("includeCodes", { get: getIncludeCodes, set: setIncludeCodes });
        o.$control.defineProperty("excludeCodes", { get: getExcludeCodes, set: setExcludeCodes });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        if (o.$control.attr("defaultCodeData") == null && o.$control.find('input').length == 0) {
            any.control.util.codedata.setObject(o);
        }

        any.control(control).initialize();
    })();

    function refresh()
    {
        if (o.refreshDisabled == true) {
            return;
        }

        o.$control.buttonset("destroy").buttonset();

        o.$control.find('label > span').click(function() {
            if (o.disabled == true) {
                return;
            }

            var $label = jQuery(this).parent();

            if (o.type == "checkbox") {
                $label.prev()[0].checked = ($label.prev()[0].checked != true);
            } else {
                $label.prev()[0].checked = true;
            }

            var val = getValue();

            if (o.currentValue != val) {
                o.$control.fire("onChange");
            }

            if (o.type == "checkbox") {
                $label.prev()[0].checked = ($label.prev()[0].checked != true);
            }

            o.currentValue = val;
        });
    }

    function setCodeDataObject(codeDatas)
    {
        o.$control.empty();

        o.refreshDisabled = true;
        any.control.util.codedata.setObject(o, any.control.util.codedata.getFiltered(codeDatas, o.includeCodes, o.excludeCodes));
        o.refreshDisabled = false;

        refresh();

        o.codeDatas = codeDatas;

        control.isReady = true;
    }

    function clearItem()
    {
        o.$control.empty();

        refresh();
    }

    function addItem(code, text, data)
    {
        var id = o.name + "_" + any.control().newIndex();
        var $input;

        if (jQuery.browser.msie != true || Number(jQuery.browser.version) >= 8) {
            $input = jQuery('<input>').prop({ "type": o.type }).attr({ "name": o.name });
        } else {
            $input = jQuery('<input type="' + o.type + '" name="' + o.name + '">');
        }

        $input.attr({ "id": id }).val(code).data("data", data).appendTo(control);

        jQuery('<label>').attr({ "for": id }).text(text).appendTo(control);

        refresh();
    }

    function $getInputs()
    {
        return o.$control.find('input[type="' + o.type + '"][name="' + o.name + '"]');
    }

    function getValue(name)
    {
        var $inputs = $getInputs();

        if (o.type == "radio") {
            for (var i = 0, ii = $inputs.length; i < ii; i++) {
                if ($inputs[i].checked != true) {
                    continue;
                }
                if (name == null) {
                    return $inputs[i].value;
                }
                return $inputs.eq(i).data("data")[name];
            }

            return null;
        }

        var vals = [];

        for (var i = 0, ii = $inputs.length; i < ii; i++) {
            if ($inputs[i].checked == true) {
                vals.push($inputs[i].value);
            }
        }

        return vals.join(o.$control.hasAttr("valueSeparator") ? o.$control.attr("valueSeparator") : ",");
    }

    function setValue(val)
    {
        if (val == null) {
            return;
        }

        if ($getInputs().length == 0) {
            o.$control.data("default-value", val);
            return;
        }

        if (o.type == "radio") {
            $getInputs().each(function() {
                this.checked = (this.value == val);
                if (this.checked == true) {
                    jQuery(this).next().children('span').click();
                }
            });
        } else {
            var vals = val.split(o.$control.hasAttr("valueSeparator") ? o.$control.attr("valueSeparator") : ",");

            $getInputs().each(function() {
                this.checked = function(v) {
                    for (var i = 0, ii = vals.length; i < ii; i++) {
                        if (vals[i] == v) {
                            return true;
                        }
                    }
                }(this.value);
            });
        }

        if (o.currentValue != val) {
            o.$control.fire("onChange");
        }

        o.currentValue = val;
    }

    function getIndex()
    {
        if (o.type != "radio") {
            return null;
        }

        var $inputs = $getInputs();

        for (var i = 0, ii = $inputs.length; i < ii; i++) {
            if ($inputs[i].checked == true) {
                return i;
            }
        }

        return -1;
    }

    function setIndex(idx)
    {
        if (o.type != "radio") {
            return;
        }

        $getInputs().each(function(index) {
            this.checked = (index == idx);
        });

        var val = (idx == -1 ? null : getValue());

        if (o.currentValue != val) {
            o.$control.fire("onChange");
        }

        o.currentValue = val;
    }

    function getText()
    {
        var $inputs = $getInputs();

        if (o.type == "radio") {
            for (var i = 0, ii = $inputs.length; i < ii; i++) {
                if ($inputs[i].checked == true) {
                    return $inputs.eq(i).next().children('span').text();
                }
            }

            return "";
        }

        var txts = [];

        for (var i = 0, ii = $inputs.length; i < ii; i++) {
            if ($inputs[i].checked == true) {
                txts.push($inputs.eq(i).next().children('span').text());
            }
        }

        return txts.join(o.$control.hasAttr("textSeparator") ? o.$control.attr("textSeparator") : ", ");
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

    function getDisabled()
    {
        return o.disabled;
    }

    function setDisabled(val)
    {
        o.disabled = (String(val).toLowerCase() == "disabled" || any.object.toBoolean(val, true));

        o.$control.buttonset("option", "disabled", o.disabled);
    }
});
