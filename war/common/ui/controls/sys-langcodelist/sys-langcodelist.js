any.control("sys-langcodelist").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);
        o.controlIndex = any.control().newIndex();

        control.isReady = false;

        o.textControlName = "txt_langValue_" + control.id + "_" + o.controlIndex;

        o.columnName = any.text(o.$control.attr("columnName")).empty("MSG_CONTENTS");
        o.rows = Number(any.text(o.$control.attr("rows")).empty(-1));
        o.maxByte = Number(any.text(o.$control.attr("maxByte")).empty(500));

        initDataset();

        o.$control.defineMethod("focus", focus);

        o.$control.defineProperty("ds", { get:getDs });

        any.control(control).initialize();

        any.codedata().get("{LANG_CODE}", function(codeData) {
            if (o.$control.tag() == "TBODY") {
                createControlsTbody(codeData.data);
            } else if (o.$control.tag() == "TD") {
                createControlsTd(codeData.data);
            }
            control.isReady = true;
        });
    })();

    function getDs()
    {
        return o.ds;
    }

    function initDataset()
    {
        if (o.$control.hasAttr("ds")) {
            o.ds = any.ds(o.$control.attr("ds"));
        } else if (control.id.indexOf("_") != -1) {
            o.ds = any.ds("ds_" + control.id.substr(control.id.indexOf("_") + 1));
        } else {
            o.ds = any.ds(control.id);
        }

        o.ds.setKeys("LANG_CODE");
    }

    function createControlsTbody(codeDataList)
    {
        for (var i = 0; i < codeDataList.length; i++) {
            var data = codeDataList[i].data;

            var $tr = $('<tr>').appendTo(o.$control);

            $('<th>').addClass("ui-widget-header").text(data.NAME + " : " + data.CODE).appendTo($tr);

            var $td = $('<td>').appendTo($tr);

            createControl(data, $td);
        }
    }

    function createControlsTd(codeDataList)
    {
        var $tbody = $('<tbody>').appendTo($('<table>').addClass("layout auto").appendTo(o.$control));

        for (var i = 0; i < codeDataList.length; i++) {
            var data = codeDataList[i].data;

            var $tr = $('<tr>').appendTo($tbody);

            $('<td>').css({ "width":"1px", "white-space":"nowrap", "cursor":"default", "padding-right":"4px" }).text(data.CODE + " :").attr("title", data.NAME).appendTo($tr);

            var $td = $('<td>').appendTo($tr);

            if (i > 0) {
                $td.css("padding-top", "2px");
            }

            createControl(data, $td);
        }
    }

    function createControl(data, $td)
    {
        $td.attr({ "bind":o.ds.id + ":LANG_CODE:langCode" }).prop({ "langCode":data.CODE });

        var $ctrl = $('<div>').attr({ "name":o.textControlName, "bind":o.ds.id + ":" + o.columnName }).appendTo($td).control(o.rows != -1 ? "any-textarea" : "any-text");

        if (o.rows != -1) {
            $ctrl.prop("rows", o.rows);
        }

        if (o.maxByte != -1) {
            $ctrl.prop("maxByte", o.maxByte);
        }

        if (data.CODE == any.meta.defaultLangCode) {
            $ctrl.require();
        }
    }

    function focus()
    {
        $('[name="' + o.textControlName + '"]').eq(0).focus();
    }
});
