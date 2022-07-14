<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%>
<%
    PatentApp app = new PatentApp(request, response, out);
%>
<%@page import="any.util.etc.NTextUtil"%>
<%@page import="any.util.etc.NDateUtil"%>
<%
    app.writeHTMLDocType();
%>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>Home</TITLE>
<%
    app.writeHTMLHeader();
%>
<%
    app.writeHTCImport(app.HTC_CHART);
%>
<%
    app.writeHTCImport(app.HTC_GRID);
%>
<ANY:DS id="ds_resultNation" />
<ANY:DS id="ds_resultTech" />
<LINK rel="StyleSheet" type="text/css" href="Home.css">
<link href="newstyle.css" rel="stylesheet" type="text/css">
<ANY:DS id="ds_boardConfig" />
<ANY:DS id="ds_boardList" />
<ANY:DS id="ds_toDoCount" />
<ANY:DS id="ds_patentCountList" />
<ANY:DS id="ds_dueDateCount" />
<ANY:DS id="ds_bizFlowCount" />
<SCRIPT language="JScript">
var gBoardConfig;
var gBoardId;

//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    document.getElementsByName("tab_board")[0].click();
    fnRetrieveToDoCount();
    fnRetrievePatentListCount();

    //해당 공지기간의 공지사항 팝업조회
    //fnOpenBoardTemp();
}


function fnRetrieve()
{
    var prx = gr_nationChartList.loader;
    var prx2 = gr_nationChartList2.loader;

    var gr = gr_nationChartList;
    var fg = gr.fg;

    prx.init();
    prx2.init();

    prx.path = top.getRoot() + "/anyfive.ipims.patent.statistic.viewchart.act.RetrieveMainNationChartPopList.do"; //국가별 특허보유현황
    prx2.path = top.getRoot() + "/anyfive.ipims.patent.statistic.viewchart.act.RetrieveMainTechChartPopList.do"; //기술별 특허보유현황
     prx.onSuccess = function()
    {

    }
     prx2.onSuccess = function(gr, fg)
     {

     }
    prx.onFail = function(gr, fg)
    {
        this.error.show();
    }
    prx2.onFail = function(gr, fg)
    {
        this.error.show(gr, fg);
    }
    prx.execute();
    prx2.execute();
}


//게시판 설정 조회
function fnRetrieveBoardConfig(brdId)
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.board.act.RetrieveBoardConfig.do";
    prx.addParam("BRD_ID", brdId);
    prx.hideMessage = true;

    prx.onStart = function()
    {
        fnClearTbodyRows(tbd_boardList, true);
    }

    prx.onSuccess = function()
    {
        gBoardId = brdId;
        gBoardConfig = new Object();
        for (var c = 0; c < ds_boardConfig.colCount; c++) {
            gBoardConfig[ds_boardConfig.colId(c)] = ds_boardConfig.value(0, c);
        }
        fnRetrieveBoardList(brdId);

    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//게시판 목록 조회
function fnRetrieveBoardList(brdId)
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.home.act.RetrieveBoardList.do";
    prx.addParam("BRD_ID", brdId);
    prx.hideMessage = true;

    prx.onStart = function()
    {
        fnClearTbodyRows(tbd_boardList, true);
    }

    prx.onSuccess = function()
    {
        fnClearTbodyRows(tbd_boardList);
        fnCreateBoardList();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//게시판 목록 생성
function fnCreateBoardList()
{
    var ds = ds_boardList;
    var tr, td;
    var spn, a;
    var html;

    for (var r = 0; r < ds.rowCount; r++) {
        tr = tbd_boardList.insertRow();

        td = tr.insertCell();
        td.className = "ipims_portlet_line";

        html = new Array();

        html.push('<TABLE border="0" cellspacing="0" cellpadding="0" width="100%">');
        html.push('    <TR>');
        html.push('        <TD id="td_boardTitle_' + r + '" style="color:#555555;"></TD>');
        html.push('        <TD id="td_boardDate_' + r + '" style="color:#555555;" align="right" noWrap></TD>');
        html.push('    </TR>');
        html.push('</TABLE>');

        td.innerHTML = html.join("\n");

        spn = document.createElement('<SPAN>');
        spn.style.paddingLeft = ds.value(r, "RE_LEVEL") * 20 + 5;
        document.getElementById("td_boardTitle_" + r).appendChild(spn);

        a = document.createElement('<A href="javascript:fnOpenBoard(' + r + ');" style="text-decoration:none;" onFocus="this.blur();">');
        a.innerText = (ds.value(r, "RE_LEVEL") == "0" ? "" : "[RE] ") + ds.value(r, "SUBJECT");
        a.title = ds.value(r, "SUBJECT");
        spn.appendChild(a);

        document.getElementById("td_boardDate_" + r).innerText = cfGetFormatDate(ds.value(r, "CRE_DATE"));
    }
}

//게시판 상세
function fnOpenBoard(row)
{
    var win = new any.window(2);
    win.path = top.getRoot() + "/anyfive/ipims/share/board/BoardRD.jsp";
    win.arg.brdConfig = gBoardConfig;
    win.arg.readCntAdd = 1;
    win.arg.BRD_NO = ds_boardList.value(row, "BRD_NO");
    win.opt.resizable = "yes";

    win.onReload = function()
    {
        fnRetrieveBoardList(ds_boardList.value(row, "BRD_ID"));
    }

    win.show();
}

//임시 게시판 상세
function fnOpenBoardTemp()
{
    var brdConfig = [];
    brdConfig.MENU_NAME = "1";
    brdConfig.FILE_POLICY = "1";
    brdConfig.ANS_AVAIL = "0";
    brdConfig.BRD_ID = "PAT_NOTICE";

    var win = new any.window(2);
    win.path = top.getRoot() + "/anyfive/ipims/share/board/BoardRD.jsp";

    win.arg.brdConfig = brdConfig;
    win.arg.readCntAdd = 1;
    win.arg.BRD_NO = "000000000058";
    win.opt.resizable = "yes";

    win.onReload = function()
    {
    }

    win.show();
}

//게시판 팝업조회상세
function fnOpenBoardList(row)
{
    var win = new any.window(2);
    win.path = top.getRoot() + "/anyfive/ipims/share/board/BoardListR.jsp";
    win.arg.brdConfig = gBoardConfig;
    win.arg.brdId = gBoardId;
    win.opt.resizable = "yes";

    win.onReload = function()
    {
    }
    win.show();
}

//To Do 건수 조회
function fnRetrieveToDoCount()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.home.act.RetrieveToDoCount.do";
    prx.hideMessage = true;

    prx.onSuccess = function()
    {
        for (var i = 0; i < ds_toDoCount.rowCount; i++) {
            fnSetCountValue("TODO_" + ds_toDoCount.value(i, "ID"), ds_toDoCount.value(i, "CNT"));
        }
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//특허보유현황 건수조회
function fnRetrievePatentListCount()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.home.act.RetrievePatentCountList.do";
    prx.hideMessage = true;

    prx.onSuccess = function()
    {
        for( var i = 0; i < ds_patentCountList.rowCount; i++){
            fnSetCountValue("PATENT_" + ds_patentCountList.value(i, "ID"), ds_patentCountList.value(i,"CNT"));
        }
    }
    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();

}

//건수 셋팅
function fnSetCountValue(objId, val)
{
    var obj = document.getElementById(objId);

    if (obj != null) obj.innerText = cfGetFormatNumber(val);
}

//To-Do List 목록
function fnOpenToDoList(kind)
{
    var win = new any.window();

    win.opt.width = 800;
    win.opt.height = 500;
    win.opt.resizable = "yes";

    switch (kind) {
    case "APPR":
        parent.any_menuLeft.go("/anyfive/ipims/patent/approval/ApprovalAnsListR.jsp");
        break;
    case "EVAL":
        win.path = "ToDoEvalListR.jsp";
        break;
    case "NEW":
        win.path = "ToDoNewListR.jsp";
        break;
    case "PAPER":
        win.path = "ToDoPaperListR.jsp";
        break;
    }

    if (win.path == null) return;

    win.show();

    fnRetrieveToDoCount();
}

// 그림목록 팝법
function fnOpenMenu(name)
{

    var win = new any.window();

    win.opt.width = 800;
    win.opt.height = 250;
    win.opt.resizable = "yes";


    switch (name) {
    case "ToDoListR":  //기관관리현황
        parent.any_menuLeft.go("/anyfive/ipims/patent/applymgt/priorjob/todolist/ToDoListR.jsp");
        break;
    case "IntPatentConsultListR":  //국내출원품의
        parent.any_menuLeft.go("/anyfive/ipims/patent/applymgt/intpatent/consult/IntPatentConsultListR.jsp");
        break;
    case "DocPaperListR": //출원진행현황
        win.path = "Mainpop.jsp?gubun=App";
        break;
    case "ListR": //OA진행현황
        win.path = "Mainpop.jsp?gubun=Oa";
        break;
    case "IntPatentRequestC": //발명신고서작성
        parent.any_menuLeft.go("/anyfive/ipims/patent/applymgt/intpatent/request/IntPatentRequestC.jsp");
        break;
    case "IntPatentRequestListR": //발명신고서현황
        parent.any_menuLeft.go("/anyfive/ipims/patent/applymgt/intpatent/request/IntPatentRequestListR.jsp");
        break;
    case "DueDateListR": //MY-due-date
        win.path = "Mainpop.jsp?gubun=Due";
        break;
    case "ContractListR": //계약서현황
        parent.any_menuLeft.go("/anyfive/ipims/patent/ipbiz/contract/ContractListR.jsp");
        break;
    }
    if (win.path == null) return;

    win.show();

}

//업무현황 목록
function fnOpenBizFlowList(bizFlowId)
{
    var win = new any.window();
    win.path = "BizFlowListR.jsp";
    win.arg.BIZ_FLOW_ID = bizFlowId;
    win.opt.width = 750;
    win.opt.height = 500;
    win.opt.resizable = "yes";
    win.show();
}

//TBODY Row 삭제
function fnClearTbodyRows(tbd, isLoading)
{
    if (tbd == null) return;

    for (var r = tbd.rows.length - 1; r >= 0; r--) {
        tbd.deleteRow(r);
    }

    if (isLoading != true) return;

    var tr, td;

    tr = tbd.insertRow();

    td = tr.insertCell();
    td.style.padding = "5px";
    td.innerText = "Loading...";
}

//팝업으로 해당데이터 상세보기
function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/IntMasterTabR.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.arg.gr = gr;
    win.opt.width = 800;
    win.opt.height = 600;

    win.onReload = function()
    {
        gr_nationChartList.loader.reload();
    }

    win.show();
}

function fntechpop()
{
    var win = new any.window(2);
    win.path = "Techpop.jsp";
    win.opt.width = 750;
    win.opt.height =200;
    win.opt.resizable = "yes";
    win.show();
}


function fnnationpop()
{
   var win = new any.window(2);
   win.path = "Nationpop.jsp";
   win.opt.width = 750;
   win.opt.height = 300;
   win.opt.resizable = "yes";
   win.show();
}
</SCRIPT>

<!-- 게시판 탭 클릭시 -->
<SCRIPT language="JScript" for="tab_board" event="onclick()">
    var tabs = document.getElementsByName("tab_board");
    for (var i = 0; i < tabs.length; i++) {
        tabs[i].className = (tabs[i] == this ? "ipims_tab_on" : "ipims_tab_off");
    }
    fnRetrieveBoardConfig(this.brdId);
</SCRIPT>
</HEAD>
<BODY scroll="auto">
<div style="width: 100%; padding: 15px 13px 0px 13px;">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td width="156" valign="top"><!---to do start--->
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="jupos_portlet_head">To do List</td>
                <td class="jupos_portlet_title" valign="bottom">&nbsp;</td>
                <td class="jupos_portlet_title" align="right"><img
                    src="image/ipims_title_end.gif" width="6" height="32"></td>
            </tr>
            <tr>
                <td height="120" colspan="3" class="jupos_portlet_content">
                <table border="0" cellpadding="0" cellspacing="0" height="100%"
                    width="100%" class="ipims_to_do">
                    <TR style="cursor: hand"
                        onClick="javascript:fnOpenToDoList('APPR');">
                        <TD class="jupos_to_do">결재함<SPAN class="ipims_text01">(<SPAN
                            id="TODO_APPR"></SPAN>)</SPAN></TD>
                    </TR>
                    <TR style="cursor: hand"
                        onClick="javascript:fnOpenToDoList('EVAL');">
                        <TD class="jupos_to_do">평가<SPAN class="ipims_text01">(<SPAN
                            id="TODO_EVAL"></SPAN>)</SPAN></TD>
                    </TR>
                    <TR style="cursor: hand"
                        onClick="javascript:fnOpenToDoList('NEW');">
                        <TD class="jupos_to_do">신규접수<SPAN class="ipims_text01">(<SPAN
                            id="TODO_NEW"></SPAN>)</SPAN></TD>
                    </TR>
                    <TR style="cursor: hand"
                        onClick="javascript:fnOpenToDoList('PAPER');">
                        <TD class="jupos_to_do">진행서류<SPAN class="ipims_text01">(<SPAN
                            id="TODO_PAPER"></SPAN>)</SPAN></TD>
                    </TR>
                </table>
                </td>
            </tr>
            <tr>
                <td class="jupos_portlet_b_bg"><img
                    src="image/ipims_portlet_b_left.gif"></td>
                <td class="jupos_portlet_b_bg"></td>
                <td class="jupos_portlet_b_bg" align="right"><img
                    src="image/ipims_portlet_b_right.gif"></td>
            </tr>
        </table>
        <!---to do end---></td>
        <td width="10"><img src="image/padding_10.gif" width="10"
            height="1"></td>
        <td width="449" valign="top"><!---quick menu start--->
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td width="7" height="120"><img
                    src="image/quick_menu_bg_l.gif" width="7" height="198"></td>
                <td width="" background="image/quick_menu_bg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                   <%
                   if( app.userInfo.getDeptName().equals("특허팀")){
                   %>

                    <tr style="cursor: hand">
                        <td class="quick"><img src="image/quick_img1.gif"
                            onClick="javascript:fnOpenMenu('ToDoListR')"><br>
                        특허기한관리</td>
                        <td class="quick"><img src="image/quick_img2.gif"
                            onClick="javascript:fnOpenMenu('IntPatentConsultListR')"><br>
                        국내출원품의</td>
                        <td class="quick"><img src="image/quick_img3.gif"
                            onClick="javascript:fnOpenMenu('DocPaperListR')"><br>
                        출원진행현황</td>
                        <td class="quick_no"><img src="image/quick_img4.gif"
                            onClick="javascript:fnOpenMenu('ListR')"><br>
                        OA진행현황</td>
                    </tr>
                    <tr style="cursor: hand">
                        <td class="quick"><img src="image/quick_img7.gif"
                            onClick="javascript:fnOpenMenu('IntPatentRequestC')"><br>
                        발명신고서작성</td>
                        <td class="quick"><img src="image/quick_img8.gif"
                            onClick="javascript:fnOpenMenu('IntPatentRequestListR')"><br>
                        발명신고현황</td>
                        <td class="quick"><img src="image/quick_img5.gif"
                            onClick="javascript:fnOpenMenu('DueDateListR')"><br>
                        MY Due-Date현황</td>
                        <td class="quick_no"><img src="image/quick_img6.gif"
                            onClick="javascript:fnOpenMenu('ContractListR')"><br>
                        계약서 현황</td>
                    </tr>
                    <%}
                   else{%>
                   <tr>
                        <td class="quick"><img src="image/quick_img1.gif"
                            onClick="javascript:fnOpenMenu('ToDoListR')"><br>
                      특허기한관리 </td>
                        <td class="quick"><img src="image/quick_img2.gif"
                            onClick="javascript:fnOpenMenu('IntPatentConsultListR')"><br>
                      국내출원품의</td>
                        <td  style="cursor: hand" class="quick"><img src="image/quick_img3.gif"
                            onClick="javascript:fnOpenMenu('DocPaperListR')"><br>
                      출원진행현황</td>
                        <td  style="cursor: hand" class="quick_no"><img src="image/quick_img4.gif"
                            onClick="javascript:fnOpenMenu('ListR')"><br>
                    OA진행현황</td>
                    </tr>
                    <tr>
                        <td  style="cursor: hand" class="quick"><img src="image/quick_img7.gif"
                            onClick="javascript:fnOpenMenu('IntPatentRequestC')"><br>
                       발명신고서작성</td>
                        <td  style="cursor: hand" class="quick"><img src="image/quick_img8.gif"
                            onClick="javascript:fnOpenMenu('IntPatentRequestListR')"><br>
                       발명신고현황</td>
                        <td  style="cursor: hand" class="quick"><img src="image/quick_img5.gif"
                            onClick="javascript:fnOpenMenu('DueDateListR')"><br>
                     MY Due-Date현황</td>
                        <td class="quick_no"><img src="image/quick_img6.gif"
                            onClick="javascript:fnOpenMenu('ContractListR')"><br>
                        계약서 현황</td>
                    </tr>
                   <%} %>
                </table>
                </td>
                <td width="7"><img src="image/quick_menu_bg_r.gif" width="9"
                    height="198"></td>
            </tr>
        </table>
        <!---quick menu end---></td>
        <td width="10"><img src="image/padding_10.gif" width="10"
            height="1"></td>
        <td width="398" valign="top"><!---공지사항 start--->
        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
            <TR>
                <TD class="ipims_portlet_head"></TD>
                <TD class="ipims_portlet_title" valign="bottom">
                <TABLE border="0" cellspacing="0" cellpadding="0">
                    <TR>
                        <td id="tab_board" class="jupos_tab_on" noWrap brdId="PAT_NOTICE">공지사항</td>
                        <td id="tab_board" class="jupos_tab_off" noWrap brdId="PAT_QNA">Q
                        &amp; A</td>
                        <td id="tab_board" class="jupos_tab_off" noWrap brdId="INV_DATA">자료실</td>
                        <td id="tab_board" class="jupos_tab_off" nowrap brdId="PAT_CONT">표준계약서</td>
                    </TR>
                </TABLE>
                </TD>
                <TD class="ipims_portlet_title" align="right"><IMG
                    src="image/ipims_title_end.gif" width="6" height="32"></TD>
            </TR>
            <TR>
                <TD height="120" colspan="3" class="ipims_portlet_content">
                <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                    <TBODY id="tbd_boardList"></TBODY>
                    <TR valign="bottom">
                        <TD><img style="cursor: hand" src="image/more.gif"
                            onClick="javascript:fnOpenBoardList()" align="right"></TD>
                    </TR>
                </TABLE>
                </TD>
            </TR>            <TR>
                <TD class="ipims_portlet_b_bg"><IMG
                    src="image/ipims_portlet_b_left.gif"></TD>
                <TD class="ipims_portlet_b_bg"></TD>
                <TD class="ipims_portlet_b_bg" align="right"><IMG
                    src="image/ipims_portlet_b_right.gif"></TD>
            </TR>
        </TABLE>
        <!---공지사항 end---></td>
        <td width="10"><img src="image/padding_10.gif" width="10"
            height="1"></td>
        <td valign="top"><!---유용한사이트 start--->
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="jupos_portlet_head">특허보유현황</td>
                <td class="jupos_portlet_title" valign="bottom">&nbsp;</td>

                <td class="jupos_portlet_title" align="right"><img
                    src="image/ipims_title_end.gif" width="6" height="32"></td>
            </tr>
            <tr>
                <td height="120" colspan="3" class="jupos_portlet_content">
                <table border="0" cellpadding="0" cellspacing="0" height="100%"
                    width="100%">
                    <tr>
                        <td class="jupos_p">전체특허건수 : <span class="jupos_text01"><SPAN
                            id="PATENT_ALL"></SPAN></span>건</td>
                    </tr>
                    <tr>
                        <td class="jupos_p">전체등록건수 : <span class="jupos_text01"><SPAN
                            id="PATENT_REG"></SPAN></span>건<br>
                        </td>
                    </tr>
                    <tr>
                        <td class="jupos_p2">전체출원건수 : <span class="jupos_text01"><SPAN
                            id="PATENT_APP"></SPAN></span>건</td>
                    </tr>
                </table>
                </td>
            </tr>
            <tr>
                <td class="jupos_portlet_b_bg"><img
                    src="image/ipims_portlet_b_left.gif"></td>
                <td class="jupos_portlet_b_bg"></td>
                <td class="jupos_portlet_b_bg" align="right"><img
                    src="image/ipims_portlet_b_right.gif"></td>
            </tr>
        </table>
        <!---유용한사이트 end---></td>
    </tr>
</table>
</div>
<!---Content Area start--->
<div style="width: 100%; padding: 15px 13px 0px 13px; height:100%" >
<table width="100%" border="0" cellpadding="0" cellspacing="0"  height="100%">
    <tr>
        <td valign="top"><!---기술별특허보유현황 start--->
         <table border="0" cellpadding="0" cellspacing="0" width="100%" >
            <tr>
                <td colspan="2" class="jupos_portlet_head03">&nbsp;&nbsp;기술별 특허보유현황&nbsp;</td>
                <!-- <img src="image/more.gif"
                    style="cursor: hand" onClick ="javascript:fntechpop()" align="absmiddle"> -->
                <td width="379" height="200" align="right" class="jupos_portlet_title"><img
                    src="image/ipims_title_end.gif" width="6" height="32"
                    align="absmiddle"></td>
            </tr>
            <tr>
                <td height="161" colspan="3" align="center"
                    class="jupos_portlet_content2">
               <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                    <TR>
                        <TD height="500px" width="100%">
                        <ANY:GRID id="gr_nationChartList2" pagingType="0" ><COMMENT>
                                addColumn({ width:80, align:"center", type:"string", sort:false, id:"TECH_CODE" , name:"구분"  })
                                addColumn({ width:80, align:"center", type:"string", sort:false, id:"KR" })
                                addColumn({ width:80, align:"center", type:"string", sort:false, id:"US" })
                                addColumn({ width:80, align:"center", type:"string", sort:false, id:"CN" })
                                addColumn({ width:80, align:"center", type:"string", sort:false, id:"TW" })
                                addColumn({ width:80, align:"center", type:"string", sort:false, id:"JP" })
                                addColumn({ width:80, align:"center", type:"string", sort:false, id:"PCT" })
                                addColumn({ width:80, align:"center", type:"string", sort:false, id:"EP" })
                                addColumn({ width:80, align:"center", type:"string", sort:false, id:"DE" })

                                setFixedColumn("TECH_CODE");
                          </COMMENT></ANY:GRID>
                        </TD>
                     </TR>
                </TABLE>
              </td>
            </tr>
            <tr>
                <td width="108" class="jupos_portlet_b_bg"><img
                    src="image/ipims_portlet_b_left.gif"></td>
                <td width="300" class="jupos_portlet_b_bg"></td>
                <td class="jupos_portlet_b_bg" align="right"><img
                    src="image/ipims_portlet_b_right.gif"></td>
            </tr>
        </table>
        <!---기술별특허보유현황 end---></td>
        <td width="10"><img src="image/padding_10.gif" width="10"
            height="1"></td>
        <td valign="top"><!---국가별특허보유현황 start--->
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td colspan="2" class="jupos_portlet_head03">&nbsp;&nbsp;국가별 특허보유현황&nbsp;</td>
                <!-- <img style="cursor: hand" src="image/more.gif"   onClick="javascript:fnnationpop()" align="absmiddle"> -->
                <td width="379" height="200" align="right" class="jupos_portlet_title"><img
                    src="image/ipims_title_end.gif" width="6" height="32"
                    align="absmiddle"></td>
            </tr>
            <tr>
                <td height="161" colspan="3" align="center"
                    class="jupos_portlet_content2">
                    <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                    <TR>
                        <TD height="500px" width="100%">
                        <ANY:GRID id="gr_nationChartList" pagingType="0"><COMMENT>
                                addHeader([ null, "누계","", "당해년도", "", ]);
                                addColumn({ width:70, align:"center", type:"string", sort:false,  id:"CODE"  , name:"구분" })
                                addColumn({ width:150, align:"center", type:"string", sort:false, id:"TO_APP" , name:"출원"  });
                                addColumn({ width:150, align:"center"  , type:"number", sort:false, id:"TO_REG" , name:"등록"   });
                                addColumn({ width:150, align:"center"  , type:"number", sort:false, id:"Y_APP"  , name:"출원"  });
                                addColumn({ width:150, align:"center"  , type:"number", sort:false, id:"Y_REG"  , name:"등록"  });
                                setFixedColumn("CODE");
                          </COMMENT></ANY:GRID>
                        </TD>
                     </TR>
                  </TABLE>
                </td>
            </tr>
            <tr>
                <td width="108" class="jupos_portlet_b_bg"><img
                    src="image/ipims_portlet_b_left.gif"></td>
                <td width="300" class="jupos_portlet_b_bg"></td>
                <td class="jupos_portlet_b_bg" align="right"><img
                    src="image/ipims_portlet_b_right.gif"></td>
            </tr>
        </table>
        <!---국가별 특허보유현황 end---></td>
    </tr>
</table>
<div style="padding-top: 25px;"></div>
<!---Content Area End---></div>
<%
    app.writeBodyFooter();
%>
</BODY>
</HTML>
