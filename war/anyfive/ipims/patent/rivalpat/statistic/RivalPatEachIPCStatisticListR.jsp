<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>출원인별 IPC분석자료 </TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<% app.writeHTCImport(app.HTC_TREE); %>
<ANY:DS id="ds_TechResultList" />
<SCRIPT language="JScript">
//윈도우 로딩시

var techCode;
window.onready = function()
{
    fnRetrieveTechTree();
}

//검색
function fnRetrieveTechTree()
{
    var ldr = gr_ipcCodeTree.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrieveIpcCodeSearchTree.do";

    ldr.onSuccess = function(gr, fg)
    {
        if (gr_actualByTechList.loader.executed == true && gr_rivalPatList.loder.executed == true ) {
            gr_actualByTechList.loader.reload(); //자사특허 트리검색
            gr_rivalPatList.loader.reload(); //경쟁사 특허 트리검색
        } else {
            fnRetrieveActualByIpcList(gr.value(fg.Row, "IPC_CODE"));
        }
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//기술별 국내실적통계 조회
function fnRetrieveActualByIpcList(priorCode)
{
    if (priorCode != null){
        ipcCode = priorCode;
    }
    var ldr = gr_actualByTechList.loader;
    var ldr2 = gr_rivalPatList.loader;

    ldr.init();
    ldr2.init();

    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.statistic.act.RetrieveActualByIpcList.do"; //자사
    ldr2.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.evalmaster.act.RetrieveRivalPatEvalMasterListTech.do"; //경쟁사
    ldr.addParam("IPC_CODE" , ipcCode);
    ldr2.addParam("IPC_CODE" , ipcCode);


    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr2.onSuccess = function(gr, fg)
    {
    }

    ldr2.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
    ldr2.execute();
}

function fnAppno(gr, fg, row, colId)
{
    var addr = gr.value(row,"APP_NO");
    window.open("http://192.168.1.17:8081/fullText.do?execute=fullTextCheckPT&applno="+addr+"" );
}

function fnRefno(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "RetrieveIntPatentMasterRD.jsp";
    win.arg.REF_ID = gr.value(row,"REF_ID");
    win.opt.width = 800;
    win.opt.height = 400;
    win.show();
}

function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/rivalpat/evalmaster/RivalPatEvalMasterRD.jsp";
    win.arg.MGT_ID = gr.value(row, "MGT_ID");
    win.opt.width = 850;
    win.opt.height = 700;
    win.opt.resizable = "yes";
    win.show();
}

</SCRIPT>
<!-- 검색일자 구분 변경시 -->
<SCRIPT language="JScript" for="DATE_GUBUN" event="OnChange()">
    DATE_START.disabled = (this.value == "");
    DATE_END.disabled = (this.value == "");
</SCRIPT>

</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                <TR>
                    <TD width="1px">
                        <ANY:TREE id="gr_ipcCodeTree" style="width:230px;"><COMMENT>
                            parentColumn = "PRIOR_IPC_CODE";
                            codeColumn   = "IPC_CODE";
                            nameColumn   = "IPC_HNAME";
                            expandLevel  = 1;

                            addRoot(null, "ROOT", "iPIMS");

                            fg.attachEvent("AfterRowColChange", function(iOldRow, iOldCol, iNewRow, iNewCol)
                            {
                                if (element.loader.loading == true) return;

                                fnRetrieveActualByIpcList(element.value(iNewRow, "IPC_CODE"));
                            });
                        </COMMENT></ANY:TREE>
                    </TD>
                    <TD width="100%" style="padding-left:5px;">
                    <TABLE border="0" width="100%">
                        <TR>
                            <TD>
                                <b> <FONT color="#6C1D39"  size="2">경쟁사특허</FONT></b>
                            </TD>
                            <TD align="right">
                                <SPAN id="spn_gridMessage_2"></SPAN>
                            </TD>
                        </TR>
                    </TABLE>
                     <TABLE border="0" width="100%" height="45%">
                            <TR>
                                <TD>
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
                                        messageSpan = "spn_gridMessage_2";
                                        setFixedColumn("ROW_NUM", "APP_NO");
                                        addAction("APP_NO", fnAppno);
                                        addAction("TITLE", fnDetail);
                                   </COMMENT></ANY:GRID>
                               </TD>
                           </TR>
                       </TABLE>

                        <TABLE border="0" width="100%">
                        <TR>
                            <TD>
                                <b> <FONT color="#6C1D39"  size="2">자사특허</FONT></b>
                            </TD>
                            <TD align="right">
                                <SPAN id="spn_gridMessage_1"></SPAN>
                            </TD>
                        </TR>
                        </TABLE>
                         <TABLE border="0" width="100%" height="45%">
                            <TR>
                                <TD>
                                    <ANY:GRID id="gr_actualByTechList" pagingType="1"><COMMENT>
                                        addColumn({ width:120, align:"left"  , type:"string" , sort:false, id:"REF_NO"            , name:"REF_NO" });
                                        addColumn({ width:130, align:"left"  , type:"string" , sort:false, id:"APP_NO"            , name:"출원번호" });
                                        addColumn({ width:130, align:"left"  , type:"string" , sort:false, id:"PAT_APP_NO"        , name:"풀출원번호" ,hide:true});
                                        addColumn({ width:200, align:"left"  , type:"string" , sort:false, id:"KO_APP_TITLE"      , name:"발명의 명칭" });
                                        addColumn({ width:75 , align:"center", type:"date"   , sort:false, id:"PATTEAM_RCPT_DATE" , name:"접수일" });
                                        addColumn({ width:75 , align:"center", type:"date"   , sort:false, id:"PATTEAM_REQ_DATE"  , name:"의뢰일" });
                                        addColumn({ width:75 , align:"center", type:"date"   , sort:false, id:"APP_DATE"          , name:"출원일" });
                                        addColumn({ width:130, align:"string", type:"string" , sort:false, id:"REG_NO"            , name:"등록번호" });
                                        addColumn({ width:130, align:"string", type:"string" , sort:false, id:"REF_ID"            , name:"REF_ID" , hide:true });
                                        messageSpan = "spn_gridMessage_1";
                                        addAction("REF_NO", fnRefno);
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
