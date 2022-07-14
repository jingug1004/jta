<%@page pageEncoding="UTF-8"%><% response.setContentType("text/x-component; charset=utf-8"); %>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out, true, false); %>
<PUBLIC:COMPONENT tagName="APPROVAL">
    <PUBLIC:DEFAULTS tabStop="true" viewInheritStyle="true" viewLinkContent="true" viewMasterTab="false" />
    <PUBLIC:ATTACH event="ondocumentready" onevent="document_onready();" />
    <PUBLIC:PROPERTY name="isReady" value="false" />
    <PUBLIC:PROPERTY name="code" />
    <PUBLIC:PROPERTY name="apprNo" get="getApprNo" />
    <PUBLIC:PROPERTY name="reqUser" />
    <PUBLIC:PROPERTY name="avail" get="getAvail" />
    <PUBLIC:PROPERTY name="check" put="setCheck" />
    <PUBLIC:PROPERTY name="showHideObjects" put="setShowHideObjects" />
    <PUBLIC:PROPERTY name="status" get="getStatus" />
    <PUBLIC:PROPERTY name="isPat" />
    <PUBLIC:METHOD name="reset" />
    <PUBLIC:METHOD name="addKey" />
    <PUBLIC:METHOD name="getHTML" />
    <PUBLIC:EVENT name="OnLoad" id="OnLoadEvent" />
    <PUBLIC:EVENT name="OnComplete" id="OnCompleteEvent" />
    <PUBLIC:EVENT name="OnSuccess" id="OnSuccessEvent" />
    <PUBLIC:EVENT name="OnFail" id="OnFailEvent" />
</PUBLIC:COMPONENT>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ANY>
<HEAD>
<META http-equiv="Content-Type" content="text/x-component; charset=utf-8">
<LINK rel="StyleSheet" type="text/css" href="<%= request.getContextPath() %>/anyfive/framework/css/style.css">
<LINK rel="StyleSheet" type="text/css" href="<%= request.getContextPath() %>/anyfive/framework/htc/anyworks.jsp">
<LINK rel="StyleSheet" type="text/css" href="<%= request.getContextPath() %>/anyfive/ipims/patent/common/htc/common.jsp">
<SCRIPT language="JScript" src="<%= request.getContextPath() %>/anyfive/framework/js/anyworks.js" charset="utf-8"></SCRIPT>
<ANY:DS id="ds_apprKey" />
<ANY:DS id="ds_apprMain" />
<ANY:DS id="ds_apprMgt" />
<ANY:DS id="ds_apprMst" />
<ANY:DS id="ds_apprHist" />
<ANY:DS id="ds_apprReq" />
<ANY:DS id="ds_apprAnsA" />
<ANY:DS id="ds_apprAnsB" />
<ANY:DS id="ds_apprReqSave" />
<ANY:DS id="ds_apprAnsSave" />
<ANY:DS id="ds_apprAnsUserA" />
<ANY:DS id="ds_apprAnsUserB" />
<SCRIPT language="JScript">
var gCheck;
var gShowHideObjects;

var gApprStatus;
var gLoginUserId;
var gCurrValue;

var gScrollToBottom;

function document_onready()
{
    element.isReady = true;
}

function getApprNo()
{
    return ds_apprMain.value(0, "APPR_NO");
}

function getAvail()
{
    for (var i = 0; i < arguments.length; i++) {
        if (getValue(arguments[i]) == true) return true;
    }

    return false;

    function getValue(apprEvent)
    {
        switch (apprEvent) {
        case "NONE": //결재없음
            var rtnStatus = false;
            if(element.code == "P01" || element.code == "D01" || element.code == "T01"){
                rtnStatus = (gApprStatus == "0" || ds_apprMain.value(0, "WP_REQ_AVAIL") == "1") && ds_apprMgt.value(0, "APPR_NONE_AVAIL_YN") == "1" && isPat == "true";
            }else{
                rtnStatus = (gApprStatus == "0" || ds_apprMain.value(0, "WP_REQ_AVAIL") == "1") && ds_apprMgt.value(0, "APPR_NONE_AVAIL_YN") == "1";
            }
            return rtnStatus;
        case "REQUEST": //결재요청
            return (gApprStatus == "0" || ds_apprMain.value(0, "WP_REQ_AVAIL") == "1");
        case "CANCEL": //결재취소
            return gApprStatus == "1" && ds_apprMgt.value(0, "APPR_CANCEL_AVAIL_YN") == "1" && ds_apprMst.value(0, "LAST_ANS_CNT") == "0";
        case "AGREE": //승인
        case "REJECT": //반려
            return gApprStatus == "1";
        case "UPPER": //상위요청
            return gApprStatus == "1" && ds_apprMgt.value(0, "UPPER_REQ_AVAIL_YN") == "1";
        case "REWRITE": //재작성
            return gApprStatus == "9";
        }
    }
}

function setCheck(apprEvent, checkFunc)
{
    gCheck[apprEvent] = checkFunc;
}

function setShowHideObjects(arr)
{
    gShowHideObjects = arr;
}

function setShowHideObjectsDisplay()
{
    if (gShowHideObjects == null) return;

    var disp = (element.reqUser == gLoginUserId && getAvail("REQUEST") == true ? "" : "none");
    var obj;

    for (var i = 0; i < gShowHideObjects.length; i++) {
        obj = element.document.getElementById(gShowHideObjects[i]);
        if (obj == null) continue;
        if (obj.tagName == "BUTTON") {
            obj.display = disp;
        } else {
            obj.style.display = disp;
        }
    }
}

function getStatus()
{
    return gApprStatus;
}

function reset(fireEvent)
{
    var ds = document.getElementsByTagName("DS");

    for (var i = 0; i < ds.length; i++) {
        ds[i].init();
    }

    ds_apprKey.init();
    ds_apprKey.addRow();

    gCheck = new Object();

    gCurrValue = new Object();

    div_history.innerHTML = '';
    div_history.style.display = "none";

    div_request.style.display = "none";

    div_button.innerHTML = '';
    div_button.style.display = "none";

    div_patch.style.display = "none";

    for (var i = 0, elements = element.getElementsByTagName("*"); i < elements.length; i++) {
        if (elements[i].tagName == "SCRIPT" || elements[i].tagName == "COMMENT") eval(elements[i].text);
    }

    retrieveApproval(fireEvent);
}

function addKey(name, value)
{
    ds_apprKey.value(0, name) = value;
}

function getHTML()
{
    return document.body.innerHTML;
}

function retrieveApproval(fireEvent)
{
    if (ds_apprKey.colCount == 0) {
        alert("결재키가 정의되지 않았습니다.");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.common.approval.act.RetrieveApproval.do";
    prx.addParam("APPR_CODE", element.code);
    prx.addData("ds_apprKey");

    prx.onSuccess = function()
    {
        gApprStatus = ds_apprMst.value(0, "APPR_STATUS");
        gLoginUserId = ds_apprMgt.value(0, "LOGIN_USER_ID");

        if (gApprStatus == null || gApprStatus == "") gApprStatus = "0";

        if (ds_apprReq.rowCount > 0) {
            gCurrValue.reqSeq = ds_apprReq.value(ds_apprReq.rowCount - 1, "REQ_SEQ");
        }

        makeHTML();

        if (gScrollToBottom == true) {
            cfSetScrollBottom();
        }

        setShowHideObjectsDisplay();

        OnLoadEvent.fire(element.document.createEventObject());

        if (fireEvent == true) {
            OnCompleteEvent.fire(element.document.createEventObject());
            OnSuccessEvent.fire(element.document.createEventObject());
        }
    }

    prx.onFail = function()
    {
        this.error.show();

        if (fireEvent == true) {
            OnCompleteEvent.fire(element.document.createEventObject());
            OnFailEvent.fire(element.document.createEventObject());
        }
    }

    prx.execute();
}

function makeHTML()
{
    var html;
    var ctrl;

    var titleDivs = document.getElementsByName("div_approval_title");
    var tbds = document.getElementsByName("tbd_approval");
    var tbd, tr, td;

    html = new Array();

    for (var r = 0; r < ds_apprReq.rowCount; r++) {
        html.push(cmt_history.text);
    }

    if (html.length > 0) {
        div_history.innerHTML = html.join("\n");
        div_history.style.display = "";
    }

    for (var r = 0; r < ds_apprReq.rowCount; r++) {
        titleDivs[r].innerText = ds_apprMgt.value(0, "APPR_NAME") + " 결재현황" + (titleDivs.length == 1 ? "" : " " + (r + 1));

        tbd = tbds[0];

        tbd.id = "tbd_appr_" + ds_apprReq.value(r, "REQ_SEQ");
        tbd.reqRow = r;

        tr = document.createElement('<TR>');
        tbd.appendChild(tr);

        td = document.createElement('<TD class="listhead">');
        td.innerHTML = '요청자';
        tr.appendChild(td);

        td = document.createElement('<TD class="listdata">');
        td.innerHTML = ds_apprReq.value(r, "REQ_USER_NAME");
        td.title = ds_apprReq.value(r, "REQ_USER_NAME") + " / " + ds_apprReq.value(r, "REQ_USER_DEPT_NAME");
        td.style.cursor = "default";
        tr.appendChild(td);

        td = document.createElement('<TD class="listdata" align="center">');
        td.innerHTML = (ds_apprReq.value(r, "REQ_STATUS") == "7" ? '[결재없음]' : '[결재요청]');
        tr.appendChild(td);

        td = document.createElement('<TD class="listdata" align="center" noWrap>');
        td.innerHTML = cfGetFormatDate(ds_apprReq.value(r, "REQ_DATE"));
        tr.appendChild(td);

        td = document.createElement('<TD class="listdata">');
        td.innerHTML = ds_apprReq.value(r, "REQ_MEMO");
        tr.appendChild(td);

        if (ds_apprReq.value(r, "REQ_STATUS") != "7") continue;

        tr = document.createElement('<TR>');
        tbd.appendChild(tr);

        td = document.createElement('<TD class="listdata">');
        td.align = "center";
        td.style.color = "blue";
        td.colSpan = 5;
        td.innerHTML = '(결재없이 처리되었습니다)';
        tr.appendChild(td);
    }

    for (var r = 0; r < ds_apprAnsA.rowCount; r++) {
        tbd = document.getElementById("tbd_appr_" + ds_apprAnsA.value(r, "REQ_SEQ"));

        if (getAvail("AGREE", "REJECT", "UPPER") == true && ds_apprAnsA.value(r, "REQ_SEQ") == gCurrValue.reqSeq && ds_apprAnsA.value(r, "ANS_STATUS") == "1" && ds_apprAnsA.value(r, "ANS_USER") == gLoginUserId) {
            gCurrValue.ansOrd = ds_apprAnsA.value(r, "ANS_ORD");
        }

        tr = document.createElement('<TR>');
        tbd.appendChild(tr);

        td = document.createElement('<TD class="listhead">');
        td.innerHTML = ds_apprAnsA.value(r, "ANS_ORD") + '차 결재자';
        tr.appendChild(td);

        td = document.createElement('<TD class="listdata">');
        td.innerHTML = ds_apprAnsA.value(r, "ANS_USER_NAME");
        td.title = ds_apprAnsA.value(r, "ANS_USER_NAME") + " / " + ds_apprAnsA.value(r, "ANS_USER_DEPT_NAME");
        td.style.cursor = "default";
        tr.appendChild(td);

        td = document.createElement('<TD class="listdata" align="center">');
        if (ds_apprAnsA.value(r, "ANS_ORD") == gCurrValue.ansOrd) {
            html = new Array();
            html.push('<SELECT id="sel_ansStatus">');
            html.push('    <OPTION>');
            if (getAvail("AGREE") == true) html.push('    <OPTION apprEvent="AGREE" value="8" style="color:blue;">승인');
            if (getAvail("REJECT") == true) html.push('    <OPTION apprEvent="REJECT" value="9" style="color:red;">반려');
            if (getAvail("UPPER") == true && r == ds_apprAnsA.rowCount - 1)  {
                html.push('    <OPTION apprEvent="UPPER" value="7" style="color:blue;">상위요청');
            }
            html.push('</SELECT>');
            td.innerHTML = html.join("\n");
            createButton("결재처리", function() { doEvent(
                function() {
                    var apprEvent = sel_ansStatus.options[sel_ansStatus.selectedIndex].apprEvent;
                    if (apprEvent == null) {
                        alert("결재상태를 선택하세요.");
                        sel_ansStatus.focus();
                        return null;
                    }
                    return apprEvent;
                }());
            });
        } else {
            html = new Array();
            switch (Number(ds_apprAnsA.value(r, "ANS_STATUS"))) {
                case 0: html.push(ds_apprReq.value(tbd.reqRow, "REQ_STATUS") == "9" ? '-' : '[대기중]'); td.disabled = true; break;
                case 1: html.push('[결재중]'); td.disabled = true; break;
                case 7: html.push('[상위요청]'); td.style.color = "blue"; break;
                case 8: html.push('[승인]'); td.style.color = "blue"; break;
                case 9: html.push('[반려]'); td.style.color = "red"; break;
            }
            td.innerHTML = html.join("\n");
        }
        tr.appendChild(td);

        td = document.createElement('<TD class="listdata" align="center" noWrap>');
        if (ds_apprAnsA.value(r, "ANS_ORD") == gCurrValue.ansOrd) {
            td.innerHTML = cfGetSysDate();
        } else if (ds_apprAnsA.value(r, "ANS_STATUS") == "0" || ds_apprAnsA.value(r, "ANS_STATUS") == "1") {
            td.disabled = true;
            td.innerHTML = '-';
        } else {
            td.innerHTML = cfGetFormatDate(ds_apprAnsA.value(r, "ANS_DATE"));
        }
        tr.appendChild(td);

        td = document.createElement('<TD class="listdata">');
        if (ds_apprAnsA.value(r, "ANS_ORD") == gCurrValue.ansOrd) {
            td.innerHTML = '<INPUT type="text" id="txt_ansMemo" class="text" maxByte="500">';
        } else if (ds_apprAnsA.value(r, "ANS_STATUS") == "0" || ds_apprAnsA.value(r, "ANS_STATUS") == "1") {
            td.align = "center";
            td.disabled = true;
            td.innerHTML = '-';
        } else {
            td.innerHTML = ds_apprAnsA.value(r, "ANS_MEMO");
        }
        tr.appendChild(td);
    }

    if (getAvail("UPPER") == true) {
        tr = document.createElement('<TR id="tr_upperAnsUser" style="display:none;">');
        tbd.appendChild(tr);

        td = document.createElement('<TD class="listhead">');
        td.innerHTML = (Number(ds_apprAnsA.value(ds_apprAnsA.rowCount - 1, "ANS_ORD")) + 1) + '차 결재자';
        tr.appendChild(td);

        td = document.createElement('<TD class="listdata>');
        td.colSpan = 3;
        td.innerHTML = '<ANY:SEARCH id="any_upperAnsUser" mode="C" />';
        tr.appendChild(td);

        td = document.createElement('<TD class="listdata>');
        td.align = "center";
        td.disabled = true;
        td.innerHTML = '-';
        tr.appendChild(td);
    }

    var distUserObj = new Object();
    var reqSeq;

    for (var r = 0; r < ds_apprAnsB.rowCount; r++) {
        reqSeq = ds_apprAnsB.value(r, "REQ_SEQ");
        if (distUserObj[reqSeq] == null) distUserObj[reqSeq] = { seq:reqSeq, arr:[] };
        ctrl = document.createElement('<SPAN>');
        ctrl.innerText = ds_apprAnsB.value(r, "DIST_USER_NAME");
        ctrl.title = ds_apprAnsB.value(r, "DIST_USER_NAME") + ' / ' + ds_apprAnsB.value(r, "DIST_USER_DEPT_NAME");
        distUserObj[reqSeq].arr.push(ctrl.outerHTML);
        ctrl = null;
    }

    for (var item in distUserObj) {
        tbd = document.getElementById("tbd_appr_" + distUserObj[item].seq);

        tr = document.createElement('<TR>');
        tbd.appendChild(tr);

        td = document.createElement('<TD class="listhead">');
        td.innerHTML = '배포자';
        tr.appendChild(td);

        td = document.createElement('<TD class="listdata" colspan="4">');
        td.innerHTML = distUserObj[item].arr.join(",\n");
        td.style.cursor = "default";
        tr.appendChild(td);
    }

    if (element.reqUser == gLoginUserId) {
        if (getAvail("NONE", "REQUEST")) {
            spn_reqUserName.innerText = "<%= app.userInfo.getEmpHname() %>(<%= app.userInfo.getEmpNo() %>)";
            div_request_title.innerText = ds_apprMgt.value(0, "APPR_NAME") + " 결재요청";
            div_request.style.display = "";
        }
        if (getAvail("NONE"))    createButton("결재없음", function() { doEvent("NONE"); });
        if (getAvail("REQUEST")) createButton("결재요청", function() { doEvent("REQUEST"); });
        if (getAvail("CANCEL"))  createButton("결재취소", function() { doEvent("CANCEL"); });
        if (getAvail("REWRITE")) createButton("재작성"  , function() { doEvent("REWRITE"); });
    }

    if (div_history.innerHTML != '' || div_request.style.display != "none") {
        div_patch.style.display = "block";
    }
}

function createButton(txt, act)
{
    var btn = document.createElement('<BUTTON>');
    div_button.appendChild(btn);
    div_button.style.display = "";
    btn.text = txt;
    btn.onclick = act;
}

function getAnsUserType()
{
    if (rdo_ansTypeA.checked == true) return "A";
    if (rdo_ansTypeB.checked == true) return "B";
    rdo_ansTypeA.checked = true;
    return getAnsUserType();
}

function getAnsUserList()
{
    return document.getElementById("sel_ansUserList" + getAnsUserType());
}

function searchAnsUser()
{
    var ps = new cfPopupSearch();
    ps.prx.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrieveUserSearchList.do";
    ps.win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/UserSearchListR.jsp";
    ps.win.opt.width = 700;
    ps.win.opt.height = 500;
    ps.searchText = txt_ansUserSearch;
    ps.resultFunc = addAnsUser;
    ps.multiCheck = true;
    ps.closePopup = true;
    ps.search();
}

function addAnsUser(obj)
{
    if (getAnsUserType() == "A" && obj.USER_ID == element.reqUser) {
        alert("결재요청자를 결재자로 지정할 수 없습니다.");
        return;
    }

    for (var i = 0; i < getAnsUserList().options.length; i++) {
        if (getAnsUserList().options[i].values.USER_ID == obj.USER_ID) return "exists";
    }

    var opt = new Option();

    opt.values = new Object();
    for (var item in obj) {
        opt.values[item] = obj[item];
    }

    getAnsUserList().add(opt);
    setAnsUserText(opt);
}

function setAnsUserText(opt)
{
    var empNo = opt.values.EMP_NO;
    var empHname = opt.values.EMP_HNAME;
    var deptName = opt.values.DEPT_NAME;

    if (empNo == null) empNo = "";
    if (empHname == null) empHname = "";
    if (deptName == null) deptName = "";

    if (opt.parentElement.ansType == "A") {
        opt.text = (opt.index + 1) + "차 결재자 : " + empHname + "(" + empNo + ") / " + deptName;
    } else {
        opt.text = "배포자 " + (opt.index + 1) + " : " + empHname + "(" + empNo + ") / " + deptName;
    }
}

function deleteAnsUser()
{
    while (getAnsUserList().options.selectedIndex >= 0) {
        getAnsUserList().options[getAnsUserList().options.selectedIndex] = null;
    }

    for (var i = 0; i < getAnsUserList().options.length; i++) {
        setAnsUserText(getAnsUserList().options[i]);
    }
}

function moveAnsUser(dir)
{
    var selArray = new Array();

    if (getAnsUserList().options.length == 0) return;
    if (dir == -1 && getAnsUserList().options[0].selected == true) return;
    if (dir == 1 && getAnsUserList().options[getAnsUserList().options.length - 1].selected == true) return;

    if (dir == -1) {
        for (var i = 0; i < getAnsUserList().options.length; i++) {
            if (getAnsUserList().options[i].selected == false) continue;
            move(dir, i);
            selArray.push(i + dir);
        }
    } else {
        for (var i = getAnsUserList().options.length - 1; i >= 0; i--) {
            if (getAnsUserList().options[i].selected == false) continue;
            move(dir, i);
            selArray.push(i + dir);
        }
    }

    for (var i = 0; i < selArray.length; i++) {
        getAnsUserList().options[selArray[i]].selected = true;
    }

    function move(dir, i)
    {
        var optSource;
        var optTarget;
        var tmp = new Object();

        optSource = getAnsUserList().options[i];
        optTarget = getAnsUserList().options[i + dir];

        for (var item in optTarget.values) {
            tmp[item] = optTarget.values[item];
        }

        for (var item in optSource.values) {
            optTarget.values[item] = optSource.values[item];
        }

        for (var item in tmp) {
            optSource.values[item] = tmp[item];
        }

        setAnsUserText(optSource);
        setAnsUserText(optTarget);

        getAnsUserList().options[i].selected = false;
    }
}

function doEvent(apprEvent)
{
    if (ds_apprKey.colCount == 0) {
        alert("결재키가 정의되지 않았습니다.");
        return;
    }

    if (apprEvent == null) return;

    function doCheck()
    {
        if (gCheck[apprEvent] == null) return true;

        return gCheck[apprEvent]();
    }

    func = new Object();

    func["NONE"] = function()
    {
        if (!doCheck()) return;

        if (!confirm("결재없음으로 처리하시겠습니까?\n\n(입력된 결재자는 무시됩니다)")) return;

        ds_apprReqSave.init();
        ds_apprReqSave.addRow();
        ds_apprReqSave.value(0, "REQ_MEMO") = txt_reqMemo.value;
        ds_apprReqSave.value(0, "REQ_STATUS") = "7";

        var prx = getProxy();

        if (prx == null) return;

        prx.addData("ds_apprReqSave");

        prx.onSuccess = function()
        {
            reset(true);
            alert("결재없음 처리가 성공적으로 수행되었습니다.");
        }

        prx.execute();
    }

    func["REQUEST"] = function()
    {
        if (sel_ansUserListA.options.length == 0) {
            alert("결재자를 1명 이상 입력하세요.");
            rdo_ansTypeA.checked = true;
            txt_ansUserSearch.focus();
            return;
        }

        if (!doCheck()) return;

        if (!confirm("결재요청을 하시겠습니까?")) return;

        ds_apprReqSave.init();
        ds_apprReqSave.addRow();
        ds_apprReqSave.value(0, "REQ_MEMO") = txt_reqMemo.value;
        ds_apprReqSave.value(0, "REQ_STATUS") = "1";

        ds_apprAnsUserA.init();
        for (var r = 0; r < sel_ansUserListA.options.length; r++) {
            ds_apprAnsUserA.addRow();
            ds_apprAnsUserA.value(r, "ANS_ORD") = r + 1;
            ds_apprAnsUserA.value(r, "ANS_USER") = sel_ansUserListA.options[r].values.USER_ID;
        }

        ds_apprAnsUserB.init();
        for (var r = 0; r < sel_ansUserListB.options.length; r++) {
            ds_apprAnsUserB.addRow();
            ds_apprAnsUserB.value(r, "DIST_USER") = sel_ansUserListB.options[r].values.USER_ID;
        }

        var prx = getProxy();

        if (prx == null) return;

        prx.addData("ds_apprReqSave");
        prx.addData("ds_apprAnsUserA");
        prx.addData("ds_apprAnsUserB");

        prx.onSuccess = function()
        {
            reset(true);
            alert("결재요청이 성공적으로 수행되었습니다.");
        }

        prx.execute();
    }

    func["CANCEL"] = function()
    {
        if (!doCheck()) return;

        if (!confirm("결재요청을 취소하시겠습니까?")) return;

        var prx = getProxy();

        if (prx == null) return;

        prx.onSuccess = function()
        {
            reset(true);
            alert("결재취소가 성공적으로 수행되었습니다.");
        }

        prx.execute();
    }

    func["REWRITE"] = function()
    {
        if (!doCheck()) return;

        if (!confirm("재작성 하시겠습니까?")) return;

        var prx = getProxy();

        if (prx == null) return;

        prx.onSuccess = function()
        {
            reset(true);
            alert("재작성 처리가 성공적으로 수행되었습니다.");
        }

        prx.execute();
    }

    func["AGREE"] = function()
    {
        if (!doCheck()) return;

        if (!confirm("결재요청을 승인하시겠습니까?")) return;

        var prx = getProxyAns();

        if (prx == null) return;

        prx.onSuccess = function()
        {
            reset(true);
            alert("승인 처리가 성공적으로 수행되었습니다.");
        }

        prx.execute();
    }

    func["REJECT"] = function()
    {
        if (!doCheck()) return;

        if (!confirm("결재요청을 반려하시겠습니까?")) return;

        var prx = getProxyAns();

        if (prx == null) return;

        prx.onSuccess = function()
        {
            reset(true);
            alert("반려 처리가 성공적으로 수행되었습니다.");
        }

        prx.execute();
    }

    func["UPPER"] = function()
    {
        if (any_upperAnsUser.value == "") {
            alert("상위결재자를 선택하세요.");
            any_upperAnsUser.doSearch();
            return;
        }

        if (any_upperAnsUser.value == element.reqUser) {
            alert("결재요청자를 결재자로 지정할 수 없습니다.\n\n상위결재자를 다시 선택하세요.");
            any_upperAnsUser.doSearch();
            return;
        }

        if (ds_apprAnsA.valueRow(["REQ_SEQ", gCurrValue.reqSeq], ["ANS_USER", any_upperAnsUser.value]) != -1) {
            alert("이미 처리한 결재자입니다.\n\n상위결재자를 다시 선택하세요.");
            any_upperAnsUser.doSearch();
            return;
        }

        if (!doCheck()) return;

        if (!confirm("상위요청을 하시겠습니까?")) return;

        ds_apprAnsUserA.init();
        ds_apprAnsUserA.addRow();
        ds_apprAnsUserA.value(0, "ANS_ORD") = Number(gCurrValue.ansOrd) + 1;
        ds_apprAnsUserA.value(0, "ANS_USER") = any_upperAnsUser.value;

        var prx = getProxyAns();

        if (prx == null) return;

        prx.addData("ds_apprAnsUserA");

        prx.onSuccess = function()
        {
            reset(true);
            alert("상위요청이 성공적으로 수행되었습니다.");
        }

        prx.execute();
    }

    if (func[apprEvent] == null) {
        alert("처리할 수 없는 요청입니다.");
    } else {
        func[apprEvent]();
    }

    function getProxy()
    {
        gScrollToBottom = true;

        var prx = new any.proxy();
        prx.path = top.getRoot() + "/anyfive.ipims.patent.common.approval.act.ExecuteApproval.do";
        prx.addParam("APPR_CODE", element.code);
        prx.addParam("APPR_NO", ds_apprMain.value(0, "APPR_NO"));
        prx.addParam("REF_NO", ds_mainInfo.value(0, "REF_NO" ));
        if (gCurrValue.reqSeq != null) {
            prx.addParam("REQ_SEQ", gCurrValue.reqSeq);
        }
        if (gCurrValue.ansOrd != null) {
            prx.addParam("ANS_ORD", gCurrValue.ansOrd);
        }
        prx.addParam("APPR_EVENT", apprEvent);
        prx.addData("ds_apprKey");
        prx.addData("ds_apprMgt");

        prx.onFail = function()
        {
            this.error.show();

            reset();
        }

        return prx;
    }

    function getProxyAns()
    {
        ds_apprAnsSave.init();
        ds_apprAnsSave.addRow();
        ds_apprAnsSave.value(0, "ANS_STATUS") = sel_ansStatus.value;
        ds_apprAnsSave.value(0, "ANS_MEMO") = txt_ansMemo.value;

        var prx = getProxy();

        if (prx == null) return;

        prx.addData("ds_apprAnsSave");

        return prx;
    }
}

function openIEBugPatch()
{
    var width = 450;
    var height = 180;

    if (navigator.appVersion.indexOf("MSIE 7") == -1) {
        width  += 6;
        height += 52;
    }

    window.showModalDialog(top.getRoot() + "/anyfive/ipims/share/patch/IEBugPatch.jsp", null, "center:yes;dialogWidth:" + width + "px;dialogHeight:" + height + "px;");
}
</SCRIPT>

<!-- 결재상태 변경시 -->
<SCRIPT language="JScript" for="sel_ansStatus" event="onchange()">
    if (sel_ansStatus.value == "7") {
        any_upperAnsUser.win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/UserSearchListR.jsp";
        any_upperAnsUser.codeColumn = "USER_ID";
        any_upperAnsUser.nameExpr = "{#EMP_HNAME}({#EMP_CNAME}) / {#DEPT_NAME}";
        tr_upperAnsUser.style.display = "block";
        cfSetScrollBottom();
        if (any_upperAnsUser.value == "") {
            any_upperAnsUser.doSearch();
        }
    } else {
        if (document.getElementById("tr_upperAnsUser") != null) {
            tr_upperAnsUser.style.display = "none";
        }
        txt_ansMemo.focus();
    }
</SCRIPT>
</HEAD>

<BODY>

<COMMENT id="cmt_history">
<DIV id="div_approval_title" class="title_sub"></DIV>
<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <TR>
        <TD class="listhead" width="15%">구분</TD>
        <TD class="listhead" width="15%">이름</TD>
        <TD class="listhead" width="10%">상태</TD>
        <TD class="listhead" width="10%">일자</TD>
        <TD class="listhead" width="50%">메모</TD>
    </TR>
    <TBODY id="tbd_approval"></TBODY>
</TABLE>
</COMMENT>

<DIV id="div_history" style="display:none;"></DIV>

<DIV id="div_request" style="display:none;">
<DIV id="div_request_title" class="title_sub"></DIV>
<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD>요청자</TD>
        <TD><SPAN id="spn_reqUserName"></SPAN></TD>
        <TD>요청메모</TD>
        <TD><INPUT type="text" id="txt_reqMemo" class="text" maxByte="500"></TD>
    </TR>
    <TR>
        <TD>결재자</TD>
        <TD colspan="3">
            <TABLE border="0" cellpadding="0" cellspacing="0" width="100%">
                <TR>
                    <TD noWrap>
                        <LABEL for="rdo_ansTypeA" style="cursor:hand;">
                            <INPUT type="radio" name="rdo_ansType" id="rdo_ansTypeA" onFocus="this.blur(); txt_ansUserSearch.focus(); txt_ansUserSearch.select();" checked>결재자
                        </LABEL>
                        <LABEL for="rdo_ansTypeB" style="cursor:hand;">
                            <INPUT type="radio" name="rdo_ansType" id="rdo_ansTypeB" onFocus="this.blur(); txt_ansUserSearch.focus(); txt_ansUserSearch.select();">배포자
                        </LABEL>
                    </TD>
                    <TD width="100%" style="padding-left:5px;">
                        <INPUT type="text" id="txt_ansUserSearch" class="text" onKeyPress="javascript:if (event.keyCode == 13) { event.keyCode = 0; searchAnsUser(); }">
                    </TD>
                    <TD noWrap>
                        <BUTTON text="추가" onClick="javascript:searchAnsUser();"></BUTTON>
                        <BUTTON text="삭제" onClick="javascript:deleteAnsUser();"></BUTTON>
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON text="▲" onClick="javascript:moveAnsUser(-1);"></BUTTON>
                        <BUTTON text="▼" onClick="javascript:moveAnsUser(1);"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
            <TABLE border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:1px;">
                <TR>
                    <TD width="50%"><SELECT id="sel_ansUserListA" multiple size="4" ansType="A" style="width:100%;" onClick="rdo_ansTypeA.checked = true;"></SELECT></TD>
                    <TD width="50%"><SELECT id="sel_ansUserListB" multiple size="4" ansType="B" style="width:100%;" onClick="rdo_ansTypeB.checked = true;"></SELECT></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>
</DIV>

<DIV id="div_button" class="button_area" style="display:none;"></DIV>

<DIV id="div_patch" style="text-align:right; margin-top:5px; width:100%; display:none;">
※
<SPAN style="cursor:hand;" onMouseOver="this.style.textDecoration='underline';" onMouseOut="this.style.textDecoration='none';" onClick="javascript:openIEBugPatch();">
결재내용이 복사 또는 붙여넣기가 작동되지 않는 경우 클릭하세요.
</SPAN>
</DIV>

</BODY>
</HTML>
