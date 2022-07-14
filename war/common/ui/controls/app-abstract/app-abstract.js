any.control("app-abstract").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);
        o.controlIndex = any.control().newIndex();

        initDataset();

        o.masterLink = (o.$control.hasAttr("masterLink") && any.object(o.$control.attr("masterLink")).toBoolean(true));

        if (o.$control.hasAttr("titleArea")) {
            o.$titleArea = $('#' + o.$control.attr("titleArea"));
        }

        o.labelWidth = "150px";

        o.$control.defineMethod("getValue", getValue);
        o.$control.defineMethod("refresh", refresh);

        o.$control.defineProperty("labelWidth", { get:getLabelWidth, set:setLabelWidth });
        o.$control.defineProperty("refId", { get:getRefId, set:setRefId });
        o.$control.defineProperty("priRefId", { get:getPriRefId, set:setPriRefId });

        // 워크플로우 상세 화면에서 서지사항 존재시 자식 화면에서는 안보이게 처리
        o.isView = true;
        try {
            if ($(window.frameElement).parent().attr("id") == "div_workflowDetail" && parent.any_abstractInfo != null) {
                var parentAbstractRefId = $(parent.any_abstractInfo).prop("refId");
                var refId = getRefId();
                if (parentAbstractRefId == refId) {
                    o.isView = false;
                }
            }
        } catch(e) {
        }

        any.control(control).initialize();

        makeHTML();
    })();

    function initDataset()
    {
        if (o.$control.hasAttr("ds")) {
            o.ds = any.ds(o.$control.attr("ds"));
        } else if (control.id.indexOf("_") > 0) {
            o.ds = any.ds("ds_" + control.id.substr(control.id.indexOf("_") + 1));
        } else {
            o.ds = any.ds(control.id);
        }
    }

    function getLabelWidth()
    {
        return o.labelWidth;
    }

    function setLabelWidth(val)
    {
        o.labelWidth = val;
    }

    function getRefId()
    {
        return o.refId;
    }

    function setRefId(refId)
    {
        o.refId = refId;

        if (o.refId == null || o.refId == "") {
            o.$control.empty();
            o.ds.init();
        } else {
            refresh(true);
        }
    }

    function getPriRefId()
    {
        return o.priRefId;
    }

    function setPriRefId(priRefId)
    {
        o.priRefId = priRefId;

        if (o.priRefId == null || o.priRefId == "") {
            o.$control.empty();
            o.ds.init();
        } else {
            refresh(true);
        }
    }

    function getValue(name)
    {
        return o.ds.value(0, name);
    }

    function refresh(fireEvent)
    {
        if (o.refId == null || o.refId == "") return;

        var prx = any.proxy();
        prx.url("/common.abstractinfo.AbstractInfoAct/retrieve");
        prx.param("REF_ID", o.refId);
        prx.output(o.ds);

        prx.onSuccess = function()
        {
            makeHTML();

            if (fireEvent == true) {
                o.$control.fire("onLoad");
            }
            var invMgtPersonTel = any.ds(o.ds.id).value(0, "INV_MGT_PERSON_TEL");
            var jobManTel = any.ds(o.ds.id).value(0, "JOB_MAN_TEL");
            var officeJobManTel = any.ds(o.ds.id).value(0, "OFFICE_JOB_MAN_TEL");
            var wriPersonTel = any.ds(o.ds.id).value(0, "WRI_PERSON_TEL");

            $('#INV_MGT_PERSON_NAME').prop("title", invMgtPersonTel);
            $('#JOB_MAN_NAME').prop("title", jobManTel);
            $('#OFFICE_JOB_MAN_NAME').prop("title", officeJobManTel);
            $('#WRI_PERSON_NAME').prop("title", wriPersonTel);
        };

        prx.onError = function()
        {
            this.error.show();
        };

        prx.execute();
    }

    //패밀리구조도
    function fnFamilyDiagram()
    {
        var win = any.window();
        win.url("/common.familydiagram.FamilyDiagramAct/viewDetail");
        win.param("REF_ID", o.refId);
        win.option({ resizable:"yes" });
        win.open();
    }

    //관련파일목록
    function fnRelateFileList()
    {
        var win = any.window(true);
        win.url("/common.reffile.RefFileAct/viewList");
        win.param("MST_ID",  o.refId);
        win.show();
    }

    //크게 보기
    function fnViewExpansion()
    {
        var win = any.window();
        win.url("/app.viewexpansion.ViewExpansionAct/viewDetail");
        win.param("DRAWING_ATTACH_FILE", o.ds.value(0, "DRAWING_ATTACH_FILE"));
        win.option({width:900, height:800, resizable:"yes" });
        win.open();
    }

    function makeHTML()
    {
        if (o.ds == null) return;
        if (!o.isView) return;
        var html = [];
        switch (o.ds.meta("abstractDiv")) {
        case "APP_PATENT_MST":
            if (o.$titleArea == null) {
                html.push('<h2>' + any.message("app-abstract.app.patent.title", "출원 서지사항").toHTML() + '</h2>  ');
            } else {
                o.$titleArea.text(any.message("app-abstract.app.patent.title", "출원 서지사항").toString());
            }

            html.push('<div class="ui-widget-content ui-corner-all">                                            ');
            html.push('<table class="view">                                                                     ');
            html.push('    <colgroup>                                                                           ');
            html.push('        <col width="' + o.labelWidth + '">                                               ');
            html.push('        <col width="*">                                                                  ');
            html.push('        <col width="*">                                                                  ');
            html.push('        <col width="220">                                                                  ');
            html.push('    </colgroup>                                                                          ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.MST_NO", "관리번호").toHTML() + '</th>                  ');
            if (o.masterLink == true) {
                html.push('   <td><a href="javascript:void(0);" id="MST_NO" bind="' + o.ds.id + '"></a>&nbsp;&nbsp;'+
                                   '('+'<span id="COUNTRY_NAME" bind="' + o.ds.id + '" ></span>'+' / '+'<span id="RIGHT_DIV_NAME" bind="' + o.ds.id + '"></span>'+')'+'</td>');
                html.push('   <td>&nbsp;<button any-button size="small" id="btn_familyDiagram_' + o.controlIndex + '"">' + any.message("btn.com.family.diagram.list", "패밀리구조도").toHTML() + '</button>   <button any-button size="small" id="btn_fnRelateFileList_' + o.controlIndex + '"">' + any.message("btn.com.related.file.list", "관련파일").toHTML() + '</button></td>');
            } else {
                html.push('   <td><span id="MST_NO" bind="' + o.ds.id + '"></span></td>        ');
                html.push('   <td></td>        ');
            }
            html.push('        <td rowspan="9" align="center">                ');
            if (o.ds.value(0, "OWN_DRAWING_ATTACH_FILE") == '') {
                html.push();
            } else {
                html.push('    <img id="' + control.id + '_drawingAttachFile" src="' + any.meta.contextPath + '/patent.master.PatentMasterAct/downloadRepresentImage.any?MST_ID=' + o.refId + '" width="200" height="150">');
            }
            html.push('        </td>');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.KO_APP_TITLE", "출원의명칭(한)").toHTML() + '</th>     ');
            html.push('        <td colspan="2"><span id="KO_APP_TITLE" bind="' + o.ds.id + '"></span></td>      ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.PRSENT_STATUS", "현재상태").toHTML() + '</th>     ');
            html.push('        <td colspan="2">'+o.ds.meta("abstractStatus")+'</td>      ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.APP_NO", "출원번호").toHTML() + '</th>     ');
            html.push('        <td><span id="APP_NO_VIEW" bind="' + o.ds.id + '"></span></td>      ');
            html.push('        <td><span any-date id="APP_DATE_VIEW" bind="' + o.ds.id + '" readOnly></span></td>      ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.EXAMREQ_YN", "심사청구").toHTML() + '</th>     ');
            html.push('        <td><span id="EXAMREQ_YN_NM" bind="' + o.ds.id + '"></span></td>      ');
            html.push('        <td>'+'<span any-date id="EXAMREQ_DATE_VIEW" bind="' + o.ds.id + '" readOnly></span>'+'</td>      ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.REG_NO", "등록번호").toHTML() + '</th>     ');
            html.push('        <td><span id="REG_NO_VIEW" bind="' + o.ds.id + '"></span></td>      ');
            html.push('        <td><span any-date id="REG_DATE_VIEW" bind="' + o.ds.id + '" readOnly></span></td>      ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.INV_MGT_PERSON_NAME", "발명관리자").toHTML() + '</th>     ');
            if (o.ds.value(0, "INV_MGT_PERSON_NAME") == '') {
                html.push('        <td><span id="INV_MGT_PERSON_NAME" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td><span id="INV_MGT_PERSON_NAME" bind="' + o.ds.id + '"></span>'+' ('+'<span id="DEPT_NAME" bind="' + o.ds.id + '"></span>'+')'+'</td>      ');
            }
            if (o.ds.value(0, "INV_OFFICE_TEL") == '') {
                html.push('        <td><span id="INV_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td>☎ <span id="INV_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            }
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.JOB_MAN_NAME", "건담당자").toHTML() + '</th>     ');
            html.push('        <td><span id="JOB_MAN_NAME" bind="' + o.ds.id + '"></span></td>      ');
            if (o.ds.value(0, "JOB_OFFICE_TEL") == '') {
                html.push('        <td><span id="JOB_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td>☎ <span id="JOB_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            }
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.OFFICE_JOB_MAN_NAME", "사무소담당자").toHTML() + '</th>     ');
            if (o.ds.value(0, "OFFICE_JOB_MAN_NAME") == '') {
                html.push('        <td><span id="OFFICE_JOB_MAN_NAME" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td><span id="OFFICE_JOB_MAN_NAME" bind="' + o.ds.id + '"></span>'+' ('+'<span id="OFFICE_NAME" bind="' + o.ds.id + '"></span>'+')'+'</td>      ');
            }
            if (o.ds.value(0, "OFF_OFFICE_TEL") == '') {
                html.push('        <td><span id="OFF_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td>☎ <span id="OFF_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            }
            html.push('    </tr>                                                                                ');
            html.push('</table>                                                                                 ');
            html.push('</div>                                                                                   ');
            break;
        case "APP_DESIGN_MST":
            if (o.$titleArea == null) {
                html.push('<h2>' + any.message("app-abstract.app.patent.title", "출원 서지사항").toHTML() + '</h2>  ');
            } else {
                o.$titleArea.text(any.message("app-abstract.app.patent.title", "출원 서지사항").toString());
            }

            html.push('<div class="ui-widget-content ui-corner-all">                                            ');
            html.push('<table class="view">                                                                     ');
            html.push('    <colgroup>                                                                           ');
            html.push('        <col width="' + o.labelWidth + '">                                               ');
            html.push('        <col width="*">                                                                  ');
            html.push('        <col width="*">                                                                  ');
            html.push('        <col width="220">                                                                  ');
            html.push('    </colgroup>                                                                          ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.MST_NO", "관리번호").toHTML() + '</th>                  ');
            if (o.masterLink == true) {
                html.push('   <td><a href="javascript:void(0);" id="MST_NO" bind="' + o.ds.id + '"></a>&nbsp;&nbsp;'+
                        '('+'<span id="COUNTRY_NAME" bind="' + o.ds.id + '" ></span>'+' / '+'<span id="RIGHT_DIV_NAME" bind="' + o.ds.id + '"></span>'+')'+'</td>');
                html.push('   <td>&nbsp;<button any-button size="small" id="btn_familyDiagram_' + o.controlIndex + '"">' + any.message("btn.com.family.diagram.list", "패밀리구조도").toHTML() + '</button>   <button any-button size="small" id="btn_fnRelateFileList_' + o.controlIndex + '"">' + any.message("btn.com.related.file.list", "관련파일").toHTML() + '</button></td>');
            } else {
                html.push('   <td><span id="MST_NO" bind="' + o.ds.id + '"></span></td>        ');
                html.push('   <td></td>        ');
            }
            html.push('        <td rowspan="8" align="center">                ');
            if (o.ds.value(0, "OWN_DRAWING_ATTACH_FILE") == '') {
                html.push();
            } else {
                html.push('    <img id="' + control.id + '_drawingAttachFile" src="' + any.meta.contextPath + '/patent.master.PatentMasterAct/downloadRepresentImage.any?MST_ID=' + o.refId + '" width="200" height="150">');
            }
            html.push('        </td>');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.KO_APP_TITLE", "출원의명칭(한)").toHTML() + '</th>     ');
            html.push('        <td colspan="2"><span id="KO_APP_TITLE" bind="' + o.ds.id + '"></span></td>      ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.PRSENT_STATUS", "현재상태").toHTML() + '</th>     ');
            html.push('        <td colspan="2">'+o.ds.meta("abstractStatus")+'</td>      ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.APP_NO", "출원번호").toHTML() + '</th>     ');
            html.push('        <td><span id="APP_NO_VIEW" bind="' + o.ds.id + '"></span></td>      ');
            html.push('        <td><span any-date id="APP_DATE_VIEW" bind="' + o.ds.id + '" readOnly></span></td>      ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.REG_NO", "등록번호").toHTML() + '</th>     ');
            html.push('        <td><span id="REG_NO_VIEW" bind="' + o.ds.id + '"></span></td>      ');
            html.push('        <td><span any-date id="REG_DATE_VIEW" bind="' + o.ds.id + '" readOnly></span></td>      ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.INV_MGT_PERSON_NAME", "발명관리자").toHTML() + '</th>     ');
            if (o.ds.value(0, "INV_MGT_PERSON_NAME") == '') {
                html.push('        <td><span id="INV_MGT_PERSON_NAME" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td><span id="INV_MGT_PERSON_NAME" bind="' + o.ds.id + '"></span>'+' ('+'<span id="DEPT_NAME" bind="' + o.ds.id + '"></span>'+')'+'</td>      ');
            }
            if (o.ds.value(0, "INV_OFFICE_TEL") == '') {
                html.push('        <td><span id="INV_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td>☎ <span id="INV_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            }
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.JOB_MAN_NAME", "건담당자").toHTML() + '</th>     ');
            html.push('        <td><span id="JOB_MAN_NAME" bind="' + o.ds.id + '"></span></td>      ');
            if (o.ds.value(0, "JOB_OFFICE_TEL") == '') {
                html.push('        <td><span id="JOB_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td>☎ <span id="JOB_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            }
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.OFFICE_JOB_MAN_NAME", "사무소담당자").toHTML() + '</th>     ');
            if (o.ds.value(0, "OFFICE_JOB_MAN_NAME") == '') {
                html.push('        <td><span id="OFFICE_JOB_MAN_NAME" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td><span id="OFFICE_JOB_MAN_NAME" bind="' + o.ds.id + '"></span>'+' ('+'<span id="OFFICE_NAME" bind="' + o.ds.id + '"></span>'+')'+'</td>      ');
            }
            if (o.ds.value(0, "OFF_OFFICE_TEL") == '') {
                html.push('        <td><span id="OFF_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td>☎ <span id="OFF_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            }
            html.push('    </tr>                                                                                ');
            html.push('</table>                                                                                 ');
            html.push('</div>                                                                                   ');
            break;
        case "APP_TMARK_MST":
            if (o.$titleArea == null) {
                html.push('<h2>' + any.message("app-abstract.app.patent.title", "출원 서지사항").toHTML() + '</h2>  ');
            } else {
                o.$titleArea.text(any.message("app-abstract.app.patent.title", "출원 서지사항").toString());
            }

            html.push('<div class="ui-widget-content ui-corner-all">                                            ');
            html.push('<table class="view">                                                                     ');
            html.push('    <colgroup>                                                                           ');
            html.push('        <col width="' + o.labelWidth + '">                                               ');
            html.push('        <col width="*">                                                                  ');
            html.push('        <col width="*">                                                                  ');
            html.push('        <col width="220">                                                                  ');
            html.push('    </colgroup>                                                                          ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.MST_NO", "관리번호").toHTML() + '</th>                  ');
            if (o.masterLink == true) {
                html.push('   <td><a href="javascript:void(0);" id="MST_NO" bind="' + o.ds.id + '"></a>&nbsp;&nbsp;'+
                        '('+'<span id="COUNTRY_NAME" bind="' + o.ds.id + '" ></span>'+' / '+'<span id="RIGHT_DIV_NAME" bind="' + o.ds.id + '"></span>'+')'+'</td>');
                html.push('   <td>&nbsp;<button any-button size="small" id="btn_familyDiagram_' + o.controlIndex + '"">' + any.message("btn.com.family.diagram.list", "패밀리구조도").toHTML() + '</button>   <button any-button size="small" id="btn_fnRelateFileList_' + o.controlIndex + '"">' + any.message("btn.com.related.file.list", "관련파일").toHTML() + '</button></td>');
            } else {
                html.push('   <td><span id="MST_NO" bind="' + o.ds.id + '"></span></td>        ');
                html.push('   <td></td>        ');
            }
            html.push('        <td rowspan="8" align="center">                ');
            if (o.ds.value(0, "OWN_DRAWING_ATTACH_FILE") == '') {
                html.push();
            } else {
                html.push('    <img id="' + control.id + '_drawingAttachFile" src="' + any.meta.contextPath + '/patent.master.PatentMasterAct/downloadRepresentImage.any?MST_ID=' + o.refId + '" width="200" height="150">');
            }
            html.push('        </td>');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.TMARK_TITLE", "상표의명칭(한)").toHTML() + '</th>     ');
            html.push('        <td colspan="2"><span id="KO_APP_TITLE" bind="' + o.ds.id + '"></span></td>      ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.PRSENT_STATUS", "현재상태").toHTML() + '</th>     ');
            html.push('        <td colspan="2">'+o.ds.meta("abstractStatus")+'</td>      ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.APP_NO", "출원번호").toHTML() + '</th>     ');
            html.push('        <td><span id="APP_NO_VIEW" bind="' + o.ds.id + '"></span></td>      ');
            html.push('        <td><span any-date id="APP_DATE_VIEW" bind="' + o.ds.id + '" readOnly></span></td>      ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.REG_NO", "등록번호").toHTML() + '</th>     ');
            html.push('        <td><span id="REG_NO_VIEW" bind="' + o.ds.id + '"></span></td>      ');
            html.push('        <td><span any-date id="REG_DATE_VIEW" bind="' + o.ds.id + '" readOnly></span></td>      ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.REQ_PERSON_NAME", "발명관리자").toHTML() + '</th>     ');
            if (o.ds.value(0, "INV_MGT_PERSON_NAME") == '') {
                html.push('        <td><span id="INV_MGT_PERSON_NAME" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td><span id="INV_MGT_PERSON_NAME" bind="' + o.ds.id + '"></span>'+' ('+'<span id="DEPT_NAME" bind="' + o.ds.id + '"></span>'+')'+'</td>      ');
            }
            if (o.ds.value(0, "INV_OFFICE_TEL") == '') {
                html.push('        <td><span id="INV_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td>☎ <span id="INV_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            }
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.JOB_MAN_NAME", "건담당자").toHTML() + '</th>     ');
            html.push('        <td><span id="JOB_MAN_NAME" bind="' + o.ds.id + '"></span></td>      ');
            if (o.ds.value(0, "JOB_OFFICE_TEL") == '') {
                html.push('        <td><span id="JOB_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td>☎ <span id="JOB_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            }
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.OFFICE_JOB_MAN_NAME", "사무소담당자").toHTML() + '</th>     ');
            if (o.ds.value(0, "OFFICE_JOB_MAN_NAME") == '') {
                html.push('        <td><span id="OFFICE_JOB_MAN_NAME" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td><span id="OFFICE_JOB_MAN_NAME" bind="' + o.ds.id + '"></span>'+' ('+'<span id="OFFICE_NAME" bind="' + o.ds.id + '"></span>'+')'+'</td>      ');
            }
            if (o.ds.value(0, "OFF_OFFICE_TEL") == '') {
                html.push('        <td><span id="OFF_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            } else {
                html.push('        <td>☎ <span id="OFF_OFFICE_TEL" bind="' + o.ds.id + '"></span></td>      ');
            }
            html.push('    </tr>                                                                                ');
            html.push('</table>                                                                                 ');
            html.push('</div>                                                                                   ');
            break;
        case "APP_PATENT_INV":
            if (o.$titleArea == null) {
                html.push('<h2>' + any.message("app-abstract.title.app.inv", "발명 서지사항").toHTML() + '</h2>  ');
            } else {
                o.$titleArea.text(any.message("app-abstract.title.app.inv", "발명 서지사항").toString());
            }
            html.push('<div class="ui-widget-content ui-corner-all">                                            ');
            html.push('<table class="view">                                                                     ');
            html.push('    <colgroup>                                                                           ');
            html.push('        <col width="' + o.labelWidth + '">                                               ');
            html.push('        <col width="*">                                                                  ');
            html.push('        <col width="' + o.labelWidth + '">                                               ');
            html.push('        <col width="*">                                                                  ');
            html.push('    </colgroup>                                                                          ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.REPORT_NO", "신고번호").toHTML() + '</th>               ');
            if (o.masterLink == true) {
                html.push('    <td><a href="javascript:void(0);" id="REPORT_NO" bind="'+ o.ds.id + '"></a></td>');
            } else {
                html.push('    <td><span id="REPORT_NO" bind="' + o.ds.id + '"></span></td>    ');
            }
            html.push('        <th>' + any.message("lbl.RIGHT_DIV", "권리구분").toHTML() + '</th>               ');
            html.push('        <td><span id="RIGHT_DIV_NAME" bind="' + o.ds.id + '"></span></td>                  ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.KO_INV_TITLE", "발명의 명칭(한)").toHTML() + '</th>     ');
            html.push('        <td colspan="3"><span id="KO_INV_TITLE" bind="' + o.ds.id + '"></span></td>      ');
            html.push('    </tr>                                                                                 ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.INV_MGT_PERSON", "발명관리자").toHTML() + '</th>          ');
            html.push('        <td><span id="INV_MGT_PERSON_NAME" bind="' + o.ds.id + '"></span></td>               ');
            html.push('        <th>' + any.message("lbl.DEPT_NAME", "부서명").toHTML() + '</th>               ');
            html.push('        <td><span id="DEPT_NAME" bind="' + o.ds.id + '"></span></td>                     ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.JOB_MAN_NAME", "건담당자").toHTML() + '</th>          ');
            html.push('        <td><span id="JOB_MAN_NAME" bind="' + o.ds.id + '"></span></td>               ');
            html.push('        <th >' + any.message("lbl.PRSENT_STATUS", "현재상태").toHTML() + '</th>           ');
            html.push('        <td>'+o.ds.meta("abstractStatus")+'</td>                             ');
            html.push('    </tr>                                                                                ');
            html.push('</table>                                                                                 ');
            html.push('</div>                                                                                   ');
            break;
        case "APP_DESIGN_INV":
            if (o.$titleArea == null) {
                html.push('<h2>' + any.message("app-abstract.title.app.inv", "발명 서지사항").toHTML() + '</h2>  ');
            } else {
                o.$titleArea.text(any.message("app-abstract.title.app.inv", "발명 서지사항").toString());
            }
            html.push('<div class="ui-widget-content ui-corner-all">                                            ');
            html.push('<table class="view">                                                                     ');
            html.push('    <colgroup>                                                                           ');
            html.push('        <col width="' + o.labelWidth + '">                                               ');
            html.push('        <col width="*">                                                                  ');
            html.push('        <col width="' + o.labelWidth + '">                                               ');
            html.push('        <col width="*">                                                                  ');
            html.push('    </colgroup>                                                                          ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.REPORT_NO", "신고번호").toHTML() + '</th>               ');
            if (o.masterLink == true) {
                html.push('    <td><a href="javascript:void(0);" id="REPORT_NO" bind="'+ o.ds.id + '"></a></td>');
            } else {
                html.push('    <td><span id="REPORT_NO" bind="' + o.ds.id + '"></span></td>    ');
            }
            html.push('        <th>' + any.message("lbl.RIGHT_DIV", "권리구분").toHTML() + '</th>               ');
            html.push('        <td><span id="RIGHT_DIV_NAME" bind="' + o.ds.id + '"></span></td>                  ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.KO_INV_TITLE", "발명의 명칭(한)").toHTML() + '</th>     ');
            html.push('        <td colspan="3"><span id="KO_INV_TITLE" bind="' + o.ds.id + '"></span></td>      ');
            html.push('    </tr>                                                                                 ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.INV_MGT_PERSON", "발명관리자").toHTML() + '</th>          ');
            html.push('        <td><span id="INV_MGT_PERSON_NAME" bind="' + o.ds.id + '"></span></td>               ');
            html.push('        <th>' + any.message("lbl.DEPT_NAME", "부서명").toHTML() + '</th>               ');
            html.push('        <td><span id="DEPT_NAME" bind="' + o.ds.id + '"></span></td>                     ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.JOB_MAN_NAME", "건담당자").toHTML() + '</th>          ');
            html.push('        <td><span id="JOB_MAN_NAME" bind="' + o.ds.id + '"></span></td>               ');
            html.push('        <th >' + any.message("lbl.PRSENT_STATUS", "현재상태").toHTML() + '</th>           ');
            html.push('        <td>'+o.ds.meta("abstractStatus")+'</td>                             ');
            html.push('    </tr>                                                                                ');
            html.push('</table>                                                                                 ');
            html.push('</div>                                                                                   ');
            break;
        case "APP_TMARK_INV":
            if (o.$titleArea == null) {
                html.push('<h2>' + any.message("app-abstract.title.app.tmark.inv", "의뢰 서지사항").toHTML() + '</h2>  ');
            } else {
                o.$titleArea.text(any.message("app-abstract.title.app.tmark.inv", "의뢰 서지사항").toString());
            }
            html.push('<div class="ui-widget-content ui-corner-all">                                            ');
            html.push('<table class="view">                                                                     ');
            html.push('    <colgroup>                                                                           ');
            html.push('        <col width="' + o.labelWidth + '">                                               ');
            html.push('        <col width="*">                                                                  ');
            html.push('        <col width="' + o.labelWidth + '">                                               ');
            html.push('        <col width="*">                                                                  ');
            html.push('    </colgroup>                                                                          ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.TMARK_REPORT_NO", "의뢰번호").toHTML() + '</th>               ');
            if (o.masterLink == true) {
                html.push('    <td><a href="javascript:void(0);" id="REPORT_NO" bind="'+ o.ds.id + '"></a></td>');
            } else {
                html.push('    <td><span id="REPORT_NO" bind="' + o.ds.id + '"></span></td>    ');
            }
            html.push('        <th>' + any.message("lbl.RIGHT_DIV", "권리구분").toHTML() + '</th>               ');
            html.push('        <td><span id="RIGHT_DIV_NAME" bind="' + o.ds.id + '"></span></td>                  ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.TMARK_TITLE", "상표의 명칭(한)").toHTML() + '</th>     ');
            html.push('        <td colspan="3"><span id="KO_INV_TITLE" bind="' + o.ds.id + '"></span></td>      ');
            html.push('    </tr>                                                                                 ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.REQ_PERSON_NAME", "의뢰자").toHTML() + '</th>          ');
            html.push('        <td><span id="INV_MGT_PERSON_NAME" bind="' + o.ds.id + '"></span></td>               ');
            html.push('        <th>' + any.message("lbl.REQ_DEPT_NAME", "의뢰부서").toHTML() + '</th>               ');
            html.push('        <td><span id="DEPT_NAME" bind="' + o.ds.id + '"></span></td>                     ');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.JOB_MAN_NAME", "건담당자").toHTML() + '</th>          ');
            html.push('        <td><span id="JOB_MAN_NAME" bind="' + o.ds.id + '"></span></td>               ');
            html.push('        <th >' + any.message("lbl.PRSENT_STATUS", "현재상태").toHTML() + '</th>           ');
            html.push('        <td>'+o.ds.meta("abstractStatus")+'</td>                             ');
            html.push('    </tr>                                                                                ');
            html.push('</table>                                                                                 ');
            html.push('</div>                                                                                   ');
            break;
        }

        o.$control.html(html.join("\n")).controls(function() {
            o.ds.resetControlValues();

            o.$control.find('#' + control.id + '_drawingAttachFile').css({ "cursor":"pointer" }).click(function() {
                var win = any.window(true);
                win.url("/common/util/ImageViewer.jsp");
                win.arg("imgSrc", this.src);
                win.option("resizable", "yes");
                win.open();
            });
        }).find('th').addClass("ui-widget-header");

        cfResetH2Padding(o.$control);

        // 신고번호 링크
        o.$control.find('a#REPORT_NO').click(function() {
            var win = any.window();
            if (o.ds.meta("abstractDiv") == "APP_PATENT_INV") {
                win.url("/patent.inv.report.PatentInvReportAct/viewDetail");
            } else if (o.ds.meta("abstractDiv") == "APP_DESIGN_INV") {
                win.url("/design.inv.report.DesignInvReportAct/viewDetail");
            } else if (o.ds.meta("abstractDiv") == "APP_TMARK_INV") {
                win.url("/tmark.inv.report.TmarkInvReportAct/viewDetail");
            }
            win.param("INV_REPORT_ID", any.ds(o.ds.id).value(0, "INV_REPORT_ID"));
            win.option({ resizable:"yes" });
            win.open();
        });

        o.$control.find('a#MST_NO').click(function() {
            var win = any.window();
            if (o.ds.meta("abstractDiv") == "APP_PATENT_MST") {
                win.url("/patent.master.PatentMasterAct/viewTab");
            } else if (o.ds.meta("abstractDiv") == "APP_DESIGN_MST") {
                win.url("/design.master.DesignMasterAct/viewTab");
            } else if (o.ds.meta("abstractDiv") == "APP_TMARK_MST") {
                win.url("/tmark.master.TmarkMasterAct/viewTab");
            }

            win.param("MST_ID", o.refId);
            win.option({ resizable:"yes" });
            win.open();
        });

        o.$btn_search = o.$control.find('#btn_familyDiagram_' + o.controlIndex).click(function() {
            fnFamilyDiagram();
        });
        o.$btn_search = o.$control.find('#btn_fnRelateFileList_' + o.controlIndex).click(function() {
            fnRelateFileList();
        });
        o.$btn_search = o.$control.find('#btn_viewexpansion_' + o.controlIndex).click(function() {
            fnViewExpansion();
        });
    }


});
