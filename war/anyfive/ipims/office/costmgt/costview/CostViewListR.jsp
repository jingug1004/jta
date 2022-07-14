<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>건별비용현황</TITLE>
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
    var ldr = gr_costViewList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.office.costmgt.costview.act.RetrieveCostViewList.do";
    ldr.addParam("SEARCH_TYPE" , SEARCH_TYPE.value);
    ldr.addParam("SEARCH_TEXT" , SEARCH_TEXT.value);
    ldr.addParam("INOUT_DIV"   , INOUT_DIV.value);
    ldr.addParam("RIGHT_DIV"   , RIGHT_DIV.value);
    ldr.addParam("JOB_MAN"     , JOB_MAN.value);
    ldr.addParam("DATE_GUBUN"  , DATE_GUBUN.value);
    ldr.addParam("DATE_START"  , DATE_START.value);
    ldr.addParam("DATE_END"    , DATE_END.value);

    ldr.onStart = function(gr, fg)
    {
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
    var win = new any.viewer();
    win.path = top.getRoot() + "/anyfive/ipims/office/costmgt/costview/CostViewRD.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.arg.gr = gr;

    win.onReload = function()
    {

    }

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
        <TD>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                </COLGROUP>
                <TR>
                    <TD>검색번호</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="SEARCH_TYPE" codeData="/costmgt/costInputSearchNoDiv" style="width:80px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SEARCH_TEXT" style="text-transform:uppercase;">
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>국내외구분</TD>
                    <TD>
                        <ANY:SELECT id="INOUT_DIV" codeData="{INOUT_DIV}" firstName="all" />
                    </TD>
                    <TD>권리구분</TD>
                    <TD>
                        <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV_ALL}" firstName="all"/>
                    </TD>
                </TR>
                <TR>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobManAll" firstName="all"/>
                    </TD>
                    <TD>검색일자</TD>
                    <TD colspan="3" noWrap>
                        <ANY:SELECT id="DATE_GUBUN" codeData="/costmgt/costInputSearchDateDiv" firstName="none" style="width:80px; margin-right:3px;" />
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
                        <BUTTON auto="retrieve" onClick="javascript:fnRetrieve();"></BUTTON>
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
            <ANY:GRID id="gr_costViewList" pagingType="0"><COMMENT>
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"REF_NO"         , name:"REF-NO" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"RIGHT_DIV_NAME" , name:"권리구분" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"INOUT_DIV_NAME" , name:"국내외" });
                addColumn({ width:130, align:"left"  , type:"string" , sort:true , id:"KO_APP_TITLE"   , name:"발명의 명칭" });
                //addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"OFFICE_NAME"    , name:"사무소" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"APP_NO"         , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"APP_DATE"       , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"REG_NO"         , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"REG_DATE"       , name:"등록일" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"JOB_MAN_NAME"   , name:"건담당자" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_CHK", "REF_NO");
                addSorting("REF_NO", "DESC");
                addAction("REF_NO", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
