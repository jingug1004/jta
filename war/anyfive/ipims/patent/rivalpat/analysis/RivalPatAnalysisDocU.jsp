<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="any.util.etc.NCommonUtil"%>
<%@page import="any.util.etc.NDateUtil"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>분석자료수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_analyInfo"></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();

}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.analysis.act.RetriveAnalysisDocR.do";
    prx.addParam("ANALY_ID", parent.ANALY_ID);
    prx.checkData = ds_analyInfo;

    prx.onSuccess = function()
    {
        ch_ourright(ds_analyInfo.value(0,"OUR_RIGHT"),ds_analyInfo.value(0,"THEM_RIGHT"));
        ch_themright(ds_analyInfo.value(0,"THEM_RIGHT"),ds_analyInfo.value(0,"OUR_RIGHT"));
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}


//수정후저장
function fnSave(isFileUploaded)
{

    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.analysis.act.UpdateAnalysisDoc.do";
    prx.addParam("ANALY_ID", parent.ANALY_ID);
    prx.addData("ds_analyInfo");
    prx.addData("ds_attachFile");
    prx.addData("ds_techCodeList");
    prx.addData("ds_ipcCodeList");


    prx.addData("ds_analyFileId1");
    prx.addData("ds_analyFileId2");
    prx.addData("ds_analyFileId3");
    prx.addData("ds_analyFileId4");
    prx.addData("ds_analyFileId5");
    prx.addData("ds_analyFileId6");
    prx.addData("ds_analyFileId7");

    prx.addData("ds_analyFileIdThem1");
    prx.addData("ds_analyFileIdThem2");
    prx.addData("ds_analyFileIdThem3");
    prx.addData("ds_analyFileIdThem4");
    prx.addData("ds_analyFileIdThem5");
    prx.addData("ds_analyFileIdThem6");
    prx.addData("ds_analyFileIdThem7");
    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("RivalPatAnalysisDocListR.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

function ch_ourright(val1,val2){
    if(val1 == "10"){
        //청구항(독립항)
        OUR_ITEM_TITLE.style.display = "block";
        OUR_ITEM.style.display = "block";
        //design_attach_them.style.display = "none";
        //design_attach_our.style.display = "none";
        item1.style.display = "block";
        any_analyFileId2.style.display = "none";
        any_analyFileId3.style.display = "none";
        any_analyFileId4.style.display = "none";
        any_analyFileId5.style.display = "none";
        any_analyFileId6.style.display = "none";
        any_analyFileId7.style.display = "none";

        OUR_ATTACH1_TITLE.value="대표도면";

        OUR_ATTACH2_TITLE.style.display = "none";
        OUR_ATTACH3_TITLE.style.display = "none";
        OUR_ATTACH4_TITLE.style.display = "none";
        OUR_ATTACH5_TITLE.style.display = "none";
        OUR_ATTACH6_TITLE.style.display = "none";
        OUR_ATTACH7_TITLE.style.display = "none";
    }else if(val1 == "20"){
        OUR_ITEM_TITLE.style.display = "block";
        OUR_ITEM.style.display = "block";
        //design_attach_them.style.display = "none";
        //design_attach_our.style.display = "none";
        item1.style.display = "block";
        any_analyFileId2.style.display = "none";
        any_analyFileId3.style.display = "none";
        any_analyFileId4.style.display = "none";
        any_analyFileId5.style.display = "none";
        any_analyFileId6.style.display = "none";
        any_analyFileId7.style.display = "none";

        OUR_ATTACH1_TITLE.value="첨부파일";

        OUR_ATTACH2_TITLE.style.display = "none";
        OUR_ATTACH3_TITLE.style.display = "none";
        OUR_ATTACH4_TITLE.style.display = "none";
        OUR_ATTACH5_TITLE.style.display = "none";
        OUR_ATTACH6_TITLE.style.display = "none";
        OUR_ATTACH7_TITLE.style.display = "none";
    }else if(val1 == "30"){
        OUR_ITEM_TITLE.style.display = "none";
        OUR_ITEM.style.display = "none";
        design_attach_our.style.display = "block";
        any_analyFileId2.style.display = "block";
        any_analyFileId3.style.display = "block";
        any_analyFileId4.style.display = "block";
        any_analyFileId5.style.display = "block";
        any_analyFileId6.style.display = "block";
        any_analyFileId7.style.display = "block";
        design_attach_them.style.display = "block";

        OUR_ATTACH1_TITLE.value="사시도";

        OUR_ATTACH2_TITLE.style.display = "block";
        OUR_ATTACH3_TITLE.style.display = "block";
        OUR_ATTACH4_TITLE.style.display = "block";
        OUR_ATTACH5_TITLE.style.display = "block";
        OUR_ATTACH6_TITLE.style.display = "block";
        OUR_ATTACH7_TITLE.style.display = "block";
    }else if(val1 == "40"){
        OUR_ITEM_TITLE.style.display = "none";
        OUR_ITEM.style.display = "none";
        //design_attach_them.style.display = "none";
        //design_attach_our.style.display = "none";
        any_analyFileId2.style.display = "none";
        any_analyFileId3.style.display = "none";
        any_analyFileId4.style.display = "none";
        any_analyFileId5.style.display = "none";
        any_analyFileId6.style.display = "none";
        any_analyFileId7.style.display = "none";

        THEM_ATTACH1_TITLE.value="첨부파일";

        OUR_ATTACH2_TITLE.style.display = "none";
        OUR_ATTACH3_TITLE.style.display = "none";
        OUR_ATTACH4_TITLE.style.display = "none";
        OUR_ATTACH5_TITLE.style.display = "none";
        OUR_ATTACH6_TITLE.style.display = "none";
        OUR_ATTACH7_TITLE.style.display = "none";
    }else if(val1 == "" && val2 == ""){
        OUR_ITEM_TITLE.style.display = "none";
        OUR_ITEM.style.display = "none";
        THEM_ITEM_TITLE.style.display = "none";
        THEM_ITEM.style.display = "none";
        //design_attach_our.style.display = "none";
        //design_attach_them.style.display = "none";
        any_analyFileId2.style.display = "none";
        any_analyFileId3.style.display = "none";
        any_analyFileId4.style.display = "none";
        any_analyFileId5.style.display = "none";
        any_analyFileId6.style.display = "none";
        any_analyFileId7.style.display = "none";

        item1.style.display = "none";
        OUR_ATTACH1_TITLE.value="첨부파일";

        OUR_ATTACH2_TITLE.style.display = "none";
        OUR_ATTACH3_TITLE.style.display = "none";
        OUR_ATTACH4_TITLE.style.display = "none";
        OUR_ATTACH5_TITLE.style.display = "none";
        OUR_ATTACH6_TITLE.style.display = "none";
        OUR_ATTACH7_TITLE.style.display = "none";
    }else if((val1 != "10" && val2 != "10") || (val1 != "20" && val2 != "20")){
        item1.style.display = "none";
    }
}

function ch_themright(val1,val2){

    if(val1 == "10"){
        THEM_ITEM_TITLE.style.display = "block";
        THEM_ITEM.style.display = "block";
        //design_attach_them.style.display = "none";
        //design_attach_our.style.display = "none";
        item1.style.display = "block";
        any_analyFileIdThem2.style.display = "none";
        any_analyFileIdThem3.style.display = "none";
        any_analyFileIdThem4.style.display = "none";
        any_analyFileIdThem5.style.display = "none";
        any_analyFileIdThem6.style.display = "none";
        any_analyFileIdThem7.style.display = "none";

        THEM_ATTACH1_TITLE.value="대표도면";

        THEM_ATTACH2_TITLE.style.display = "none";
        THEM_ATTACH3_TITLE.style.display = "none";
        THEM_ATTACH4_TITLE.style.display = "none";
        THEM_ATTACH5_TITLE.style.display = "none";
        THEM_ATTACH6_TITLE.style.display = "none";
        THEM_ATTACH7_TITLE.style.display = "none";
    }else if(val1 == "20"){
        THEM_ITEM_TITLE.style.display = "block";
        THEM_ITEM.style.display = "block";
        //design_attach_them.style.display = "none";
        //design_attach_our.style.display = "none";
        item1.style.display = "block";
        any_analyFileIdThem2.style.display = "none";
        any_analyFileIdThem3.style.display = "none";
        any_analyFileIdThem4.style.display = "none";
        any_analyFileIdThem5.style.display = "none";
        any_analyFileIdThem6.style.display = "none";
        any_analyFileIdThem7.style.display = "none";

        THEM_ATTACH1_TITLE.value="첨부파일";

        THEM_ATTACH2_TITLE.style.display = "none";
        THEM_ATTACH3_TITLE.style.display = "none";
        THEM_ATTACH4_TITLE.style.display = "none";
        THEM_ATTACH5_TITLE.style.display = "none";
        THEM_ATTACH6_TITLE.style.display = "none";
        THEM_ATTACH7_TITLE.style.display = "none";
    }else if(val1 == "30"){
        THEM_ITEM_TITLE.style.display = "none";
        THEM_ITEM.style.display = "none";
        design_attach_them.style.display = "block";
        design_attach_our.style.display = "block";
        any_analyFileIdThem2.style.display = "block";
        any_analyFileIdThem3.style.display = "block";
        any_analyFileIdThem4.style.display = "block";
        any_analyFileIdThem5.style.display = "block";
        any_analyFileIdThem6.style.display = "block";
        any_analyFileIdThem7.style.display = "block";

        THEM_ATTACH1_TITLE.value="사시도";

        THEM_ATTACH2_TITLE.style.display = "block";
        THEM_ATTACH3_TITLE.style.display = "block";
        THEM_ATTACH4_TITLE.style.display = "block";
        THEM_ATTACH5_TITLE.style.display = "block";
        THEM_ATTACH6_TITLE.style.display = "block";
        THEM_ATTACH7_TITLE.style.display = "block";
    }else if(val1 == "40"){
        THEM_ITEM_TITLE.style.display = "none";
        THEM_ITEM.style.display = "none";
        any_analyFileIdThem2.style.display = "none";
        any_analyFileIdThem3.style.display = "none";
        any_analyFileIdThem4.style.display = "none";
        any_analyFileIdThem5.style.display = "none";
        any_analyFileIdThem6.style.display = "none";
        any_analyFileIdThem7.style.display = "none";
        //design_attach_them.style.display = "none";
        //design_attach_our.style.display = "none";

        THEM_ATTACH1_TITLE.value="첨부파일";

        THEM_ATTACH2_TITLE.style.display = "none";
        THEM_ATTACH3_TITLE.style.display = "none";
        THEM_ATTACH4_TITLE.style.display = "none";
        THEM_ATTACH5_TITLE.style.display = "none";
        THEM_ATTACH6_TITLE.style.display = "none";
        THEM_ATTACH7_TITLE.style.display = "none";
    }else if(val1 == "" && val2 == ""){
        OUR_ITEM_TITLE.style.display = "none";
        OUR_ITEM.style.display = "none";
        THEM_ITEM_TITLE.style.display = "none";
        THEM_ITEM.style.display = "none";
        //design_attach_our.style.display = "none";
        //design_attach_them.style.display = "none";
        any_analyFileIdThem2.style.display = "none";
        any_analyFileIdThem3.style.display = "none";
        any_analyFileIdThem4.style.display = "none";
        any_analyFileIdThem5.style.display = "none";
        any_analyFileIdThem6.style.display = "none";
        any_analyFileIdThem7.style.display = "none";

        item1.style.display = "none";
        THEM_ATTACH1_TITLE.value="첨부파일";

        THEM_ATTACH2_TITLE.style.display = "none";
        THEM_ATTACH3_TITLE.style.display = "none";
        THEM_ATTACH4_TITLE.style.display = "none";
        THEM_ATTACH5_TITLE.style.display = "none";
        THEM_ATTACH6_TITLE.style.display = "none";
        THEM_ATTACH7_TITLE.style.display = "none";
    }else if((val1 != "10" && val2 != "10") || (val1 != "20" && val2 != "20")){
        item1.style.display = "none";
    }
}
function fnSearch_a()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/AnalyOurInfoSearchListR.jsp";
    win.opt.width = 750;
    win.opt.height = 550;
    win.show();

    if (win.rtn == null) return;

    ds_analyInfo.value(0, "OUR_APPNO") = win.rtn.APP_NO;
    ds_analyInfo.value(0, "OUR_APPDATE") = win.rtn.APP_DATE;
    ds_analyInfo.value(0, "OUR_PUBNO") = win.rtn.PUB_NO;
    ds_analyInfo.value(0, "OUR_PUBDATE") = win.rtn.PUB_DATE;
    ds_analyInfo.value(0, "OUR_REGNO") = win.rtn.REG_NO;
    ds_analyInfo.value(0, "OUR_REGDATE") = win.rtn.REG_DATE;

}
function fnSearch_b()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/AnalyKiprisSearchListR.jsp"
    win.opt.width = 550;
    win.opt.height = 250;
    win.show();

    if (win.rtn == null) return;

    ds_analyInfo.value(0, "THEM_APPNO") = win.rtn.K_APP_NO;
}
</SCRIPT>
</HEAD>
<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD>관리번호</TD>
        <TD><SPAN id="MNG_NO"  bind="ds_analyInfo"></SPAN></TD>
        <TD>작성자(작성일)</TD>
        <TD><%= app.userInfo.getEmpHname() %>(<ANY:SPAN format="date" value="<%= NDateUtil.getSysDate() %>" />)</TD>
    </TR>
    <TR>
        <TD req="AN_TITLE" >분석자료명</TD>
        <TD><INPUT Type="text" id="AN_TITLE" maxByte = "2000"  bind="ds_analyInfo"></TD>
        <TD req="THEM_NAME" >경쟁사</TD>
        <TD><INPUT Type="text" id="THEM_NAME" maxByte = "2000" bind="ds_analyInfo"></TD>
    </TR>
    <TR>
        <TD colspan="2" align="center">자사정보&nbsp; <ANY:SELECT id="OUR_RIGHT" codeData="{RIGHT_DIV}" firstName="=선택=" bind="ds_analyInfo"  style="width:70px;" onClick="javascript:ch_ourright(OUR_RIGHT.value,THEM_RIGHT.value);"/><BUTTON text="검색" onClick="javascript:fnSearch_a();"/></TD>
        <TD colspan="2" align="center">비교정보&nbsp; <ANY:SELECT id="THEM_RIGHT" codeData="{RIGHT_DIV}" firstName="=선택=" bind="ds_analyInfo"  style="width:90px;" onClick="javascript:ch_themright(THEM_RIGHT.value,OUR_RIGHT.value);"/><BUTTON text="검색" onClick="javascript:fnSearch_b();"/></TD>
    </TR>
    <TR>
        <TD>출원번호/출원일자</TD>
        <TD>
            <INPUT type="text" id="OUR_APPNO" maxByte = "20" bind="ds_analyInfo" style="width:120px;">/<ANY:DATE id="OUR_APPDATE"  bind="ds_analyInfo"/>
        </TD>
        <TD>출원번호/출원일자</TD>
        <TD>
            <INPUT type="text" id="THEM_APPNO" maxByte = "20" bind="ds_analyInfo" style="width:120px;">/<ANY:DATE id="THEM_APPDATE"  bind="ds_analyInfo"/>
        </TD>
    </TR>
    <TR>
        <TD>공개번호/공개일자</TD>
        <TD>
            <INPUT type="text" id="OUR_PUBNO" maxByte = "20" bind="ds_analyInfo" style="width:120px;">/<ANY:DATE id="OUR_PUBDATE"  bind="ds_analyInfo"/>
        </TD>
        <TD>공개번호/공개일자</TD>
        <TD>
            <INPUT type="text" id="THEM_PUBNO" maxByte = "20" bind="ds_analyInfo" style="width:120px;">/<ANY:DATE id="THEM_PUBDATE"  bind="ds_analyInfo"/>
        </TD>
    </TR>
    <TR>
        <TD>등록번호/등록일자</TD>
        <TD>
            <INPUT type="text" id="OUR_REGNO" maxByte = "20" bind="ds_analyInfo" style="width:120px;">/<ANY:DATE id="OUR_REGDATE"  bind="ds_analyInfo"/>
        </TD>
        <TD>등록번호/등록일자</TD>
        <TD>
            <INPUT type="text" id="THEM_REGNO" maxByte = "20" bind="ds_analyInfo" style="width:120px;">/<ANY:DATE id="THEM_REGDATE"  bind="ds_analyInfo"/>
        </TD>
    </TR>
    <TR id="item1" style="display:none;" >
        <TD><ANY:SPAN id="OUR_ITEM_TITLE" style="display:none;" >청구항(독립항)</ANY:SPAN></TD>
        <TD>
            <TEXTAREA id="OUR_ITEM" rows="5" bind="ds_analyInfo"  style="display:none;"></TEXTAREA>
        </TD>
        <TD><ANY:SPAN id="THEM_ITEM_TITLE" style="display:none;">청구항(독립항)</ANY:SPAN></TD>
        <TD>
            <TEXTAREA id="THEM_ITEM" rows="5" bind="ds_analyInfo" style="display:none;"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD><ANY:SPAN id="OUR_ATTACH1_TITLE" value="첨부파일"></ANY:SPAN></TD>
        <TD>
            <ANY:FILE id="any_analyFileId1" mode="C"  bind="ds_analyInfo:OUR_ATTACH1"  policy="design_image" imageMode="true" />
        </TD>
        <TD><ANY:SPAN id="THEM_ATTACH1_TITLE" value="첨부파일"></ANY:SPAN></TD>
        <TD>
            <ANY:FILE id="any_analyFileIdThem1" mode="C"  bind="ds_analyInfo:THEM_ATTACH1"  policy="design_image" imageMode="true" />
        </TD>
    </TR>
    <TR>
        <TD colspan="2" id="design_attach_our" style="display:none;" class="contdata" ><ANY:SPAN id="OUR_ATTACH2_TITLE" style="width:60px; display:none;">정면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileId2" mode="C"  bind="ds_analyInfo:OUR_ATTACH2" policy="design_image" imageMode="true"  style="width:320px; display:none;"/><br>
                                 <ANY:SPAN id="OUR_ATTACH3_TITLE"  style="width:60px; display:none;">배면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileId3" mode="C"  bind="ds_analyInfo:OUR_ATTACH3" policy="design_image" imageMode="true"  style="width:320px; display:none;"/><br>
                                 <ANY:SPAN id="OUR_ATTACH4_TITLE"  style="width:60px; display:none;">죄측면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileId4" mode="C"  bind="ds_analyInfo:OUR_ATTACH4" policy="design_image" imageMode="true"  style="width:320px; display:none;"/><br>
                                 <ANY:SPAN id="OUR_ATTACH5_TITLE"  style="width:60px; display:none;">우측면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileId5" mode="C"  bind="ds_analyInfo:OUR_ATTACH5" policy="design_image" imageMode="true"  style="width:320px; display:none;"/><br>
                                 <ANY:SPAN id="OUR_ATTACH6_TITLE"  style="width:60px; display:none;">평면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileId6" mode="C"  bind="ds_analyInfo:OUR_ATTACH6" policy="design_image" imageMode="true"  style="width:320px; display:none;"/><br>
                                 <ANY:SPAN id="OUR_ATTACH7_TITLE"  style="width:60px; display:none;">저면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileId7" mode="C"  bind="ds_analyInfo:OUR_ATTACH7" policy="design_image" imageMode="true"  style="width:320px; display:none;"/>
        </TD>
        <TD colspan="2" id="design_attach_them" style="display:none;" class="contdata" ><ANY:SPAN id="THEM_ATTACH2_TITLE"  style="width:60px; display:none;">정면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileIdThem2" mode="C" policy="design_image" imageMode="true"  bind="ds_analyInfo:THEM_ATTACH2" style="width:320px; display:none;"/><br>
                                <ANY:SPAN id="THEM_ATTACH3_TITLE"  style="width:60px; display:none;">배면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileIdThem3" mode="C" policy="design_image" imageMode="true"  bind="ds_analyInfo:THEM_ATTACH3" style="width:320px; display:none;"/><br>
                                 <ANY:SPAN id="THEM_ATTACH4_TITLE"  style="width:60px; display:none;">죄측면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileIdThem4" mode="C" policy="design_image" imageMode="true"  bind="ds_analyInfo:THEM_ATTACH4" style="width:320px; display:none;"/><br>
                                <ANY:SPAN id="THEM_ATTACH5_TITLE"  style="width:60px; display:none;">우측면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileIdThem5" mode="C" policy="design_image" imageMode="true"  bind="ds_analyInfo:THEM_ATTACH5" style="width:320px; display:none;"/><br>
                                 <ANY:SPAN id="THEM_ATTACH6_TITLE"  style="width:60px; display:none;">평면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileIdThem6" mode="C" policy="design_image" imageMode="true"  bind="ds_analyInfo:THEM_ATTACH6" style="width:320px; display:none;"/><br>
                                 <ANY:SPAN id="THEM_ATTACH7_TITLE"  style="width:60px; display:none;">저면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileIdThem7" mode="C" policy="design_image" imageMode="true"  bind="ds_analyInfo:THEM_ATTACH7" style="width:320px; display:none;"/>
        </TD>
    </TR>
    <TR>
        <TD colspan="4" class="contdata" ></TD>
    </TR>
    <TR>
        <TD>기술분류코드</TD>
        <TD>
             <ANY:MSEARCH id="any_techCodeList" mode="U"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/TechCodeSearchTreeR.jsp";
                codeColumn = "TECH_CODE";
                nameExpr = "[{#TECH_CODE}] {#TECH_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
         <TD>IPC분류코드</TD>
        <TD>
            <ANY:MSEARCH id="any_ipcCodeList" mode="U"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/IpcCodeSearchTreeR.jsp";
                codeColumn = "IPC_CODE";
                nameExpr = "[{#IPC_CODE}] {#IPC_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>검토의견</TD>
        <TD colspan="3">
            <TEXTAREA id="AN_OPINION" rows="5"   bind="ds_analyInfo" ></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3">
            <TEXTAREA id="AN_BIGO" rows="5"  bind="ds_analyInfo"></TEXTAREA>
        </TD>
    </TR>
     <TR>
        <TD>공개/미공개</TD>
        <TD colspan="3">
            <ANY:RADIO id="PUB_YN" codeData="{OPEN_YN}"  style="width:40%"  bind="ds_analyInfo"/>
        </TD>
    </TR>
    <TR>
        <TD>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile"  mode="U"  policy="paper"   bind="ds_analyInfo:ATTACH_FILE" />
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="history.back();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="RivalPatAnalysisDocListR.jsp"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
