<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out, true, false); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>패밀리구조도</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainList" />
<ANY:DS id="ds_linkList" />
<ANY:DS id="ds_flowList" />
<ANY:DS id="ds_tooltipInfo" />
<SCRIPT language="JScript">
var gMousePos = { x:0, y:0 };
var gPopupPos = { x:0, y:0 };

var gPopup;

//윈도우 로딩시
window.onready = function()
{
    usr_flow.MonthWidth = usr_flow.DEFAULT_MONTH_WIDTH = 15;

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.family.act.RetrieveFamilyList.do";
    prx.addParam("REF_ID", parent.REF_ID);

    prx.onSuccess = function()
    {
        fnDrawFamily();
        fnRetrieveFlowList();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//패밀리구조도 그리기
function fnDrawFamily()
{
    var linkTypes = new Array();
    var statTypes = new Array();

    linkTypes.push({ code:"A", name:"CPA" });
    linkTypes.push({ code:"C", name:"CA" });
    linkTypes.push({ code:"D", name:"분할" });
    linkTypes.push({ code:"P", name:"CIP" });
    linkTypes.push({ code:"R", name:"RCE" });
    linkTypes.push({ code:"RE", name:"ReExamination" });
    linkTypes.push({ code:"RS", name:"ReIssue" });
    linkTypes.push({ code:"U", name:"실용실안" });
    linkTypes.push({ code:"E", name:"국내진입" });
    linkTypes.push({ code:"G", name:"그룹" });
    linkTypes.push({ code:"N", name:"통합" });
    linkTypes.push({ code:"PR", name:"우선권" });
    linkTypes.push({ code:"O", name:"해외출원" });

    statTypes.push({ code:"0", name:"참조" });
    statTypes.push({ code:"1", name:"검토/준비" });
    statTypes.push({ code:"2", name:"출원" });
    statTypes.push({ code:"3", name:"등록" });
    statTypes.push({ code:"4", name:"포기" });
    statTypes.push({ code:"5", name:"OA" });

    for (var i = 0; i < linkTypes.length; i++) {
        vbSetFamilyLinkStyle(linkTypes[i].code, linkTypes[i].name);
    }

    for (var i = 0; i < statTypes.length; i++) {
        vbSetFamilyStatusStyle(statTypes[i].code, statTypes[i].name);
    }

    vbSetFamilyCaptionStyle();

    fnSetMainList();
    fnSetLinkList();

    usr_family.SetGap(130, 50);
    usr_family.SetData();

    usr_family.LinkCaptionDisplay = chk_linkCaption.checked;
    usr_family.DrawMap();
}

//패밀리 메인 목록 표시
function fnSetMainList()
{
    var ds = ds_mainList;
    var status;

    for (var r = 0; r < ds.rowCount; r++) {
        if (ds.value(r, "SECTION_TYPE") == "2") {
            status = "0";
        } else if (ds.value(r, "ABD_DATE") != "") {
            status = "4";
        } else if (ds.value(r, "REG_DATE") != "") {
            status = "3";
        } else if (ds.value(r, "APP_DATE") != "") {
            status = "2";
        } else {
            status = "1";
        }

        usr_family.AddEntity(ds.value(r, "KEY_VALUE"), ds.value(r, "CAPTION"), status, ds.value(r, "SECTION_TYPE"), ds.value(r, "BIGO"));
    }
}

//패밀리 링크 목록 표시
function fnSetLinkList()
{
    var ds = ds_linkList;

    for (var r = 0; r < ds.rowCount; r++) {
        usr_family.AddLink(r, ds.value(r, "CAPTION"), ds.value(r, "SOUR"), ds.value(r, "DEST"), ds.value(r, "RELATION"), ds.value(r, "BIGO"));
    }
}

//툴팁 상세정보 조회
function fnRetrieveTooltipDetail(key)
{
    gPopupPos = { x:gMousePos.x + 2, y:gMousePos.y + 2};

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.family.act.RetrieveFamilyTooltip.do";
    prx.addParam("REF_ID", key);
    prx.hideMessage = true;

    prx.onStart = function()
    {
        gPopup = window.createPopup();
        gPopup.show(gPopupPos.x, gPopupPos.y, 350, 250, document.body);
    }

    prx.onSuccess = function()
    {
        fnShowTooltip();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//툴팁 표시
function fnShowTooltip()
{
    var ds = ds_tooltipInfo;
    var html = new Array();

    html.push('<DIV style="overflow:auto; width:100%; height:100%; padding:3px;">');
    html.push('<TABLE border="0" cellspacing="0" cellpadding="1">');
    html.push(' <COLGROUP>');
    html.push('     <COL style="vertical-align:top; text-align:right;">');
    html.push('     <COL style="vertical-align:top; padding-left:2px; padding-right:2px;">');
    html.push('     <COL style="vertical-align:top;">');
    html.push(' </COLGROUP>');

    if (ds.value(0, "INOUT_DIV") == "EXT") {
        addInfo("그룹번호"     , '<B>' + ds.value(0, "INFO_NO") + '</B>');
    } else {
        addInfo("REF-NO"       , '<B>' + ds.value(0, "INFO_NO") + '</B>');
    }

    addInfo("발명의 명칭"  , ds.value(0, "KO_APP_TITLE"));
    addInfo("출원국가"     , ds.value(0, "COUNTRY_NAME"));
    addInfo("출원번호"     , ds.value(0, "APP_NO"));
    addInfo("출원일자"     , cfGetFormatDate(ds.value(0, "APP_DATE")));
    addInfo("건담당자"     , ds.value(0, "JOB_MAN_NAME"));
    addInfo("국내사무소"   , ds.value(0, "OFFICE_NAME"));
    addInfo("사무소REF"    , ds.value(0, "OFFICE_REF_NO"));
    addInfo("사무소담당자" , ds.value(0, "OFFICE_JOB_MAN_NAME"));

    html.push('</TABLE>');
    html.push('</DIV>');

    gPopup.document.createStyleSheet(top.getRoot() + "/anyfive/framework/css/style.css");
    gPopup.document.body.style.backgroundColor = "#FFFFE1";
    gPopup.document.body.style.font = "10pt Tahoma";
    gPopup.document.body.style.color = "#575757";
    gPopup.document.body.style.border = "#000000 1px solid";
    gPopup.document.body.style.verticalAlign = "top";
    gPopup.document.body.style.cursor = "default";
    gPopup.document.body.innerHTML = html.join("\n");

    function addInfo(name, value)
    {
        html.push(' <TR>');
        html.push('     <TD noWrap>' + name + '</TD>');
        html.push('     <TD>:</TD>');
        html.push('     <TD>' + value + '</TD>');
        html.push(' </TR>');
    }
}

//상세화면 팝업
function fnOpenDetail(key)
{
    var mainRow = ds_mainList.valueRow(["KEY_VALUE", key]);

    if (mainRow == -1) return;

    var tabId = ds_mainList.value(mainRow, "TABID");

    if (!(tabId == "1" || tabId == "3")) return;

    window.open(top.getRoot() + "/anyfive/ipims/patent/applymgt/common/MasterView.jsp?ID=" + key, "_blank", "width=1000,height=800,resizable=yes");

    if (gPopup != null) gPopup.hide();
}

//업무흐름도 목록 조회
function fnRetrieveFlowList(key)
{
    if (key == null) key = parent.REF_ID;
    if (key == null) return;

    var mainRow = ds_mainList.valueRow(["KEY_VALUE", key]);

    if (mainRow == -1) return;

    var tabId = ds_mainList.value(mainRow, "TABID");

    if (!(tabId == "1" || tabId == "3")) return;

    spn_refNo.innerText = ds_mainList.value(mainRow, "CAPTION");

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.family.act.RetrieveFamilyFlowList.do";
    prx.addParam("REF_ID", key);
    prx.hideMessage = true;

    prx.onSuccess = function()
    {
        fnDrawFlow();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//업무흐름도 그리기
function fnDrawFlow(monthWidth)
{
    try {
        usr_flow.Clear();
    } catch(ex) {
    }

    vbSetFlowShape();

    if (monthWidth != null) usr_flow.MonthWidth = monthWidth; //1개월의 길이(기본값 15) 단위:픽셀
    usr_flow.MarginLeft = 20; //왼쪽 (기본값 20) 단위:픽셀
    usr_flow.MarginRight = 20; //오른쪽 (기본값 20) 단위:픽셀

    var ds = ds_flowList;

    if (ds.rowCount == 0) return;

    for (var r = 0; r < ds.rowCount; r++) {
        usr_flow.PaperAdd("F", ds.value(r, "PAPER_NAME"), cfGetFormatDate(ds.value(r, "PAPER_DATE")), "I", "0", "발생일자 : " + cfGetFormatDate(ds.value(r, "PAPER_DATE")));
    }

    usr_flow.Draw();
}

//업무흐름도 확대/축소
function fnResizeFlow(type)
{
    fnDrawFlow(type == null ? usr_flow.DEFAULT_MONTH_WIDTH : Math.max(eval(usr_flow.MonthWidth + type + 5), 1));
}
</SCRIPT>

<SCRIPT language="VBScript">
'패밀리구조도 링크스타일 설정
Public Sub vbSetFamilyLinkStyle(ByVal aCode, ByVal aName)
    usr_family.AddLinkType aCode, aName
    usr_family.SetStyleLinkType aCode, "굴림", 10, RGB(100,100,100), RGB(255,255,255), 1, 0, RGB(150,150,150), "굴림", 10, RGB(0,0,0), RGB(255,255,255), 1, 0
End Sub

'패밀리구조도 상태별 스타일 설정
Public Sub vbSetFamilyStatusStyle(ByVal aCode, ByVal aName)
    usr_family.AddStatusType aCode, aName
    usr_family.SetStyleStatusDescType aCode, "굴림", 10, RGB(0,0,0), RGB(255,255,255), 1, 0
End Sub

'패밀리구조도 캡션스타일 설정
Public Sub vbSetFamilyCaptionStyle()
    usr_family.SetStyleStatusCaptionType "0", "굴림",11, RGB(0,0,0), RGB(150,150,150), RGB(150,150,150), RGB(150,150,150), RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), 1, 0
    usr_family.SetStyleStatusCaptionType "1", "굴림",11, RGB(0,0,0), RGB(150,150,150), RGB(150,150,150), RGB(150,150,150), RGB(250,242,171), RGB(255,255,255), RGB(255,255,255), 1, 0
    usr_family.SetStyleStatusCaptionType "2", "굴림",11, RGB(0,0,0), RGB(150,150,150), RGB(150,150,150), RGB(150,150,150), RGB(205,225,225), RGB(255,255,255), RGB(255,255,255), 1, 0
    usr_family.SetStyleStatusCaptionType "3", "굴림",11, RGB(0,0,0), RGB(150,150,150), RGB(150,150,150), RGB(150,150,150), RGB(249,200,168), RGB(255,255,255), RGB(255,255,255), 1, 0
    usr_family.SetStyleStatusCaptionType "4", "굴림",11, RGB(0,0,0), RGB(150,150,150), RGB(150,150,150), RGB(150,150,150), RGB(214,222,217), RGB(255,255,255), RGB(255,255,255), 1, 0
End Sub

'업무흐름도 모양 설정
Public Sub vbSetFlowShape()
    '모양추가 1.구분(string) 2.글자색(long) 3.화살표굵기(integer) 4.화살표색(long) 5.마일스톤표시색상(long)
    usr_flow.SetShape "A", False, RGB(200,200,200), 1, 10, RGB(200,200,200), RGB(255,0,0) '출원의뢰
    usr_flow.SetShape "B", True , RGB(80,80,80)   , 3, 30, RGB(255,0,0)    , RGB(255,0,0) '출원
    usr_flow.SetShape "C", True , RGB(30,30,30)   , 3, 30, RGB(30,30,30)   , RGB(30,30,30) 'OA
    usr_flow.SetShape "D", True , RGB(255,0,0)    , 3, 30, RGB(255,0,0)    , RGB(255,0,0) '포기
    usr_flow.SetShape "E", True , RGB(255,0,0)    , 3, 30, RGB(255,0,0)    , RGB(255,0,0) '등록
    usr_flow.SetShape "F", True , RGB(0,0,255)    , 3, 30, RGB(0,0,255)    , RGB(0,255,255) '분할/우선권
    usr_flow.SetShape "Z", False, RGB(150,150,150), 1, 10, RGB(200,200,200), RGB(255,255,255) '기타서류
End Sub
</SCRIPT>

<!-- LinkCaption 사용여부 변경시 -->
<SCRIPT language="JScript" for="chk_linkCaption" event="onclick()">
    usr_family.LinkCaptionDisplay = this.checked;
    usr_family.DrawMap;
</SCRIPT>

<!-- 패밀리구조도 마우스 이동시 -->
<SCRIPT language="JScript" for="usr_family" event="onmousemove()">
    gMousePos = { x:event.x, y:event.y };
</SCRIPT>

<!-- 패밀리구조도 Entity 클릭시 -->
<SCRIPT language="JScript" for="usr_family" event="EntityClick(key)">
    fnRetrieveFlowList(key);
    fnRetrieveTooltipDetail(key);
</SCRIPT>

<!-- 패밀리구조도 Entity 더블클릭시 -->
<SCRIPT language="JScript" for="usr_family" event="EntityDblClick(key)">
    fnOpenDetail(key);
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
    <TR>
        <TD height="1">
            <TABLE border="0" cellpadding="0" cellspacing="0" width="100%">
                <TR>
                    <TD class="title_sub">Application Relation Diagram</TD>
                    <TD align="right">
                        <ANY:CHECK id="chk_linkCaption" text="LinkCaption 사용" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="3"></TD>
    </TR>
    <TR>
        <TD height="100%" style="border:#000000 1px solid;">
            <OBJECT id="usr_family" classid="CLSID:DDC1318D-25A2-47C7-9014-89A80B50D51F"
                    codebase="cab/PatentFlowMap1.0.0.5.cab#version=1,0,0,5"
                    width="100%" height="100%" border="0"
            ></OBJECT>
        </TD>
    </TR>
    <TR>
        <TD height="15"></TD>
    </TR>
    <TR>
        <TD height="1">
            <TABLE border="0" cellpadding="0" cellspacing="0" width="100%">
                <TR>
                    <TD>
                        <SPAN class="title_sub">Application Flow Diagram</SPAN>
                        &nbsp;&nbsp;REF.No : <SPAN id="spn_refNo"></SPAN>
                    </TD>
                    <TD align="right">
                        <BUTTON text="확대" onClick="javascript:fnResizeFlow('+');"></BUTTON>
                        <BUTTON text="축소" onClick="javascript:fnResizeFlow('-');"></BUTTON>
                        <BUTTON text="원본" onClick="javascript:fnResizeFlow();"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="3"></TD>
    </TR>
    <TR>
        <TD height="200px" style="border:#000000 1px solid;">
            <OBJECT id="usr_flow" classid="CLSID:9663BD12-C138-4B95-B531-D18D3236624A"
                    codebase="cab/AnyFiveAFD1.0.0.1.cab#version=1,0,0,1"
                    width="100%" height="100%" border="0"
            ></OBJECT>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
