<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
var gDiv;

//윈도우 로딩시
window.onready = function()
{
    fnInitLayers();
}

//레이어 초기화
function fnInitLayers()
{
    fnCreateLayer(-44, 54, "직무발명작성", "INT_PA01");
    fnCreateLayer(-44, 99, "발명부서장결재중", "INT_PA02");
    fnCreateLayer(-44, 145, "담당자지정", "INT_PA03");
    fnCreateLayer(-44, 190, "특허팀접수완료", "INT_PA11");
    fnCreateLayer(-44, 236, "출원품의", "INT_PA04");
    fnCreateLayer(-44, 286, "품의결재", "INT_PA05");

    fnCreateLayer(88, 91, "수정여부");
    fnCreateLayer(90, 286, "사무소접수", "INT_PA06");
    fnCreateLayer(90, 145, "명세서검토", "INT_PA08");
    fnCreateLayer(90, 236, "명세서작성", "INT_PA07");

    fnCreateLayer(203, 236, "제출", "INT_PA09");
    fnCreateLayer(203, 286, "출원", "INT_PA10");

    fnCreateLayer(341, 52, "OA발생", "INT_OA01");
    fnCreateLayer(341, 97, "대응방안검토", "INT_OA02");
    fnCreateLayer(341, 155, "대응");
    fnCreateLayer(341, 283, "포기", "INT_OA06");

    fnCreateLayer(474, 91, "수정여부");
    fnCreateLayer(476, 143, "의견안 검토", "INT_OA04");
    fnCreateLayer(476, 234, "의견안 작성", "INT_OA03");

    fnCreateLayer(589, 234, "제출", "INT_OA05");
    fnCreateLayer(589, 285, "대응완료");
}

//레이어 생성
function fnCreateLayer(left, top, title, wfId)
{
    var div;
    var spn;

    left += 10;
    top  += 10;

    div = document.createElement('<DIV style="position:absolute; left:' + left + '; top:' + top + '; width:200px; text-align:center; white-space:nowrap;">');
    div.wfId = wfId;
    document.body.appendChild(div);

    spn = document.createElement('<SPAN>');
    spn.innerText = title;
    div.appendChild(spn);
    div.titleSpan = spn;

    div.style.cursor = "default";

    if (wfId == null) return;

    spn = document.createElement('<SPAN>');
    spn.id = "spn_" + wfId;
    spn.style.marginLeft = "3px";
    spn.innerText = "...";
    div.appendChild(spn);

    spn = document.createElement('<SPAN>');
    spn.innerText = '건';
    div.appendChild(spn);

    div.style.cursor = "hand";

    div.onclick = function()
    {
        fnRetrieveList(this);
    }

    fnRetrieveCnt(wfId);
}

//건수 조회
function fnRetrieveCnt(wfId)
{
    if (wfId == null) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.bizflow.act.RetrieveIntPatentBizFlowCount.do";
    prx.addParam("WF_ID", wfId);
    prx.hideMessage = true;

    prx.onSuccess = function()
    {
        var spn = document.getElementById("spn_" + wfId);

        if (spn != null) {
            spn.innerText = cfGetFormatNumber(prx.result);
        }
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//목록 조회
function fnRetrieveList(div)
{
    var ldr = gr_bizFlowList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.bizflow.act.RetrieveIntPatentBizFlowList.do";
    ldr.addParam("WF_ID", div.wfId);

    ldr.onStart = function(gr, fg)
    {
        fnSetGridHeader(div);
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

//그리드 헤더 설정
function fnSetGridHeader(div)
{
    if (gDiv == div) return;

    gDiv = div;

    td_title.style.display = "block";
    spn_title.innerText = div.titleSpan.innerText;

    var gr = gr_bizFlowList;

    gr.init();

    gr.addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"               , name:"No" });

    switch(div.wfId){
    case 'INT_PA01' : //직무발명작성
    case 'INT_PA02' : //직무발명검토
        gr.addColumn({ width:101 , align:"left"  , type:"string", sort:true , id:"REF_NO"               , name:"REF-NO" });
        gr.addColumn({ width:301 , align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"         , name:"발명의 명칭" });
        gr.addColumn({ width:129 , align:"left"  , type:"string", sort:true , id:"INVENTOR_NAMES"       , name:"발명자" });
        gr.addColumn({ width:75  , align:"center", type:"date"  , sort:true , id:"CRE_DATE"             , name:"작성일" });
        gr.addColumn({ width:87  , align:"center", type:"string", sort:true , id:"CRE_USER_NAME"        , name:"작성자" });
        gr.addColumn({ width:89  , align:"left"  , type:"string", sort:true , id:"STATUS_NAME"          , name:"진행상태" });
        gr.addColumn({ width:75  , align:"center", type:"date"  , sort:true , id:"PATTEAM_RCPT_DATE"    , name:"지적대산팀접수일" });
        gr.addColumn({ width:73  , align:"center", type:"string", sort:true , id:"EXAM_RESULT_NAME"     , name:"검토결과" });
        gr.addColumn({ width:109 , align:"center", type:"string", sort:true , id:"JOB_MAN_NAME"         , name:"지적재산팀담당자" });
        gr.addSorting("REF_NO", "DESC");
        break;
    case 'INT_PA03' : //담당자지정
        gr.addColumn({ width:299 , align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"         , name:"발명의 명칭" });
        gr.addColumn({ width:205 , align:"left"  , type:"string", sort:true , id:"INVENTOR_NAMES"       , name:"발명자" });
        gr.addColumn({ width:110 , align:"center", type:"string", sort:true , id:"REF_NO"               , name:"REF-NO" });
        gr.addColumn({ width:75  , align:"left"  , type:"date"  , sort:true , id:"PATTEAM_RCPT_DATE"    , name:"지적재산팀의뢰일" });
        gr.addColumn({ width:103 , align:"center", type:"string", sort:true , id:"CRE_USER_NAME"        , name:"작성자" });
        break;
    case 'INT_PA11' : //특허팀접수완료
    case 'INT_PA04' : //출원품의
    case 'INT_PA05' : //품의결재
    case 'INT_PA07' : //명세서작성
    case 'INT_PA06' : //사무소접수
    case 'INT_PA09' : //제출(출원현황)
    case 'INT_PA10' : //출원
        gr.addColumn({ width:95  , align:"left"  , type:"string", sort:true , id:"REF_NO"               , name:"REF-NO" });
        gr.addColumn({ width:296 , align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"         , name:"발명의 명칭" });
        gr.addColumn({ width:75  , align:"left"  , type:"date"  , sort:true , id:"CRE_DATE"             , name:"작성일" });
        gr.addColumn({ width:86  , align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"          , name:"사무소" });
        gr.addColumn({ width:75  , align:"left"  , type:"date"  , sort:true , id:"OFFICE_SEND_DATE"     , name:"사무소위임일" });
        gr.addColumn({ width:147 , align:"left"  , type:"string", sort:true , id:"INVENTOR_NAMES"       , name:"발명자" });
        gr.addColumn({ width:71  , align:"center", type:"string", sort:true , id:"JOB_MAN_NAME"         , name:"담당자" });
        gr.addColumn({ width:68  , align:"left"  , type:"string", sort:true , id:"RIGHT_DIV_NAME"       , name:"권리구분" });
        break;
    case 'INT_PA08' : //명세서 검토
    case 'INT_OA01' : //OA발생
    case 'INT_OA02' : //대응방안검토
    case 'INT_OA06' : //포기
    case 'INT_OA04' : //의견안 검토
    case 'INT_OA03' : //의견안 작성
    case 'INT_OA05' : //제출(OA현황)
        gr.addColumn({ width:73  , align:"left"  , type:"string", sort:true , id:"REF_NO"               , name:"REF_NO" });
        gr.addColumn({ width:112 , align:"left"  , type:"string", sort:true , id:"APP_NO"               , name:"출원번호" });
        gr.addColumn({ width:92  , align:"left"  , type:"string", sort:true , id:"PAPER_NAME"           , name:"진행서류명" });
        gr.addColumn({ width:117 , align:"left"  , type:"string", sort:true , id:"COMMENTS"             , name:"기타사항" });
        gr.addColumn({ width:223 , align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"         , name:"발명의 명칭" });
        gr.addColumn({ width:70  , align:"left"  , type:"string", sort:true , id:"INVENTOR_NAMES"       , name:"발명자" });
        gr.addColumn({ width:75  , align:"center", type:"date"  , sort:true , id:"PAPER_DATE"           , name:"서류일자" });
        gr.addColumn({ width:75  , align:"center", type:"date"  , sort:true , id:"DUE_DATE"             , name:"법정기한" });
        gr.addColumn({ width:87  , align:"left"  , type:"string", sort:true , id:"OFFICE_CODE_NAME"     , name:"사무소" });
        gr.addColumn({ width:70  , align:"center", type:"string", sort:true , id:"JOB_MAN_NAME"         , name:"건담당자" });
        gr.addColumn({ width:75  , align:"cneter", type:"stirng", sort:true , id:"STATUS_NAME"          , name:"진행상태" });
        break;
    default :
        break;
    }

    gr.setFixedColumn("ROW_NUM");
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
    <TR>
        <TD height="1px">
            <TABLE border="0" cellspacing="0" cellpadding="0">
                <TR>
                    <TD width="1px"><IMG src="image/kch.gif" width="356px" height="317px"></TD>
                    <TD width="1px"><IMG src="<%= request.getContextPath() %>/anyfive/framework/img/blank.gif" width="10px" height="1px"></TD>
                    <TD width="1px"><IMG src="image/oa.gif" width="376px" height="317px"></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="1px" id="td_title" style="padding-top:5px; padding-bottom:5px; display:none;">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_title" class="title_sub"></SPAN></TD>
                    <TD align="right"><SPAN id="spn_gridMessage"></SPAN></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_bizFlowList" pagingType="1"><COMMENT>
                title = "국내출원 업무흐름";
                messageSpan = "spn_gridMessage";
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
