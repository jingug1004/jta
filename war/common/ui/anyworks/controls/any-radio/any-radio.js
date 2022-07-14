any.control("any-radio").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);

        control.isReady = (!o.$control.hasAttr("codeData") || o.$control.hasAttr("depend"));

        if (o.$control.hasAttr("radioName")) {
            o.radioName = "rdo_" + o.$control.attr("radioName");
        } else {
            o.radioName = "rdo_" + control.id + "_" + any.control().newIndex();
        }

        if (control.isReady == true) {
            var text = any.text.trim(o.$control.text());
            o.$control.text("");
            if (text != "") {
                o.singleMode = true;
                addItem(o.$control.attr("value"), text, null, o.$control);
                o.$control.removeAttr("value");
                o.$control.prop("value", null);
            }
            if (o.$control.data("default-value") != null) {
                setValue(o.$control.data("default-value"));
                o.$control.removeData("default-value");
            }
        }

        any.control.util.codedata.setDefault(o, "codeData");

        o.$control.defineMethod("setCodeDataObject", setCodeDataObject);
        o.$control.defineMethod("setDepend", setDepend);
        o.$control.defineMethod("clearItem", clearItem);
        o.$control.defineMethod("addItem", addItem);
        o.$control.defineMethod("getValue", getValue);

        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("index", { get: getIndex, set: setIndex });
        o.$control.defineProperty("text", { get: getText });
        o.$control.defineProperty("checked", { get: getChecked, set: setChecked });
        o.$control.defineProperty("codeData", { get: getCodeData, set: setCodeData });
        o.$control.defineProperty("includeCodes", { get: getIncludeCodes, set: setIncludeCodes });
        o.$control.defineProperty("excludeCodes", { get: getExcludeCodes, set: setExcludeCodes });
        o.$control.defineProperty("depend", { get: getDepend, set: setDepend });
        o.$control.defineProperty("noWrap", { get: getNoWrap, set: setNoWrap });
        o.$control.defineProperty("space", { get: getSpace, set: setSpace });
        o.$control.defineProperty("readOnly", { get: getReadOnly, set: setReadOnly });
        o.$control.defineProperty("readOnly2", { get: getReadOnly2, set: setReadOnly2 });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        if (o.$control.attr("defaultCodeData") == null && o.$control.find('td').length == 0) {
            any.control.util.codedata.setObject(o);
        }

        any.control(control).initialize();
    })();

    function setCodeDataObject(codeDatas)
    {
        any.control.util.codedata.clearArea(o);

        any.control.util.codedata.setObject(o, any.control.util.codedata.getFiltered(codeDatas, o.includeCodes, o.excludeCodes));

        delete(o.currentValue);

        o.codeDatas = codeDatas;

        control.isReady = true;
    }

    function clearItem()
    {
        any.control.util.codedata.clearArea(o);

        delete(o.currentValue);

        o.$control.fire("onChange");
    }

    function addItem(code, text, data, $area)
    {
        var rdo_id = o.radioName + "_" + any.control().newIndex();
        var $rdo;

        if (jQuery.browser.msie != true || Number(jQuery.browser.version) >= 8) {
            $rdo = jQuery('<input>').prop({ "type": "radio" }).attr({ "name": o.radioName, "id": rdo_id });
        } else {
            $rdo = jQuery('<input type="radio" name="' + o.radioName + '">').attr({ "id": rdo_id });
        }

        $rdo.prop("value", code).data("data", data).css({ "padding": "0px", "margin": "0px", "vertical-align": "middle" });

        if ($area == null) {
            $area = any.control.util.codedata.getArea(o);
        }

        if (text != null && text != "") {
            any.control.util.codedata.setSpace(o,
                jQuery('<label>').attr({ "for": rdo_id, "title": text }).css({ "vertical-align": "middle" }).appendTo($area)
                    .append($rdo)
                    .append(jQuery('<span>').text(text).css({ "padding-left": "2px", "vertical-align": "middle" }))
            );
        } else {
            $area.append($rdo);
        }

        $rdo.click(function() {
            var val = getValue();
            if (o.currentValue != val) {
                o.$control.fire("onChange");
            }
            o.currentValue = val;
        });

        resetDisplay();
    }

    function getValue(name)
    {
        var $rdos = jQuery('input[type="radio"][name="' + o.radioName + '"]');

        for (var i = 0, ii = $rdos.length; i < ii; i++) {
            if ($rdos[i].checked != true) {
                continue;
            }
            if (name == null) {
                return $rdos[i].value;
            }
            return $rdos.eq(i).data("data")[name];
        }

        return null;
    }

    function setValue(val)
    {
        if (val == null) {
            return;
        }

        var $rdos = jQuery('input[type="radio"][name="' + o.radioName + '"]');

        if ($rdos.length == 0) {
            o.$control.data("default-value", val);
            return;
        }

        $rdos.each(function() {
            this.checked = (this.value == val);
        });

        if (o.currentValue != val) {
            o.$control.fire("onChange");
        }

        o.currentValue = val;

        resetDisplay();
    }

    function getIndex()
    {
        var $rdos = jQuery('input[type="radio"][name="' + o.radioName + '"]');

        for (var i = 0, ii = $rdos.length; i < ii; i++) {
            if ($rdos[i].checked == true) {
                return i;
            }
        }

        return -1;
    }

    function setIndex(idx)
    {
        if (idx == null) {
            return;
        }

        var $rdos = jQuery('input[type="radio"][name="' + o.radioName + '"]');

        if ($rdos.length == 0) {
            o.$control.data("default-index", idx);
            return;
        }

        $rdos.each(function(index) {
            this.checked = (index == idx);
        });

        var val = getValue();

        if (o.currentValue != val) {
            o.$control.fire("onChange");
        }

        o.currentValue = val;

        resetDisplay();
    }

    function getText()
    {
        var $rdos = jQuery('input[type="radio"][name="' + o.radioName + '"]');

        for (var i = 0, ii = $rdos.length; i < ii; i++) {
            if ($rdos[i].checked == true) {
                return $rdos.eq(i).next().text();
            }
        }

        return "";
    }

    function getChecked()
    {
        if (o.singleMode == true) {
            var $rdos = o.$control.find('input[type="radio"]');
            if ($rdos.length > 0) {
                return $rdos[0].checked;
            }
        }
    }

    function setChecked(checked)
    {
        if (o.singleMode == true) {
            var $rdos = o.$control.find('input[type="radio"]');
            if ($rdos.length > 0) {
                $rdos[0].checked = (String(checked).toLowerCase() == "checked" || any.object.toBoolean(checked, true));
            }
        }
    }

    function getCodeData()
    {
        return o.codeData;
    }

    function setCodeData(val)
    {
        o.singleMode = false;

        if (o.depend != null && o.depend.defaultParams != null) {
            any.codedata(control).get(val + "," + o.depend.defaultParams);
            o.depend.defaultParams = null;
        } else {
            any.codedata(control).get(val);
        }

        if (o.depend != null && o.depend.codeData == null) {
            o.depend.codeData = val;
        }

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

    function getNoWrap()
    {
        return o.noWrap;
    }

    function setNoWrap(val)
    {
        o.noWrap = (String(val).toLowerCase() == "" || any.object.toBoolean(val, true));
        resetDisplay();
    }

    function getSpace()
    {
        return o.space;
    }

    function setSpace(space)
    {
        o.space = space;
        any.control.util.codedata.setSpace(o);
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

    function resetDisplay()
    {
        if (o.readOnly == true) {
            if (o.$readElement == null) {
                o.$readElement = jQuery('<' + o.$control.tag().toLowerCase() + '>').appendTo(control).hide();
            }
            if (o.$codeDataArea != null) {
                o.$codeDataArea.hide();
            }
            o.$readElement.prop({ "innerText": o.$control.prop("text"), "disabled": o.disabled }).attr({ "title": o.$control.prop("text") }).show();
        } else {
            if (o.$readElement != null) {
                o.$readElement.hide();
            }
            if (o.$codeDataArea != null) {
                o.$codeDataArea.show();
            }
            o.$control.find('input:radio').each(function() {
                this.disabled = (o.disabled == true || (o.readOnly2 == true && o.currentValue != this.value));
                jQuery(this).parent().prop("disabled", this.disabled).css("white-space", o.noWrap == true ? "nowrap" : "");
            });
        }
    }
});
