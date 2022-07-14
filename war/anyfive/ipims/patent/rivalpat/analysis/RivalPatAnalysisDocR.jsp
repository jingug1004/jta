<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="any.util.etc.NCommonUtil"%>
<%@page import="any.util.etc.NDateUtil"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>분석자료상세화면</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<% app.writeHTCImport(app.HTC_IPBHIST); %>
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
//수정
function fnModify()
{
    window.location.href = "RivalPatAnalysisDocU.jsp";
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() +  "/anyfive.ipims.patent.rivalpat.analysis.act.DeleteAnalysisDoc.do";
    prx.addParam("ANALY_ID", parent.ANALY_ID);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.delete").toJS() %>");
        parent.goList();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
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
        <TD><SPAN id="CRE_USER_NAME" bind="ds_analyInfo"></SPAN>(<SPAN id="CRE_DATE" bind="ds_analyInfo"></SPAN>)</TD>
    </TR>
    <TR>
        <TD req="AN_TITLE" >분석자료명</TD>
        <TD><SPAN id="AN_TITLE"  bind="ds_analyInfo"></SPAN></TD>
        <TD req="THEM_NAME" >경쟁사</TD>
        <TD><SPAN id="THEM_NAME"  bind="ds_analyInfo"></SPAN></TD>
    </TR>
    <TR>
         <TD colspan="2" align="center">자사정보&nbsp;<ANY:SELECT id="OUR_RIGHT" codeData="{RIGHT_DIV}" firstName="=선택=" bind="ds_analyInfo"  style="width:70px;" ></ANY:SELECT></TD>
        <TD colspan="2" align="center">비교정보&nbsp;<ANY:SELECT id="THEM_RIGHT" codeData="{RIGHT_DIV}" firstName="=선택=" bind="ds_analyInfo"  style="width:90px;" ></ANY:SELECT></TD>
    </TR>
    <TR>
        <TD>출원번호/출원일자</TD>
        <TD>
            <SPAN id="OUR_APPNO" bind="ds_analyInfo" style="width:120px;"></SPAN>/<SPAN id="OUR_APPDATE"  bind="ds_analyInfo"></SPAN>
        </TD>
        <TD>출원번호/출원일자</TD>
        <TD>
            <SPAN id="THEM_APPNO"  bind="ds_analyInfo" style="width:120px;"></SPAN>/<SPAN id="THEM_APPDATE"  bind="ds_analyInfo"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD>공개번호/공개일자</TD>
        <TD>
            <SPAN id="OUR_PUBNO" bind="ds_analyInfo" style="width:120px;"></SPAN>/<SPAN id="OUR_PUBDATE"  bind="ds_analyInfo"></SPAN>
        </TD>
        <TD>공개번호/공개일자</TD>
        <TD>
            <SPAN id="THEM_PUBNO" bind="ds_analyInfo" style="width:120px;"></SPAN>/<SPAN id="THEM_PUBDATE"  bind="ds_analyInfo"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD>등록번호/등록일자</TD>
        <TD>
            <SPAN id="OUR_REGNO" bind="ds_analyInfo" style="width:120px;"></SPAN>/<SPAN id="OUR_REGDATE"  bind="ds_analyInfo"></SPAN>
        </TD>
        <TD>등록번호/등록일자</TD>
        <TD>
            <SPAN id="THEM_REGNO"  bind="ds_analyInfo" style="width:120px;"></SPAN>/<SPAN id="THEM_REGDATE"  bind="ds_analyInfo"></SPAN>
        </TD>
    </TR>
    <TR id="item1" style="display:none;" >
        <TD><SPAN id="OUR_ITEM_TITLE" style="display:none;" >청구항(독립항)</SPAN></TD>
        <TD>
            <SPAN  id="OUR_ITEM" rows="5" bind="ds_analyInfo"  style="display:none;"/>
        </TD>
        <TD><SPAN id="THEM_ITEM_TITLE" style="display:none;">청구항(독립항)</SPAN></TD>
        <TD>
            <SPAN  id="THEM_ITEM" rows="5" bind="ds_analyInfo" style="display:none;"/>
        </TD>
    </TR>
    <TR>
        <TD><ANY:SPAN id="OUR_ATTACH1_TITLE" value="첨부파일"></ANY:SPAN></TD>
        <TD>
            <ANY:FILE id="any_analyFileId1" mode="R"  bind="ds_analyInfo:OUR_ATTACH1"  policy="design_image" imageMode="true" />
        </TD>
        <TD><ANY:SPAN id="THEM_ATTACH1_TITLE" value="첨부파일"></ANY:SPAN></TD>
        <TD>
            <ANY:FILE id="any_analyFileIdThem1" mode="R"  bind="ds_analyInfo:THEM_ATTACH1"  policy="design_image" imageMode="true" />
        </TD>
    </TR>
    <TR>
        <TD colspan="2" id="design_attach_our" style="display:none;" class="contdata" ><ANY:SPAN id="OUR_ATTACH2_TITLE"  style="width:60px; display:none;">정면도</ANY:SPAN>

            <ANY:FILE id="any_analyFileId2"  bind="ds_analyInfo:OUR_ATTACH2"  imageMode="true"  style="width:320px; display:none;"/><br>
                                <ANY:SPAN id="OUR_ATTACH3_TITLE"  style="width:60px; display:none;"> 배면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileId3" mode="R"  bind="ds_analyInfo:OUR_ATTACH3" imageMode="true"  style="width:320px; display:none;"/><br>
                                <ANY:SPAN id="OUR_ATTACH4_TITLE"  style="width:60px; display:none;"> 죄측면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileId4" mode="R"  bind="ds_analyInfo:OUR_ATTACH4" imageMode="true"  style="width:320px; display:none;"/><br>
                                <ANY:SPAN id="OUR_ATTACH5_TITLE"  style="width:60px; display:none;">우측면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileId5" mode="R"  bind="ds_analyInfo:OUR_ATTACH5" imageMode="true"  style="width:320px; display:none;"/><br>
                                <ANY:SPAN id="OUR_ATTACH6_TITLE"  style="width:60px; display:none;"> 평면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileId6" mode="R"  bind="ds_analyInfo:OUR_ATTACH6" imageMode="true"  style="width:320px; display:none;"/><br>
                                 <ANY:SPAN id="OUR_ATTACH7_TITLE"  style="width:60px; display:none;">저면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileId7" mode="R"  bind="ds_analyInfo:OUR_ATTACH7" imageMode="true"  style="width:320px; display:none;"/>
        </TD>
        <TD colspan="2" id="design_attach_them" style="display:none;" class="contdata" ><ANY:SPAN id="THEM_ATTACH2_TITLE"  style="width:60px; display:none;">정면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileIdThem2" mode="R"  imageMode="true"  bind="ds_analyInfo:THEM_ATTACH2" style="width:320px; display:none;"/><br>
                                <ANY:SPAN id="THEM_ATTACH3_TITLE"  style="width:60px; display:none;"> 배면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileIdThem3" mode="R"  imageMode="true"  bind="ds_analyInfo:THEM_ATTACH3" style="width:320px; display:none;"/><br>
                                 <ANY:SPAN id="THEM_ATTACH4_TITLE"  style="width:60px; display:none;">죄측면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileIdThem4" mode="R"  imageMode="true"  bind="ds_analyInfo:THEM_ATTACH4" style="width:320px; display:none;"/><br>
                                <ANY:SPAN id="THEM_ATTACH5_TITLE"  style="width:60px; display:none;">우측면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileIdThem5" mode="R"  imageMode="true"  bind="ds_analyInfo:THEM_ATTACH5" style="width:320px; display:none;"/><br>
                                 <ANY:SPAN id="THEM_ATTACH6_TITLE"  style="width:60px; display:none;">평면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileIdThem6" mode="R"  imageMode="true"  bind="ds_analyInfo:THEM_ATTACH6" style="width:320px; display:none;"/><br>
                                 <ANY:SPAN id="THEM_ATTACH7_TITLE"  style="width:60px; display:none;">저면도</ANY:SPAN>
            <ANY:FILE id="any_analyFileIdThem7" mode="R"  imageMode="true"  bind="ds_analyInfo:THEM_ATTACH7" style="width:320px; display:none;"/>
        </TD>
    </TR>
    <TR>
        <TD colspan="4" class="contdata" ></TD>
    </TR>
    <TR>
        <TD>기술분류코드</TD>
        <TD>
             <ANY:MSEARCH id="any_techCodeList" mode="R"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/TechCodeSearchTreeR.jsp";
                codeColumn = "TECH_CODE";
                nameExpr = "[{#TECH_CODE}] {#TECH_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
         <TD>IPC분류코드</TD>
        <TD>
            <ANY:MSEARCH id="any_ipcCodeList" mode="R"><COMMENT>
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
            <SPAN id="AN_OPINION" rows="5"  bind="ds_analyInfo"/>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3">
            <SPAN id="AN_BIGO" rows="5"  bind="ds_analyInfo"/>
        </TD>
    </TR>
    <TR>
        <TD>공개/미공개</TD>
        <TD colspan="3">
            <ANY:RADIO id="PUB_YN" codeData="{OPEN_YN}"  bind="ds_analyInfo"   style="width:40%" readOnly />
        </TD>
    </TR>
    <TR>
        <TD>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile"  mode="R"  imageMode="true"  bind="ds_analyInfo:ATTACH_FILE" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="RivalPatAnalysisDocListR.jsp"></BUTTON>
</DIV>

<ANY:IPBHIST id="any_AnalyHistory" style="height:250px;"><COMMENT>
    refId = parent.ANALY_ID;
</COMMENT></ANY:IPBHIST>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
