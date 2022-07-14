any.control("wf-mgt-name").inherit("any-search", function initialize(control, controlName)
{
    this.setColumn(control.id, "NAME_ID");
    this.setNameExpr("{#NAME_TEXT}");
})
.define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);
        o.controlIndex = any.control().newIndex();

        o.$control.data("any-properties").value2 = o.$control.data("any-properties").value;

        o.$control.defineProperty("value", { get:getValue, set:setValue });

        o.$control.on("onChange", function() {
            o.$editButton.button("option", "disabled", o.$control.prop("disabled") || getValue() == null);
        });

        control.win.url("/sysmgt.workflowmgt.wfnamemgt.WorkflowNameMgtAct/viewSearch");
        control.prx.url("/sysmgt.workflowmgt.wfnamemgt.WorkflowNameMgtAct/retrieveSearchList");

        control.addButton("ui-icon-plus", function() {
            editDetail();
        }, any.message("msg.wf.name.add").toString());

        o.$editButton = control.addButton("ui-icon-gear", function() {
            var nameId = getValue();
            if (nameId != null) {
                editDetail(nameId);
            }
        }, any.message("msg.wf.name.modify").toString());

        o.$editButton.button("option", "disabled", true);

        o.$control.defineProperty("nameDiv", { get:getNameDiv, set:setNameDiv });

        any.control(control).initialize();
    })();

    function editDetail(nameId)
    {
        var win = any.window(true);
        win.url("/sysmgt.workflowmgt.wfnamemgt.WorkflowNameMgtAct/viewDetail");
        win.param("NAME_DIV", o.nameDiv);
        win.param("NAME_ID", nameId);
        win.arg("unloadPage", true);

        win.ok(function(nameId) {
            setValue(nameId);
        });

        win.show();
    }

    function getValue()
    {
        return o.$control.prop("value2");
    }

    function setValue(val)
    {
        if (val != null) {
            if (typeof(val) === "object") {
                o.nameId = val[control.id];
            } else {
                o.nameId = val;
            }
        }

        if (val == null || o.nameId == null) {
            o.$control.prop("value2", {});
            return;
        }

        var prx = any.proxy();
        prx.url("/sysmgt.workflowmgt.wfnamemgt.WorkflowNameMgtAct/retrieveContents");
        prx.param("NAME_ID", o.nameId);

        prx.onSuccess = function()
        {
            o.$control.prop("value2", { "NAME_ID":o.nameId, "NAME_TEXT":this.result });
        };

        prx.onError = function()
        {
            this.error.show();
        };

        prx.execute();
    }

    function getNameDiv()
    {
        return o.nameDiv;
    }

    function setNameDiv(nameDiv)
    {
        o.nameDiv = nameDiv;

        control.setParam("NAME_DIV", o.nameDiv);
    }
});
