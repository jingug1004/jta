any.control("any-search").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.config = any.control(control).config;

        initHTML();

        control.isObjectValueSet = true;

        control.prx = any.proxy();
        control.win = any.window(true);

        o.searchBoxName = o.config("searchBox.name");

        if (o.searchBoxName == null || o.searchBoxName == "") {
            o.searchBoxName = "SEARCH_TEXT";
        }

        o.$control.attr("defaultValue", o.$control.attr("value"));

        o.$control.defineMethod("focus", focus);
        o.$control.defineMethod("addButton", addButton);
        o.$control.defineMethod("setParam", setParam);
        o.$control.defineMethod("setColumn", setColumn);
        o.$control.defineMethod("setNameExpr", setNameExpr);
        o.$control.defineMethod("setMultiple", setMultiple);
        o.$control.defineMethod("doSearch", doSearch);
        o.$control.defineMethod("doDelete", doDelete);
        o.$control.defineMethod("getValue", getValue);

        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("text", { get: getText });
        o.$control.defineProperty("nameExpr", { get: getNameExpr, set: setNameExpr });
        o.$control.defineProperty("valueData", { get: getValueData });
        o.$control.defineProperty("searchBoxName", { get: getSearchBoxName, set: setSearchBoxName });
        o.$control.defineProperty("searchBoxReadOnly", { get: getSearchBoxReadOnly, set: setSearchBoxReadOnly });
        o.$control.defineProperty("readOnly", { get: getReadOnly, set: setReadOnly });
        o.$control.defineProperty("searchOnly", { get: getSearchOnly, set: setSearchOnly });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        any.control(control).initialize();
    })();

    function initHTML()
    {
        if (o.$control.tag() == "DIV") {
            o.$editElement = jQuery('<table>').addClass("layout").appendTo(control);
        } else {
            o.$editElement = jQuery('<span>').appendTo(control);
        }

        o.$input = jQuery('<input>').prop({ "type": "text" }).css({ "padding-left": "1px", "padding-right": "1px", "margin-left": "0px", "margin-right": "0px", "vertical-align": "middle" });

        if (o.$control.tag() == "DIV") {
            var $tr = jQuery('<tr>').appendTo(jQuery('<tbody>').appendTo(o.$editElement));
            o.$input.css({ "width": "100%" }).appendTo(jQuery('<td>').css({ "width": "*" }).appendTo($tr));
            o.$input.parent().css("padding-right", any.elementWidthGap(o.$control, 'input:text'));
        } else {
            o.$input.css({ "margin-left": "0px" }).appendTo(o.$editElement);
            o.$control.copyAttr("size", o.$input);
        }

        o.$input.enter(function(event) {
            any.event(event).stopPropagation();
            execSearch();
        });

        o.$input.keydown(function(event) {
            if (event.keyCode != 8 && event.keyCode != 46) {
                return;
            }
            any.event(event).stopPropagation();
            if (o.value == null) {
                return;
            }
            doDelete();
        });

        o.$input.blur(function() {
            if (o.$input.prop("readonly") == true) {
                return;
            }
            if (o.$input.val() == "") {
                return;
            }
            execSearch();
        });

        o.$input.click(function() {
            if (o.searchBoxReadOnly == true) {
                doSearch();
            }
        });

        o.$search = addButton("ui-icon-search", execSearch, "Search");
        o.$delete = addButton("ui-icon-close", doDelete, "Delete");
    }

    function focus()
    {
        if (jQuery.browser.msie && Number(jQuery.browser.version) < 10) {
            o.$input.blur().select().blur().focus();
        } else {
            o.$input.focus();
        }
    }

    function addButton(icon, func, title)
    {
        var $button = jQuery('<span>').button({ icons: { primary: icon } }).css({ "vertical-align": "middle", "width": "18px", "height": "18px", "margin-right": "0px" });

        if (o.$control.tag() == "DIV") {
            $button.appendTo(jQuery('<td>').css({ "width": "20px", "padding-left": "2px" }).appendTo(o.$editElement.find('tr')));
        } else {
            $button.css({ "margin-left": "2px" }).appendTo(o.$editElement);
        }

        $button.children('span.ui-button-icon-primary').css({ "left": "1px" });
        $button.children('span.ui-button-text').remove();

        $button.click(func);

        if (title != null) {
            $button.attr("title", title);
        }

        return $button;
    }

    function setParam()
    {
        control.prx.param.apply(control.prx, arguments);
        control.win.param.apply(control.win, arguments);
        control.win.arg.apply(control.win, arguments);
    }

    function setColumn(internalColumnName, externalColumnName)
    {
        if (arguments.length == 1) {
            o.codeColumn = internalColumnName;
            return;
        }

        if (o.internalColumns == null) {
            o.internalColumns = {};
        }
        if (o.externalColumns == null) {
            o.externalColumns = {};
        }

        o.internalColumns[externalColumnName] = internalColumnName;
        o.externalColumns[internalColumnName] = externalColumnName;
    }

    function getNameExpr()
    {
        return o.nameExpr;
    }

    function setNameExpr(val, reset)
    {
        o.nameExpr = val;

        if (reset == true) {
            resetData(o.valueData, false, false);
        }
    }

    function setMultiple(spec)
    {
        if (spec == null) {
            spec = {};
        }

        o.multipleOptions = {};

        o.multipleOptions.codeDelimiter = any.text.nvl(spec.codeDelimiter, ",");
        o.multipleOptions.nameDelimiter = any.text.nvl(spec.nameDelimiter, ", ");
        o.multipleOptions.displayCodeColumn = spec.displayCodeColumn;
        o.multipleOptions.displayNameColumn = spec.displayNameColumn;

        control.win.arg("multiselect", true);

        o.$input.prop("readonly", o.value != null);
        o.$input.css("cursor", "pointer");

        o.searchBoxReadOnly = true;
    }

    function getValue(name)
    {
        if (arguments.length == 0) {
            return o.value;
        }

        if (o.valueData == null) {
            return null;
        }

        if (o.multipleOptions == null) {
            if (name in o.valueData) {
                return o.valueData[name];
            }
        } else {
            var values = [];
            for (var i = 0, ii = o.valueData.length; i < ii; i++) {
                if (name in o.valueData[i]) {
                    values.push(o.valueData[i][name]);
                }
            }
            return values.join(o.multipleOptions.codeDelimiter);
        }

        return null;
    }

    function setValue(obj)
    {
        resetData(obj, false, true);
    }

    function getText()
    {
        return o.$input.val();
    }

    function getValueData()
    {
        return o.valueData;
    }

    function getSearchBoxName()
    {
        return o.searchBoxName;
    }

    function setSearchBoxName(name)
    {
        o.searchBoxName = name;
    }

    function getSearchBoxReadOnly()
    {
        return o.searchBoxReadOnly;
    }

    function setSearchBoxReadOnly(val)
    {
        o.searchBoxReadOnly = (String(val).toLowerCase() == "readonly" || any.object.toBoolean(val, true));

        o.$input.prop("readonly", o.value != null || o.searchBoxReadOnly == true);
        o.$input.css("cursor", o.searchBoxReadOnly == true ? "pointer" : "");
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

    function getSearchOnly()
    {
        return o.searchOnly;
    }

    function setSearchOnly(val)
    {
        o.searchOnly = (String(val).toLowerCase() == "searchonly" || any.object(val).toBoolean(true));
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

    function getInternalColumnName(externalColumnName)
    {
        if (o.internalColumns == null) {
            return externalColumnName;
        }

        return any.text.nvl(o.internalColumns[externalColumnName], externalColumnName);
    }

    function getExternalColumnName(internalColumnName)
    {
        if (o.externalColumns == null) {
            return internalColumnName;
        }

        return any.text.nvl(o.externalColumns[internalColumnName], internalColumnName);
    }

    function getNameExprValue(obj)
    {
        if (o.nameExpr == null) {
            return any.text.nvl(obj[control.id], "");
        }

        var result = o.nameExpr;

        for (var item in obj) {
            result = any.text.replaceAll(result, "{#" + item + "}", obj[item]);
        }

        for (var item in obj) {
            result = any.text.replaceAll(result, "{#" + getInternalColumnName(item) + "}", obj[item]);
        }

        for (var item in obj) {
            result = any.text.replaceAll(result, "{#" + getExternalColumnName(item) + "}", obj[item]);
        }

        return result;
    }

    function execSearch()
    {
        var val = o.$input.val();

        if (o.searchValue == val) {
            return;
        }

        o.searchValue = val;

        doSearch();
    }

    function doSearch()
    {
        if (o.disabled == true || o.$input.prop("disabled") == true || o.$search.button("option", "disabled")) {
            return;
        }

        o.$control.fire("onBeforeSearch");

        var sch = any.search({ prx: control.prx, win: control.win });

        sch.windowMode(o.value != null || o.$input.val() == "");
        sch.prx.param(o.searchBoxName, o.$input.val());
        sch.win.arg(o.searchBoxName, o.value == null ? o.$input.val() : "");
        sch.win.type(o.config("openSearch.type"));

        if (sch.prx.url() == null || sch.windowMode() == true) {
            window.setTimeout(function() {
                delete(o.searchValue);
            }, 1000);
        } else {
            sch.prx.on("onComplete", function() {
                delete(o.searchValue);
            });
        }

        sch.ok(function(data) {
            if (data == null) {
                any.dialog(true).alert(any.message("any.com.noDataFound", "No data found.").toString()).ok(function() {
                    resetData(null, true, true);
                });
            } else {
                resetData(data, true, true);
            }
        });

        sch.search();
    }

    function doDelete()
    {
        if (o.disabled == true || o.$input.prop("disabled") == true || o.$delete.button("option", "disabled")) {
            return;
        }

        resetData(null, true, true);
    }

    function resetData(data, isFocus, onChangeCall)
    {
        if (data == null) {
            o.value = null;
            o.valueData = null;
        } else {
            var dataType = jQuery.type(data);
            var key = any.text.nvl(o.codeColumn, control.id);

            if (dataType === "array" && o.multipleOptions == null) {
                o.valueData = {};
                if (data.length > 0) {
                    for (var item in data[0]) {
                        o.valueData[getInternalColumnName(item)] = o.valueData[item] = data[0][item];
                    }
                }
            } else if (dataType === "array") {
                o.valueData = [];
                for (var i = 0, ii = data.length; i < ii; i++) {
                    var obj = {};
                    for (var item in data[i]) {
                        obj[getInternalColumnName(item)] = obj[item] = data[i][item];
                    }
                    o.valueData.push(obj);
                }
            } else {
                o.valueData = {};
                for (var item in data) {
                    o.valueData[getInternalColumnName(item)] = o.valueData[item] = data[item];
                }
            }

            if (dataType === "object" || o.multipleOptions == null) {
                if (o.multipleOptions == null) {
                    o.value = any.text.nvl(o.valueData[key], o.valueData[getExternalColumnName(key)]);
                    o.$input.val(getNameExprValue(o.valueData));
                } else {
                    o.value = o.valueData[o.multipleOptions.displayCodeColumn];
                    o.$input.val(o.valueData[o.multipleOptions.displayNameColumn]);
                }
            } else {
                var codes = [];
                var names = [];
                for (var i = 0, ii = o.valueData.length; i < ii; i++) {
                    var value = any.text.nvl(o.valueData[i][key], o.valueData[i][getExternalColumnName(key)]);
                    if (value != null && value != "") {
                        codes.push(value);
                        names.push(getNameExprValue(o.valueData[i]));
                    }
                }
                o.value = codes.join(o.multipleOptions.codeDelimiter);
                o.$input.val(names.join(o.multipleOptions.nameDelimiter));
            }
        }

        if (o.value == "") {
            o.value = null;
        }

        if (o.value == null) {
            o.$input.val("");
        }

        var bool = (o.value != null);

        o.$input.prop("readonly", bool == true || o.searchBoxReadOnly == true);
        o.$delete.button("option", "disabled", !bool);

        if (bool) {
            o.$input.addClass("any-search-readonly");
        } else {
            o.$input.removeClass("any-search-readonly");
        }

        resetDisplay();

        if (onChangeCall == true) {
            o.$control.fire("onChange");
        }

        if (isFocus == true && o.readOnly != true) {
            focus();
        }
    }

    function resetDisplay()
    {
        if (o.readOnly == true) {
            if (o.$readElement == null) {
                o.$readElement = jQuery('<' + o.$control.tag().toLowerCase() + '>').appendTo(control).hide();
            }
            o.$editElement.hide();
            o.$readElement.prop({ "innerText": getText(), "disabled": o.disabled }).attr("title", getText()).show();
        } else {
            if (o.$readElement != null) {
                o.$readElement.hide();
            }
            o.$input.prop("disabled", o.disabled);
            o.$editElement.find('span.ui-button').button("option", "disabled", o.disabled);
            o.$delete.button("option", "disabled", o.disabled || o.value == null);
            o.$editElement.attr("title", getText()).show();
        }

        if (o.$control.tag() == "DIV") {
            o.$input.parent().showHide(o.searchOnly != true);
            o.$search.parent().css("padding-left", o.searchOnly == true ? "0px" : "2px");
            o.$delete.parent().showHide(o.searchOnly != true);
        } else {
            o.$input.showHide(o.searchOnly != true);
            o.$search.css("margin-left", o.searchOnly == true ? "0px" : "2px");
            o.$delete.showHide(o.searchOnly != true);
        }
    }
});
