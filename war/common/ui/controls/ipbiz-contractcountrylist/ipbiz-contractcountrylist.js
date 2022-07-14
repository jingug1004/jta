any.control("ipbiz-contractcountrylist").inherit("any-dsgrid", function initialize(control, controlName)
{
    var edit = $(control).prop("edit");

    this.addColumn({ width:150 , align:"center"  , name:"COUNTRY_NAME"          , label:any.message("lbl.COUNTRY_NAME", "국가") });
    this.setOption({ rownumbers:true });
    this.setOption({ multiselect:true });
    this.setKeys("COUNTRY_ID");
})
.define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);

        control.setAddButton(doSearch);

        any.control(control).initialize();
    })();

    function doSearch()
    {
        var win = any.window(true);
        win.url("/common.popup.PopupAct/viewPopup?path=CountrySearchListR.jsp");
        win.arg("multiselect", true);

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
});
