any.control("app-refdsnlist").inherit("any-dsgrid", function initialize(control, controlName)
{
    this.addColumn({width : 140, align : "center", name : "REF_NO"              , label : any.message("lbl.MST_NO", "관리번호")});
    this.addColumn({width : 100, align : "center", name : "RIGHT_DIV_NAME"      , label : any.message("lbl.RIGHT_DIV", "권리구분")});
    this.addColumn({width : 200, align : "left"  , name : "KO_APP_TITLE"        , label : any.message("lbl.KO_APP_TITLE", "출원의명칭")});
    this.addColumn({width : 100, align : "center", name : "COUNTRY_NAME"        , label : any.message("lbl.COUNTRY_NAME", "국가")});
    this.addColumn({width : 100, align : "center", name : "INV_MGT_PERSON_NAME" , label : any.message("lbl.INV_MGT_PERSON", "발명관리자")});
    this.addColumn({width : 100, align : "center", name : "APP_NO"              , label : any.message("lbl.APP_NO", "출원번호")});
    this.addColumn({width : 100, align : "center", name : "APP_DATE"            , label : any.message("lbl.APP_DATE", "출원일"),control : "any-date",controlattr : {readOnly : true}});
    this.setOption({rownumbers : true});
    this.setKeys("MST_ID");

    // 1번째 행을 삭제 불가
    this.setRowDeletable(function(rowData, rowId) {
        return rowId != "1";
    });
})

.define(function behavior(control, controlName)
{
    var o = {};
    var checkValid = true;

    (function main()
    {
        o.$control = $(control);

        control.setAddButton(doSearch);
        control.addAction("REF_NO", fnMasterAct);

        o.$control.defineMethod("searchData", searchData);

        o.$control.defineProperty("firstAppData", { get : getFirstAppData });
        o.$control.defineProperty("checkValid", { get : getCheckValid });

        any.control(control).initialize();
    })();

    // 마스터 팝업 호출
    function fnMasterAct(rowData, rowId, colName)
    {
        var win = any.window();
        win.url("/design.master.DesignMasterAct/viewTab");
        win.param("MST_ID", rowData.REF_ID);
        win.option({ resizable:"yes" });
        win.open();
    }

    function doSearch(searchText)
    {
        var win = any.window(true);
        win.url("/common.popup.PopupAct/viewPopup?path=RefNoSearchListR.jsp");
        win.arg("IS_DSN", "1");
        win.arg("IS_GRP", "1");
        win.arg("multiselect", true);
        if (searchText != null) {
            win.arg("SEARCH_TEXT", searchText);
        }
        win.ok(function(data)
        {
            var rowCount = control.getRowCount(true);
            if (data == null) return;
            var exists = [];

            for ( var i = 0; i < data.length; i++) {
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

    function getCheckValid()
    {
        return checkValid;
    }

    function getFirstAppData()
    {
        var minAppDate = null;
        var row = null;

        for (var i = 0; i < control.getRowCount(); i++) {
            if (control.getJobType(i) == "D") continue;

            var appDate = control.getValue(i, "APP_DATE");

            if ((minAppDate == null || minAppDate > appDate) && appDate!="") {
                minAppDate = appDate;
                row = i;
            }
        }

        if (row == null) return control.getRowData(0);
        return control.getRowData(row);
    }

    function searchData(refId)
    {
        var ds = any.ds("ds_" + control.id + "_searchData");

        if (refId == null || refId == "") return;

        var prx = any.proxy();
        prx.url("/common.popup.PopupAct/retrieveList?name=refNoList");
        prx.param("SEARCH_TEXT", refId);
        prx.param("_DS_ID_", ds.id);

        prx.onSuccess = function()
        {
            if (ds.rowCount() > 0) {
                control.addRow(ds.rowData(0));
            } else {
                doSearch(refId);
            }
        };

        prx.onError = function()
        {
            this.error.show();
        };

        prx.execute();
    }

});
