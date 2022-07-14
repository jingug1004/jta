any.control("app-techcodelist").inherit("any-dsgrid", function initialize(control, controlName)
{
    this.addColumn({ width:70 , align:"center", name:"TECH_CODE"        , label:any.message("lbl.TECH_CODE", "기술코드") });
    this.addColumn({ width:80 , align:"cneter", name:"KO_TECH_NAME"     , label:any.message("lbl.TECH_PATHNAME", "기술이름") });
    this.addColumn({ width:"*", align:"left"  , name:"TECH_PATHNAME"    , label:any.message("lbl.TECH_PATH_NAME", "기술분류") });
    this.setOption({ rownumbers:true });
    this.setKeys("TECH_CODE");
})
.define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);

        control.setAddButton(doSearch);

        o.$control.defineMethod("addList", addList);

        any.control(control).initialize();
    })();

    function doSearch()
    {
        var win = any.window(true);
        win.url("/common.popup.PopupAct/viewPopup?path=TechCodeSearchTreeR.jsp");
        win.arg("multiselect", true);

        win.ok(function(data) {
            if (data == null) return;

            var exists = [];

            for (var i = 0; i < data.length; i++) {
                if (control.addRow(data[i]) == "exists") {
                    exists.push("[" + data[i].TECH_CODE + "] " + data[i].TECH_PATHNAME);
                }
            }

            if (exists.length > 0) {
                alert(any.message("msg.alert.nextCase.already.add", "다음 건은 이미 추가되어 있습니다.") + "\n\n" + exists.join("\n"));
            }
        });

        win.show();
    }

    function initSearchDs()
    {
        if (o.searchDs == null) {
            o.searchDs = any.ds("ds_techCodeSearch_" + control.id + "_" + o.controlIndex);
        }
    }

    function addList(refId, mappDiv)
    {
        if (refId == null || refId == "") return;
        if (mappDiv == null || mappDiv == "") return;

        initSearchDs();

        var prx = any.proxy();
        prx.url("/common.mapp.techcode.TechCodeMappAct/retrieveList");
        prx.param("_DS_ID_", o.searchDs.id);
        prx.param("REF_ID", refId);
        prx.param("MAPP_DIV", mappDiv);

        prx.onSuccess = function()
        {
            for (var i = 0; i < o.searchDs.rowCount(); i++) {
                control.addRow(o.searchDs.rowData(i));
            }
        };

        prx.onError = function()
        {
            this.error.show();
        };

        prx.execute();
    }
});
