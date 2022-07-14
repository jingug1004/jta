any.control("app-projectlist").inherit("any-dsgrid", function initialize(control, controlName)
{
    this.addColumn({ width:150 , align:"center" , name:"PRJT_CODE"          , label:any.message("lbl.PRJT_CODE", "프로젝트코드") });
    this.addColumn({ width:"*" , align:"left"   , name:"PRJT_NAME"          , label:any.message("lbl.PRJT_NAME", "프로젝트명")});
    this.setOption({ rownumbers:true });

    this.setKeys("PRJT_ID");
})
.define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);
        o.multiselect = (o.$control.hasAttr("multiselect") && any.object(o.$control.attr("multiselect")).toBoolean(true));

        o.$addButton = control.setAddButton(doSearch);

        if (o.multiselect != true) {
            o.$control.on("onChangeRow", function() {
                o.$addButton.prop("disabled", this.getRowCount() > 0);
            });
        }

        o.$control.defineMethod("addList", addList);

        any.control(control).initialize();
    })();

    function doSearch()
    {
        var win = any.window(true);
        win.url("/common.popup.PopupAct/viewPopup?path=ProjectSearchListR.jsp");
        win.arg("multiselect",o.multiselect);
        win.ok(function(data) {
            if (o.multiselect) {

                if (data == null) return;
                var exists = [];

                for (var i = 0; i < data.length; i++) {
                    if (control.addRow(data[i]) == "exists") {
                        exists.push(data[i].PRJT_NAME);
                    }
                }

                if (exists.length > 0) {
                    alert(any.message("msg.alert.nextCase.already.add", "다음 건은 이미 추가되어 있습니다.") + "\n\n" + exists.join("\n"));
                }
            } else {
                if (data.PRJT_ID != null) {
                    control.addRow(data);
                }
            }
        });

        win.show();
    }

    function initSearchDs()
    {
        if (o.searchDs == null) {
            o.searchDs = any.ds("ds_projectSearch_" + control.id + "_" + o.controlIndex);
        }
    }

    /*
     * 관련ID, 매핑구분을 이용하여 해당 되는 프로젝트 목록을 조회하여
     * 다중의 프로젝트를 추가하여 준다.
     * */
    function addList(refId, mappDiv)
    {
        if (refId == null || refId == "") return;
        if (mappDiv == null || mappDiv == "") return;

        initSearchDs();

        var prx = any.proxy();
        prx.url("/common.mapp.project.ProjectMappAct/retrieveList");
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
