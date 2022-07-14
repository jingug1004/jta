any.control("any-select").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);

        control.isReady = (!o.$control.hasAttr("codeData") || o.$control.hasAttr("depend"));

        o.$editElement = jQuery('select', control);

        if (o.$editElement.length == 0) {
            o.$editElement = jQuery('<select>').appendTo(control);
        }

        o.$editElement.css({ "vertical-align": "middle" });
        o.$editElement.css(any.object.parse({}, o.$control.attr("element-style"), ";", ":"));

        if (o.$control.tag() == "DIV") {
            o.$editElement.css("width", "100%");
        }

        o.$editElement.on("change", function() {
            var val = o.$editElement.val();
            if (o.currentValue != val) {
                o.currentValue = val;
                o.$control.fire("onChange");
            }
        });

        o.$editElement.on("mouseover", function() {
            var options = o.$editElement[0].options;
            var title;

            if (options.length == 0 || options.selectedIndex == -1 || options[options.selectedIndex].value == "") {
                title = "";
            } else {
                title = options[options.selectedIndex].title;
            }

            o.$editElement.attr("title", title);
        });

        any.control.util.codedata.setDefault(o, "codeData");

        o.$control.copyAttr("title", o.$editElement);

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("focus", focus);
        o.$control.defineMethod("select", select);
        o.$control.defineMethod("setCodeDataObject", setCodeDataObject);
        o.$control.defineMethod("setDepend", setDepend);
        o.$control.defineMethod("clearItem", clearItem);
        o.$control.defineMethod("addItem", addItem);
        o.$control.defineMethod("getData", getData);
        o.$control.defineMethod("getValueRow", getValueRow);
        o.$control.defineMethod("getValue", getValue);

        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("index", { get: getIndex, set: setIndex });
        o.$control.defineProperty("text", { get: getText });
        o.$control.defineProperty("codeData", { get: getCodeData, set: setCodeData });
        o.$control.defineProperty("includeCodes", { get: getIncludeCodes, set: setIncludeCodes });
        o.$control.defineProperty("excludeCodes", { get: getExcludeCodes, set: setExcludeCodes });
        o.$control.defineProperty("depend", { get: getDepend, set: setDepend });
        o.$control.defineProperty("readOnly", { get: getReadOnly, set: setReadOnly });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        if (o.$control.attr("defaultCodeData") == null && o.$editElement[0].options.length == 0) {
            any.control.util.codedata.setObject(o);
        }

        any.control(control).initialize();
    })();

    function element()
    {
        return o.readOnly == true ? o.$readElement : o.$editElement;
    }

    function focus()
    {
        o.$editElement.focus();
    }

    function select()
    {
        o.$editElement.select();
    }

    function setCodeDataObject(codeDatas)
    {
        o.$editElement[0].options.length = 0;

        any.control.util.codedata.setObject(o, any.control.util.codedata.getFiltered(codeDatas, o.includeCodes, o.excludeCodes));

        if (o.$control.hasAttr("firstName") != true && o.$editElement[0].options.length > 0 && o.currentValue == null && o.$control.data("default-value") == null) {
            var onChangeCall = (o.$editElement[0].options.selectedIndex == -1);
            o.$editElement[0].options.selectedIndex = 0;
            if (onChangeCall == true) {
                o.$control.fire("onChange");
            }
        }

        delete(o.currentValue);

        o.codeDatas = codeDatas;

        control.isReady = true;
    }

    function clearItem(clearFirstName)
    {
        if (clearFirstName == true || o.$control.hasAttr("firstName") != true) {
            o.$editElement[0].options.length = 0;
        } else {
            o.$editElement[0].options.length = 1;
        }

        delete(o.currentValue);

        o.$control.fire("onChange");
    }

    function addItem(code, text, data)
    {
        if (code == null) {
            code = "";
        }
        if (text == null) {
            text = code;
        }

        var opt = new Option(text, code);

        opt.title = text;
        opt.data = data;

        o.$editElement[0].options.add(opt);
    }

    function getData(idx)
    {
        if (idx == null) {
            idx = o.$editElement[0].options.selectedIndex;
        }

        if (idx == null || idx == -1) {
            return null;
        }

        return o.$editElement[0].options[idx].data;
    }

    function getValueRow(code)
    {
        for (var i = 0; i < o.$editElement[0].options.length; i++) {
            if (o.$editElement[0].options[i].value == code) {
                return i;
            }
        }

        return -1;
    }

    function getValue(name)
    {
        if (name == null) {
            return o.$editElement.val();
        }

        var data = getData();

        if (data == null || data[name] == null) {
            return null;
        }

        return data[name];
    }

    function setValue(val)
    {
        if (o.$editElement.length == 0 || o.$editElement[0].options.length == 0 || (o.$control.hasAttr("firstName") == true && o.$editElement[0].options.length == 1)) {
            o.$control.data("default-value", val);
            return;
        }
        o.$editElement[0].options.selectedIndex = (o.$control.hasAttr("firstName") == true ? 0 : -1);
        for (var i = 0; i < o.$editElement[0].options.length; i++) {
            if (o.$editElement[0].options[i].value == val) {
                o.$editElement[0].options.selectedIndex = i;
                break;
            }
        }
        if (o.currentValue != val) {
            o.$control.fire("onChange");
        }
        o.currentValue = val;
        resetDisplay();
    }

    function getIndex()
    {
        return o.$editElement[0].options.selectedIndex;
    }

    function setIndex(idx)
    {
        if (o.$editElement.length == 0 || o.$editElement[0].options.length == 0 || (o.$control.hasAttr("firstName") == true && o.$editElement[0].options.length == 1)) {
            o.$control.data("default-index", idx);
            return;
        }
        o.$editElement[0].options.selectedIndex = idx;
        var val = getValue();
        if (o.currentValue != val) {
            o.$control.fire("onChange");
        }
        o.currentValue = val;
        resetDisplay();
    }

    function getText()
    {
        var elem = o.$editElement[0];
        if (elem.options.selectedIndex == -1) {
            return "";
        }
        if (o.readOnly == true && elem.options[elem.options.selectedIndex].value == "") {
            return "";
        }
        return elem.options[elem.options.selectedIndex].text;
    }

    function getCodeData()
    {
        return o.codeData;
    }

    function setCodeData(val)
    {
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
            o.$readElement.prop({ "innerText": o.$control.prop("text"), "disabled": o.disabled }).attr({ "title": o.$control.prop("text") }).show();
        } else {
            if (o.$readElement != null) {
                o.$readElement.hide();
            }
            o.$editElement.prop({ "disabled": o.disabled }).show();
        }
    }
});
