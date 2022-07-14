any.control("competitor-abstract").define(function behavior(control, controlName)
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
        prx.url("/competitor.abstractinfo.CompetitorAbstractInfoAct/retrieve");
        prx.param("REF_ID", o.refId);
        prx.output(o.ds);

        prx.onSuccess = function()
        {
            makeHTML();

            if (fireEvent == true) {
                o.$control.fire("onLoad");
            }

        };

        prx.onError = function()
        {
            this.error.show();
        };

        prx.execute();
    }


    function makeHTML()
    {
        if (o.ds == null) return;
        var html = [];
            if (o.$titleArea == null) {
                html.push('<h2>' + any.message("competitor.eval.bibliographic.items", "경쟁사 서지사항").toHTML() + '</h2>  ');
            } else {
                o.$titleArea.text(any.message("competitor.eval.bibliographic.items", "경쟁사 서지사항").toString());
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
            html.push('        <th>' + any.message("lbl.RIGHT_DIV", "권리구분").toHTML() + ' / '+ any.message("lbl.COUNTRY_NAME", "국가").toHTML() +'</th>               ');
            html.push('        <td><span id="RIGHT_DIV_NAME" bind="' + o.ds.id + '"></span> '+' / '+'<span id="COUNTRY_NAME" bind="' + o.ds.id + '"></span></td>');
            html.push('        <th>' + any.message("lbl.INVENT.TITLE", "발명의 명칭").toHTML() + '</th>     ');
            html.push('        <td><a href="javascript:void(0);" id="TITLE" bind="' + o.ds.id + '"></a></td>      ');
            html.push('    </tr>                                                                                 ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.APP_NO", "출원번호").toHTML() + ' / '+ any.message("lbl.APP_DATE", "출원일").toHTML() +'</th>               ');
            html.push('        <td><span id="APP_NO" bind="' + o.ds.id + '"></span> '+' / '+'<span any-date id="APP_DATE" bind="' + o.ds.id + '" readOnly></span></td>');
            html.push('        <th>' + any.message("lbl.NOTICE.NO", "공고번호").toHTML() + ' / '+ any.message("lbl.NOTICE.DATE.01", "공고일").toHTML() +'</th>               ');
            html.push('        <td><span id="NOTICE_NO" bind="' + o.ds.id + '"></span> '+' / '+'<span any-date id="NOTICE_DATE" bind="' + o.ds.id + '" readOnly></span></td>');
            html.push('    </tr>                                                                                ');
            html.push('    <tr>                                                                                 ');
            html.push('        <th>' + any.message("lbl.REG_NO", "등록번호").toHTML() + ' / '+ any.message("lbl.REG_DATE", "등록일").toHTML() +'</th>               ');
            html.push('        <td><span id="REG_NO" bind="' + o.ds.id + '"></span> '+' / '+'<span any-date id="REG_DATE" bind="' + o.ds.id + '" readOnly></span></td>');
            html.push('        <th>' + any.message("lbl.INV_STATUS", "상태").toHTML() + ' / '+ any.message("lbl.EVAL.GRADE", "평가등급").toHTML() +'</th>               ');
            html.push('        <td><span id="STATUS_CODE_NAME" bind="' + o.ds.id + '"></span> '+' / '+'<span id="EVAL_GRADE" bind="' + o.ds.id + '"></span></td>');
            html.push('    </tr>                                                                                ');
            html.push('</table>                                                                                 ');
            html.push('</div>                                                                                   ');

    o.$control.html(html.join("\n")).controls(function() {
        o.ds.resetControlValues();
    }).find('th').addClass("ui-widget-header");

    o.$control.find('a#TITLE').click(function() {
        var win = any.window();
        win.url("/competitor.master.CompetitorMasterAct/viewDetail");
        win.param("MGT_ID", o.refId);
        win.option({ resizable:"yes" });
        win.open();
    });

   }

});
