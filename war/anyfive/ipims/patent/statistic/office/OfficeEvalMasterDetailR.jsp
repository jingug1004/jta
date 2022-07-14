<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사무소평가현황</TITLE>
<ANY:DS id="ds_officeEvalList" />
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve2();
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_officeEvalMasterDetail.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.office.act.RetrieveOfficeEvalMasterDetail.do";
    ldr.addParam("REF_ID", parent.REF_ID);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}



function fnRetrieve2()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.statistic.office.act.RetrieveEvalItem.do";

    prx.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);
    //prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        fnOfficeEvalList();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//사무소평가요소조회
function fnOfficeEvalList()
{
  var ds = ds_officeEvalList;
  var tbd = tbd_officeEvalList;
  var tr, td;

  for (var i = tbd.rows.length - 1; i >= 0; i--) {
      tbd.deleteRow(i);
  }

  var supTr = {};
  var supNo = 0;

  for (var i = 0; i < ds.rowCount; i++) {

          tr = tbd.insertRow();

          if (supTr[supNo] == null) {
              supTr[supNo] = tr;
          }

          tr.td = {};

          //번호
          tr.td.ITEM_SEQ = td = tr.insertCell();
          td.className = "listdata";
          td.align = "center";
          td.innerText = ds.value(i, "ITEM_SEQ");


          //세부평가요소
          tr.td.ITEM_NAME = td = tr.insertCell();
          td.className = "listdata";
          td.align = "left";
          td.innerText = ds.value(i, "ITEM_NAME");


  }
}


//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/statistic/office/EvalOpinionViewPop.jsp?EVALID="+gr.value(row, "EVAL_ID")+"&REFID="+gr.value(row, "REF_ID");
    win.opt.width = 500;
    win.opt.height = 200;

    win.onReturn = function(rtn)
    {

    }
    win.show();
}



</SCRIPT>


</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <TR>
        <TD class="listhead" width="10%">번호</TD>
        <TD class="listhead" width="40%">검토내용</TD>
    </TR>
    <TBODY id="tbd_officeEvalList"></TBODY>
</TABLE>
<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="50%">
<br>
    <TR>
        <TD height="50%">
            <ANY:GRID id="gr_officeEvalMasterDetail" pagingType="1"><COMMENT>
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"JOB_MAN_NAME"      , name:"평가자" });
                addColumn({ width:100, align:"center", type:"date"   , sort:true , id:"EVAL_DATE"         , name:"평가일" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"PAPER_FULL_NAME"   , name:"진행서류" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"ELEM_VALUE_1"      , name:"1" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"ELEM_VALUE_2"      , name:"2" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"ELEM_VALUE_3"      , name:"3" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"ELEM_VALUE_4"      , name:"4" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"ELEM_VALUE_5"      , name:"5" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"ELEM_VALUE_6"      , name:"6" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"ELEM_VALUE_7"      , name:"7" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"SUM_TOTAL"         , name:"합계" });

                //useConfig = true;
                //messageSpan = "spn_gridMessage";
                //addSorting("REF_NO", "DESC");
                addAction("PAPER_FULL_NAME", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE><br>
<DIV class="buttons_bottom" align="right">
    <BUTTON auto="list"></BUTTON>
</DIV>
<% app.writeBodyFooter(); %>

</BODY>
</HTML>
