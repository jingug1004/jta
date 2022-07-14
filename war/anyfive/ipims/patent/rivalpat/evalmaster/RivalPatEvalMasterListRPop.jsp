<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>경쟁사특허</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_TechResultList" />
<SCRIPT language="JScript">
var gPriorCode;

//윈도우 로딩시
window.onready = function()
{
    fnSearch();

}

//검색
function fnSearch()
{
    var ldr = gr_rivalPatList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.evalmaster.act.RetrieveRivalPatEvalMasterListTech.do";
    ldr.addParam("TECH_CODE" , gPriorCode);
    ldr.addParam("IPC_CODE" , parent.IPC_CODE);
    ldr.addParam("MGT_ID", parent.MGT_ID);
    ldr.addParam("EVAL_CNT", parent.EVAL_CNT);
    ldr.addParam("GUBUN", parent.GUBUN);


    function getCheckValues()
    {
        var arr = new Array();
        var chk = document.getElementsByName("chk_searchField");
        for (var i = 0; i < chk.length; i++) {
            if (chk[i].checked == true) arr.push(chk[i].value);
        }
        return arr.join(",");
    }

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    win.path ="RivalPatEvalMasterRD.jsp";
    win.arg.MGT_ID = gr.value(row, "MGT_ID");
    win.arg.gr = gr_rivalPatList;
    win.opt.width = 850;
    win.opt.height = 700;
    win.opt.resizable = "yes";

    win.onReload = function()
    {
        gr_rivalPatList.loader.reload();
    }

    win.show();
}

function fnAppno(gr, fg, row, colId)
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
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                <TR>
                     <TD id="td_grid" style="padding-left:5px;">
                        <TABLE border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                            <TR>
                                <TD>
                                    <TABLE border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <TR>
                                            <TD><ANY:SPAN id="spn_techPathname">ROOT</ANY:SPAN></TD>
                                            <TD align="right" style="padding-left:10px;" valign="bottom">
                                                <SPAN id="spn_gridMessage"></SPAN>
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
                                    <ANY:GRID id="gr_rivalPatList" pagingType="1"><COMMENT>
                                        addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                                        addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"           , name:"출원번호"});
                                        addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"         , name:"출원일"});
                                        addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"TITLE"            , name:"발명의 명칭"});
                                        addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"INVENTOR"         , name:"발명자" });
                                        addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"APP_MAN"          , name:"출원인" });
                                        addColumn({ width:130, align:"left"  , type:"string", sort:true , id:"WIPS_KEY"         , name:"WIPS키"  , hide:true });
                                        addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"TECH_NAMES"       , name:"기술분류" });
                                        addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"IPC_NAMES"       , name:"IPC분류" });
                                        addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"OWN_APP_MAN"      , name:"대표출원인" });
                                        addColumn({ width:50 , align:"center", type:"string", sort:true , id:"COUNTRY_CODE"     , name:"국가" });
                                        addColumn({ width:70 , align:"center", type:"string", sort:true , id:"PAT_DIV"          , name:"특/실구분" });
                                        addColumn({ width:70 , align:"center", type:"string", sort:true , id:"EVAL_GRADE"       , name:"평가등급" });
                                        useConfig = true;
                                        messageSpan = "spn_gridMessage";
                                        setFixedColumn("ROW_NUM", "APP_NO");
                                        addAction("TITLE", fnDetail);
                                        addAction("APP_NO", fnAppno);
                                    </COMMENT></ANY:GRID>
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>
<% app.writeBodyFooter(); %>
</BODY>
</HTML>
