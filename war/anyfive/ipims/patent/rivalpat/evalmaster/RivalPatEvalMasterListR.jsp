<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>평가마스터</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<% app.writeHTCImport(app.HTC_TREE); %>
<ANY:DS id="ds_TechResultList" />
<SCRIPT language="JScript">
var gPriorCode;

//윈도우 로딩시
window.onready = function()
{
    fnRetrieveTechTree();
    fnSearch();
}

//기술분류 트리 조회
function fnRetrieveTechTree()
{
    var ldr = gr_techCodeTree.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrieveTechCodeSearchTree.do";

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//검색
function fnSearch()
{
    var ldr = gr_rivalPatList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.evalmaster.act.RetrieveRivalPatEvalMasterListTech.do";
    ldr.addParam("TECH_CODE"    , gPriorCode);
    ldr.addParam("EVAL_GRADE"   , EVAL_GRADE.value);
    ldr.addParam("EVAL_MAN"     , EVAL_MAN.value);
    ldr.addParam("KEY_WORD"     , KEY_WORD.value);
    ldr.addParam("SEARCH_FIELD" , getCheckValues());
    ldr.addParam("APP_DATE_START"    , APP_DATE_START.value);
    ldr.addParam("APP_DATE_END"      , APP_DATE_END.value);
    ldr.addParam("REG_DATE_START"    , REG_DATE_START.value);
    ldr.addParam("REG_DATE_END"      , REG_DATE_END.value);
    ldr.addParam("PRIORITY_DATE_START" , PRIORITY_DATE_START.value);
    ldr.addParam("PRIORITY_DATE_END" , PRIORITY_DATE_END.value);
    ldr.addParam("I_APP_DATE_START"  , I_APP_DATE_START.value);
    ldr.addParam("I_APP_DATE_END"    , I_APP_DATE_END.value);
    ldr.addParam("PUB_DATE_START"    , PUB_DATE_START.value);
    ldr.addParam("PUB_DATE_END"      , PUB_DATE_END.value);

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
    var win = new any.window(2);
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

//검색필드 선택 표시/숨김
function fnShowHideKeywordItem()
{
    var popup = window.createPopup();

    popup.document.body.onunload = function()
    {
        div_searchField.innerHTML = popup.document.body.innerHTML;
    }

    popup.document.createStyleSheet(top.getRoot() + "/anyfive/framework/css/style.css");
    popup.document.body.innerHTML = div_searchField.innerHTML;
    popup.show(0, btn_showHideKeywordItem.offsetHeight, 230, 250, btn_showHideKeywordItem);

    popup.document.getElementById("img_popupClose").onclick = function()
    {
        popup.hide();
    }
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnSearch();">
                <COLGROUP>
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                </COLGROUP>
                <TR>
                    <TD>출원일</TD>
                    <TD noWrap>
                        <ANY:DATE id="APP_DATE_START" />&nbsp;~
                        <ANY:DATE id="APP_DATE_END" />
                    </TD>
                    <TD>등록일</TD>
                    <TD noWrap>
                        <ANY:DATE id="REG_DATE_START" />&nbsp;~
                        <ANY:DATE id="REG_DATE_END" />
                    </TD>
                    <TD>공개일</TD>
                    <TD noWrap>
                        <ANY:DATE id="PUB_DATE_START" />&nbsp;~
                        <ANY:DATE id="PUB_DATE_END" />
                    </TD>
                </TR>
                <TR>
                    <TD>우선일</TD>
                    <TD noWrap>
                        <ANY:DATE id="PRIORITY_DATE_START" />&nbsp;~
                        <ANY:DATE id="PRIORITY_DATE_END" />
                    </TD>
                    <TD>국제출원일</TD>
                    <TD noWrap>
                        <ANY:DATE id="I_APP_DATE_START" />&nbsp;~
                        <ANY:DATE id="I_APP_DATE_END" />
                    </TD>
                    <TD>평가등급</TD>
                    <TD>
                        <ANY:SELECT id="EVAL_GRADE" codeData="{RIVALPAT_EVAL_GRADE}" firstname="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>검토자명</TD>
                    <TD>
                        <INPUT type="text" id="EVAL_MAN" />
                    </TD>
                    <TD>키워드</TD>
                    <TD colspan="3">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD width="100%">
                                    <INPUT type="text" id="KEY_WORD" />
                                </TD>
                                <TD>
                                    <BUTTON text="검색필드 선택" onClick="javascript:fnShowHideKeywordItem();" id="btn_showHideKeywordItem"></BUTTON>
                                    <BUTTON auto="line"></BUTTON>
                                    <BUTTON auto="search" onClick="javascript:fnSearch();"></BUTTON>
                                </TD>
                            </TR>
                        </TABLE>
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
                    <TD id="td_tree" width="250px">
                        <ANY:TREE id="gr_techCodeTree"><COMMENT>
                            parentColumn = "PRIOR_TECH_CODE";
                            codeColumn   = "TECH_CODE";
                            nameColumn   = "TECH_HNAME";
                            expandLevel  = 1;

                            addRoot(null, "ROOT", "ROOT");

                            fg.attachEvent("AfterRowColChange", function(iOldRow, iOldCol, iNewRow, iNewCol)
                            {
                                if (element.loader.loading == true) return;

                                gPriorCode = element.value(iNewRow, "TECH_CODE");
                                spn_techPathname.value = (iNewRow == 0 ? element.value(iNewRow, "TECH_HNAME") : element.value(iNewRow, "TECH_PATHNAME"));
                                fnSearch();
                            });
                        </COMMENT></ANY:TREE>
                    </TD>
                    <TD><ANY:SEPARATOR id1="td_tree" id2="td_grid" /></TD>
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

<DIV style="display:none;" id="div_searchField">
<DIV style="border:#CCCCCC 1px solid; padding:3px; width:100%; height:100%;">
<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" onDragStart="return false;">
    <TR>
        <TD height="1px" align="right">
            <IMG src="<%= request.getContextPath() %>/anyfive/framework/img/close.gif" id="img_popupClose" title="닫기" style="cursor:hand;">
        </TD>
    </TR>
    <TR>
        <TD height="2px"></TD>
    </TR>
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                <COLGROUP>
                    <COL class="conddata" width="50%">
                    <COL class="conddata" width="50%">
                </COLGROUP>
                <TR>
                    <TD><LABEL for="chk_searchField_01" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_01" onFocus="this.blur();" value="A.OWN_APP_MAN">출원인대표명</LABEL></TD>
                    <TD><LABEL for="chk_searchField_02" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_02" onFocus="this.blur();" value="A.COUNTRY_CODE">국가</LABEL></TD>
                </TR>
                <TR>
                    <TD><LABEL for="chk_searchField_03" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_03" onFocus="this.blur();" value="A.STATUS_CODE">권리구분</LABEL></TD>
                    <TD><LABEL for="chk_searchField_04" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_04" onFocus="this.blur();" value="A.APP_NO" checked>출원번호</LABEL></TD>
                </TR>
                <TR>
                    <TD><LABEL for="chk_searchField_05" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_05" onFocus="this.blur();" value="A.TITLE" checked>발명의명칭</LABEL></TD>
                    <TD><LABEL for="chk_searchField_06" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_06" onFocus="this.blur();" value="A.PRIORITY_NO">우선권번호</LABEL></TD>
                </TR>
                <TR>
                    <TD><LABEL for="chk_searchField_07" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_07" onFocus="this.blur();" value="A.I_APP_NO">국제출원번호</LABEL></TD>
                    <TD><LABEL for="chk_searchField_08" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_08" onFocus="this.blur();" value="A.PUB_NO">공개번호</LABEL></TD>
                </TR>
                <TR>
                    <TD><LABEL for="chk_searchField_09" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_09" onFocus="this.blur();" value="A.APP_MAN" checked>출원인</LABEL></TD>
                    <TD><LABEL for="chk_searchField_10" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_10" onFocus="this.blur();" value="A.APP_MAN_IDENTIFY_MARK">출원인식별기호</LABEL></TD>
                </TR>
                <TR>
                    <TD><LABEL for="chk_searchField_11" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_11" onFocus="this.blur();" value="A.INVENTOR" checked>발명자</LABEL></TD>
                    <TD><LABEL for="chk_searchField_12" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_12" onFocus="this.blur();" value="A.AGENT">대리인</LABEL></TD>
                </TR>
                <TR>
                    <TD><LABEL for="chk_searchField_13" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_13" onFocus="this.blur();" value="A.OWN_IPC">대표IPC</LABEL></TD>
                    <TD><LABEL for="chk_searchField_14" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_14" onFocus="this.blur();" value="A.IPC">IPC(all)</LABEL></TD>
                </TR>
                <TR>
                    <TD><LABEL for="chk_searchField_15" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_15" onFocus="this.blur();" value="A.FI">FI</LABEL></TD>
                    <TD><LABEL for="chk_searchField_16" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_16" onFocus="this.blur();" value="A.THEME_CODE">테마코드</LABEL></TD>
                </TR>
                <TR>
                    <TD><LABEL for="chk_searchField_17" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_17" onFocus="this.blur();" value="A.F_TERM">F-TERM</LABEL></TD>
                    <TD><LABEL for="chk_searchField_18" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_18" onFocus="this.blur();" value="US_CLASS">US class</LABEL></TD>
                </TR>
                <TR>
                    <TD><LABEL for="chk_searchField_19" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_19" onFocus="this.blur();" value="A.SUMMARY">요약</LABEL></TD>
                    <TD><LABEL for="chk_searchField_20" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_20" onFocus="this.blur();" value="A.REQCNT">청구항</LABEL></TD>
                </TR>
                <TR>
                    <TD><LABEL for="chk_searchField_21" style="cursor:hand;"><INPUT type="checkbox" name="chk_searchField" id="chk_searchField_21" onFocus="this.blur();" value="A.WIPS_KEY">WIPS키</LABEL></TD>
                    <TD></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>
</DIV>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
