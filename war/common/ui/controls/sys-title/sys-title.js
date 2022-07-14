any.control("sys-title").inherit("any-search", function initialize(control, controlName)
{
    this.setColumn(control.id, "TITLE_CODE");
    this.setNameExpr("{#TITLE_CONTENTS}");
})
.define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);
        o.controlIndex = any.control().newIndex();

        o.$control.data("any-properties").value2 = o.$control.data("any-properties").value;

        o.$control.defineProperty("prefix", { get:getPrefix, set:setPrefix });
        o.$control.defineProperty("value", { get:getValue, set:setValue });

        o.$control.on("onChange", function() {
            o.$editButton.button("option", "disabled", o.$control.prop("disabled") || getValue() == null);
        });

        control.win.url("/sysmgt.config.titlemgt.TitleMgtAct/viewSearch");
        control.prx.url("/sysmgt.config.titlemgt.TitleMgtAct/retrieveSearchList");

        control.setParam("TITLE_PREFIX", o.prefix);

        control.addButton("ui-icon-plus", function() {
            editMessage();
        }, any.message("common.btn.add").toString());

        o.$editButton = control.addButton("ui-icon-gear", function() {
            var titleCode = getValue();
            if (titleCode != null) {
                editMessage(titleCode);
            }
        }, any.message("common.btn.modify").toString());

        o.$editButton.button("option", "disabled", true);

        any.control(control).initialize();
    })();

    function editMessage(titleCode)
    {
        var win = any.window(true);
        win.url("/sysmgt.config.titlemgt.TitleMgtAct/viewDetail");
        win.param("TITLE_PREFIX", o.prefix);
        win.param("TITLE_CODE", titleCode);
        win.arg("unloadPage", true);

        win.ok(function(newTitleCode) {
            setValue(titleCode == null ? newTitleCode : titleCode);
        });

        win.show();
    }

    function getPrefix()
    {
        return o.prefix;
    }

    function setPrefix(val)
    {
        o.prefix = val;
    }

    function getValue()
    {
        return o.$control.prop("value2");
    }

    function setValue(val)
    {
        if (val != null) {
            if (typeof(val) === "object") {
                o.titleCode = val[control.id];
            } else {
                o.titleCode = val;
            }
        }

        if (o.$control.attr("textColumn") != null && typeof(val) === "object") {
            if (o.titleCode != null) {
                o.$control.prop("value2", { "TITLE_CODE":o.titleCode, "TITLE_CONTENTS":val[o.$control.attr("textColumn")] });
            }
            return;
        }

        if (val == null || o.titleCode == null) {
            o.$control.prop("value2", {});
            return;
        }

        var prx = any.proxy();
        prx.url("/sysmgt.config.titlemgt.TitleMgtAct/retrieveContents");
        prx.param("TITLE_CODE", o.titleCode);

        prx.onSuccess = function()
        {
            o.$control.prop("value2", { "TITLE_CODE":o.titleCode, "TITLE_CONTENTS":this.result });
        };

        prx.onError = function()
        {
            this.error.show();
        };

        prx.execute();
    }
});
