any.control("dspt-refnolist").inherit("any-dsgrid", function initialize(control, controlName)
{
    this.addColumn({ width:120, align:"center"  , name:"REF_NO"           , label:"REF_NO" });
    this.addColumn({ width:100, align:"center"  , name:"APP_NO"           , label:any.message("lbl.APP_NO","출원번호") });
    this.addColumn({ width:100, align:"center"  , name:"REG_NO"           , label:any.message("lbl.REG_NO","등록번호") });
    this.addColumn({ width:120, align:"left"  , name:"KO_APP_TITLE"     , label:any.message("lbl.KO_TITLE","발명의명칭") });
    this.setOption({ rownumbers:true });
    this.setKeys("MST_ID");
})
.define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);

        control.setAddButton(doSearch);
        control.addAction("REF_NO", fnMasterAct);

        o.reqDiv = any.text(o.$control.attr("reqDiv")).nvl("");

        any.control(control).initialize();
    })();

    // 마스터 팝업 호출
    function fnMasterAct(rowData, rowId, colName)
    {
        var win = any.window();
        win.url("/patent.master.PatentMasterAct/viewTab");
        win.param("MST_ID", rowData.REF_ID);
        win.option({ resizable:"yes" });
        win.open();
    }

    function doSearch()
    {
        var win = any.window(true);
        win.url("/common.popup.PopupAct/viewPopup?path=RefNoSearchListR.jsp");
        win.arg("multiselect", true);
        win.arg("REQ_DIV", o.reqDiv);
        win.param("APP_NO","EXIST");
        win.param("APP_DATE","EXIST");


        win.ok(function(data) {
            if (data == null) return;
            var exists = [];
            for (var i = 0; i < data.length; i++) {
                if (control.addRow(data[i]) == "exists") {
                    exists.push(data[i].REF_NO);
                }
            }

            if (exists.length > 0) {
                alert(any.message("msg.alert.nextCase.already.add", "다음 건은 이미 추가되어 있습니다.") + "\n\n" + exists.join("\n"));
            }
        });

        win.show();
    }


});
