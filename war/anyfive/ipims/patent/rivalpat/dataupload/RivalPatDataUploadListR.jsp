<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>Data업로드</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_dataUploadList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.dataupload.act.RetrieveRivalPatDataUploadList.do";
    ldr.addParam("APP_MAN", APP_MAN.value);
    ldr.addParam("TITLE", TITLE.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//엑셀 Import
function fnImportExcel()
{
    var ldr = new any.excelImporter();
    ldr.templateFile = "/excel/WipsUpload.xls";
    ldr.saveAction = top.getRoot() + "/anyfive.ipims.patent.rivalpat.dataupload.act.UploadExcel.do";
    if (ldr.execute() == "OK") {
        fnRetrieve();
    }
}

function fnPatAppNo(gr, fg, row, colId)
{
    var addr = gr.value(row,"APP_NO");
    window.open("http://192.168.1.17:8081/fullText.do?execute=fullTextCheckPT&applno="+addr+"" );
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" width="100%" cellspacing="1" cellpadding="2" class="main" width="100%" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="13%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="13%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="13%">
                    <COL class="conddata" width="20%">
                </COLGROUP>
                <TR>
                    <TD>출원인</TD>
                    <TD><INPUT type="text" id="APP_MAN"></TD>
                    <TD>발명의명칭</TD>
                    <TD><INPUT type="text" id="TITLE"></TD>
                    <TD>업로드일자</TD>
                    <TD noWrap>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                    <TD align="right">
                        <BUTTON auto="retrieve" onClick="javascript:fnRetrieve();"></BUTTON>
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON text="Excel Import" onClick="javascript:fnImportExcel();"></BUTTON>
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
            <ANY:GRID id="gr_dataUploadList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"                  , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"COUNTRY_CODE"             , name:"국가" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"STATUS_CODE"              , name:"특허구분" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"APP_NO"                   , name:"출원번호"});
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"                 , name:"출원일"});
                addColumn({ width:130, align:"left"  , type:"string", sort:true , id:"TITLE"                    , name:"발명의명칭"});
                addColumn({ width:70 , align:"left"  , type:"string", sort:true , id:"IPC"                      , name:"IPC" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_MAN"                  , name:"출원인" });
                addColumn({ width:130, align:"left"  , type:"string", sort:true , id:"SUMMARY"                  , name:"요약" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"REQ_RANGE"                , name:"청구범위" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"REQCNT"                   , name:"청구항 수" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"PUB_NO"                , name:"공개번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PUB_DATE"              , name:"공개일" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"REG_NO"                   , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"                 , name:"등록일" });
                addColumn({ width:80 , align:"center", type:"date"  , sort:true , id:"PRIORITY_CLAIM_DATE"      , name:"우선권주장일" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"PRIORITY_NO"              , name:"우선권번호" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"PRIORITY_COUNTRY"         , name:"우선권국가" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"AGENT"                    , name:"대리인" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"APP_MAN_IDENTIFY_MARK"    , name:"출원인식별기호" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"APP_MAN_NATIONALITY"      , name:"출원인국적" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"OWN_APP_MAN"              , name:"대표출원인" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"INVENTOR"                 , name:"발명자" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"INVENTOR_NATIONALITY"     , name:"발명자국적" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"SPEC_COUNTRY"             , name:"지정국" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"NOTICE_NO"                , name:"공고번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"NOTICE_DATE"              , name:"공고일" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"OWN_US_CLS_CURR"          , name:"대표미국분류(Curr)" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"US_CLS_CURR"              , name:"미국분류(Curr)" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"OWN_US_CLS_ORG"           , name:"대표미국분류(Org)" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"US_CLS_ORG"               , name:"미국분류(Org)" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"I_APP_NO"                 , name:"국제출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"I_APP_DATE"               , name:"국제출원일" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"I_PUB_NO"                 , name:"국제공개번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"I_PUB_DATE"               , name:"국제공개일" });
                addColumn({ width:70 , align:"left"  , type:"string", sort:true , id:"THEME_CODE"               , name:"테마코드" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"US_REFER_PAT"             , name:"미국인용특허" });
                addColumn({ width:70 , align:"left"  , type:"string", sort:true , id:"JUDGE"                    , name:"심사관" });
                addColumn({ width:70 , align:"left"  , type:"string", sort:true , id:"F_TERM"                   , name:"F텀" });
                addColumn({ width:70 , align:"left"  , type:"string", sort:true , id:"FI"                       , name:"FI" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"PAT_DIV"                  , name:"특실구분" });
                addColumn({ width:140, align:"left"  , type:"string", sort:true , id:"WIPS_KEY"                 , name:"WIPS키" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"DR_IMAGES"                , name:"대표도면" });
                addColumn({ width:75 , align:"center", type:"string", sort:true , id:"STATE"                    , name:"상태" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "TITLE");
                addAction("APP_NO", fnPatAppNo)
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
