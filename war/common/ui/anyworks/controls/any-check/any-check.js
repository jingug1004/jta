any.control("any-check").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.config = any.control(control).config;

        o.checkValue = any["boolean"](o.config("booleanValues")).trueValue();
        o.uncheckValue = any["boolean"](o.config("booleanValues")).falseValue();

        control.isReady = !o.$control.hasAttr("codeData");

        if (control.isReady == true) {
            o.singleMode = true;
            var text = any.text.trim(o.$control.text());
            o.$control.text("");
            addItem(o.checkValue, text, null, o.$control);
            if (o.$control.data("default-value") != null) {
                setValue(o.$control.data("default-value"));
                o.$control.removeData("default-value");
            }
        }

        any.control.util.codedata.setDefault(o, "codeData");

        o.$control.defineMethod("setCodeDataObject", setCodeDataObject);
        o.$control.defineMethod("clearItem", clearItem);
        o.$control.defineMethod("addItem", addItem);
        o.$control.defineMethod("deleteItem", deleteItem);
        o.$control.defineMethod("getItem", getItem);
        o.$control.defineMethod("setItemText", setItemText);
        o.$control.defineMethod("getCheckedData", getCheckedData);
        o.$control.defineMethod("getChecked", getChecked);
        o.$control.defineMethod("setChecked", setChecked);
        o.$control.defineMethod("checkAll", checkAll);

        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("singleText", { get: getSingleText, set: setSingleText });
        o.$control.defineProperty("text", { get: getText });
        o.$control.defineProperty("checked", { get: getChecked, set: setChecked });
        o.$control.defineProperty("codeData", { get: getCodeData, set: setCodeData });
        o.$control.defineProperty("includeCodes", { get: getIncludeCodes, set: setIncludeCodes });
        o.$control.defineProperty("excludeCodes", { get: getExcludeCodes, set: setExcludeCodes });
        o.$control.defineProperty("noWrap", { get: getNoWrap, set: setNoWrap });
        o.$control.defineProperty("space", { get: getSpace, set: setSpace });
        o.$control.defineProperty("readOnly", { get: getReadOnly, set: setReadOnly });
        o.$control.defineProperty("readOnly2", { get: getReadOnly2, set: setReadOnly2 });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        any.control(control).initialize();
    })();

    function setCodeDataObject(codeDatas)
    {
        any.control.util.codedata.clearArea(o);

        any.control.util.codedata.setObject(o, any.control.util.codedata.getFiltered(codeDatas, o.includeCodes, o.excludeCodes));

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
        var chk_id = "chk_" + control.id + "_" + any.control().newIndex();
        var $chk = jQuery('<input>').prop({ "type": "checkbox", "value": code }).attr({ "id": chk_id });

        $chk.data("data", data).css({ "padding": "0px", "margin": "0px", "vertical-align": "middle" });

        if ($area == null) {
            $area = any.control.util.codedata.getArea(o);
        }

        if (text == null || text == "") {
            jQuery('<label>').appendTo($area).append($chk);
        } else {
            any.control.util.codedata.setSpace(o,
                jQuery('<label>').attr({ "for": chk_id, "title": text }).css({ "vertical-align": "middle" }).appendTo($area)
                    .append($chk)
                    .append(jQuery('<span>').text(text).css({ "padding-left": "2px", "vertical-align": "middle" }))
            );
        }

        $chk.click(function() {
            if (getReadOnly() == true) {
                this.checked = (this.disabled != true);
            } else if (getDisabled() != true) {
                o.$control.fire("onChange");
            }
        });

        resetDisplay();
    }

    function deleteItem(code)
    {
        var item = getItem(code);

        if (item != null) {
            var $td = o.$control.find(jQuery(item).parent('label').parent('td'));

            if ($td.length == 1) {
                $td.remove();
            } else {
                jQuery(item).next().remove().end().remove();
            }
        }

        resetDisplay();
    }

    function getItem(code)
    {
        var $chks = o.$control.find('input[type="checkbox"]');

        for (var i = 0, ii = $chks.length; i < ii; i++) {
            if ($chks[i].value == code) {
                return $chks[i];
            }
        }

        return null;
    }

    function setItemText(code, text)
    {
        var item = getItem(code);

        if (item != null) {
            jQuery(item).next().text(text);
        }
    }

    function checkAll(checked)
    {
        o.$control.find('input[type="checkbox"]').prop("checked", checked);
        o.$control.fire("onChange");
        resetDisplay();
    }

    function getValue()
    {
        var $chks = o.$control.find('input[type="checkbox"]');
        var vals = [];

        for (var i = 0, ii = $chks.length; i < ii; i++) {
            if ($chks[i].checked == true) {
                vals.push($chks[i].value);
            }
        }

        if (o.singleMode == true && vals.length == 0) {
            return o.uncheckValue;
        }

        return vals.join(o.$control.hasAttr("valueSeparator") ? o.$control.attr("valueSeparator") : ",");
    }

    function setValue(val)
    {
        if (val == null) {
            return;
        }

        var $chks = o.$control.find('input[type="checkbox"]');

        if ($chks.length == 0) {
            o.$control.data("default-value", val);
            return;
        }

        var vals;

        if (o.singleMode == true) {
            vals = [val];
        } else {
            vals = String(val).split(o.$control.hasAttr("valueSeparator") ? o.$control.attr("valueSeparator") : ",");
        }

        $chks.each(function() {
            this.checked = function(v) {
                for (var i = 0, ii = vals.length; i < ii; i++) {
                    if (vals[i] == v) {
                        return true;
                    }
                }
            }(this.value);
        });

        o.$control.fire("onChange");

        resetDisplay();
    }

    function getSingleText()
    {
        return o.singleText;
    }

    function setSingleText(val)
    {
        var $label = o.$control.children('label');
        var $span = $label.children('span');

        if ($span.length == 0) {
            $span = jQuery('<span>').css({ "padding-left": "2px", "vertical-align": "middle" }).appendTo($label);
        }

        $span.text(val);

        o.singleText = val;

        resetDisplay();
    }

    function getText()
    {
        var $chks = o.$control.find('input[type="checkbox"]');
        var txts = [];

        for (var i = 0, ii = $chks.length; i < ii; i++) {
            if ($chks[i].checked == true) {
                txts.push($chks.eq(i).next().text());
            }
        }

        return txts.join(o.$control.hasAttr("textSeparator") ? o.$control.attr("textSeparator") : ", ");
    }

    function getCheckedData()
    {
        var datas = [];

        o.$control.find('input[type="checkbox"]').each(function() {
            if (this.checked == true) {
                datas.push(jQuery(this).data("data"));
            }
        });

        return datas;
    }

    function getChecked(val)
    {
        var $chks = o.$control.find('input[type="checkbox"]' + (arguments.length == 0 ? '' : '[value="' + val + '"]'));

        if ($chks.length == 1) {
            return $chks[0].checked;
        }
    }

    function setChecked(val, val2)
    {
        var $chks = o.$control.find('input[type="checkbox"]' + (arguments.length == 1 ? '' : '[value="' + val + '"]'));
        var checked = (arguments.length == 1 ? val : val2);

        if ($chks.length == 1) {
            $chks[0].checked = (String(checked).toLowerCase() == "checked" || any.object.toBoolean(checked, true));
        }

        resetDisplay();
    }

    function getCodeData()
    {
        return o.codeData;
    }

    function setCodeData(val)
    {
        o.singleMode = false;
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
            if (o.singleMode == true) {
                o.$control.children('label').hide();
            }
            o.$readElement.prop({ "innerText": getText(), "disabled": o.disabled }).attr({ "title": getText() }).show();
        } else {
            if (o.$readElement != null) {
                o.$readElement.hide();
            }
            if (o.$codeDataArea != null) {
                o.$codeDataArea.show();
            }
            if (o.singleMode == true) {
                o.$control.children('label').show();
            }
            o.$control.find('td').css("white-space", o.noWrap == true ? "nowrap" : "");
            o.$control.find('input:checkbox').each(function() {
                jQuery(this).parent().prop({ "disabled": this.disabled = (o.disabled == true || (o.readOnly2 == true && this.checked != true)) });
            });
            o.$control.find('input:checkbox:enabled[readonly2-click-attacked!="1"]').click(function() {
                if (o.readOnly2 === true) {
                    jQuery(this).prop("checked", true);
                }
            }).attr("readonly2-click-attacked", "1");
        }
    }
});
