any.control("com-approval").define(function behavior(control, controlName)
{
    var o = { ds:{} };

    (function main() {
        o.$control = $(control);
        o.controlIndex = any.control().newIndex();
        o.scope = control.id + "-" + o.controlIndex;

        o.$buttonArea = $('[name="' + o.$control.attr("buttonArea") + '"]').hide();

        o.ds.configInfo = any.ds("ds_configInfo", o.scope);
        o.ds.mainInfo = any.ds("ds_mainInfo", o.scope);
        o.ds.reqList = any.ds("ds_reqList", o.scope);
        o.ds.procList = any.ds("ds_procList", o.scope);
        o.ds.referList = any.ds("ds_referList", o.scope);
        o.ds.lastApprLineList = any.ds("ds_lastApprLineList", o.scope);
        o.ds.reqSaveInfo = any.ds("ds_reqSaveInfo", o.scope);
        o.ds.reqProcSaveList = any.ds("ds_reqProcSaveList", o.scope);
        o.ds.reqReferSaveList = any.ds("ds_reqReferSaveList", o.scope);
        o.ds.procSaveInfo = any.ds("ds_procSaveInfo", o.scope);

        if (any.arg("wf") != null) {
            o.wfActivity = any.text.empty(any.arg("wf").ACTIVITY, any.arg("wf").ACTIVITY_ID);
        }

        initControl();
        initHTML();

        o.$control.defineMethod("reset", reset);
        o.$control.defineMethod("getAvail", getAvail);
        o.$control.defineMethod("setCheck", setCheck);
        o.$control.defineMethod("setShowHideObjects", setShowHideObjects);
        o.$control.defineMethod("continueProcess", continueProcess);
        o.$control.defineMethod("addApprLine", addApprLine);

        o.$control.defineProperty("apprCode", { get:getApprCode, set:setApprCode });
        o.$control.defineProperty("bizId", { get:getBizId, set:setBizId });
        o.$control.defineProperty("reqPerson", { get:getReqPerson, set:setReqPerson });
        o.$control.defineProperty("reqSubject", { get:getReqSubject, set:setReqSubject });
        o.$control.defineProperty("reqApproved", { get:getReqApproved, set:setReqApproved });
        o.$control.defineProperty("readOnly", { get:getReadOnly, set:setReadOnly });
        o.$control.defineProperty("isFinalApproval", { get:isFinalApproval });
        o.$control.defineProperty("wfActivity", { get:getWfActivity, set:setWfActivity });

        any.control(control).initialize();
    })();

    function initControl()
    {
        for (var name in o.ds) {
            o.ds[name].init();
        }

        o.checkFuncs = {};
        o.currValue = {};
    }

    function initHTML()
    {
        var html = [];

        html.push('<h2></h2>');
        html.push('<div class="ui-widget-content ui-corner-all">');
        html.push('<table class="list">');
        html.push('    <colgroup>');
        html.push('        <col width="120px">');
        html.push('        <col width="130px">');
        html.push('        <col width="90px">');
        html.push('        <col width="150px">');
        html.push('        <col width="*">');
        html.push('    </colgroup>');
        html.push('    <thead>');
        html.push('        <tr>');
        html.push('            <th class="ui-widget-header">' + any.message("application.common.approval.lbl.DIV", "구분").toHTML() + '</th>');
        html.push('            <th class="ui-widget-header">' + any.message("application.common.approval.lbl.NAME", "이름").toHTML() + '</th>');
        html.push('            <th class="ui-widget-header">' + any.message("application.common.approval.lbl.STATUS", "상태").toHTML() + '</th>');
        html.push('            <th class="ui-widget-header">' + any.message("application.common.approval.lbl.DATETIME", "일시").toHTML() + '</th>');
        html.push('            <th class="ui-widget-header">' + any.message("application.common.approval.lbl.MEMO", "메모").toHTML() + '</th>');
        html.push('        </tr>');
        html.push('    </thead>');
        html.push('    <tbody name="tbd_approval"></tbody>');
        html.push('</table>');
        html.push('</div>');

        o.historyHTML = html.join("\n");

        html = [];

        html.push('<div id="div_history" style="display:none;"></div>');

        html.push('<div id="div_request" style="display:none;">');
        html.push('<h2 id="div_request_title"></h2>');
        html.push('<div class="ui-widget-content ui-corner-all">');
        html.push('<table class="view">');
        html.push('    <colgroup>');
        html.push('        <col width="150px">');
        html.push('        <col width="*">');
        html.push('        <col width="150px">');
        html.push('        <col width="*">');
        html.push('    </colgroup>');
        html.push('    <tr>');
        html.push('        <th class="ui-widget-header">' + any.message("application.common.approval.lbl.APPR_REQ_PERSON", "요청자").toHTML() + '</th>');
        html.push('        <td><span id="spn_reqPersonName"></span></td>');
        html.push('        <th class="ui-widget-header">' + any.message("application.common.approval.lbl.APPR_REQ_MEMO", "요청메모").toHTML() + '</th>');
        html.push('        <td><div any-text id="txt_reqMemo" maxByte="500"></div></td>');
        html.push('    </tr>');
        html.push('    <tr>');
        html.push('        <th class="ui-widget-header">' + any.message("application.common.approval.lbl.APPR_LINE", "결재선").toHTML() + '</th>');
        html.push('        <td colspan="3">');
        html.push('            <table class="layout auto">');
        html.push('                <tr>');
        html.push('                    <td nowrap>');
        html.push('                        <label for="rdo_apprLineDivSelect_' + o.controlIndex + '_procA" style="cursor:default;">');
        html.push('                            <input type="radio" name="rdo_apprLineDivSelect_' + o.controlIndex + '" id="rdo_apprLineDivSelect_' + o.controlIndex + '_procA" lineDiv="procA" listDiv="proc" procDiv="A" checked>' + any.message("application.common.approval.lbl.APPR_PROC_PERSON", "결재자").toHTML());
        html.push('                        </label>');
        html.push('                        <label for="rdo_apprLineDivSelect_' + o.controlIndex + '_procB" style="cursor:default;">');
        html.push('                            <input type="radio" name="rdo_apprLineDivSelect_' + o.controlIndex + '" id="rdo_apprLineDivSelect_' + o.controlIndex + '_procB" lineDiv="procB" listDiv="proc" procDiv="B">' + any.message("application.common.approval.lbl.APPR_AGREE_PERSON", "합의자").toHTML());
        html.push('                        </label>');
        html.push('                        <label for="rdo_apprLineDivSelect_' + o.controlIndex + '_refer" style="cursor:default;">');
        html.push('                            <input type="radio" name="rdo_apprLineDivSelect_' + o.controlIndex + '" id="rdo_apprLineDivSelect_' + o.controlIndex + '_refer" lineDiv="refer" listDiv="refer">' + any.message("application.common.approval.lbl.APPR_REFER_PERSON", "참조자").toHTML());
        html.push('                        </label>');
        html.push('                    </td>');
        html.push('                    <td width="100%" style="padding-left:5px; padding-right:5px;">');
        html.push('                        <div any-text id="txt_apprPersonSearch_' + o.controlIndex + '"></div>');
        html.push('                    </td>');
        html.push('                    <td nowrap>');
        html.push('                        <button any-button size="small" id="btn_search_' + o.controlIndex + '"">' + any.message("application.common.btn.add", "추가").toHTML() + '</button>');
        html.push('                        <button any-button size="small" id="btn_delete_' + o.controlIndex + '"">' + any.message("application.common.btn.delete", "삭제").toHTML() + '</button>');
        html.push('                        <button any-button size="small" id="btn_moveUp_' + o.controlIndex + '"">▲</button>');
        html.push('                        <button any-button size="small" id="btn_moveDn_' + o.controlIndex + '"">▼</button>');
        html.push('                    </td>');
        html.push('                </tr>');
        html.push('            </table>');
        html.push('            <table class="layout" style="margin-top:2px;">');
        html.push('                <tr>');
        html.push('                    <td width="50%"><select name="sel_apprLineList_' + o.controlIndex + '" multiple size="4" listDiv="proc" style="width:100%; height:80px;"></select></td>');
        html.push('                    <td width="2px"></td>');
        html.push('                    <td width="50%"><select name="sel_apprLineList_' + o.controlIndex + '" multiple size="4" listDiv="refer" style="width:100%; height:80px;"></select></td>');
        html.push('                </tr>');
        html.push('            </table>');
        html.push('        </td>');
        html.push('    </tr>');
        html.push('</table>');
        html.push('</div>');
        html.push('</div>');

        html.push('<div id="div_button" class="buttons" style="padding-top:10px; display:none;"></div>');

        o.$control.html(html.join("\n"));

        o.$txt_apprPersonSearch = o.$control.find('#txt_apprPersonSearch_' + o.controlIndex).enter(function(event) {
            searchApprPerson();
        });

        o.$rdo_apprLineDivSelect = o.$control.find('input:radio[name="rdo_apprLineDivSelect_' + o.controlIndex + '"]').click(function() {
            o.$txt_apprPersonSearch.focus().select();
        });

        o.$sel_apprLineList = o.$control.find('select[name="sel_apprLineList_' + o.controlIndex + '"]').click(function() {
            o.$currApprLineList = $(this);
            o.$sel_apprLineList.filter(':not([listDiv="' + o.$currApprLineList.attr("listDiv") + '"])').children('option').removeAttr("selected");
        });

        o.$btn_search = o.$control.find('#btn_search_' + o.controlIndex).click(function() {
            searchApprPerson();
        });
        o.$btn_delete = o.$control.find('#btn_delete_' + o.controlIndex).click(function() {
            deleteApprLine();
        });
        o.$btn_moveUp = o.$control.find('#btn_moveUp_' + o.controlIndex).click(function() {
            moveApprLine(-1);
        });
        o.$btn_moveDn = o.$control.find('#btn_moveDn_' + o.controlIndex).click(function() {
            moveApprLine(1);
        });
    }

    function getApprCode()
    {
        return o.apprCode;
    }

    function setApprCode(apprCode)
    {
        o.apprCode = apprCode;
    }

    function getBizId()
    {
        return o.bizId;
    }

    function setBizId(bizId)
    {
        o.bizId = bizId;
    }

    function getReqPerson()
    {
        return o.reqPerson;
    }

    function setReqPerson(reqPerson)
    {
        o.reqPerson = ($.type(reqPerson) == "array" ? reqPerson : [reqPerson]);
    }

    function isReqPerson(personId)
    {
        if (o.reqPerson == null) return false;

        if (personId == null) personId = o.loginPersonId;

        for (var i = 0; i < o.reqPerson.length; i++) {
            if (o.reqPerson[i] == personId) return true;
        }

        return false;
    }

    function getReqSubject()
    {
        return o.reqSubject;
    }

    function setReqSubject(reqSubject)
    {
        o.reqSubject = reqSubject;
    }

    function getReqApproved()
    {
        return o.reqApproved;
    }

    function setReqApproved(reqApproved)
    {
        o.reqApproved = reqApproved;
    }

    function getReadOnly()
    {
        return o.readOnly;
    }

    function setReadOnly(val)
    {
        o.readOnly = (String(val).toLowerCase() == "readonly" || any.object.toBoolean(val, true));

        o.$control.find('div#div_request').showHide(o.readOnly != true);
        o.$control.find('div#div_button').showHide(o.readOnly != true);
    }

    function isFinalApproval()
    {
        var ds = o.ds.procList;
        var cnt = 0;

        for (var i = 0; i < ds.rowCount(); i++) {
            if (ds.value(i,"PROC_DIV") == "A" && (ds.value(i, "PROC_STATUS") == "0" || ds.value(i, "PROC_STATUS") == "1")) {
                cnt++;
            }
        }

        return cnt == 1;
    }

    function getWfActivity()
    {
        return o.wfActivity;
    }

    function setWfActivity(val)
    {
        o.wfActivity = val;
    }

    function getAvail()
    {
        if (o.readOnly == true) return false;

        for (var i = 0; i < arguments.length; i++) {
            if (getValue(arguments[i]) == true) return true;
        }

        return false;

        function getValue(apprEvent)
        {
            switch (apprEvent) {
            case "NONE": // 없음
                return (o.apprStatus == "0" || (o.apprStatus == "8" && o.reqApproved == true) || o.reqStatus == "4") && o.ds.configInfo.value(0, "APPR_NONE_AVAIL_YN") == "1";
            case "REQUEST": // 요청
                return (o.apprStatus == "0" || (o.apprStatus == "8" && o.reqApproved == true) || o.reqStatus == "4");
            case "CANCEL": // 취소
                return (o.apprStatus == "1") && o.ds.configInfo.value(0, "APPR_CANCEL_AVAIL_YN") == "1" && o.ds.mainInfo.value(0, "PROC_CNT") == "0";
            case "APPROVE": // 승인
            case "AGREE": // 합의
            case "REJECT": // 반려
                return (o.apprStatus == "1");
            case "UPPER": // 상위요청
                return (o.apprStatus == "1") && o.ds.configInfo.value(0, "PRIOR_APPR_AVAIL_YN") == "1";
            case "REWRITE": // 재작성
                return (o.apprStatus == "9");
            }
        }
    }

    function setCheck(apprEvent, checkFunc)
    {
        if ($.type(apprEvent) == "array") {
            for (var i = 0; i < apprEvent.length; i++) {
                o.checkFuncs[apprEvent[i]] = checkFunc;
            }
        } else {
            o.checkFuncs[apprEvent] = checkFunc;
        }
    }

    function setShowHideObjects(arr)
    {
        o.showHideObjects = arr;
    }

    function setShowHideObjectsDisplay()
    {
        if (o.showHideObjects == null) return;

        var show = (isReqPerson() == true && getAvail("REQUEST") == true && o.readOnly != true);

        for (var i = 0; i < o.showHideObjects.length; i++) {
            $('#' + o.showHideObjects[i] + ',[name="' + o.showHideObjects[i] + '"]').showHide(show);
        }
    }

    function continueProcess()
    {
        if (o.continueProcessFunc != null) {
            o.continueProcessFunc.apply(control);
        }
    }

    function reset(fireEvent)
    {
        initControl();

        o.$control.fire("onReset");

        o.$control.find('#div_history').empty().hide();
        o.$control.find('#div_request').hide();
        o.$control.find('#div_button').empty().hide();

        retrieveApproval(fireEvent);
    }

    function getHTML()
    {
        return document.body.innerHTML;
    }

    // 결재 정보 조회
    function retrieveApproval(fireEvent)
    {
        if (o.bizId == null) {
            alert(any.message("application.common.approval.msg.error.bizIdNotDefined", "업무 ID가 정의되지 않았습니다."));
            return;
        }

        var prx = any.proxy(o.scope);
        prx.url("/common.approval.core.ApprovalCoreAct/retrieve");
        prx.param("APPR_CODE", o.apprCode);
        prx.param("BIZ_ID", o.bizId);

        prx.onSuccess = function()
        {
            o.loginPersonId = o.ds.configInfo.value(0, "LOGIN_PERSON_ID");
            o.lastReqId = o.ds.mainInfo.value(0, "LAST_REQ_ID");
            o.apprStatus = o.ds.mainInfo.value(0, "APPR_STATUS");
            o.reqStatus = o.ds.mainInfo.value(0, "REQ_STATUS");

            o.interfaceInfo = any.config.approvalInterface;

            // 외부 인터페이스 전자결재 사용일 경우
            if (o.interfaceInfo.enable == true) {
                o.$control.find('div#div_request').hide();
                o.$control.find('div#div_button').hide();
            } else {
                o.interfaceInfo = null;
            }

            if (o.apprStatus == null || o.apprStatus == "") o.apprStatus = "0";

            makeHTML();

            if (getAvail("REQUEST") == true) {
                for (var i = 0; i < o.ds.lastApprLineList.rowCount(); i++) {
                    addApprLine(o.ds.lastApprLineList.rowData(i), o.ds.lastApprLineList.value(i, "LINE_DIV"), true);
                }
            }

            setShowHideObjectsDisplay();

            o.$control.fire("onLoad");

            if (fireEvent == true) {
                o.$control.fire("onComplete");
                o.$control.fire("onSuccess");
            }
        };

        prx.onError = function()
        {
            this.error.show();

            if (fireEvent == true) {
                o.$control.fire("onComplete");
                o.$control.fire("onError");
            }
        };

        prx.execute();
    }

    function makeHTML()
    {
        var html = [];

        for (var i = 0; i < o.ds.reqList.rowCount(); i++) {
            html.push(o.historyHTML);
        }

        if (html.length > 0) {
            o.$control.find('#div_history').html(html.join("\n")).show();
        }

        var $titleHead = o.$control.find('h2');
        var $tbodys = o.$control.find('tbody[name="tbd_approval"]');
        var $tbd = null;
        var $tr, $td;

        for (var i = 0; i < o.ds.reqList.rowCount(); i++) {
            $titleHead.eq(i).text(any.message("application.common.approval.lbl.status", "결재현황") + ($titleHead.length == 1 ? "" : " " + (i + 1)) + " - " + o.ds.configInfo.value(0, "APPR_NAME"));

            $tbd = $tbodys.eq(i);

            $tbd.attr({ id:"tbd_appr_" + o.controlIndex + "_" + o.ds.reqList.value(i, "APPR_REQ_ID") });

            $tr = $('<tr>').appendTo($tbd);

            $('<th>').text(any.message("application.common.approval.lbl.APPR_REQ_PERSON", "요청자")).addClass("ui-widget-header").appendTo($tr);

            $td = $('<td>').text(o.ds.reqList.value(i, "REQ_PERSON_NAME"));
            $td.attr({ "title":o.ds.reqList.value(i, "REQ_PERSON_NAME") + " / " + o.ds.reqList.value(i, "REQ_PERSON_DEPT_NAME") });
            $td.css({ "cursor":"default" });
            $td.appendTo($tr);

            $td = $('<td>').text('[' + function() {
                switch (o.ds.reqList.value(i, "REQ_STATUS")) {
                case "4":
                    return any.message("application.common.approval.btn.APPR_CANCEL", "상신취소").toHTML();
                case "5":
                    return any.message("application.common.approval.btn.APPR_NONE", "결재없음").toHTML();
                default:
                    return any.message("application.common.approval.btn.APPR_REQUEST", "결재요청").toHTML();
                }
            }() + ']');
            $td.css({ "text-align":"center" });
            if (o.ds.reqList.value(i, "REQ_STATUS") == "4") {
                $td.css({ "color":"gray" });
            }
            $td.appendTo($tr);

            $td = $('<td>').text(any.date(o.ds.reqList.value(i, "REQ_DATETIME")).toString("yyyy-mm-dd hh:ii:ss"));
            $td.css({ "text-align":"center", "white-space":"nowrap" });
            $td.appendTo($tr);

            $td = $('<td>').text(o.ds.reqList.value(i, "REQ_MEMO"));
            $td.appendTo($tr);

            if (o.ds.reqList.value(i, "REQ_STATUS") != "5") continue;

            $tr = $('<tr>').appendTo($tbd);

            $td = $('<td>').text(any.message("application.common.approval.msg.apprNoneCompleted", "(결재없이 처리되었습니다)"));
            $td.attr({ "colspan":5 });
            $td.css({ "text-align":"center", "color":"blue" });
            $td.appendTo($tr);
        }

        // 마지막 결재자 차수
        var lastProcASeq = o.ds.procList.rowCount() - 1;

        for (var i = 0; i < o.ds.procList.rowCount(); i++) {
            if ("A" == o.ds.procList.value(i, "PROC_DIV")) {
                lastProcASeq = i;
            }
        }

        for (var i = 0; i < o.ds.procList.rowCount(); i++) {
            var apprProcId = o.ds.procList.value(i, "APPR_PROC_ID");
            var apprReqId = o.ds.procList.value(i, "APPR_REQ_ID");
            var procDeg = Number(o.ds.procList.value(i, "PROC_DEG"));
            var procDiv = o.ds.procList.value(i, "PROC_DIV");
            var procPersonId = o.ds.procList.value(i, "PROC_PERSON_ID");
            var procStatus = o.ds.procList.value(i, "PROC_STATUS");

            $tbd = o.$control.find('#tbd_appr_' + o.controlIndex + '_' + apprReqId);

            if (getAvail("APPROVE", "AGREE", "REJECT", "UPPER") == true && apprReqId == o.lastReqId && procStatus == "1" && procPersonId == o.loginPersonId) {
                o.currValue.apprProcId = apprProcId;
                o.currValue.procDeg = procDeg;
            }

            $tr = $('<tr>').appendTo($tbd);

            $('<th>').text(any.message("application.common.approval.msg.proc" + procDiv, "{0}차 결재자").arg(procDeg)).addClass("ui-widget-header").appendTo($tr);

            $td = $('<td>').text(o.ds.procList.value(i, "PROC_PERSON_NAME"));
            $td.attr({ "title":o.ds.procList.value(i, "PROC_PERSON_NAME") + " / " + o.ds.procList.value(i, "PROC_PERSON_DEPT_NAME") });
            $td.css({ "cursor":"default" });
            $td.appendTo($tr);

            $td = $('<td>').css({ "text-align":"center" });
            if (apprProcId == o.currValue.apprProcId) {
                var html = [];
                html.push('<select id="sel_procStatus" style="width:100%;">');
                html.push('    <option></option>');
                if (getAvail("APPROVE", "AGREE") == true) {
                    if (procDiv == "A") {
                        html.push('    <option value="8" apprEvent="APPROVE" style="color:blue;">' + any.message("application.common.approval.lbl.APPR_APPROVE", "승인").toHTML() + '</option>');
                    } else if (procDiv == "B") {
                        html.push('    <option value="7" apprEvent="AGREE" style="color:blue;">' + any.message("application.common.approval.lbl.APPR_AGREE", "합의").toHTML() + '</option>');
                    }
                }
                if (getAvail("REJECT") == true) {
                    html.push('    <option value="9" apprEvent="REJECT" style="color:red;">' + any.message("application.common.approval.lbl.APPR_REJECT", "반려").toHTML() + '</option>');
                }
                // 상위요청 가능 & 마지막 결재자
                if (getAvail("UPPER") == true && procDiv == "A" && i == lastProcASeq)  {
                    html.push('    <option value="6" apprEvent="UPPER" style="color:blue;">' + any.message("application.common.approval.lbl.APPR_UPPER", "상위요청").toHTML() + '</option>');
                }
                html.push('</select>');
                $td.html(html.join("\n")).children('select').change(function() {
                    if ($(this).val() == "6") {
                        o.$control.find('#tr_upperProcPerson').show();
                        if (o.$control.find('#any_upperProcPerson').val() == null) {
                            o.$control.find('#any_upperProcPerson').exec("doSearch");
                        }
                    } else {
                        o.$control.find('#tr_upperProcPerson').hide();
                        o.$control.find('#txt_procMemo').focus();
                    }
                }).find('option').each(function() {
                    var $this = $(this);
                    if ($this.text() != "") {
                        $this.attr("title", $this.text());
                    }
                });
                createButton(any.message("application.common.approval.lbl.apprProc", "결재처리"), function() { doEvent(
                    function() {
                        var apprEvent = o.$control.find('#sel_procStatus').children('option:selected').attr("apprEvent");
                        if (apprEvent == null || apprEvent == "") {
                            alert(any.message("application.common.approval.msg.statusNotSelected", "결재상태를 선택하세요."));
                            o.$control.find('#sel_procStatus').focus();
                            return null;
                        }
                        return apprEvent;
                    }());
                });
            } else {
                var procStatusName = o.ds.procList.value(i, "PROC_STATUS_NAME");
                if (o.interfaceInfo == null || procStatus != "0") {
                    procStatusName = (procStatusName == "" ? "-" : "[" + procStatusName + "]");
                } else {
                    procStatusName = "-";
                }
                $td.text(procStatusName).css("color", function() {
                    switch (procStatus) {
                    case "0":
                    case "1":
                    case "4":
                        return "gray";
                    case "6":
                    case "7":
                    case "8":
                        return "blue";
                    case "9":
                        return "red";
                    default:
                        return "black";
                    }
                }());
            }
            $td.appendTo($tr);

            $td = $('<td>').css({ "text-align":"center", "white-space":"nowrap" });
            if (apprProcId == o.currValue.apprProcId) {
                $td.text(any.date().toDisplay());
            } else if (procStatus == "0" || procStatus == "1" || procStatus == "4") {
                $td.text('-').css("color", "gray");
            } else {
                $td.text(any.date(o.ds.procList.value(i, "PROC_DATETIME")).toString("yyyy-mm-dd hh:ii:ss"));
            }
            $td.appendTo($tr);

            $td = $('<td>');
            if (apprProcId == o.currValue.apprProcId) {
                $td.append($('<div>').attr({ "id":"txt_procMemo", "maxByte":500 }).control("any-text"));
            } else if (procStatus == "0" || procStatus == "1" || procStatus == "4") {
                $td.text("-").css({ "text-align":"center" }).css("color", "gray");
            } else {
                $td.text(o.ds.procList.value(i, "PROC_MEMO"));
            }
            $td.appendTo($tr);
        }

        if (getAvail("UPPER") == true) {
            $tr = $('<tr>').attr({ "id":"tr_upperProcPerson" }).hide().appendTo($tbd);

            $('<th>').text(any.message("application.common.approval.msg.procA", "{0}차 결재자").arg(o.currValue.procDeg + 1)).addClass("ui-widget-header").appendTo($tr);

            $td = $('<td>').attr({ "colspan":3 });
            $('<div>').attr({ "id":"any_upperProcPerson" }).control("any-search", function() {
                this.win.url("/common.popup.PopupAct/viewPopup?path=PersonSearchListR.jsp");
                this.setParam("PERSON_DIVS", "PAT");
                this.setColumn("PERSON_ID");
                this.setNameExpr("{#PERSON_NAME}({#EMP_NO}) / {#DEPT_NAME}");
            }).appendTo($td);
            $td.appendTo($tr);

            $td = $('<td>').attr({ "align":"center", "color":"gray" });
            $td.html('-');
            $td.appendTo($tr);
        }

        var referPersonObj = {};

        for (var i = 0; i < o.ds.referList.rowCount(); i++) {
            var apprReqId = o.ds.referList.value(i, "APPR_REQ_ID");
            if (referPersonObj[apprReqId] == null) referPersonObj[apprReqId] = { reqId:apprReqId, arr:[] };
            var title = o.ds.referList.value(i, "REFER_PERSON_NAME") + ' / ' + o.ds.referList.value(i, "REFER_PERSON_DEPT_NAME");
            referPersonObj[apprReqId].arr.push('<span title="' + title + '">' + o.ds.referList.value(i, "REFER_PERSON_NAME") + '</span>');
        }

        for (var item in referPersonObj) {
            $tbd = o.$control.find('#tbd_appr_' + o.controlIndex + '_' + referPersonObj[item].reqId);

            $tr = $('<tr>').appendTo($tbd);

            $('<th>').text(any.message("application.common.approval.lbl.APPR_REFER_PERSON", "참조자")).addClass("ui-widget-header").appendTo($tr);

            $td = $('<td colspan="4">').html(referPersonObj[item].arr.join(",\n"));
            $td.attr({ "colspan":4 }).css({ "cursor":"default" });
            $td.appendTo($tr);
        }

        if (isReqPerson() != true || o.readOnly == true) return;

        if (o.interfaceInfo == null) {
            if (getAvail("NONE", "REQUEST")) {
                o.$control.find('#spn_reqPersonName').text(o.ds.configInfo.value(0, "LOGIN_PERSON_NAME"));
                o.$control.find('#div_request_title').text(any.message("application.common.approval.lbl.APPR_REQUEST", "결재요청") + " - " + o.ds.configInfo.value(0, "APPR_NAME"));
                o.$control.find('#div_request').show();
            }
            if (getAvail("NONE")) {
                createButton(any.message("application.common.approval.btn.APPR_NONE", "결재없음"), function() {
                    doEvent("NONE");
                });
            }
            if (getAvail("REQUEST")) {
                createButton(any.message("application.common.approval.btn.APPR_REQUEST", "결재요청"), function() {
                    doEvent("REQUEST");
                });
            }
            if (getAvail("CANCEL")) {
                createButton(any.message("application.common.approval.btn.APPR_CANCEL", "결재취소"), function() {
                    doEvent("CANCEL");
                });
            }
            if (getAvail("REWRITE")) {
                createButton(any.message("application.common.approval.btn.APPR_REWRITE", "재작성"), function() {
                    doEvent("REWRITE");
                });
            }
        } else {
            if (getAvail("REQUEST")) {
                createButton(any.message("application.common.approval.btn.APPR_REQUEST", "결재요청"), function() {
                    doEvent("REQUEST", function() {
                        // 인터페이스 전자결재 사용시 수정 사용 요망!!
                        /*var win = any.window(true);
                        win.url(o.interfaceInfo.url);
                        win.param("docid", o.bizId + "-" + o.apprCode);
                        win.param("formty", o.interfaceInfo.docCode);
                        win.onUnload = function()
                        {
                            any.location().reload();
                        };
                        win.option({ width:800, height:380 });
                        win.show();*/
                    });
                });
            }
            if (getAvail("REWRITE")) {
                createButton(any.message("application.common.approval.btn.APPR_REWRITE", "재작성"), function() {
                    doEvent("REWRITE");
                });
            }
        }
    }

    function createButton(txt, act)
    {
        if (o.readOnly == true) return;

        var $buttonArea;

        if (o.interfaceInfo == null || o.$buttonArea.length == 0) {
            $buttonArea = o.$control.find('#div_button');
        } else {
            $buttonArea = o.$buttonArea;
            $buttonArea.parent('div.buttons').parent('div.page-footer').show();
        }

        $buttonArea.append(' ').show().append($('<button>').text(txt).control("any-button").click(act));
    }

    function searchApprPerson()
    {
        if (any.text.trim(o.$txt_apprPersonSearch.val()) == "") {
            openSearch();
            return;
        }

        var ds = any.ds("ds_apprPersonSearchList", o.scope);

        var prx = any.proxy(o.scope);
        prx.url("/common.popup.PopupAct/retrieveList?name=personList");
        prx.param("PERSON_DIVS", "PAT");
        prx.param("SEARCH_TEXT", o.$txt_apprPersonSearch.val());
        prx.data(ds, "RESULT_SET", true);

        prx.onSuccess = function()
        {
            if (ds.rowCount() == 0) {
                alert(any.message("application.common.approval.msg.noSearchResult", "검색결과가 존재하지 않습니다."));
                o.$txt_apprPersonSearch.focus().select();
            } else if (ds.rowCount() == 1) {
                o.$txt_apprPersonSearch.val("");
                addApprLine(ds.rowData(0));
                o.$txt_apprPersonSearch.focus().select();
            } else {
                openSearch();
            }
        };

        prx.onError = function()
        {
            this.error.show();
        };

        prx.execute();

        function openSearch()
        {
            var win = any.window(true);
            win.url("/common.popup.PopupAct/viewPopup?path=PersonSearchListR.jsp");
            win.param("PERSON_DIVS", "PAT");
            win.arg("SEARCH_TEXT", o.$txt_apprPersonSearch.val());
            win.ok(function(data) {
                addApprLine(data);
                window.setTimeout(function() {
                    o.$txt_apprPersonSearch.focus().select();
                });
            });
            win.show();
        }
    }

    function addApprLine(values, lineDiv, noMessage)
    {
        if (values.PERSON_ID == o.loginPersonId) {
            if (noMessage != true) {
                alert(any.message("application.common.approval.msg.reqPersonAddNotAvail", "요청자를 추가할 수 없습니다."));
            }
            return;
        }

        var $rdo = o.$rdo_apprLineDivSelect.filter(lineDiv == null ? ':checked' : '[lineDiv="' + lineDiv + '"]');
        var $list = o.$sel_apprLineList.filter('[listDiv="' + $rdo.attr("listDiv") + '"]');
        var $opts = $list.children('option');

        for (var i = 0; i < $opts.length; i++) {
            if ($opts.eq(i).data("values").PERSON_ID == values.PERSON_ID && $opts.eq(i).data("procDiv") == $rdo.attr("procDiv")) return "exists";
        }

        setApprLineText($('<option>').attr({ procDiv:$rdo.attr("procDiv") }).data({ values:values, lineDiv:$rdo.attr("lineDiv"), procDiv:$rdo.attr("procDiv"), listDiv:$rdo.attr("listDiv") }).appendTo($list));
    }

    function setApprLineText($opt)
    {
        var $list = o.$sel_apprLineList.filter('[listDiv="' + $opt.data("listDiv") + '"]');
        var $opts = $list.children('option');
        var procDeg = 0;

        for (var i = 0; i < $opts.length; i++) {
            if ($opts.eq(i).data("procDiv") == $opt.data("procDiv")) procDeg++;
            if ($opts.eq(i).data("values").PERSON_ID == $opt.data("values").PERSON_ID) break;
        }

        var textPrefix = any.message("application.common.approval.msg.lineTitle." + $opt.data("lineDiv"), "{0}차 결재자").arg(procDeg) + " : ";

        var values = $opt.data("values");

        var empNo = any.text(values.EMP_NO).nvl("").toString();
        var personName = any.text(values.PERSON_NAME).nvl("").toString();
        var deptName = any.text(values.DEPT_NAME).nvl("").toString();

        // 사번을 보여 주어야 하는 경우 사용
        //$opt.text(textPrefix + personName + "(" + empNo + ") / " + deptName);
        $opt.text(textPrefix + personName + " / " + deptName);
    }

    function deleteApprLine()
    {
        if (o.$currApprLineList == null) return;

        o.$currApprLineList.children('option:selected').each(function() {
            $(this).remove();
        });

        o.$currApprLineList.children('option').each(function() {
            setApprLineText($(this));
        });
    }

    function moveApprLine(dir)
    {
        if (o.$currApprLineList == null) return;

        var $opts = o.$currApprLineList.children('option:selected');

        if ($opts.length == 0) return;

        if (dir == -1 && $opts.first().is(':first-child')) return;
        if (dir == 1 && $opts.last().is(':last-child')) return;

        if (dir == -1) {
            for (var i = 0; i < $opts.length; i++) {
                $opts.eq(i).prev().before($opts.eq(i).clone(true).attr("selected", "selected"));
                $opts.eq(i).remove();
            }
        } else {
            for (var i = $opts.length - 1; i >= 0; i--) {
                $opts.eq(i).next().after($opts.eq(i).clone(true).attr("selected", "selected"));
                $opts.eq(i).remove();
            }
        }

        o.$currApprLineList.children('option').each(function() {
            setApprLineText($(this));
        });
    }

    function doEvent(apprEvent, apprFunc)
    {
        o.continueProcessFunc = null;

        if (o.bizId == null) {
            alert(any.message("application.common.approval.msg.error.bizIdNotDefined", "업무 ID가 정의되지 않았습니다."));
            return;
        }

        if (apprEvent == null) return;

        function doCheck(func)
        {
            o.continueProcessFunc = (apprFunc == null ? func : apprFunc);

            if (o.checkFuncs[apprEvent] == null) {
                continueProcess();
            } else {
                o.checkFuncs[apprEvent].apply(control);
            }
        }

        var func = {};

        func["NONE"] = function()
        {
            doCheck(function() {
                if (!confirm(any.message("application.common.approval.msg.apprNone.confirm", "결재없음으로 처리하시겠습니까?\n\n(입력된 결재자는 무시됩니다)"))) return;

                o.ds.reqSaveInfo.init();
                o.ds.reqSaveInfo.addRow();
                o.ds.reqSaveInfo.value(0, "REQ_SUBJECT", o.reqSubject);
                o.ds.reqSaveInfo.value(0, "REQ_MEMO", o.$control.find('#txt_reqMemo').val());
                o.ds.reqSaveInfo.value(0, "REQ_STATUS", "5");

                var prx = getProxy();

                if (prx == null) return;

                prx.data(o.ds.reqSaveInfo);

                prx.onSuccess = function()
                {
                    alert(any.message("application.common.approval.msg.apprNone.success", "결재없음 처리가 성공적으로 수행되었습니다."));
                    any.location().reload();
                };

                prx.execute();
            });
        };

        func["REQUEST"] = function()
        {
            if (o.interfaceInfo == null && o.$sel_apprLineList.filter('[listDiv="proc"]').children('option[procDiv="A"]').length == 0) {
                alert(any.message("application.common.approval.msg.error.procPersonInputOneOver", "결재자를 1명 이상 입력하세요."));
                o.$rdo_apprLineDivSelect.filter('[lineDiv="procA"]')[0].checked = true;
                o.$txt_apprPersonSearch.focus();
                return;
            }

            doCheck(function() {
                if (!confirm(any.message("application.common.approval.msg.apprReq.confirm", "결재상신을 하시겠습니까?"))) return;

                o.ds.reqSaveInfo.init();
                o.ds.reqSaveInfo.addRow();
                o.ds.reqSaveInfo.value(0, "REQ_SUBJECT", o.reqSubject);
                o.ds.reqSaveInfo.value(0, "REQ_MEMO", o.$control.find('#txt_reqMemo').val());
                o.ds.reqSaveInfo.value(0, "REQ_STATUS", "1");

                var $opts;

                o.ds.reqProcSaveList.init();
                $opts = o.$sel_apprLineList.filter('[listDiv="proc"]').children('option');
                for (var i = 0; i < $opts.length; i++) {
                    o.ds.reqProcSaveList.addRow();
                    o.ds.reqProcSaveList.value(i, "PROC_DIV", $opts.eq(i).data("procDiv"));
                    o.ds.reqProcSaveList.value(i, "PROC_PERSON_ID", $opts.eq(i).data("values").PERSON_ID);
                }

                o.ds.reqReferSaveList.init();
                $opts = o.$sel_apprLineList.filter('[listDiv="refer"]').children('option');
                for (var i = 0; i < $opts.length; i++) {
                    o.ds.reqReferSaveList.addRow();
                    o.ds.reqReferSaveList.value(i, "REFER_PERSON_ID", $opts.eq(i).data("values").PERSON_ID);
                }

                var prx = getProxy();

                if (prx == null) return;

                prx.data(o.ds.reqSaveInfo);
                prx.data(o.ds.reqProcSaveList);
                prx.data(o.ds.reqReferSaveList);

                prx.onSuccess = function()
                {
                    alert(any.message("application.common.approval.msg.apprReq.success", "결재상신이 성공적으로 수행되었습니다."));
                    any.location().reload();
                };

                prx.execute();
            });
        };

        func["CANCEL"] = function()
        {
            doCheck(function() {
                if (!confirm(any.message("application.common.approval.msg.apprCancel.confirm", "결재상신을 취소하시겠습니까?"))) return;

                var prx = getProxy();

                if (prx == null) return;

                prx.onSuccess = function()
                {
                    alert(any.message("application.common.approval.msg.apprCancel.success", "결재취소가 성공적으로 수행되었습니다."));
                    any.location().reload();
                };

                prx.execute();
            });
        };

        func["REWRITE"] = function()
        {
            doCheck(function() {
                if (!confirm(any.message("application.common.approval.msg.apprRewrite.confirm", "재작성 하시겠습니까?"))) return;

                var prx = getProxy();

                if (prx == null) return;

                prx.onSuccess = function()
                {
                    alert(any.message("application.common.approval.msg.apprRewrite.success", "재작성 처리가 성공적으로 수행되었습니다."));
                    any.location().reload();
                };

                prx.execute();
            });
        };

        func["APPROVE"] = function()
        {
            doCheck(function() {
                if (!confirm(any.message("application.common.approval.msg.apprApprove.confirm", "승인하시겠습니까?"))) return;

                var prx = getProxyProc();

                if (prx == null) return;

                prx.onSuccess = function()
                {
                    alert(any.message("application.common.approval.msg.apprApprove.success", "승인 처리가 성공적으로 수행되었습니다."));
                    any.location().reload();
                };

                prx.execute();
            });
        };

        func["AGREE"] = function()
        {
            doCheck(function() {
                if (!confirm(any.message("application.common.approval.msg.apprAgree.confirm", "합의하시겠습니까?"))) return;

                var prx = getProxyProc();

                if (prx == null) return;

                prx.onSuccess = function()
                {
                    alert(any.message("application.common.approval.msg.apprAgree.success", "합의 처리가 성공적으로 수행되었습니다."));
                    any.location().reload();
                };

                prx.execute();
            });
        };

        func["REJECT"] = function()
        {
            doCheck(function() {
                if (!confirm(any.message("application.common.approval.msg.apprReject.confirm", "반려하시겠습니까?"))) return;

                var prx = getProxyProc();

                if (prx == null) return;

                prx.onSuccess = function()
                {
                    alert(any.message("application.common.approval.msg.apprReject.success", "반려 처리가 성공적으로 수행되었습니다."));
                    any.location().reload();
                };

                prx.execute();
            });
        };

        func["UPPER"] = function()
        {
            if (o.$control.find('#any_upperProcPerson').val() == null) {
                alert(any.message("application.common.approval.msg.upperSelect", "상위결재자를 선택하세요."));
                o.$control.find('#any_upperProcPerson').exec("doSearch");
                return;
            }

            if (o.$control.find('#any_upperProcPerson').val() == o.loginPersonId) {
                alert(any.message("application.common.approval.msg.reqPersonAddNotAvail.upper", "결재요청자를 결재자로 지정할 수 없습니다.\n\n상위결재자를 다시 선택하세요."));
                o.$control.find('#any_upperProcPerson').exec("doSearch");
                return;
            }

            if (o.ds.procList.valueRow({ "APPR_REQ_ID":o.lastReqId, "PROC_PERSON":o.$control.find('#any_upperProcPerson').val() }) != -1) {
                alert(any.message("application.common.approval.msg.alreadyProcPerson.upper", "이미 처리한 결재자입니다.\n\n상위결재자를 다시 선택하세요."));
                o.$control.find('#any_upperProcPerson').exec("doSearch");
                return;
            }

            doCheck(function() {
                if (!confirm(any.message("application.common.approval.msg.upperRequest.confirm", "상위요청을 하시겠습니까?"))) return;

                o.ds.reqProcSaveList.init();
                o.ds.reqProcSaveList.addRow();
                o.ds.reqProcSaveList.value(0, "PROC_DEG", o.currValue.procDeg + 1);
                o.ds.reqProcSaveList.value(0, "PROC_DIV", "A");
                o.ds.reqProcSaveList.value(0, "PROC_PERSON_ID", o.$control.find('#any_upperProcPerson').val());

                var prx = getProxyProc();

                if (prx == null) return;

                prx.data(o.ds.reqProcSaveList);

                prx.onSuccess = function()
                {
                    alert(any.message("application.common.approval.msg.upperRequest.success", "상위요청이 성공적으로 수행되었습니다."));
                    any.location().reload();
                };

                prx.execute();
            });
        };

        if (func[apprEvent] == null) {
            alert(any.message("application.common.approval.msg.error.invalidRequest", "처리할 수 없는 요청입니다."));
        } else {
            func[apprEvent]();
        }

        function getProxy()
        {
            var prx = any.proxy(o.scope);
            prx.url("/common.approval.core.ApprovalCoreAct/execute");
            prx.param("APPR_CODE", o.apprCode);
            prx.param("BIZ_ID", o.bizId);
            prx.param("APPR_ID", o.ds.mainInfo.value(0, "APPR_ID"));
            prx.param("APPR_PROC_ID", o.currValue.apprProcId);
            prx.param("APPR_EVENT", apprEvent);
            prx.param("WF_ACTIVITY", o.wfActivity);
            prx.data(o.ds.configInfo);

            prx.onError = function()
            {
                this.error.show();

                reset();
            };

            return prx;
        }

        function getProxyProc()
        {
            o.ds.procSaveInfo.init();
            o.ds.procSaveInfo.addRow();
            o.ds.procSaveInfo.value(0, "PROC_STATUS", o.$control.find('#sel_procStatus').val());
            o.ds.procSaveInfo.value(0, "PROC_MEMO", o.$control.find('#txt_procMemo').val());

            var prx = getProxy();

            if (prx == null) return;

            prx.data(o.ds.procSaveInfo);

            return prx;
        }
    }
});
