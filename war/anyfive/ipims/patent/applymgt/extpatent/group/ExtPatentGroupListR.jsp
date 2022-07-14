<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원품의</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_ExtNewConsultList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.group.act.RetrieveExtPatentGroupList.do";
    ldr.addParam("NO_GUBUN", NO_GUBUN.value);
    ldr.addParam("SR_NO", SR_NO.value);
    ldr.addParam("SR_NO_ONLY", SR_NO_ONLY.value);
    ldr.addParam("KO_APP_TITLE", KO_APP_TITLE.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);
    ldr.addParam("JOB_MAN", JOB_MAN.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//작성
function fnWrite()
{
    var win = new any.viewer();
    win.path = "ExtPatentGroupC.jsp";

    win.onReload = function()
    {
        gr_ExtNewConsultList.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "ExtPatentGroupRD.jsp";
    win.arg.GRP_ID = gr.value(row, "GRP_ID");

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}
</SCRIPT>

</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>검색번호</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="NO_GUBUN" codeData="/applymgt/extNewConsultOptSelNo" style="width:125px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SR_NO" style="text-transform:uppercase;">
                                </TD>
                                <TD noWrap>
                                    <ANY:CHECK id="SR_NO_ONLY" text="번호만 검색" />
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>발명의명칭</TD>
                    <TD>
                        <INPUT type="text" id="KO_APP_TITLE">
                    </TD>
                </TR>
                <TR>
                    <TD>작성기간</TD>
                    <TD noWrap>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
                    </TD>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,PAT" firstName="all" />
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
                        <BUTTON text="<%= app.message.get("btn.com.write").toHTML() %>" onClick="javascript:fnWrite();"></BUTTON>
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
            <ANY:GRID id="gr_ExtNewConsultList" pagingType="1"><COMMENT>
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"GRP_NO"             , name:"해외출원번호" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"APP_NO"             , name:"국내출원번호" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"RIGHT_DIV_NAME"     , name:"구분" });
                addColumn({ width:250, align:"left"  , type:"string" , sort:true , id:"KO_APP_TITLE"       , name:"발명의 명칭" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"JOB_MAN_NAME"       , name:"건담당자" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"INVENTOR_NAMES"     , name:"발명자" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"KR_OFFICE"          , name:"국내사무소" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"CRE_DATE"           , name:"작성일" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "KO_APP_TITLE");
                addSorting("GRP_NO", "DESC");
                addAction("KO_APP_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
