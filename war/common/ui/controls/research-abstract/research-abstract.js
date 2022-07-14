any.control("research-abstract").define(function behavior(control, controlName)
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

    function getValue(name)
    {
        return o.ds.value(0, name);
    }

    function refresh(fireEvent)
    {
        if (o.refId == null || o.refId == "") return;

        var prx = any.proxy();
        prx.url("/research.abstractinfo.ResearchAbstractInfoAct/retrieve");
        prx.param("REF_ID", o.refId);
        prx.output(o.ds);

        prx.onSuccess = function()
        {
            makeHTML();

            if (fireEvent == true) {
                o.$control.fire("onLoad");
            }
            var reqOfficeTel = any.ds(o.ds.id).value(0, "REQ_OFFICE_TEL");
            var jobOfficeTel = any.ds(o.ds.id).value(0, "JOB_OFFICE_TEL");
            var offOfficeTel = any.ds(o.ds.id).value(0, "OFF_OFFICE_TEL");

            $('#REQ_PERSON_NAME').prop("title", reqOfficeTel);
            $('#JOB_MAN_NAME').prop("title", jobOfficeTel);
            $('#OFFICE_JOB_MAN_NAME').prop("title", offOfficeTel);
        };

        prx.onError = function()
        {
            this.error.show();
        };

        prx.execute();
    }

    //관련파일목록
    function fnRelateFileList()
    {
        var win = any.window(true);
        win.url("/common.reffile.RefFileAct/viewList");
        win.param("MST_ID",  o.refId);
        win.show();
    }

    function makeHTML()
    {
        if (o.ds == null) return;
        if (!o.isView) return;
        var html = [];
        switch (o.ds.meta("abstractDiv")) {
        case "RESEARCH_MST":
            if (o.$titleArea == null) {
                html.push('<h2>' + any.message("research-abstract.research.mst.title", "조사 서지사항").toHTML() + '</h2>  ');
            } else {
                o.$titleArea.text(any.message("research-abstract.research.mst.title", "조사 서지사항").toString());
            }
            html.push('<div class="ui-widget-content ui-corner-all">                                            ');
            html.push('<table class="view">                                                                     ');
            html.push('    <colgroup>                                                                           ');
            html.push('        <col width="' + o.labelWidth + '">                                               ');
            html.push('        <col width="*">                                                                  ');
            html.push('        <col width="' + o.labelWidth + '">                                               ');
            html.push('        <col width="*">                                                                  ');
            html.push('    </colgroup>                                                                          ');
            html.push('        <tr>                                                                                          ');
            html.push('            <th>                                                                                      ');
            html.push(            any.message("lbl.RESEARCH_MST_NO", "조사분석 관리번호").toHTML()                          );
            html.push('            </th>                                                                                     ');
if (o.masterLink == true) {
            html.push('            <td colspan="3">                                                                          ');
            html.push('            <a href="javascript:void(0);" id="RESEARCH_MST_NO" bind="' + o.ds.id + '"></a>       ');
            html.push('            </td>                                                                                     ');
} else {
            html.push('            <td colspan="3">                                                                          ');
            html.push('            <span id="RESEARCH_MST_NO" bind="' + o.ds.id + '"></span>                                 ');
            html.push('            </td>                                                                                     ');
}
            html.push('        </tr>                                                                                         ');
            html.push('        <tr>                                                                                          ');
            html.push('            <th>                                                                                      ');
            html.push(            any.message("lbl.REQ_PERSON_NAME", "의뢰자").toHTML()                                     );
            html.push('            </th>                                                                                     ');
            html.push('            <td>                                                                                      ');
            html.push('            <span id="REQ_PERSON_NAME" bind="' + o.ds.id + '"></span>                                 ');
            html.push('            (<span id="REQ_DEPT_NAME" bind="' + o.ds.id + '"></span>)                                   ');
            html.push('            </td>                                                                                     ');
if (o.ds.value(0, "REQ_OFFICE_TEL") == '') {
            html.push('            <td colspan="2">                                                                                      ');
            html.push('            <span id="REQ_OFFICE_TEL" bind="' + o.ds.id + '"></span>                                 ');
            html.push('            </td>                                                                                     ');
} else {
            html.push('            <td colspan="2">                                                                                      ');
            html.push('            ☎ <span id="REQ_OFFICE_TEL" bind="' + o.ds.id + '"></span>                                 ');
            html.push('            </td>                                                                                     ');
}
            html.push('        </tr>                                                                                         ');
            html.push('        <tr>                                                                                          ');
            html.push('            <th>                                                                                      ');
            html.push(            any.message("lbl.JOB_MAN_NAME", "건담당자").toHTML()                                      );
            html.push('            </th>                                                                                     ');
            html.push('            <td>                                                                          ');
            html.push('            <span id="JOB_MAN_NAME" bind="' + o.ds.id + '"></span>                                    ');
            html.push('            </td>                                                                                     ');
if (o.ds.value(0, "JOB_OFFICE_TEL") == '') {
            html.push('            <td colspan="2">                                                                                      ');
            html.push('            <span id="JOB_OFFICE_TEL" bind="' + o.ds.id + '"></span>                                 ');
            html.push('            </td>                                                                                     ');
} else {
            html.push('            <td colspan="2">                                                                                      ');
            html.push('            ☎ <span id="JOB_OFFICE_TEL" bind="' + o.ds.id + '"></span>                                 ');
            html.push('            </td>                                                                                     ');
}
            html.push('        </tr>                                                                                         ');
            html.push('        <tr>                                                                                          ');
            html.push('            <th>                                                                                      ');
            html.push(            any.message("lbl.OFFICE_JOB_MAN_NAME", "사무소담당자").toHTML()                           );
            html.push('            </th>                                                                                     ');
            html.push('            <td>                                                                                      ');
            html.push('            <span id="OFFICE_JOB_MAN_NAME" bind="' + o.ds.id + '"></span>                             ');
            html.push('            (<span id="OFFICE_NAME" bind="' + o.ds.id + '"></span>)                                     ');
            html.push('            </td>                                                                                     ');
if (o.ds.value(0, "OFF_OFFICE_TEL") == '') {
            html.push('            <td colspan="2">                                                                                      ');
            html.push('            <span id="OFF_OFFICE_TEL" bind="' + o.ds.id + '"></span>                                 ');
            html.push('            </td>                                                                                     ');
} else {
            html.push('            <td colspan="2">                                                                                      ');
            html.push('            ☎ <span id="OFF_OFFICE_TEL" bind="' + o.ds.id + '"></span>                                 ');
            html.push('            </td>                                                                                     ');
}
            html.push('        </tr>                                                                                         ');
            html.push('        <tr>                                                                                          ');
            html.push('            <th>                                                                                      ');
            html.push(            any.message("lbl.RESEARCH_SUBJECT", "조사제목").toHTML()                                  );
            html.push('            </th>                                                                                     ');
            html.push('            <td colspan="3">                                                                          ');
            html.push('            <span id="RESEARCH_SUBJECT" bind="' + o.ds.id + '"></span>                                ');
            html.push('            </td>                                                                                     ');
            html.push('        </tr>                                                                                         ');
            break;

        case "RESEARCH_REQ":
            if (o.$titleArea == null) {
                html.push('<h2>' + any.message("research-abstract.research.mst.title", "조사 서지사항").toHTML() + '</h2>  ');
            } else {
                o.$titleArea.text(any.message("research-abstract.research.mst.title", "조사 서지사항").toString());
            }
            html.push('<div class="ui-widget-content ui-corner-all">                                            ');
            html.push('<table class="view">                                                                     ');
            html.push('    <colgroup>                                                                           ');
            html.push('        <col width="' + o.labelWidth + '">                                               ');
            html.push('        <col width="*">                                                                  ');
            html.push('        <col width="' + o.labelWidth + '">                                               ');
            html.push('        <col width="*">                                                                  ');
            html.push('    </colgroup>                                                                          ');
            html.push('        <tr>                                                                                          ');
            html.push('            <th>                                                                                      ');
            html.push(            any.message("lbl.RESEARCH_REQ_NO", "조사분석 의뢰번호").toHTML()                          );
            html.push('            </th>                                                                                     ');
            html.push('            <td colspan="3">                                                                          ');
            html.push('            <span id="RESEARCH_REQ_NO" bind="' + o.ds.id + '"></span>                                 ');
            html.push('            </td>                                                                                     ');
            html.push('        </tr>                                                                                         ');
            html.push('        <tr>                                                                                          ');
            html.push('            <th>                                                                                      ');
            html.push(            any.message("lbl.REQ_PERSON_NAME", "의뢰자").toHTML()                                     );
            html.push('            </th>                                                                                     ');
            html.push('            <td>                                                                                      ');
            html.push('            <span id="REQ_PERSON_NAME" bind="' + o.ds.id + '"></span>                                 ');
            html.push('            (<span id="REQ_DEPT_NAME" bind="' + o.ds.id + '"></span>)                                   ');
            html.push('            </td>                                                                                     ');
if (o.ds.value(0, "REQ_OFFICE_TEL") == '') {
            html.push('            <td colspan="2">                                                                                      ');
            html.push('            <span id="REQ_OFFICE_TEL" bind="' + o.ds.id + '"></span>                                 ');
            html.push('            </td>                                                                                     ');
} else {
            html.push('            <td colspan="2">                                                                                      ');
            html.push('            ☎ <span id="REQ_OFFICE_TEL" bind="' + o.ds.id + '"></span>                                 ');
            html.push('            </td>                                                                                     ');
}
            html.push('        </tr>                                                                                         ');
            html.push('        <tr>                                                                                          ');
            html.push('            <th>                                                                                      ');
            html.push(            any.message("lbl.JOB_MAN_NAME", "건담당자").toHTML()                                      );
            html.push('            </th>                                                                                     ');
            html.push('            <td>                                                                          ');
            html.push('            <span id="JOB_MAN_NAME" bind="' + o.ds.id + '"></span>                                    ');
            html.push('            </td>                                                                                     ');
if (o.ds.value(0, "JOB_OFFICE_TEL") == '') {
            html.push('            <td colspan="2">                                                                                      ');
            html.push('            <span id="JOB_OFFICE_TEL" bind="' + o.ds.id + '"></span>                                 ');
            html.push('            </td>                                                                                     ');
} else {
            html.push('            <td colspan="2">                                                                                      ');
            html.push('            ☎ <span id="JOB_OFFICE_TEL" bind="' + o.ds.id + '"></span>                                 ');
            html.push('            </td>                                                                                     ');
}
            html.push('        </tr>                                                                                         ');
            html.push('        <tr>                                                                                          ');
            html.push('            <th>                                                                                      ');
            html.push(            any.message("lbl.RESEARCH_REQ_SUBJECT", "조사제목").toHTML()                                  );
            html.push('            </th>                                                                                     ');
            html.push('            <td colspan="3">                                                                          ');
            html.push('            <span id="REQ_SUBJECT" bind="' + o.ds.id + '"></span>                                ');
            html.push('            </td>                                                                                     ');
            html.push('        </tr>                                                                                         ');

            break;
        }

        o.$control.html(html.join("\n")).controls(function() {
            o.ds.resetControlValues();

        }).find('th').addClass("ui-widget-header");

        cfResetH2Padding(o.$control);

        o.$control.find('a#RESEARCH_MST_NO').click(function() {
            var win = any.window();
            win.url("/research.master.ResearchMasterAct/viewTab");
            win.param("RESEARCH_MST_ID", o.refId);
            win.option({ resizable:"yes" });
            win.open();
        });

        o.$btn_search = o.$control.find('#btn_fnRelateFileList_' + o.controlIndex).click(function() {
            fnRelateFileList();
        });
    }


});
