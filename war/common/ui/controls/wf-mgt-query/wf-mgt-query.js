any.control("wf-mgt-query").inherit("any-search", function initialize(control, controlName)
{
    this.setColumn(control.id, "QRY_ID");
    this.setNameExpr("{#QRY_SUBJECT}");
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

        control.win.url("/sysmgt.workflowmgt.wfquerymgt.WorkflowQueryMgtAct/viewSearch");
        control.prx.url("/sysmgt.workflowmgt.wfquerymgt.WorkflowQueryMgtAct/retrieveSearchList");

        control.addButton("ui-icon-plus", function() {
            editDetail();
        }, any.message("msg.wf.code.add").toString());

        o.$editButton = control.addButton("ui-icon-gear", function() {
            var qryId = o.$control.prop("value");
            if (qryId != null) {
                editDetail(qryId);
            }
        }, any.message("msg.wf.code.modify").toString());

        o.$editButton.button("option", "disabled", true);

        o.$control.defineProperty("nameColumn", { get:getNameColumn, set:setNameColumn });
        o.$control.defineProperty("qryKind", { get:getQryKind, set:setQryKind });

        any.control(control).initialize();
    })();

    function editDetail(qryId)
    {
        var win = any.window(true);
        win.url("/sysmgt.workflowmgt.wfquerymgt.WorkflowQueryMgtAct/viewDetail");
        win.param("QRY_KIND", o.qryKind);
        win.param("QRY_ID", qryId);

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

        control.setColumn("QRY_SUBJECT", o.nameColumn);
    }

    function getQryKind()
    {
        return o.qryKind;
    }

    function setQryKind(val)
    {
        o.qryKind = val;

        control.setParam("QRY_KIND", o.qryKind);
    }
});
