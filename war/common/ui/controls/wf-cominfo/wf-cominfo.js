any.control("wf-cominfo").define(function behavior(control, controlName)
{
    var o = { ds:{} };

    (function main() {
        o.$control = $(control);
        o.controlIndex = any.control().newIndex();

        o.mode = o.$control.attr("mode");
        o.ofmPubYn = o.$control.attr("ofmPubYn");
        o.offPubYn = o.$control.attr("offPubYn");
        o.invPubYn = o.$control.attr("invPubYn");
        o.edit = (o.mode == "C" || o.mode == "U");

        o.ds.eventInfo = any.ds(o.$control.attr("ds"));
        o.ds.comInfo = any.ds("ds_wf_comInfo");
        o.ds.readList = any.ds("ds_wf_eventReadList");

        $(o.ds.readList).on("onLoad", function() {
            resetReadCheckboxes();
        });

        o.wfBizId = any.param("WF_BIZ_ID");
        o.wfActivityId = any.param("WF_ACTIVITY_ID");
        o.wfActivityKey = any.param("WF_ACTIVITY_KEY");
        o.wfActCodeId = any.param("WF_ACT_CODE_ID");
        o.wfActCodeKey = any.param("WF_ACT_CODE_KEY");
        o.createMode = (o.mode == "C");

        o.columns = o.$control.parent().children('colgroup').children('col').length;

        o.$bizLimitDate = $('#BIZ_LIMIT_DATE[bind="' + o.ds.eventInfo.id + '"]');

        o.row = {};
        o.row.bizSubject = any.object.toBoolean(o.$control.attr("bizSubject"), true);
        o.row.nextStatus = any.object.toBoolean(o.$control.attr("nextStatus"), true);
        o.row.bizLimitDate = (o.$bizLimitDate.length == 1);

        initBizSubject();
        //initReceiverList();

        o.$recvCheck = $('<div>').control("any-check", function() {
            if (o.createMode == true) {
                retrieveForCreate();
            }
        });

        // 처리후 상태
        //initNextStatus();

        o.$control.defineProperty("wfActCodeId", { get:getWfActCodeId });
        o.$control.defineMethod("initBizSubject", initBizSubject);
        o.$control.defineMethod("setBizId", setBizId);

        any.control(control).initialize();

        if (o.createMode != true) {
            $(o.ds.eventInfo).on("onLoad", function() {
                if (o.ds.eventInfo.rowCount() > 0) {
                    resetData(o.ds.eventInfo.rowData(0));
                }
            });
        }
    })();

    function initBizSubject()
    {
        if (o.row.bizSubject != true) return;

        var $tr = $('<tr>').appendTo(o.$control);

        $('<th>').addClass("ui-widget-header").text(any.message("lbl.BIZ_SUBJECT", "업무명")).appendTo($tr);

        var $td = $('<td>').attr({ colspan:o.columns - 1 }).appendTo($tr);

        o.$bizSubject = $('<div>').attr({ id:"BIZ_SUBJECT", bind:o.ds.eventInfo.id, maxByte:1000 }).control("any-text").appendTo($td);

        o.$bizSubject.prop("readOnly", o.edit != true);

        if (o.edit == true) {
            o.$bizSubject.require();
        }
    }

    function initReceiverList()
    {
        //var $tr1 = $('<tr>').appendTo(o.$control);
        //var $tr2 = $('<tr>').appendTo(o.$control);

        //$('<th>').addClass("ui-widget-header").attr({ rowspan:2 }).text(any.message("lbl.MAIL_RECV_PERSON", "수신자")).appendTo($tr1);

        //var $td1 = $('<td>').attr({ colspan:o.columns - 1 }).appendTo($tr1);
        //var $td2 = $('<td>').attr({ colspan:o.columns - 1 }).appendTo($tr2);

       /* o.$recvCheck = $('<div>').control("any-check", function() {
            if (o.createMode == true) {
                retrieveForCreate();
            }
        });*/
        //.appendTo($td1);

        /*o.$recvList = $('<div>').attr({ id:"dg_wf_eventRecvList", bind:o.ds.eventInfo.id, edit:o.edit }).appendTo($td2).control("any-dsgrid", function() {
            this.addColumn({ width:80 , align:"center", name:"PERSON_NAME"      , label:any.message("lbl.PERSON_NAME", "성명") });
            this.addColumn({ width:160, align:"left"  , name:"DEPT_NAME"        , label:any.message("lbl.DEPT_NAME", "부서 이름") });
            this.addColumn({ width:150, align:"left"  , name:"COMPANY_NAME"     , label:any.message("lbl.COMPANY_CODE", "소속회사") });
            this.addColumn({ width:"*", align:"left"  , name:"MAIL_ADDR"        , label:any.message("lbl.MAIL_ADDR", "메일 주소") });
            this.setOption({ rownumbers:true });
            this.setKeys("PERSON_ID");

            this.setAddButton(function() {
                var win = any.window(true);
                win.url("/common.popup.PopupAct/viewPopup?path=PersonSearchListR.jsp");
                win.param("PERSON_DIVS", "PAT,OFF");
                win.arg("multiselect", true);

                win.ok(function(data) {
                    if (data == null) return;

                    for (var i = 0; i < data.length; i++) {
                        o.$recvList.exec("addRow", data[i]);
                    }
                });

                win.show();
            });
        });*/
    }

    function initNextStatus()
    {
        if (o.row.nextStatus != true) return;

        var $tr = $('<tr>').appendTo(o.$control);

        $('<th>').addClass("ui-widget-header").text(any.message("lbl.WF_NEXT_STATUS", "처리 후 상태")).appendTo($tr);

        o.$nextStatusTd = $('<td>').attr({ colspan:o.columns - 1 }).appendTo($tr);

        o.ds.nextList = any.ds("ds_wf_nextStatusList");

        $(o.ds.nextList).on("onLoad", function() {
            resetNextStatus();
        });
    }

    function retrieveForCreate()
    {
        var prx = any.proxy();
        prx.url("/common.workflow.cominfo.WorkflowComInfoAct/retrieveForCreate");
        prx.param("WF_BIZ_ID", o.wfBizId);
        prx.param("WF_ACTIVITY_ID", o.wfActivityId);
        prx.param("WF_ACTIVITY_KEY", o.wfActivityKey);
        prx.param("WF_ACT_CODE_ID", o.wfActCodeId);
        prx.param("WF_ACT_CODE_KEY", o.wfActCodeKey);
        prx.param("nextStatus", o.row.nextStatus == true ? "1" : "0");
        prx.param("bizLimitDate", o.row.bizLimitDate == true ? "1" : "0");

        prx.onSuccess = function()
        {
            o.wfActCodeId = o.ds.comInfo.value(0, "WF_ACT_CODE_ID");
            resetData(o.ds.comInfo.rowData(0));

            if (o.row.bizSubject == true) {
                o.$bizSubject.val(o.ds.comInfo.value(0, "WF_ACT_NAME"));
            }

            if (o.row.bizLimitDate == true) {
                o.$bizLimitDate.val(o.ds.comInfo.value(0, "BIZ_LIMIT_DATE"));
            }

            if (o.row.bizSubject == true && o.edit == true) {
                o.$bizSubject.focus();
            }

            o.$control.fire("onLoadData", o.ds.comInfo.rowData(0));
        };

        prx.onError = function()
        {
            this.error.show();
        };

        prx.execute();
    }

    function resetData(data)
    {
        if (data.WF_ACT_NAME != null && data.WF_ACT_NAME != "") {
            any.dialogTitle(data.WF_ACT_NAME);
        }
    }

    function resetReadCheckboxes()
    {
        o.$recvCheck.exec("clearItem").prop("readOnly2", o.edit != true);

        var values = [];

        for (var i = 1; i < o.ds.readList.rowCount(); i++) {
            o.$recvCheck.exec("addItem", o.ds.readList.value(i, "READ_DIV"), o.ds.readList.value(i, "READ_DIV_NAME"));
        }

        if (o.createMode == true) {
            if (o.ds.comInfo.value(0, "PATTEAM_PUB_YN") == "1") {
                values.push("PAT");
            }
            if (o.ds.comInfo.value(0, "OFFICE_PUB_YN") == "1" && o.offPubYn != "N") {
                values.push("OFF");
            }
            if (o.ds.comInfo.value(0, "INVENTOR_PUB_YN") == "1" && o.ds.comInfo.value(0, "USER_DIV") != "OFF" && o.invPubYn != "N") {
                values.push("INV");
            }
            if (o.ofmPubYn != "N") {
                values.push("OFM");
            }
        } else {
            for (var i = 1; i < o.ds.readList.rowCount(); i++) {
                if (o.ds.readList.value(i, "READ_CHK_YN") == "1") {
                    values.push(o.ds.readList.value(i, "READ_DIV"));
                }
            }
        }

        o.$recvCheck.val(values.join(",")).off("onChange", resetReadCheckboxDs).on("onChange", resetReadCheckboxDs);

        resetReadCheckboxDs();
    }

    function resetReadCheckboxDs()
    {
        var values = o.$recvCheck.val();

        for (var i = 1; i < o.ds.readList.rowCount(); i++) {
            o.ds.readList.value(i, "READ_CHK_YN", values.indexOf(o.ds.readList.value(i, "READ_DIV")) == -1 ? "0" : "1");
        }
    }

    function setBizId(bizId)
    {
        o.wfBizId = bizId;
        retrieveForCreate();
    }

    function resetNextStatus()
    {
        o.$nextStatusTd.empty();

        var withRowNum = (o.ds.nextList.rowCount() > 1);

        for (var i = 0; i < o.ds.nextList.rowCount(); i++) {
            var $div = $('<div>').appendTo(o.$nextStatusTd);

            if (withRowNum == true) {
                $('<span>').text((i + 1) + ". ").appendTo($div);
            }

            $('<span>').text(o.ds.nextList.value(i, "ACTIVITY_PATH_NAME")).appendTo($div);
            $('<span>').html("&nbsp;>&nbsp;").appendTo($div);
            $('<span>').text(o.ds.nextList.value(i, "STATUS_NAME")).css({ "color":"#0000ff" }).appendTo($div);
        }
    }

    function getWfActCodeId()
    {
        return o.wfActCodeId;
    }
});
