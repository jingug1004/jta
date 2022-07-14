(function main()
{
    any.control.util.codedata = {};

    any.control.util.codedata.setDefault = setDefault;
    any.control.util.codedata.clearArea = clearArea;
    any.control.util.codedata.getArea = getArea;
    any.control.util.codedata.setSpace = setSpace;
    any.control.util.codedata.getFilterValues = getFilterValues;
    any.control.util.codedata.getFiltered = getFiltered;
    any.control.util.codedata.setObject = setObject;
    any.control.util.codedata.setDepend = setDepend;

    function setDefault(o, attrName)
    {
        if (any.codedata.initialized == true) {
            return;
        }
        if (!o.$control.hasAttr(attrName)) {
            return;
        }

        o.codeData = o.$control.attr(attrName);

        o.$control.attr("defaultCodeData", o.codeData);

        if (jQuery.browser.msie && Number(jQuery.browser.version) < 8) {
            o.$control.attr(attrName, null);
        } else {
            o.$control.removeAttr(attrName);
        }
    }

    function clearArea(o)
    {
        if (o.$control.tag() == "DIV") {
            o.$control.find('tbody').empty();
        } else {
            o.$control.children('span').empty();
        }
    }

    function getArea(o)
    {
        if (o.$control.tag() != "DIV") {
            if (o.$codeDataArea == null) {
                o.$codeDataArea = jQuery('<span>').appendTo(o.$control);
            }
            if (o.$codeDataArea.children().length > 0) {
                o.$codeDataArea.append('&nbsp;');
            }
            return o.$codeDataArea;
        }

        if (o.$codeDataArea == null) {
            o.$codeDataArea = jQuery('<table>').attr({ "border": "0", "cellspacing": "0", "cellpadding": "0", "width": "100%" }).append(jQuery('<tbody>')).appendTo(o.$control);
        }

        var $tbody = o.$codeDataArea.children('tbody');
        var $tr = $tbody.children('tr:last-child');
        var $td = null;

        $tr.children('td').not('[role="space"]').each(function() {
            if (jQuery(this).children().length == 0) {
                $td = jQuery(this);
                return false;
            }
        });

        if ($td != null) {
            return $td;
        }

        var cols = parseInt(any.text.blank(any.text.nvl(o.$control.attr("cols"), o.$control.prop("cols")), "-1"), 10);

        if (cols == -1) {
            if ($tbody.children().length == 0) {
                $tr = jQuery('<tr>').appendTo($tbody);
            }
            if ($tr.children('td').length > 0) {
                addSpace();
            }
            $td = jQuery('<td>').css({ "border": "none", "padding": "0px" }).appendTo($tr);
            var $tds = $tr.children('td').not('[role="space"]');
            $tds.css("width", String(100 / $tds.length) + "%");
        } else {
            $tr = jQuery('<tr>').appendTo($tbody);
            for (var i = 0; i < cols; i++) {
                if (i > 0) {
                    addSpace();
                }
                jQuery('<td>').css({ "border": "none", "padding": "0px", "width": String(100 / cols) + "%" }).appendTo($tr);
            }
            $td = $tr.children('td:first-child');
        }

        return $td;

        function addSpace()
        {
            jQuery('<td>').attr("role", "space").css({ "border": "none", "padding-left": any.text.nvl(o.space, "4px") }).appendTo($tr);
        }
    }

    function setSpace(o, $label)
    {
        if (o.space == null) {
            return;
        }

        if (o.$control.tag() == "DIV") {
            o.$control.find('td[role="space"]').css({ "padding-left": o.space });
        } else if ($label == null) {
            o.$control.find('label').not(':first').css({ "margin-left": o.space });
        } else if ($label.prev('label').length > 0) {
            $label.css({ "margin-left": o.space });
        }
    }

    function getFilterValues(values)
    {
        var filterValues;

        if (typeof(values) === "string") {
            filterValues = values.split(",");

            for (var i = 0; i < filterValues.length; i++) {
                filterValues[i] = any.text.trim(filterValues[i]);
            }
        } else {
            filterValues = [];

            for (var i = 0; i < values.length; i++) {
                filterValues.push(any.text.trim(values[i]));
            }
        }

        return filterValues;
    }

    function getFiltered(codeDatas, includeCodes, excludeCodes)
    {
        if (codeDatas == null) {
            return;
        }

        var filteredCodeDatas = [];

        for (var i = 0; i < codeDatas.length; i++) {
            if (includeCodes == null || jQuery.inArray(codeDatas[i].data.CODE, includeCodes) != -1) {
                filteredCodeDatas.push(codeDatas[i]);
            }
        }

        if (excludeCodes != null) {
            for (var i = 0; i < excludeCodes.length; i++) {
                var idx = inCodeData(excludeCodes[i], filteredCodeDatas);

                if (idx != -1) {
                    filteredCodeDatas.splice(idx, 1);
                }
            }
        }

        return filteredCodeDatas;

        function inCodeData(code, codeDatas)
        {
            for (var i = 0; i < codeDatas.length; i++) {
                if (codeDatas[i].data.CODE == code) {
                    return i;
                }
            }

            return -1;
        }
    }

    function setObject(o, codeDatas)
    {
        if (codeDatas == null) {
            return;
        }

        if (o.$control.hasAttr("firstName") == true) {
            o.$control[0].addItem("", any.codedata.getFirstName(any.text.nvl(o.$control.attr("firstName"), o.$control.prop("firstName"))));
        }

        var readOnly = (o.$control.prop("readOnly") || o.$control.prop("readOnly2"));

        for (var i = 0; i < codeDatas.length; i++) {
            if (readOnly != true && codeDatas[i].data.READ_ONLY == "1") {
                continue;
            }
            o.$control[0].addItem(codeDatas[i].data.CODE, any.text.nvl(codeDatas[i].data.NAME, codeDatas[i].data.CODE), codeDatas[i].data);
        }

        if (codeDatas.length > 0) {
            if (o.$control.data("default-value") != null) {
                o.$control.val(o.$control.data("default-value"));
                o.$control.removeData("default-value");
            } else if (o.$control.data("default-index") != null && o.$control.data("default-index") > -1) {
                o.$control.prop("index", o.$control.data("default-index"));
                o.$control.removeData("default-index");
            } else if (o.$control.hasAttr("firstName") != true) {
                o.$control.prop("index", -1);
            }
        }

        o.$control.removeAttr("defaultCodeData");

        o.$control.fire("onChange");
    }

    function setDepend(o, val)
    {
        if (val == null || val == "") {
            return;
        }

        o.depend = {};
        o.depend.codeData = o.codeData;
        o.depend.names = val.split(",");

        var grid = o.$control.data("grid");

        for (var i = 0, ii = o.depend.names.length; i < ii; i++) {
            jQuery('#' + getId(i)).on("onChange", doChange);
        }

        if (grid == null || jQuery(grid).prop("codeDataDisable") != true) {
            doChange();
        }

        function getId(idx)
        {
            var gridRowId = o.$control.data("grid-row-id");
            var name = any.text.trim(o.depend.names[idx]);

            if (grid == null || gridRowId == null) {
                return name;
            }

            return grid.id + "_" + name + "_" + (gridRowId - 1);
        }

        function doChange()
        {
            var params = [];

            for (var i = 0, ii = o.depend.names.length; i < ii; i++) {
                params.push(jQuery('#' + getId(i)).val());
            }

            if (o.depend.codeData == null) {
                o.depend.defaultParams = params.join(",");
                return;
            }

            var codeData = o.depend.codeData + "," + params.join(",");

            if (o.$control.data("current-depended-codeData") != codeData) {
                o.$control.data("current-depended-codeData", codeData);
                o.$control.prop("codeData", codeData);
            }
        }
    }
})();
