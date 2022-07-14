<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>기술별 실적통계</TITLE>
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
    var ldr = gr_techCodeTree.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrieveTechCodeSearchTree.do";

    ldr.onSuccess = function(gr, fg)
    {
        if (gr_actualByTechList.loader.executed == true) {
            gr_actualByTechList.loader.reload();
        } else {
            fnRetrieveActualByTechList(gr.value(fg.Row, "TECH_CODE"));
        }
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//기술별 국내실적통계 조회
function fnRetrieveActualByTechList(priorCode)
{
    if (priorCode != null){
        techCode = priorCode;
    }
    var ldr = gr_actualByTechList.loader;
    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.statistic.act.RetrieveActualByTechList.do";
    ldr.addParam("TECH_CODE" , techCode);
    ldr.addParam("DATE_GUBUN", DATE_GUBUN.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END"  , DATE_END.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

function fnDetail(gr, fg, row, colId)//팝업으로 해당데이터 상세보기
{
    var win = new any.window();

    if(gr.value(row, "INOUT_DIV") == "EXT"){
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/ExtMasterTabR.jsp";
    }else{
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/IntMasterTabR.jsp";
    }
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.arg.gr = gr;
    win.opt.width = 800;
    win.opt.height = 600;

    win.onReload = function()
    {
        gr_personChartChartList.loader.reload();
    }

    win.show();
}

function fnAppno(gr, fg, row, colId)
{
    var addr = gr.value(row,"PAT_APP_NO");
    if(addr !=""){
        window.open("http://192.168.1.17:8081/fullText.do?execute=fullTextCheckPT&applno="+addr+"" );
    }
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
        <TD>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main">
                <COLGROUP>
                    <COL class="condhead" width="20%">
                    <COL class="conddata" width="80%">
                </COLGROUP>
                <TR>
                    <TD>검색일</TD>
                    <TD noWrap>
                        <ANY:SELECT id="DATE_GUBUN" codeData="/applymgt/intPatentMasterSearchDateType" firstName="none" style="width:80px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
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
                        <BUTTON auto="retrieve" onClick="javascript:fnRetrieveActualByTechList();"></BUTTON>
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
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                <TR>
                    <TD width="1px">
                        <ANY:TREE id="gr_techCodeTree" style="width:230px;"><COMMENT>
                            parentColumn = "PRIOR_TECH_CODE";
                            codeColumn   = "TECH_CODE";
                            nameColumn   = "TECH_HNAME";
                            expandLevel  = 1;

                            addRoot(null, "ROOT", "iPIMS");

                            fg.attachEvent("AfterRowColChange", function(iOldRow, iOldCol, iNewRow, iNewCol)
                            {
                                if (element.loader.loading == true) return;

                                fnRetrieveActualByTechList(element.value(iNewRow, "TECH_CODE"));
                            });
                        </COMMENT></ANY:TREE>
                    </TD>
                    <TD width="100%" style="padding-left:5px;">
                        <ANY:GRID id="gr_actualByTechList" pagingType="0"><COMMENT>
                            addColumn({ width:120, align:"left"  , type:"string" , sort:true, id:"REF_NO"            , name:"REF_NO" });
                            addColumn({ width:200, align:"left"  , type:"string" , sort:true, id:"KO_APP_TITLE"      , name:"발명의 명칭(한)" });
                            addColumn({ width:200, align:"left"  , type:"string" , sort:true, id:"EN_APP_TITLE"      , name:"발명의 명칭(영)" });
                            //addColumn({ width:75 , align:"center", type:"date"   , sort:true, id:"PATTEAM_RCPT_DATE" , name:"접수일" });
                            //addColumn({ width:75 , align:"center", type:"date"   , sort:true, id:"PATTEAM_REQ_DATE"  , name:"의뢰일" });
                            addColumn({ width:130, align:"left"  , type:"string" , sort:true, id:"PAT_APP_NO"            , name:"출원번호" });
                            addColumn({ width:75 , align:"center", type:"date"   , sort:true, id:"APP_DATE"          , name:"출원일" });
                            addColumn({ width:130, align:"string", type:"string" , sort:true, id:"REG_NO"            , name:"등록번호" });
                            addColumn({ width:75 , align:"center", type:"date"   , sort:true, id:"REG_DATE"          , name:"등록일" });
                            addColumn({ width:130, align:"string", type:"string" , sort:true, id:"PJT_NAME"            , name:"대표PJT" });
                            addColumn({ width:130, align:"string", type:"string" , sort:true, id:"OFFICE_NAME"       , name:"사무소" });
                            addColumn({ width:60 , align:"center", type:"string" , sort:true, id:"JOB_MAN_NAME"      , name:"담당자" });
                            addColumn({ width:100, align:"string", type:"string" , sort:true, id:"STATUS_NAME"       , name:"진행상태" });
                            addColumn({ width:75 , align:"center", type:"date"   , sort:true, id:"STATUS_DATE"       , name:"서류일자" });
                            addColumn({ width:100, align:"string", type:"string" , sort:true, id:"INVENTOR_NAMES"    , name:"발명자" });
                            messageSpan = "spn_gridMessage";
                            addAction("REF_NO", fnDetail);
                            addAction("PAT_APP_NO", fnAppno);
                        </COMMENT></ANY:GRID>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
