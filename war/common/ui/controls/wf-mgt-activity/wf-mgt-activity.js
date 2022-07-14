any.control("wf-mgt-activity").inherit("any-search", function initialize(control, controlName)
{
    this.setColumn(control.id, "ACTIVITY_ID");
    this.setNameExpr("{#ACTIVITY_NAME_PATH}");
})
.define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);
        o.controlIndex = any.control().newIndex();

        o.$control.on("onChange", function() {
            o.$editButton.button("option", "disabled", o.$control.prop("disabled") || control.getValue() == null);
        });

        control.win.url("/sysmgt.workflowmgt.wfactivitymgt.WorkflowActivityMgtAct/viewSearch");
        control.prx.url("/sysmgt.workflowmgt.wfactivitymgt.WorkflowActivityMgtAct/retrieveSearchList");

        control.addButton("ui-icon-plus", function() {
            editDetail();
        }, any.message("msg.wf.name.add").toString());

        o.$editButton = control.addButton("ui-icon-gear", function() {
            var activityId = control.getValue();
            if (activityId != null) {
                editDetail(activityId);
            }
        }, any.message("msg.wf.name.modify").toString());

        o.$editButton.button("option", "disabled", true);

        o.$control.defineProperty("nameColumn", { get:getNameColumn, set:setNameColumn });

        any.control(control).initialize();
    })();

    function editDetail(activityId)
    {
        var win = any.window(true);
        win.url("/sysmgt.workflowmgt.wfactivitymgt.WorkflowActivityMgtAct/viewDetail");
        win.param("ACTIVITY_ID", activityId);
        win.arg("unloadPage", true);

        win.ok(function(activityId) {
            control.setValue(activityId);
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

        control.setColumn("ACTIVITY_NAME_PATH", o.nameColumn);
    }
});
