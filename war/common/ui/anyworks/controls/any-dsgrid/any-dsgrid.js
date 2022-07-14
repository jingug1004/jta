any.control("any-dsgrid").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.config = any.control(control).config;
        o.controlIndex = any.control().newIndex();
        o.columns = [];
        o.options = {};
        o.actions = {};
        o.events = {};
        o.rowId = 0;
        o.edit = any.object.toBoolean(o.$control.attr("edit"), false);

        o.checkValue = any["boolean"](o.config("booleanValues")).trueValue();
        o.uncheckValue = any["boolean"](o.config("booleanValues")).falseValue();

        o.options.rownumWidth = 40;
        o.options.rowAlterable = true;
        o.options.rowAddable = true;
        o.options.rowDeletable = true;
        o.options.rowCheckable = false;

        initDataset();

        if (jQuery.browser.msie) {
            window.setInterval(function() {
                if (o.$table.width() > o.$tableLayer.width()) {
                    o.$tableLayer.innerHeight(o.$table.outerHeight(true) + any.scrollbarWidth());
                } else {
                    o.$tableLayer.innerHeight(o.$table.outerHeight(true));
                }
            }, 100);
        }

        if (o.$control.hasAttr("buttons")) {
            o.$buttons = jQuery(o.$control.attr("buttons"));
        } else {
            o.$buttons = jQuery('<div>').addClass("any-dsgrid-buttons").css({ "padding-bottom": "2px" }).appendTo(control);
        }

        o.$tableLayer = jQuery('<div>').css({ "overflow-x": "auto", "overflow-y": "hidden" }).appendTo(control);
        o.$table = jQuery('<table>').addClass("list").appendTo(o.$tableLayer);
        o.$colgroup = jQuery('<colgroup>').appendTo(o.$table);
        o.$thead = jQuery('<thead>').appendTo(o.$table);
        o.$messageTbody = jQuery('<tbody>').appendTo(o.$table);
        o.$dataTbody = jQuery('<tbody>').appendTo(o.$table);

        o.$addButton = addButton(any.message("any.btn.add", "Add"), addRow);
        o.$delButton = addButton(any.message("any.btn.delete", "Delete"), deleteCheckedRow);

        o.$dataTbody.on("click", 'td[name="col_check"] > input:checkbox:enabled:visible', function() {
            o.$headCheck.prop("checked", o.$dataTbody.find('td[name="col_check"] > input:checkbox:enabled:visible').not(':checked').length == 0);
        });

        o.$control.defineMethod("addGroupHeader", addGroupHeader);
        o.$control.defineMethod("addColumn", addColumn);
        o.$control.defineMethod("getColumn", getColumn);
        o.$control.defineMethod("setColumn", setColumn);
        o.$control.defineMethod("setFormatter", setFormatter);
        o.$control.defineMethod("setKeys", setKeys);
        o.$control.defineMethod("setOption", setOption);
        o.$control.defineMethod("setRowspan", setRowspan);
        o.$control.defineMethod("setTotal", setTotal);
        o.$control.defineMethod("getTotalValue", getTotalValue);
        o.$control.defineMethod("setAddButton", setAddButton);
        o.$control.defineMethod("setDelButton", setDelButton);
        o.$control.defineMethod("addButton", addButton);
        o.$control.defineMethod("addAction", addAction);
        o.$control.defineMethod("addControlEvent", addControlEvent);
        o.$control.defineMethod("addControlInitializer", addControlInitializer);
        o.$control.defineMethod("addRow", addRow);
        o.$control.defineMethod("clearData", clearData);
        o.$control.defineMethod("getCheckedData", getCheckedData);
        o.$control.defineMethod("deleteAll", deleteAll);
        o.$control.defineMethod("deleteCheckedRow", deleteCheckedRow);
        o.$control.defineMethod("deleteRow", deleteRow);
        o.$control.defineMethod("getDataCell", getDataCell);
        o.$control.defineMethod("getControl", getControl);
        o.$control.defineMethod("setControl", setControl);
        o.$control.defineMethod("getValue", getValue);
        o.$control.defineMethod("setValue", setValue);
        o.$control.defineMethod("getRowCount", getRowCount);
        o.$control.defineMethod("getJobType", getJobType);
        o.$control.defineMethod("getRowIndex", getRowIndex);
        o.$control.defineMethod("getRowData", getRowData);
        o.$control.defineMethod("setRowData", setRowData);
        o.$control.defineMethod("setRowDeletable", setRowDeletable);
        o.$control.defineMethod("setRowEditable", setRowEditable);
        o.$control.defineMethod("setTableDnD", setTableDnD);
        o.$control.defineMethod("setMessageTbodyShowHide", setMessageTbodyShowHide);
        o.$control.defineMethod("showHideMessageTbody", showHideMessageTbody);

        o.$control.defineProperty("ds", { get: getDs });
        o.$control.defineProperty("edit", { get: getEdit });
        o.$control.defineProperty("rowCount", { get: getRowCount });
        o.$control.defineProperty("jsonObject", { get: getJsonObject, set: setJsonObject });
        o.$control.defineProperty("jsonString", { get: getJsonString, set: setJsonString });
        o.$control.defineProperty("checkRequire", { get: getCheckRequire });
        o.$control.defineProperty("codeDataDisable", { get: isCodeDataDisable });
        o.$control.defineProperty("dataLoading", { get: isDataLoading });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        setMessageTbodyShowHide(function() {
            var $tr = o.$dataTbody.children('tr');
            for (var i = 0, ii = $tr.length; i < ii; i++) {
                if ($tr.eq(i).css("display") != "none") {
                    return false;
                }
            }
            return true;
        });

        any.control(control).initialize();

        o.buttonVisible = (o.edit == true && o.options.rowAlterable == true);
        o.rowCheckVisible = ((o.buttonVisible == true && o.options.rowDeletable == true) || o.options.rowCheckable);

        o.$addButton.showHide(o.edit == true && o.options.rowAddable == true);
        o.$delButton.showHide(o.edit == true && o.options.rowDeletable == true);

        initialize();

        if (o.ds.isEmpty() != true) {
            resetData();
        }
    })();

    function getDs()
    {
        return o.ds;
    }

    function initDataset()
    {
        if (o.$control.hasAttr("ds")) {
            o.ds = any.ds(o.$control.attr("ds"));
        } else if (control.id.indexOf("_") > 0) {
            o.ds = any.ds("ds_" + control.id.substr(control.id.indexOf("_") + 1));
        } else {
            o.ds = any.ds(control.id);
        }

        o.ds.listData(true);

        o.ds.setBinder(resetData);
    }

    function resetData()
    {
        o.rowId = 0;
        o.codeDataDisable = true;
        o.dataLoading = true;

        o.$dataTbody.empty();

        for (var i = 0, ii = o.ds.rowCount(); i < ii; i++) {
            addTBodyRow(o.ds.rowData(i), i);
            if (o.ds.jobType(i) == "D") {
                deleteRow(i, true);
            }
        }

        resetCalculation();
        resetCodeData();
        resetDisplay();

        delete(o.dataLoading);

        o.$control.fire("onLoad");
    }

    function addGroupHeader(obj)
    {
        if (o.groupHeaders == null) {
            o.groupHeaders = [];
        }

        o.groupHeaders.push(obj);
    }

    function addColumn(colInfo)
    {
        if (colInfo.name == null || colInfo.name == "") {
            return;
        }

        o.columns.push(colInfo);
    }

    function getColumn(name)
    {
        for (var i = 0, ii = o.columns.length; i < ii; i++) {
            if (o.columns[i].name == name) {
                return o.columns[i];
            }
        }
    }

    function setColumn(name, propName, propValue)
    {
        var model = getColumn(name);

        if (model == null) {
            return;
        }

        model[propName] = propValue;

        if (propName == "hidden") {
            getColumnCells(name).showHide(propValue != true);
        } else if (propName == "require") {
            var $ctrls = o.$dataTbody.find('td[name="td_' + name + '"]').find('[name="' + control.id + "_" + name + '"]');
            o.$thead.find('tr > th#th_' + name).children('span.require').showHide(propValue);
            $ctrls.attr("require-enable", propValue);
            if (propValue == true) {
                $ctrls.data("require-name", model.label);
            } else {
                $ctrls.removeData("require-name");
            }
        }
    }

    function getColumnCells(name)
    {
        return o.$table.find('colgroup > col#col_' + name + ', thead > tr > th#th_' + name + ', tbody > tr > td[name="td_' + name + '"], tfoot > tr > td#tf_' + name);
    }

    function setFormatter(colName, formatter, hiddenValue)
    {
        var model = getColumn(colName);

        if (model == null) {
            return;
        }

        model.formatter = formatter;
        model.hiddenValue = hiddenValue;
    }

    function setKeys()
    {
        if (o.keyColumns == null) {
            o.keyColumns = {};
        }

        var keys = Array.prototype.slice.call(arguments);

        for (var i = 0, ii = keys.length; i < ii; i++) {
            o.keyColumns[keys[i]] = true;
        }

        for (var i = 0, ii = o.columns.length; i < ii; i++) {
            if (o.keyColumns[o.columns[i].name] != null) {
                o.keyColumns[o.columns[i].name] = false;
            }
        }

        o.ds.setKeys.apply(o.ds, keys);
    }

    function setOption()
    {
        any.copyArguments(o.options, arguments);
    }

    function setRowspan(arg1, arg2, arg3)
    {
        if (arguments.length >= 2 && typeof(arguments[0]) === "string" && typeof(arguments[1]) === "string") {
            o.rowspan = { startColumnName: arg1, endColumnName: arg2, restrict: arg3 };
        } else {
            o.rowspan = { columns: arg1, restrict: arg2 };
        }
    }

    function applyRowspan()
    {
        if (o.rowspan == null) {
            return;
        }

        if (o.rowspan.columns == null) {
            o.rowspan.columns = [];
            for (var i = 0, ii = o.columns.length; i < ii; i++) {
                if (o.columns[i].name == o.rowspan.startColumnName || o.rowspan.columns.length > 0) {
                    o.rowspan.columns.push(o.columns[i].name);
                    if (o.rowspan.columns.length > 0 && o.columns[i].name == o.rowspan.endColumnName) {
                        break;
                    }
                }
            }
        }

        var $rows = o.$dataTbody.children('tr');

        for (var c = 0, cc = o.rowspan.columns.length; c < cc; c++) {
            var spanrow = 0;
            var spannum = 1;
            var tdquery = 'td[name="td_'+ o.rowspan.columns[c] + '"]';
            var firstRow = true;

            for (var r = 0, rr = $rows.length; r < rr; r++) {
                var $td = $rows.eq(r).children(tdquery);
                var $prevTd;

                if (c > 0 && o.rowspan.restrict == true) {
                    $prevTd = $td.prev();
                }

                if ($prevTd != null && $prevTd.attr("rowspan") == 1) {
                    $td.attr("rowspan", 1);
                } else {
                    if (firstRow != true && $td.text() == $rows.eq(spanrow).children(tdquery).text() && ($prevTd == null || $prevTd.attr("rowspan") == null)) {
                        $td.hide();
                        spannum++;
                    } else {
                        $rows.eq(spanrow).children(tdquery).attr("rowspan", spannum);
                        spanrow = r;
                        spannum = 1;
                    }
                }

                firstRow = false;
            }

            $rows.eq(spanrow).children(tdquery).attr("rowspan", spannum);
        }
    }

    function setTotal(label, columns)
    {
        o.totalInfo = { label: label, columns: columns };
    }

    function getTotalValue(colName)
    {
        if (o.$tfoot == null) {
            return 0;
        }

        var $ctrl = o.$tfoot.find('[totalColumn="' + colName + '"]').children();

        if ($ctrl.length == 0) {
            return 0;
        }

        return $ctrl.val() || 0;
    }

    function setAddButton(func)
    {
        o.$addButton[0].onclick = function()
        {
            func.apply(control);
        };

        return o.$addButton;
    }

    function setDelButton(func)
    {
        o.$delButton[0].onclick = function()
        {
            func.apply(control);
        };

        return o.$delButton;
    }

    function addButton(text, func)
    {
        var $btn = jQuery('<button>').addClass("space").attr({ "size": "small" }).text(text).control("any-button").appendTo(o.$buttons);

        if (o.$buttons.hasClass("any-dsgrid-buttons") == true) {
            o.$buttons.css("margin-left", "-" + $btn.css("margin-left"));
        }

        $btn[0].onclick = function()
        {
            func.apply(control);
        };

        return $btn;
    }

    function addAction(colName, action, check)
    {
        o.actions[colName] = { action: action, check: check };
    }

    function addControlEvent(colName, eventName, eventHandler)
    {
        if (o.events[colName] == null) {
            o.events[colName] = [];
        }

        o.events[colName].push({ name: eventName, handler: eventHandler });
    }

    function addControlInitializer(colName, eventHandler)
    {
        addControlEvent(colName, "any-initialize", eventHandler);
    }

    function addRow(data)
    {
        if (o.keyColumns != null && data != null) {
            var obj = {};
            for (var name in o.keyColumns) {
                obj[name] = data[name];
            }
            var idx = o.ds.valueRow(obj);
            if (idx != -1) {
                if (o.ds.jobType(idx) == "D") {
                    resetDisplay(idx, restoreRow(idx));
                    return idx;
                }
                return "exists";
            }
        }

        var row = o.ds.addRow(data);

        resetDisplay(row, addTBodyRow(data, row));

        o.$control.fire("onAddRow", [row]);
        o.$control.fire("onChangeRow", [row]);

        return row;
    }

    function clearData()
    {
        o.$dataTbody.empty();

        o.ds.init();

        resetCalculation();
        resetDisplay();
    }

    function getCheckedData(columnNames)
    {
        var ds = any.ds("ds_" + control.id + "_checked");

        ds.init();

        o.$dataTbody.children('tr').children('td[name="col_check"]').each(function() {
            var $this = jQuery(this);
            var $check = $this.children('input:checkbox:enabled:visible');
            if ($check.prop("checked") == true) {
                var row = ds.addRow();
                var rowData = o.ds.rowData($this.parent().index());
                if (columnNames == null) {
                    ds.rowData(row, rowData);
                } else {
                    for (var i = 0, ii = columnNames.length; i < ii; i++) {
                        ds.value(row, columnNames[i], rowData[columnNames[i]]);
                    }
                }
            }
        });

        return ds;
    }

    function deleteAll()
    {
        o.$dataTbody.children('tr').each(function() {
            deleteRow(jQuery(this).index(), true);
        });

        resetCalculation();
        resetDisplay();
    }

    function deleteCheckedRow()
    {
        var data = [];
        var checkedRowCount = 0;

        o.$dataTbody.children('tr').children('td[name="col_check"]').each(function() {
            var $this = jQuery(this);
            var $check = $this.children('input:checkbox:enabled:visible');
            if ($check.prop("checked") == true) {
                $check.prop("checked", false);
                var row = $this.parent().index();
                data.push(o.ds.rowData(row));
                deleteRow(row, true);
                checkedRowCount++;
            }
        });

        o.$headCheck.prop("checked", false);

        resetCalculation();
        resetDisplay();

        o.$control.fire("onDeleteRow", [data]);
        o.$control.fire("onChangeRow");

        if (checkedRowCount == 0) {
            if (getRowCount(true) > 0) {
                if (o.config("message.rowDelete.noSelectedRow") != null) {
                    alert(o.config("message.rowDelete.noSelectedRow"));
                }
            } else {
                if (o.config("message.rowDelete.noDeleteData") != null) {
                    alert(o.config("message.rowDelete.noDeleteData"));
                }
            }
        }
    }

    function deleteRow(row, forMulti)
    {
        var rowData = o.ds.rowData(row);
        var data = [rowData];

        if (o.options.checkDeleteRowBefore != null && typeof(o.options.checkDeleteRowBefore) === "function") {
            if (o.options.checkDeleteRowBefore.apply(o.control, [row, rowData]) !== true) {
                return;
            }
        }

        var $tr = o.$dataTbody.children('tr').eq(row);

        if (o.ds.deleteRow(row) == true) {
            $tr.remove();
        } else {
            $tr.data("delete", 1).hide().find('[require-enable]').removeAttr("require-enable");
        }

        if (forMulti == true) {
            return;
        }

        resetCalculation();
        resetDisplay();

        o.$control.fire("onDeleteRow", [data]);
        o.$control.fire("onChangeRow");
    }

    function restoreRow(row)
    {
        var $tr = o.$dataTbody.children('tr').eq(row);

        o.ds.restoreRow(row);

        $tr.show();

        return $tr;
    }

    function getDataCell(row, colName)
    {
        return o.$dataTbody.children('tr').eq(row).children('td[name="td_' + colName + '"]');
    }

    function getControl(row, colName)
    {
        var $controls = getDataCell(row, colName).children();

        if ($controls.length == 0) {
            return null;
        }

        return $controls.get(0);
    }

    function setControl(row, colName, controlInfo, rowData)
    {
        var colInfo = {};

        any.object.copyFrom(colInfo, getColumn(colName));
        any.object.copyFrom(colInfo, controlInfo);

        return createControl(getDataCell(row, colName).empty(), colInfo, rowData);
    }

    function getJobType(row)
    {
        return o.ds.jobType(row);
    }

    function getRowIndex(rowVar)
    {
        if (typeof(rowVar) === "number") {
            return rowVar;
        }

        var $tr = o.$dataTbody.children('tr#' + rowVar);

        if ($tr == null || $tr.length == 0) {
            return -1;
        }

        return $tr.index();
    }

    function getRowData(row)
    {
        return o.ds.rowDataWithBind(row);
    }

    function setRowData(row, data)
    {
        o.ds.rowData(row, data);
    }

    function setRowDeletable(func)
    {
        o.rowDeletableFunction = func;
    }

    function setRowEditable(func)
    {
        o.rowEditableFunction = func;
    }

    function setTableDnD(colNames, orderColName)
    {
        o.tableDnD = { colNames: colNames, orderColName: orderColName };
    }

    function setMessageTbodyShowHide(func)
    {
        o.messageTbodyShowHide = func;
    }

    function showHideMessageTbody()
    {
        o.$messageTbody.showHide(o.messageTbodyShowHide());
    }

    function getValue(rowVar, colName)
    {
        var row = getRowIndex(rowVar);

        if (row == -1) {
            return null;
        }

        var ctrl = getControl(row, colName);

        if (ctrl == null) {
            return o.ds.value(row, colName);
        }

        return jQuery(ctrl).val();
    }

    function setValue(rowVar, colName, value)
    {
        var row = getRowIndex(rowVar);

        if (row == -1) {
            return;
        }

        o.ds.value(row, colName, value);
    }

    function initialize()
    {
        var $headTr = jQuery('<tr>').appendTo(o.$thead);
        var $footTr = null;

        if (o.totalInfo != null && o.totalInfo.columns != null && o.totalInfo.columns.length > 0) {
            o.$tfoot = jQuery('<tfoot>').appendTo(o.$table);
            $footTr = jQuery('<tr>').appendTo(o.$tfoot);
        }

        function addRowNum()
        {
            if (o.options.rownumbers == true) {
                jQuery('<col>').attr({ "width": o.options.rownumWidth }).appendTo(o.$colgroup);
                jQuery('<th>').addClass("ui-widget-header").appendTo($headTr).text("No");
                if ($footTr != null) {
                    jQuery('<th>').addClass("ui-widget-header").appendTo($footTr).prop("innerText", o.totalInfo.label);
                }
            }
        }

        function addRowCheck()
        {
            if (o.rowCheckVisible == true) {
                jQuery('<col>').attr({ "name": "col_check", "width": "30px" }).appendTo(o.$colgroup);
                jQuery('<th>').attr({ "name": "col_check" }).addClass("ui-widget-header").appendTo($headTr);
                if ($footTr != null) {
                    jQuery('<th>').addClass("ui-widget-header").appendTo($footTr).prop("innerText", o.totalInfo.label);
                }
                o.$headCheck = jQuery('<input>').attr({ "type": "checkbox" }).appendTo($headTr.children('th:last')).click(function() {
                    o.$dataTbody.children('tr').children('td[name="col_check"]').children('input:checkbox:enabled:visible').prop("checked", this.checked);
                });
            }
        }

        if (o.config("column.rowNumCheckReverse") != true) {
            addRowNum();
            addRowCheck();
        } else {
            addRowCheck();
            addRowNum();
        }

        for (var i = 0, ii = o.columns.length; i < ii; i++) {
            var colInfo = o.columns[i];

            if (colInfo.hidden != true || !(jQuery.browser.msie && Number(jQuery.browser.version) < 8)) {
                var $col = jQuery('<col>').attr({ "id": "col_" + colInfo.name, "width": colInfo.width }).appendTo(o.$colgroup);

                if (colInfo.width == "*") {
                    $col.css({ "width": "100%" });
                }
            }

            var $th = jQuery('<th>').attr({ "id": "th_" + colInfo.name }).data({ "colInfo": colInfo }).addClass("ui-widget-header").html('<div style="display:inline;">' + colInfo.label + '</div>').appendTo($headTr);

            $th.attr("title", $th.text());

            if (colInfo.nowrap == "both" || colInfo.nowrap == "head") {
                setEllipsis($th);
            }

            if (o.edit == true && colInfo.require == true) {
                $th.prepend(jQuery('<span>').addClass("require").text("*"));
            }

            if ($footTr == null) {
                continue;
            }

            if (jQuery.inArray(colInfo.name, o.totalInfo.columns) != -1) {
                var $control = jQuery('<div>').attr({ "readOnly": true }).control("any-number");
                jQuery('<td>').attr({ "id": "tf_" + colInfo.name, "totalColumn": colInfo.name }).appendTo($footTr).append($control);
                if (colInfo.controlattr != null) {
                    if (colInfo.controlattr.thousandsSeparator != null) {
                        $control.prop("thousandsSeparator", colInfo.controlattr.thousandsSeparator);
                    }
                    if (colInfo.controlattr.digits != null) {
                        $control.prop("digits", colInfo.controlattr.digits);
                    }
                }
            } else if ($footTr.children('td[totalColumn]').length == 0) {
                jQuery('<th>').addClass("ui-widget-header").appendTo($footTr).prop("innerText", o.totalInfo.label);
            } else {
                jQuery('<td>').attr({ "id": "tf_" + colInfo.name }).css({ "text-align": "center" }).text("-").appendTo($footTr);
            }
        }

        if (o.groupHeaders != null) {
            var $groupHeadTr = jQuery('<tr>').prependTo(o.$thead);
            var $headThs = $headTr.children('th');
            for (var i = 0, ii = $headThs.length; i < ii; i++) {
                var $th = jQuery('<th>').addClass($headThs.eq(i).attr("class")).appendTo($groupHeadTr);
                if ($headThs.eq(i).attr("name") == "col_check") {
                    $th.append($headThs.eq(i).children('input:checkbox'));
                } else {
                    $th.html($headThs.eq(i).html());
                    var colInfo = $headThs.eq(i).data("colInfo");
                    if (colInfo != null) {
                        $th.attr("title", $th.text());
                    }
                }
            }
            var $groupHeadThs = $groupHeadTr.children('th');
            for (var i = 0, ii = o.groupHeaders.length; i < ii; i++) {
                var gh = o.groupHeaders[i];
                var start = $headTr.children('th#th_' + gh.start).index();
                var end = $headTr.children('th#th_' + gh.end).index();
                for (var j = start; j <= end; j++) {
                    $groupHeadThs.eq(j).attr("grouping-column", "true").html('<div style="display:inline;">' + gh.label + '</div>').attr("colspan", j == start ? end - start + 1 : 1).showHide(j == start);
                    $groupHeadThs.eq(j).attr("title", $groupHeadThs.eq(j).text());
                }
            }
            for (var i = $groupHeadThs.length - 1; i >= 0; i--) {
                if ($groupHeadThs.eq(i).attr("grouping-column") == "true") {
                    continue;
                }
                $groupHeadThs.eq(i).attr("rowspan", 2);
                $headThs.eq(i).remove();
            }
        }

        resetDisplay();
    }

    function addTBodyRow(data, dsIndex)
    {
        o.rowId++;

        var row = o.$dataTbody.children('tr').length;
        var $tr = jQuery('<tr>').attr({ "id": o.rowId }).appendTo(o.$dataTbody);

        if (o.tableDnD != null) {
            $tr.data("tableDnD", true);
        }

        if (o.ds.rowCount() <= row) {
            dsIndex = o.ds.addRow(data);
        }

        $tr.data("ds-index", dsIndex);

        function addRowNum()
        {
            if (o.options.rownumbers == true) {
                var $th = jQuery('<th>').attr({ "name": "=ROW-NUM=" }).addClass("ui-widget-header").appendTo($tr).text(function() {
                    return row + 1;
                }());
                if (o.tableDnD != null && jQuery.inArray(true, o.tableDnD.colNames) != -1) {
                    $th.data("tableDnD", true);
                }
            }
        }

        function addRowCheck()
        {
            if (o.rowCheckVisible == true) {
                jQuery('<td>').attr({ "name": "col_check", "align": "center" }).appendTo($tr).html('<input type="checkbox">');
            }
        }

        if (o.config("column.rowNumCheckReverse") != true) {
            addRowNum();
            addRowCheck();
        } else {
            addRowCheck();
            addRowNum();
        }

        for (var i = 0, ii = o.columns.length; i < ii; i++) {
            var colInfo = o.columns[i];
            var $td = jQuery('<td>').attr({ "name": "td_" + colInfo.name, "align": colInfo.align }).data({ "colInfo": colInfo }).appendTo($tr);
            createControl($td, colInfo, data);
            $td.keydown(function(event) {
                var $this = jQuery(this);
                if (event.keyCode == 38) {
                    $this.parent().prev().children('td[name="' + $this.attr("name") + '"]').children().focus();
                } else if (event.keyCode == 40) {
                    $this.parent().next().children('td[name="' + $this.attr("name") + '"]').children().focus();
                }
            });
            if (o.tableDnD != null && jQuery.inArray(colInfo.name, o.tableDnD.colNames) != -1) {
                $td.data("tableDnD", true);
            }
        }

        for (var i = 0, ii = o.columns.length; i < ii; i++) {
            var colInfo = o.columns[i];
            if (colInfo.calculate == null) {
                continue;
            }
            var $td = $tr.children('td[name="td_' + colInfo.name + '"]');
            var colInfo = $td.data("colInfo");
            var colNames = colInfo.calculate.split("+");
            for (var j = 0, jj = colNames.length; j < jj; j++) {
                var colName = any.text.trim(colNames[j]);
                $td.parent().children('td[name="td_' + colName + '"]').children().on("onChange", function() {
                    doCalculation(jQuery(this).parent().parent());
                }).keyup(function() {
                    doCalculation(jQuery(this).parent().parent());
                });
            }
        }

        for (var name in o.keyColumns) {
            if (o.keyColumns[name] == true) {
                $tr.prepend(jQuery('<input>').attr({ "type": "hidden", "name": control.id + "_" + name, "bind": o.ds.id + ":" + name, "value": data == null ? null : data[name] }));
            }
        }

        if (o.totalInfo == null || o.totalInfo.columns == null) {
            return $tr;
        }

        for (var i = 0, ii = o.totalInfo.columns.length; i < ii; i++) {
            $tr.children('td[name="td_' + o.totalInfo.columns[i] + '"]').children().on("onChange", function() {
                resetTotal(jQuery(this).parent().data("colInfo"));
            }).keyup(function() {
                resetTotal(jQuery(this).parent().data("colInfo"));
            });
        }

        resetCalculation();

        return $tr;
    }

    function createControl($td, colInfo, rowData)
    {
        var attr = { "name": control.id + "_" + colInfo.name, "bind": o.ds.id + ":" + colInfo.name };

        attr.id = attr.name + "_" + (o.rowId - 1);

        var row = $td.parent().index();

        if (String(colInfo.control).toLowerCase() == "radio") {
            return addEvent(jQuery('<input>').attr({ "type": "radio", "checked": (rowData != null && rowData[colInfo.name] == o.checkValue) }).attr(attr).appendTo($td)
                .defineProperty("value", {
                    get: function() {
                        return this.checked == true ? o.checkValue : o.uncheckValue;
                    }
                }));
        }

        if (String(colInfo.control).toLowerCase() == "check") {
            return addEvent(jQuery('<input>').attr({ "type": "checkbox", "checked": (rowData != null && rowData[colInfo.name] == o.checkValue) }).attr(attr).appendTo($td)
                .defineProperty("value", {
                    get: function() {
                        return this.checked == true ? o.checkValue : o.uncheckValue;
                    }
                }));
        }

        if (colInfo.style != null) {
            $td.css(any.object.parse({}, colInfo.style, ";", ":"));
        }

        var $control;

        if (colInfo.control == null && o.actions[colInfo.name] != null && (o.actions[colInfo.name].check == null || o.actions[colInfo.name].check.apply(control, [rowData, $td.parent().attr("id"), colInfo.name]) == true)) {
            $control = jQuery('<span>').addClass("link").click(function() {
                var $tr = jQuery(this).parents('tr').eq(0);
                o.actions[colInfo.name].action.apply(control, [getRowData($tr.index()), $tr.attr("id"), colInfo.name]);
            });
        } else {
            $control = jQuery('<' + (colInfo.controltag == null ? 'div' : colInfo.controltag) + '>');
        }

        $control.attr(attr).data({ "grid": control, "grid-row-id": String(o.rowId), "grid-column": colInfo });

        if (colInfo.controlattr != null) {
            for (var name in colInfo.controlattr) {
                if (o.codeDataDisable != true) {
                    $control.attr(name, colInfo.controlattr[name]);
                    continue;
                }

                if (name.toLowerCase() == "depend") {
                    continue;
                }

                if (name.toLowerCase() != "codedata" || rowData == null) {
                    $control.attr(name, colInfo.controlattr[name]);
                    continue;
                }

                var codeData = colInfo.controlattr[name];

                for (var key in rowData) {
                    codeData = any.text.replaceAll(codeData, "{#" + key + "}", rowData[key]);
                }

                if (colInfo.controlattr.depend != null) {
                    var depends = colInfo.controlattr.depend.split(",");
                    for (var i = 0, ii = depends.length; i < ii; i++) {
                        codeData += ("," + rowData[any.text.trim(depends[i])]);
                    }
                }

                $control.attr("dsgridCodeData_" + control.id + "_" + o.controlIndex, codeData);
            }
        }

        if ((o.edit != true || colInfo.edit != true) && colInfo.editForced != true) {
            $control.attr("readOnly", true);
            if (colInfo.nowrap == "both" || colInfo.nowrap == "data") {
                setEllipsis($control);
            }
        }

        addEvent($control);

        if (rowData != null) {
            rowData[$control.get(0).id] = rowData[colInfo.name];
        }

        $control.appendTo($td).control(colInfo.control, function(event, controlName) {
            if (controlName != null && controlName != colInfo.control) {
                return;
            }
            if (colInfo.align != null && colInfo.align != "left" && $control.element() != null && $control.element().tag() != "SELECT") {
                $control.element().css("text-align", colInfo.align);
            }
            if (rowData != null) {
                $control.val($control.get(0).isObjectValueSet == true ? rowData : rowData[colInfo.name]);
            }
            if (colInfo.controlinit != null) {
                colInfo.controlinit.apply($control.get(0), [row]);
            }
            if (((o.edit == true && colInfo.edit == true) || colInfo.editForced == true) && o.keyColumns != null && colInfo.name in o.keyColumns) {
                if (colInfo.control == "any-text") {
                    $control.element().on("blur", function() {
                        var $this = jQuery(this).parent();
                        if (checkKeyValues($this.parent().parent()) != true) {
                            $this.val("");
                        }
                    });
                }
                if (colInfo.control == "any-select" || colInfo.control == "any-search") {
                    $control.on("onChange", function() {
                        var $this = jQuery(this);
                        if (checkKeyValues($this.parent().parent()) != true) {
                            $this.val("");
                        }
                    });
                }
            }
        });

        if ($control.controlName() == null) {
            $control.defineProperty("value", {
                get: function() {
                    if (colInfo.formatter != null && typeof(colInfo.formatter) === "function" && colInfo.hiddenValue === true) {
                        return jQuery(this).children('input:hidden[name="' + colInfo.name + '.value"]').val();
                    }
                    return jQuery(this).prop("innerText");
                },
                set: function(val) {
                    if (colInfo.formatter != null && typeof(colInfo.formatter) === "function") {
                        jQuery(this).html(colInfo.formatter(rowData, row, colInfo.name)).controls();
                        $td.attr("title", jQuery(this).prop("innerText"));
                        if (colInfo.hiddenValue === true) {
                            jQuery('<input>').attr({ type: "hidden", name: colInfo.name + ".value" }).appendTo(this).val(val);
                        }
                    } else {
                        jQuery(this).prop("innerText", val).attr("title", val);
                        $td.attr("title", val);
                    }
                }
            });
            if (rowData != null) {
                $control.val(rowData[colInfo.name]);
            }
        }

        if (o.edit == true && colInfo.require == true) {
            $control.attr("require-enable", true).data("require-name", colInfo.label);
        }

        $control.on("onChange", function() {
            o.$control.fire("onChange", { control: this, row: row, colName: colInfo.name, colInfo: colInfo });
        });

        return $control;

        function addEvent($control)
        {
            var events = o.events[colInfo.name];

            if (events != null) {
                for (var i = 0, ii = events.length; i < ii; i++) {
                    $control.on(events[i].name, { handler: events[i].handler }, function(event) {
                        event.data.handler.apply(this, [event, event.data.row = row]);
                    });
                }
            }

            return $control;
        }
    }

    function setEllipsis($elem)
    {
        $elem.css({ "white-space": "nowrap", "overflow": "hidden", "text-overflow": "ellipsis", "-o-text-overflow": "ellipsis" });
    }

    function checkKeyValues($tr)
    {
        var result = true;
        var values = {};

        for (var name in o.keyColumns) {
            values[name] = $tr.children('td[name="td_' + name + '"]').children().val();
            if (values[name] == "") {
                return true;
            }
        }

        o.$dataTbody.children('tr').each(function() {
            var $this = jQuery(this);
            if ($this[0] == $tr[0] || !$this.is(':visible')) {
                return true;
            }
            for (var name in o.keyColumns) {
                if ($this.children('td[name="td_' + name + '"]').children().val() != values[name]) {
                    return true;
                }
            }
            result = false;
            return false;
        });

        return result;
    }

    function getEdit()
    {
        return o.edit;
    }

    function getDisabled()
    {
        return o.disabled;
    }

    function setDisabled(val)
    {
        o.disabled = (String(val).toLowerCase() == "disabled" || any.object.toBoolean(val, true));

        o.ds.disabled = o.disabled;

        if (o.disabled != true && o.$disabledDiv == null) {
            return;
        }

        if (o.$disabledDiv == null) {
            o.$disabledDiv = jQuery('<div>').css({ "position": "absolute", "left": "0px", "top": "0px", "width": "100%", "height": "100%", "display": "none" });
            o.$disabledDiv.css({ "background-color": "#dddddd", "opacity": "0.6" });
            o.$disabledDiv.appendTo(control);
        }

        o.$control.css({ "position": "relative" });

        o.$disabledDiv.showHide(o.disabled);
    }

    function getRowCount(visible)
    {
        if (o.disabled == true) {
            return -1;
        }

        if (visible == true) {
            return o.$dataTbody.children('tr:visible').length;
        }

        return o.$dataTbody.children('tr').length;
    }

    function getJsonObject()
    {
        if (o.disabled == true) {
            return null;
        }

        return o.ds.toJSON();
    }

    function setJsonObject(val)
    {
        if (o.disabled == true) {
            return;
        }

        if (o.$control.data("grid") == null) {
            o.ds.loadData(val, true);
        } else {
            window.setTimeout(function() {
                o.ds.loadData(val, true);
            });
        }
    }

    function getJsonString()
    {
        if (o.disabled == true) {
            return null;
        }

        return o.ds.jsonString();
    }

    function setJsonString(val)
    {
        if (o.disabled == true) {
            return;
        }

        if (o.$control.data("grid") == null) {
            o.ds.load(val);
        } else {
            window.setTimeout(function() {
                o.ds.load(val);
            });
        }
    }

    function getCheckRequire()
    {
        return getRowCount(true) > 0;
    }

    function isCodeDataDisable()
    {
        return o.codeDataDisable == true;
    }

    function isDataLoading()
    {
        return o.dataLoading == true;
    }

    function doCalculation($tr)
    {
        $tr.children('td').each(function() {
            var $td = jQuery(this);
            var colInfo = $td.data("colInfo");

            if (colInfo == null || colInfo.calculate == null) {
                return true;
            }

            var colNames = colInfo.calculate.split("+");
            var maxDigits = 0;

            for (var i = 0, ii = colNames.length; i < ii; i++) {
                var digits = getColumnDigits(getColumn(colNames[i]), 0);
                if (digits > maxDigits) {
                    maxDigits = digits;
                }
            }

            var pow = Math.pow(10, maxDigits);
            var value = 0;

            for (var i = 0, ii = colNames.length; i < ii; i++) {
                value += Number($tr.children('td[name="td_' + any.text.trim(colNames[i]) + '"]').children().val()) * pow;
            }

            $td.children().val(String((value / pow).toFixed(getColumnDigits(colInfo, 0))));

            resetTotal(colInfo);
        });
    }

    function resetTotal(colInfo)
    {
        if (colInfo == null) {
            return;
        }

        var digits = getColumnDigits(colInfo, 0);
        var pow = Math.pow(10, digits);
        var total = 0;

        o.$dataTbody.find('td[name="td_' + colInfo.name + '"]').each(function() {
            var $this = jQuery(this);
            if ($this.parent().data("delete") != 1) {
                total += Number($this.children().val()) * pow;
            }
        });

        o.$tfoot.find('td#tf_' + colInfo.name).children().val(String((total / pow).toFixed(digits)));

        o.$control.fire("onResetTotal", [colInfo]);
    }

    function getColumnDigits(colInfo, defaultValue)
    {
        if (colInfo == null) {
            return defaultValue;
        }
        if (colInfo.controlattr == null) {
            return defaultValue;
        }
        if (colInfo.controlattr.digits == null) {
            return defaultValue;
        }

        return colInfo.controlattr.digits;
    }

    function resetCalculation()
    {
        o.$dataTbody.children('tr').each(function() {
            doCalculation(jQuery(this));
        });

        if (o.totalInfo == null) {
            return;
        }

        for (var i = 0, ii = o.totalInfo.columns.length; i < ii; i++) {
            resetTotal(getColumn(o.totalInfo.columns[i]));
        }
    }

    function resetCodeData()
    {
        var columns = [];

        for (var i = 0, ii = o.columns.length; i < ii; i++) {
            var colInfo = o.columns[i];

            if (colInfo.controlattr == null) {
                continue;
            }

            if (colInfo.controlattr.depend != null || colInfo.controlattr.codeData != null || colInfo.controlattr.codedata != null) {
                columns.push(colInfo);
            }
        }

        if (columns.length == 0) {
            o.codeDataDisable = null;
            return;
        }

        any.loading(true).show();

        any.ready().check(function() {
            any.codedata("dsgridCodeData_" + control.id + "_" + o.controlIndex).initialize(function() {
                for (var i = 0, ii = columns.length; i < ii; i++) {
                    var colInfo = columns[i];

                    if (colInfo.controlattr.depend == null || colInfo.controlattr.depend == "") {
                        continue;
                    }

                    o.$dataTbody.find('[name="' + control.id + '_' + colInfo.name + '"]').each(function() {
                        this.setDepend(colInfo.controlattr.depend, colInfo.controlattr.codeData);
                    });
                }

                o.codeDataDisable = null;

                any.loading(true).hide();
            });
        });
    }

    function resetRowNumbers(tr)
    {
        if (o.options.rownumbers == true) {
            o.$dataTbody.find('th[name="=ROW-NUM="]:visible').each(function(index) {
                jQuery(this).text(index + 1);
            });
        }

        if (o.tableDnD != null && o.tableDnD.orderColName != null) {
            if (tr != null) {
                var $tr = jQuery(tr);
                o.ds.moveRow($tr.data("ds-index"), $tr.index());
                o.$dataTbody.children('tr').each(function(index) {
                    jQuery(this).data("ds-index", index);
                });
            }

            var orderNo = 1;

            o.$dataTbody.children('tr').each(function(index) {
                if (jQuery(this).is(':visible')) {
                    o.ds.value(index, o.tableDnD.orderColName, orderNo++);
                }
            });
        }
    }

    function resetDisplay(row, $tr)
    {
        o.$control.attr("any--proxy--grid", o.edit == true);

        o.$buttons.showHide(o.buttonVisible);

        var colspans = {};

        if (jQuery.browser.msie && Number(jQuery.browser.version) < 9) {
            var colspanName = null;
            for (var i = 0, ii = o.columns.length; i < ii; i++) {
                if (o.columns[i].hidden != true) {
                    colspanName = o.columns[i].name;
                    colspans[colspanName] = 1;
                } else if (colspanName != null) {
                    colspans[colspanName]++;
                }
            }
        }

        if (o.edit == true) {
            ($tr == null ? o.$dataTbody.children('tr') : $tr).each(function() {
                var $this = jQuery(this);
                var rowData = o.ds.rowData(row == null ? $this.index() : row);
                var rowId = $this.attr("id");
                var rowEditable = (o.rowEditableFunction == null || o.rowEditableFunction.apply(control, [rowData, rowId]) == true);
                var $checkTd = $this.children('td[name="col_check"]');

                $this.data({ "rowEditable": rowEditable });

                if ($checkTd.length == 0) {
                    return;
                }

                var rowDeletable = (o.rowDeletableFunction == null || o.rowDeletableFunction.apply(control, [rowData, rowId]) == true);
                var showHide = (rowDeletable && rowEditable);

                $checkTd.children('input:checkbox').prop("disabled", !showHide).showHide(showHide);
                $this.data({ "rowDeletable": rowDeletable });
            });
        }

        for (var i = 0, ii = o.columns.length; i < ii; i++) {
            var colInfo = o.columns[i];
            var $column = getColumnCells(colInfo.name);
            $column.showHide(colInfo.hidden != true);
            if (colspans[colInfo.name] != null && colspans[colInfo.name] > 1) {
                $column.attr("colspan", colspans[colInfo.name]);
            }
            ($tr == null ? o.$dataTbody.find('td[name="td_' + colInfo.name + '"]') : $tr.children('td[name="td_' + colInfo.name + '"]')).each(function() {
                var $this = jQuery(this);
                var $ctrl = $this.children();
                if ($ctrl.length == 0) {
                    return true;
                }
                var readOnly = ((o.edit != true || colInfo.edit != true || $this.parent().data("rowEditable") != true || $ctrl.prop("readOnly") == true) && colInfo.editForced != true);
                if ($ctrl[0].type == "radio" || $ctrl[0].type == "checkbox") {
                    $ctrl.prop("disabled", readOnly && $ctrl[0].checked != true);
                } else {
                    $ctrl.prop("readOnly", readOnly);
                }
                if (readOnly && $ctrl[0].type == "checkbox" && $ctrl[0].checked == true) {
                    $ctrl.click(function() {
                        this.checked = true;
                    });
                }
            });
        }

        var messageTbodyEmpty = (o.$messageTbody.children().length == 0);

        if (messageTbodyEmpty == true) {
            jQuery('<tr>').appendTo(o.$messageTbody).append(jQuery('<td>').css({ "text-align": "center", "color": "gray" }).text("(No data)"));
        }

        o.$messageTbody.find('td').attr("colspan", function() {
            var colspan = 0;
            o.$thead.children('tr:first').children('th').each(function() {
                if (jQuery(this).css("display") == "none") {
                    return true;
                }
                var cols = parseInt(jQuery(this).attr("colspan"), 10);
                colspan += (isNaN(cols) ? 1 : cols);
            });
            return Math.max(colspan, 1);
        }());

        if (messageTbodyEmpty != true) {
            showHideMessageTbody();
        }

        resetRowNumbers();

        if (o.$tfoot != null) {
            var $firstTh;
            var theadThCount = 0;
            var tfootTdCount = 0;

            o.$tfoot.find('th').each(function() {
                var $this = $(this);

                if ($firstTh == null && $this.css("display") != "none") {
                    $firstTh = $this;
                } else if ($firstTh != null) {
                    $this.hide();
                }
            });

            o.$thead.find('th:not([grouping-column="true"])').each(function() {
                var $this = $(this);

                if ($this.css("display") != "none") {
                    theadThCount++;
                }
            });

            o.$tfoot.find('td').each(function() {
                var $this = $(this);

                if ($this.css("display") != "none") {
                    tfootTdCount++;
                }
            });

            $firstTh.attr("colspan", theadThCount - tfootTdCount);
        }

        applyRowspan();

        if (o.tableDnD != null) {
            any.loadScript(any.home + "/controls/any-dsgrid/any-dsgrid.tablednd.js", function() {
                o.$table.dsgridDnD({
                    onDrop: function(table, tr) {
                        resetRowNumbers(tr);
                        o.$control.fire("onTableDnD", [table, tr]);
                    }
                });
            });
        }
    }
});
