any.control("app-tmkcountrylist").inherit("any-dsgrid", function initialize(control, controlName)
{
    var isFirst = ($(control).hasAttr("isFirst") && any.object($(control).attr("isFirst")).toBoolean(true));
    var parentControlId = $(control).attr("parentControlId");
    var childControlId = $(control).attr("childControlId");

    this.addColumn({ width:150 , align:"center"  , name:"COUNTRY_NAME"          , label:any.message("lbl.COUNTRY_NAME", "국가"), require:true });
    if (isFirst) {
        this.addColumn({ width:100 , align:"center"  , name:"FIRSTAPP_YN"           , label:any.message("lbl.FIRSTAPP_YN", "기초출원"), control:"radio", edit:true,  require:true});
    }
    this.addColumn({ width:"*", align:"center"  , name:"TMARK_CLS_TYPE_NAME"       , label:any.message("lbl.TMARK_CLS_TYPE_NAME", "단류/다류")});
    this.setOption({ rownumbers:true });
    this.setKeys("COUNTRY_CODE");

    if (isFirst && childControlId != "") {
        // 마드리드건이 삭제될시 하위 마드리드 국가 목록 제거, 비필수처리
        $(this).on("onDeleteRow", function(event, data) {
            for (var i = 0; i < data.length; i++) {
                if (data[i].COUNTRY_CODE == "MD") {
                    $("#" + childControlId).exec("clearData");
                    $("#" + childControlId).prop("require", false);
                }
            }
        });
        // 마드리드건이 추가될시 하위 마드리드 필수 처리
        $(this).on("onAddRow", function(event, row) {
            if ($(control).exec("getValue", row, "COUNTRY_CODE") == "MD") {
                $("#" + childControlId).prop("require", true);
            }
        });
    }
})
.define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);
        o.config = any.control(controlName).config;
        o.edit = o.$control.prop("edit");

        o.isFirst = (o.$control.hasAttr("isFirst") && any.object(o.$control.attr("isFirst")).toBoolean(true));
        o.isMd = (o.$control.hasAttr("isMd") && any.object(o.$control.attr("isMd")).toBoolean(true));
        o.checkValue = any.boolean(o.config("booleanValues")).trueValue();
        o.uncheckValue = any.boolean(o.config("booleanValues")).falseValue();
        o.parentControlId = o.$control.attr("parentControlId");
        o.childControlId = o.$control.attr("childControlId");

        o.$control.attr("valid-enable", o.edit === true);

        control.setAddButton(doSearch);

        o.$control.defineProperty("checkValid", { get:getCheckValid });

        any.control(control).initialize();
    })();

    function doSearch()
    {
        // 마드리드 국가 추가시 부모 컨트롤에 마드리드가 추가 되어 있으야 한다.
        if (o.isMd && o.parentControlId && o.parentControlId != "") {
            var parentDs = $("#" + o.parentControlId).prop("ds");
            var isExists = false;
            for (var i = 0; i < parentDs.rowCount(true); i++) {
                if (parentDs.value(i, "COUNTRY_CODE") == "MD") {
                    isExists = true;
                    break;
                }
            }

            if (!isExists) {
                alert(any.message("msg.alert.country.md.need", "출원국가로 마드리드가 지정 되어야 합니다."));
                return;
            }
        }

        var win = any.window(true);
        win.url("/common.popup.PopupAct/viewPopup?path=CountrySearchListR.jsp");
        win.arg("multiselect", true);
        win.arg("IS_MD", o.isMd ? "1" : "0");
        win.arg("IS_TMK", "1");


        win.ok(function(data) {
            if (data == null) return;

            var exists = [];

            for (var i = 0; i < data.length; i++) {
                if (control.addRow(data[i]) == "exists") {
                    exists.push(data[i].COUNTRY_NAME);
                }
            }

            if (exists.length > 0) {
                alert(any.message("msg.alert.nextCase.already.add", "다음 건은 이미 추가되어 있습니다.") + "\n\n" + exists.join("\n"));
            }
        });

        win.show();
    }

    function getCheckValid()
    {
        if (!o.isFirst) return true;

        var isChecked = false;

        for (var i = 0; i < o.$control.prop("rowCount"); i++) {
            if (control.getJobType(i) == "D") continue;

            var rowData = control.getRowData(i);

            if (rowData.COUNTRY_CODE == "MD" && rowData.FIRSTAPP_YN == "1") {
                alert(any.message("msg.alert.country.md.firstapp.not", "마드리드 국가로 기초출원을 진행할 수 없습니다."));
                return false;
            }

            if (rowData.FIRSTAPP_YN == "1") isChecked = true;
        }

        if (!isChecked) {
            alert(any.message("msg.alert.country.md.firstapp.not.check", "기초출원 국가가 지정되지 않았습니다."));
            return false;
        }

        return true;
    }
});
