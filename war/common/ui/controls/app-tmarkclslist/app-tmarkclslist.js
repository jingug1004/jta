any.control("app-tmarkclslist").inherit("any-dsgrid", function initialize(control, controlName)
{
    var rowAlterable = $(control).attr("rowAlterable");

    this.addColumn({ width:150, align:"center", name:"TMARK_CLS_NAME"   , label:any.message("lbl.TMARK_CLS_NAME", "상품류") });
    this.addColumn({ width:"*", align:"left"  , name:"SPEC_PROD"        , label:any.message("lbl.SPEC_PROD", "지정상품"), control:"any-text", edit:true });
    this.setOption({ rownumbers:true });

    if (rowAlterable != null) {
        this.setOption({ rowAlterable:any.object.toBoolean(rowAlterable) });
    }

    this.setKeys("TMARK_CLS_ID");
})
.define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);
        o.config = any.control(controlName).config;
        o.controlIndex = any.control().newIndex();

        o.edit = o.$control.prop("edit");

        control.setAddButton(doSearch);

        any.control(control).initialize();
    })();

    function doSearch()
    {
        var win = any.window(true);
        win.url("/common.popup.PopupAct/viewPopup?path=TmarkClsSearchListR.jsp");
        win.arg("multiselect", true);

        win.ok(function(data) {
            if (data == null) return;

            var exists = [];

            for (var i = 0; i < data.length; i++) {
                if (control.addRow(data[i]) == "exists") {
                    exists.push(data[i].TMARK_CLS_NAME);
                }
            }

            if (exists.length > 0) {
                alert(any.message("이미 추가되었습니다.") + "\n\n" + exists.join("\n"));
            }
        });

        win.show();
    }
});
