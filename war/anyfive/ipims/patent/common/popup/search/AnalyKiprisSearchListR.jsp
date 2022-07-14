<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>KIPRIS 검색</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//-----------분석자료 요청 구분 정보검색화면--------------------
//윈도우 로딩시
window.onready = function()
{
   fnSearch();
}

//검색
function fnSearch()
{
    var ldr = gr_refNoList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrieveAKiprisSearchList.do";
    ldr.addParam("SEARCH_TEXT", txt_searchText.value);

    ldr.onSuccess = function(gr, fg)
    {
        txt_searchText.focus();
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//확인
function fnConfirm(gr, fg, row, colId)
{
    if( gr.value(row,"K_APP_NO") !=null && gr.value(row,"K_APP_NO") !="" ){
        top.window.returnValue = {K_APP_NO   :gr.value(row, "K_APP_NO"),
                APP_DATE :gr.value(row, "APP_DATE"),
                REG_NO   :gr.value(row, "REG_NO"),
                REG_DATE :gr.value(row, "REG_DATE"),
                PUB_NO   :gr.value(row, "PUB_NO"),
                PUB_DATE :gr.value(row, "PUB_DATE"),
                MGT_ID   :gr.value(row, "MGT_ID")}

        top.window.close();
      }
}

function fnAddr(gr, fg, row, colId)
{
    var addr = gr.value(row,"K_APP_NO");
    window.open("http://192.168.1.17:8081/fullText.do?execute=fullTextCheckPT&applno="+addr+""  );
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" onEnter="javascript:fnSearch();">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                    <TD align="right">
                        출원번호/출원인/등록번호
                        <INPUT type="text" id="txt_searchText" style="width:120px;">
                        <BUTTON auto="search" onClick="javascript:fnSearch();"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_refNoList" pagingType="1"><COMMENT>
                addColumn({ width:40 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"No" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"K_APP_NO"           , name:"출원번호" });
                addColumn({ width:130, align:"left"  , type:"string", sort:true , id:"APP_MAN"           , name:"출원인" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"REG_NO"           , name:"등록번호" });
                addColumn({ width:110 , align:"center", type:"string", sort:true , id:"LINK_PT_ADDR"       , name:"바로가기"  });
                messageSpan = "spn_gridMessage";
                addSorting("K_APP_NO", "ASC");
                addAction("K_APP_NO", fnConfirm);
                addAction("LINK_PT_ADDR" , fnAddr);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD align="right">
            <BUTTON text="확인" onClick="javascript:fnConfirm();" id="btn_confirm" display="none"></BUTTON>
            <BUTTON auto="close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
