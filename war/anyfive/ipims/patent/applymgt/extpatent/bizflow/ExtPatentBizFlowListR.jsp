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
    fnCreateLayer(-10, 54, "해외출원대상선정", "EXT_PA01");
    fnCreateLayer(-13, 99, "해외출원품의", "EXT_PA02");
    fnCreateLayer(-13, 157, "품의진행.포기");
    fnCreateLayer(1, 210, "진행");
    fnCreateLayer(-62, 185, "포기");
    fnCreateLayer(-66, 228, "종료", "EXT_PA03");
    fnCreateLayer(-13, 285, "O/L작성", "EXT_PA04");

    fnCreateLayer(118, 91, "수정여부");
    fnCreateLayer(121, 145, "명세서검토", "EXT_PA07");
    fnCreateLayer(121, 236, "명세서작성", "EXT_PA06");
    fnCreateLayer(121, 286, "사무소접수", "EXT_PA05");

    fnCreateLayer(232, 236, "제출", "EXT_PA08");
    fnCreateLayer(232, 286, "출원", "EXT_PA09");

    fnCreateLayer(375, 52, "OA현황", "EXT_OA01");
    fnCreateLayer(375, 98, "대응방안검토", "EXT_OA02");
    fnCreateLayer(375, 157, "대응");
    fnCreateLayer(375, 283, "포기", "EXT_OA06");

    fnCreateLayer(508, 91, "수정여부");
    fnCreateLayer(510, 143, "의견안 검토", "EXT_OA04");
    fnCreateLayer(510, 234, "의견안 작성", "EXT_OA03");

    fnCreateLayer(621, 234, "제출", "EXT_OA05");
    fnCreateLayer(621, 285, "대응완료");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.bizflow.act.RetrieveExtPatentBizFlowCount.do";
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
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.bizflow.act.RetrieveExtPatentBizFlowList.do";
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
    case 'EXT_PA01' : //해외출원대상선정
        gr.addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REF_NO"                , name:"REF-NO" });
        gr.addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"                , name:"출원번호" });
        gr.addColumn({ width:300, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"          , name:"발명의 명칭" });
        gr.addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"CRE_DATE"              , name:"접수일" });
        gr.addColumn({ width:86 , align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"           , name:"사무소" });
        gr.addColumn({ width:129, align:"left"  , type:"string", sort:true , id:"INVENTOR_NAMES"        , name:"발명자" });
        gr.addColumn({ width:71 , align:"left"  , type:"string", sort:true , id:"JOB_MAN_NAME"          , name:"담당자" });
        gr.addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REG_NO"                , name:"등록번호" });
        gr.addColumn({ width:89 , align:"left"  , type:"string", sort:true , id:"EXT_APP_STATUS_NAME"   , name:"품의상태" });
        gr.addSorting("REF_NO", "DESC");
        break;
    case 'EXT_PA02' : //해외출원품의
    case 'EXT_PA03' : //종료
        gr.addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"GRP_NO"                , name:"해외출원품의번호" });
        gr.addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"                , name:"국내출원번호" });
        gr.addColumn({ width:70 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"        , name:"구분" });
        gr.addColumn({ width:300, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"          , name:"발명의 명칭" });
        gr.addColumn({ width:71 , align:"left"  , type:"string", sort:true , id:"JOB_MAN_NAME"          , name:"건담당자" });
        gr.addColumn({ width:129, align:"left"  , type:"string", sort:true , id:"INVENTOR_NAMES"        , name:"발명자" });
        gr.addColumn({ width:86 , align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"           , name:"사무소" });
        gr.addColumn({ width:70 , align:"center", type:"string", sort:true , id:"INV_GRADE"             , name:"등급" });
        gr.addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"CRE_DATE"              , name:"작성일" });
        gr.addSorting("GRP_NO", "DESC");
        break;
    case 'EXT_PA04' : //O/L작성
    case 'EXT_PA05' : //사무소접수
    case 'EXT_PA08' : //제출
    case 'EXT_PA09' : //출원
        gr.addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"GRP_NO"                , name:"해외출원품의번호" });
        gr.addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"                , name:"국내출원번호" });
        gr.addColumn({ width:70 , align:"left"  , type:"string", sort:true , id:"RIGHT_DIV_NAME"        , name:"구분" });
        gr.addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"COUNTRY_NAMES"         , name:"출원국가" });
        gr.addColumn({ width:296, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"          , name:"발명의 명칭" });
        gr.addColumn({ width:89 , align:"left"  , type:"string", sort:true , id:"STATUS_NAME"           , name:"진행상태" });
        gr.addColumn({ width:71 , align:"left"  , type:"string", sort:true , id:"CRE_USER_NAME"         , name:"작성자" });
        gr.addColumn({ width:86 , align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"           , name:"국내사무소" });
        break;
    case 'EXT_PA06' : //명세서작성
    case 'EXT_PA07' : //명세서검토
    case 'EXT_OA01' : //OA현황
    case 'EXT_OA02' : //대응방안검토
    case 'EXT_OA03' : //의견안 작성
    case 'EXT_OA04' : //의견안 검토
    case 'EXT_OA05' : //제출
    case 'EXT_OA06' : //포기
        gr.addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REF_NO"                , name:"REF-NO" });
        gr.addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"                , name:"출원번호" });
        gr.addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"PAPER_NAME"            , name:"진행서류명" });
        gr.addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"COMMENT"               , name:"기타사항" });
        gr.addColumn({ width:300, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"          , name:"발명의 명칭" });
        gr.addColumn({ width:129, align:"left"  , type:"string", sort:true , id:"INVENTOR_NAMES"        , name:"발명자" });
        gr.addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PAPER_DATE"            , name:"서류일자" });
        gr.addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"DUE_DATE"              , name:"법정기한" });
        gr.addColumn({ width:86 , align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"           , name:"사무소" });
        gr.addColumn({ width:71 , align:"left"  , type:"string", sort:true , id:"JOB_MAN_NAME"          , name:"건담당자" });
        gr.addColumn({ width:89 , align:"left"  , type:"string", sort:true , id:"STATUS_NAME"           , name:"진행상태" });
        break;
    default:
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
                    <TD width="1px"><IMG src="image/hch.gif" width="390px" height="317px"></TD>
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
                title = "해외출원 업무흐름";
                messageSpan = "spn_gridMessage";
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
