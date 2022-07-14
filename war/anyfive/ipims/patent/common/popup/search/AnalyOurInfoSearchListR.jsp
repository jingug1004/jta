<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>당사정보 검색</TITLE>
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
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrieveOurInfoSearchList.do";
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
   if( gr.value(row,"REF_NO") !=null && gr.value(row,"REF_NO") !="" ){
      top.window.returnValue = {PAT_APP_NO   :gr.value(row, "PAT_APP_NO"),
                                APP_DATE :gr.value(row, "APP_DATE"),
                                REG_NO   :gr.value(row, "REG_NO"),
                                REG_DATE :gr.value(row, "REG_DATE"),
                                PUB_NO   :gr.value(row, "PUB_NO"),
                                PUB_DATE :gr.value(row, "PUB_DATE")}
      top.window.close();
    }
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
                        REF-NO/등록번호/출원번호
                        <INPUT type="text" id="txt_searchText" style="width:150px;">
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
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK"          , hide:true });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"           , name:"REF-NO" });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"   , name:"권리구분" });
                addColumn({ width:250, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"     , name:"발명의명칭" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_NO"           , name:"출원번호" , hide:true });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"         , name:"출원일자" , hide:true });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"PAT_APP_NO"       , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_NO"         , name:"등록번호" , hide:true });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"         , name:"등록일자" , hide:true });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PUB_NO"         , name:"공개번호"   , hide:true });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PUB_DATE"         , name:"공개일자" , hide:true });

                messageSpan = "spn_gridMessage";
                addSorting("REG_NO", "ASC");
                addAction("KO_APP_TITLE", fnConfirm);
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
