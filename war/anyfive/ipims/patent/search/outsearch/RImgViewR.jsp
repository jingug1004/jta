<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.core.config.NConfig"%>
<%@page import="java.util.Enumeration"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>대표도면 일괄보기</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnCreateRImgList();
    fnViewRImg();
}

//대표도면 리스트 생성
function fnCreateRImgList()
{
    var anList = parent.anList;
    var td;
    var spn;
    var img;

    for (var i = 0; i < anList.length; i++) {
        td = document.createElement('<TD bgColor="#FFFFFF">');
        td.style.cursor = "hand";
        td.an = anList[i];
        tr_rImgList.appendChild(td);

        td.onclick = function()
        {
            fnViewRImg(this.an);
        }

        spn = document.createElement('<SPAN style="width:120px; text-align:center;">');
        td.appendChild(spn);

        img = document.createElement('<IMG src="' + top.getRoot() + '/anyfive.ipims.patent.search.outsearch.act.RetrieveRImg.do?cc=KR&an=' + anList[i] + '&thumbnail=1">');
        spn.appendChild(img);
    }
}

//대표도면 상세
function fnViewRImg(an)
{
    if (an == null && parent.anList.length > 0) {
        an = parent.anList[0];
    }

    if (an == null) return;

    img_rImg.src = top.getRoot() + "/anyfive.ipims.patent.search.outsearch.act.RetrieveRImg.do?cc=KR&an=" + an;

    img_rImg.onclick = function()
    {
        document.getElementById("ifr_rImgDown").contentWindow.location.href = img_rImg.src + "&download=1";
    }
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="1px">
            <DIV style="border:#999999 1px solid; width:100%; height:150px; padding:5px; overflow-x:scroll; overflow-y:hidden;">
                <TABLE border="0" cellspacing="1" cellpadding="0" height="100%" bgColor="#DDDDDD">
                    <TR id="tr_rImgList"></TR>
                </TABLE>
            </DIV>
        </TD>
    </TR>
    <TR>
        <TD height="5px"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <DIV style="border:#999999 1px solid; width:100%; height:100%; overflow:auto;">
                <IMG id="img_rImg" style="cursor:hand;">
            </DIV>
        </TD>
    </TR>
</TABLE>

<IFRAME id="ifr_rImgDown" style="display:none;"></IFRAME>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
