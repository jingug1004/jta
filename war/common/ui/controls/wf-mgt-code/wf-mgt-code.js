any.control("wf-mgt-code").inherit("any-search", function initialize(control, controlName)
{
    this.setColumn(control.id, "CODE_ID");
    this.setNameExpr("{#CODE_NAME}");
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

        control.win.url("/sysmgt.workflowmgt.wfcodemgt.WorkflowCodeMgtAct/viewSearch");
        control.prx.url("/sysmgt.workflowmgt.wfcodemgt.WorkflowCodeMgtAct/retrieveSearchList");

        control.addButton("ui-icon-plus", function() {
            editDetail();
        }, any.message("msg.wf.code.add").toString());

        o.$editButton = control.addButton("ui-icon-gear", function() {
            var codeId = getValue();
            if (codeId != null) {
                editDetail(codeId);
            }
        }, any.message("msg.wf.code.modify").toString());

        o.$editButton.button("option", "disabled", true);

        o.$control.defineProperty("codeDiv", { get:getCodeDiv, set:setCodeDiv });

        any.control(control).initialize();
    })();

    function editDetail(codeId)
    {
        var win = any.window(true);
        win.url("/sysmgt.workflowmgt.wfcodemgt.WorkflowCodeMgtAct/viewDetail");
        win.param("CODE_DIV", o.codeDiv);
        win.param("CODE_ID", codeId);
        win.arg("unloadPage", true);

        if (codeId == null) {
            win.ok(function(codeId) {
                setValue(codeId);
            });
        } else {
            win.onReload = function() {
                setValue(codeId);
            };
        }

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
                o.codeId = val[control.id];
            } else {
                o.codeId = val;
            }
        }

        if (val == null || o.codeId == null) {
            o.$control.prop("value2", {});
            return;
        }

        var prx = any.proxy();
        prx.url("/sysmgt.workflowmgt.wfcodemgt.WorkflowCodeMgtAct/retrieveContents");
        prx.param("CODE_ID", o.codeId);

        prx.onSuccess = function()
        {
            o.$control.prop("value2", { "CODE_ID":o.codeId, "CODE_NAME":this.result });
        };

        prx.onError = function()
        {
            this.error.show();
        };

        prx.execute();
    }

    function getCodeDiv()
    {
        return o.codeDiv;
    }

    function setCodeDiv(codeDiv)
    {
        o.codeDiv = codeDiv;

        control.setParam("CODE_DIV", o.codeDiv);
    }
});
