any.control("wf-mgt-view").inherit("any-search", function initialize(control, controlName)
{
    this.setColumn(control.id, "VIEW_ID");
    this.setNameExpr("{#VIEW_NAME}");
})
.define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);
        o.controlIndex = any.control().newIndex();

        o.$control.on("onChange", function() {
            o.$editButton.button("option", "disabled", o.$control.prop("disabled") || o.$control.prop("value") == null);
        });

        control.win.url("/sysmgt.workflowmgt.wfviewmgt.WorkflowViewMgtAct/viewSearch");
        control.prx.url("/sysmgt.workflowmgt.wfviewmgt.WorkflowViewMgtAct/retrieveSearchList");

        control.addButton("ui-icon-plus", function() {
            editDetail();
        }, any.message("msg.wf.code.add").toString());

        o.$editButton = control.addButton("ui-icon-gear", function() {
            var viewId = o.$control.prop("value");
            if (viewId != null) {
                editDetail(viewId);
            }
        }, any.message("msg.wf.code.modify").toString());

        o.$editButton.button("option", "disabled", true);

        o.$control.defineProperty("nameColumn", { get:getNameColumn, set:setNameColumn });

        any.control(control).initialize();
    })();

    function editDetail(viewId)
    {
        var win = any.window(true);
        win.url("/sysmgt.workflowmgt.wfviewmgt.WorkflowViewMgtAct/viewDetail");
        win.param("VIEW_ID", viewId);

        win.ok(function(obj) {
            o.$control.prop("value", obj);
        });

        win.show();
    }

    function getNameColumn()
    {
        return o.nameColumn;
    }

    function setNameColumn(val)
    {
        o.nameColumn = val;

        control.setColumn("VIEW_NAME", o.nameColumn);
    }
});
