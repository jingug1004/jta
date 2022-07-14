<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>Delivery 현황(OA)</TITLE>
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

    var ldr = gr_intMasterList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.statistic.act.RetrieveDeliveryOAList.do";
    ldr.addParam("SR_REF_NO"             , SR_REF_NO.value);
    ldr.addParam("SR_OFFICE_NAME"        , SR_OFFICE_NAME.value);
    ldr.addParam("SR_OFFICE_JOB_CONTACT" , SR_OFFICE_JOB_CONTACT.value);
    ldr.addParam("SR_JOB_CONTACT"        , SR_JOB_CONTACT.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }
    /**/

    ldr.execute();
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
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="24%">
                </COLGROUP>
                <TR>
                    <TD>REF_NO</TD>
                    <TD>
                        <INPUT type="text" id="SR_REF_NO" style="text-transform:uppercase;">
                    </TD>
                    <TD>특허사무소</TD>
                    <TD>
                        <INPUT type="text" id="SR_OFFICE_NAME" style="text-transform:uppercase;">
                    </TD>
                    <TD>사무소담당자</TD>
                    <TD>
                        <INPUT type="text" id="SR_OFFICE_JOB_CONTACT" style="text-transform:uppercase;">
                    </TD>
                </TR>
                <TR>
                    <TD>특허팀 건담당자</TD>
                    <TD colspan="5" noWrap>
                        <INPUT type="text" id="SR_JOB_CONTACT" style="text-transform:uppercase;">
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
            <ANY:GRID id="gr_intMasterList" pagingType="1"><COMMENT>
                addColumn({ width:100, align:"left"    , type:"string" , sort:true , id:"OFFICE_NAME"      , name:"사무소" });
                addColumn({ width:100, align:"left"    , type:"string" , sort:true , id:"OFFICE_JOB_CONTACT", name:"사무소담당자" });
                addColumn({ width:120, align:"left"    , type:"string" , sort:true , id:"REF_NO"           , name:"REF-NO" });
                addColumn({ width:120, align:"left"    , type:"string" , sort:true , id:"KO_APP_TITLE"     , name:"발명의명칭" });
                addColumn({ width:100, align:"center"  , type:"string" , sort:true , id:"JOB_CONTACT"      , name:"특허팀 건담당자" });
                addColumn({ width:75, align:"center"  , type:"string" , sort:true , id:"OA_GENERATION1"    , name:"OA발생->의견안작성1" });
                addColumn({ width:75, align:"center"  , type:"string" , sort:true , id:"OA_GENERATION2"    , name:"OA발생->의견안작성2" });
                addColumn({ width:75, align:"center"  , type:"string" , sort:true , id:"OA_GENERATION3"    , name:"OA발생->의견안작성3" });

                useConfig = true;
                messageSpan = "spn_gridMessage";
                addSorting("OFFICE_JOB_CONTACT", "DESC");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
