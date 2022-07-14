any.control("copyright-inventor").inherit("any-dsgrid", function initialize(control, controlName)
{
    this.addColumn({ width:35 , align:"center", name:"MAIN_INVENTOR_YN" , label:any.message("lbl.MAIN_INVENTOR_YN","주"), control:"radio", edit:true, require:true });
    this.addColumn({ width:"*", align:"center", name:"KO_NAME"          , label:any.message("lbl.KO_NAME","성명(한)") });
    this.addColumn({ width:"*", align:"center", name:"EN_NAME"          , label:any.message("lbl.EN_NAME","성명(영)") });
    this.addColumn({ width:"*", align:"center", name:"ZH_NAME"          , label:any.message("lbl.ZH_NAME","성명(중)") });
    this.addColumn({ width:100, align:"center", name:"DEPT_NAME"        , label:any.message("lbl.DEPT_NAME","부서") });
    this.addColumn({ width:80 , align:"right" , name:"QUOTA_RATIO"      , label:any.message("lbl.QUOTA_RATIO","지분율"), control:"any-number", controlattr:{ min:0, max:100 }, edit:true, require:true });
    this.addColumn({ width:40 , align:"center", name:"INOUT_NAME"       , label:any.message("lbl.IN_INVENTOR_YN","내외") });
    this.setOption({ rownumbers:true });
    this.setKeys("PERSON_ID");
})
.define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);
        o.config = any.control(controlName).config;
        o.controlIndex = any.control().newIndex();

        control.setAddButton(doSearch);
        control.addButton(any.message("copyright.btn.quotaratio.autoCalc", "지분율 자동계산"), resetPriShare);

        o.edit = o.$control.prop("edit");
        o.checkValue = any.boolean(o.config("booleanValues")).trueValue();
        o.uncheckValue = any.boolean(o.config("booleanValues")).falseValue();

        o.$control.attr("valid-enable", o.edit === true);

        // 발명자 추가
        o.$control.defineMethod("addInventor", addInventor);
        // 다중의 발명자 추가
        o.$control.defineMethod("addList", addList);
        // 주발명자만 표시
        o.$control.defineMethod("dispMainInventor", dispMainInventor);

        o.$control.defineProperty("checkValid", { get:getCheckValid });

        any.control(control).initialize();

        // 로그인 사용자 추가
        if (o.$control.hasAttr("addLoginUser")) {
            addInventor("_LOGIN_USER_");
        }
    })();

    function doSearch()
    {
        var win = any.window(true);
        win.url("/common.popup.PopupAct/viewPopup?path=PersonSearchListR.jsp");
        win.param("PERSON_DIVS", "PAT,OUT"); // 내부, 외부
        win.param("OUT_INVENTOR_YN", "1");   // 외부발명자 등록 버튼 활성화
        win.arg("multiselect", true);

        win.ok(function(data) {
            if (data == null) return;

            var exists = [];

            for (var i = 0; i < data.length; i++) {
                if (addData(data[i]) == "exists") {
                    exists.push("[" + data[i].EMP_NO + "] " + data[i].PERSON_NAME);
                }
            }

            if (exists.length > 0) {
                alert(any.message("msg.next.inventor.already.add", "다음 발명자는 이미 추가되어 있습니다.") + "\n\n" + exists.join("\n"));
            }
        });

        win.show();
    }

    // 내부 발명자 수
    function getVisibleCount()
    {
        var count = 0;
        for (var i = 0; i < control.getRowCount(true); i++) {
            if (control.getRowData(i).IN_INVENTOR_YN == 1) {
                count += 1;
            } else {
                control.setValue(i, "QUOTA_RATIO", "0");
            }
        }
        return count;
    }

    // 지분율 자동 계산
    function resetPriShare()
    {
        var visibleCount = getVisibleCount();
        var invShare = parseInt(100 / visibleCount, 10);  // 분할된 지분율
        var priShare = 100 - invShare * (visibleCount - 1);  // 잔여 지분율
        var isMainInventorYn = false;

        for (var i = 0; i < o.$control.prop("rowCount"); i++) {
            if (control.getJobType(i) == "D") continue;
            var mainInventorYn = control.getValue(i, "MAIN_INVENTOR_YN");

            if (mainInventorYn == o.checkValue) isMainInventorYn = true;

            if (control.getRowData(i).IN_INVENTOR_YN == '1') {
                control.setValue(i, "QUOTA_RATIO", mainInventorYn == o.checkValue ? priShare : invShare);
            }
        }

        if (isMainInventorYn == true) return;

        // 주 발명자가 없을 경우 첫번째 발명자에게 잔여 지분율 설정
        for (var i = 0; i < o.$control.prop("rowCount"); i++) {
            if (control.getJobType(i) == "D") continue;
            control.setValue(i, "QUOTA_RATIO", priShare);
            break;
        }
    }

    function initSearchDs()
    {
        if (o.searchDs == null) {
            o.searchDs = any.ds("ds_inventorSearch_" + control.id + "_" + o.controlIndex);
        }
    }

    function addData(data, isSearch)
    {
        if (data == null) return;

        if (isSearch == true && o.$control.prop("rowCount") == 0) {
            data.MAIN_INVENTOR_YN = o.checkValue;
            data.QUOTA_RATIO = "100";
        } else {
            data.MAIN_INVENTOR_YN = o.uncheckValue;
            data.QUOTA_RATIO = "";
        }

        return control.addRow(data);
    }

    // 발명자 추가
    function addInventor(personId)
    {
        if (personId == null || personId == "") return;

        initSearchDs();

        var prx = any.proxy();
        prx.url("/common.mapp.inventor.InventorMappAct/retrievePersonInfo");
        prx.param("_DS_ID_", o.searchDs.id);
        prx.param("PERSON_ID", personId);

        prx.onSuccess = function()
        {
            if (o.searchDs.rowCount() == 1) {
                addData(o.searchDs.rowData(0), true);
            }
        };

        prx.onError = function()
        {
            this.error.show();
        };

        prx.execute();
    }

    /*
     * 관련ID, 매핑구분을 이용하여 해당 되는 발명자 목록을 조회하여
     * 다중의 발명자를 추가하여 준다.
     * */
    function addList(refId, mappDiv)
    {
        if (refId == null || refId == "") return;
        if (mappDiv == null || mappDiv == "") return;

        initSearchDs();

        var prx = any.proxy();
        prx.url("/common.mapp.inventor.InventorMappAct/retrieveList");
        prx.param("_DS_ID_", o.searchDs.id);
        prx.param("REF_ID", refId);
        prx.param("MAPP_DIV", mappDiv);

        prx.onSuccess = function()
        {
            for (var i = 0; i < o.searchDs.rowCount(); i++) {
                addData(o.searchDs.rowData(i));
            }
        };

        prx.onError = function()
        {
            this.error.show();
        };

        prx.execute();
    }

    // 주 발명자만 표시
    function dispMainInventor()
    {
        for(var i = 0; i < o.$control.prop("rowCount"); i++ ) {
            var mainInventorYn = control.getValue(i, "MAIN_INVENTOR_YN");

            if (mainInventorYn == o.checkValue) continue;
            else control.deleteRow(i);

        }
    }

    /*
     * 주 발명자 선택 여부, 지분율 합계100 여부, 내부발명자의 지분율입력 여부 확인
     */
    function getCheckValid()
    {
        if (control.getRowCount(true) == 0) return true;

        var isMainInventorYn = false;
        var quotaRatioSum = 0;

        for (var i = 0; i < o.$control.prop("rowCount"); i++) {
            if (control.getJobType(i) == "D") continue;

            var rowData = control.getRowData(i);

            if (rowData.QUOTA_RATIO == null || rowData.QUOTA_RATIO == "" || rowData.QUOTA_RATIO == "0") {
                if (rowData.IN_INVENTOR_YN == 1) {
                    alert(any.message("msg.quota.ratio.input", "지분율을 입력하세요."));
                    control.getControl(i, "QUOTA_RATIO").focus();
                    return false;
                }
            }

            if (rowData.MAIN_INVENTOR_YN == o.checkValue) {
                isMainInventorYn = true;
            }

            quotaRatioSum += Number(rowData.QUOTA_RATIO);
        }

        if (isMainInventorYn != true) {
            alert(any.message("msg.main.inventor.select", "주 발명자를 선택하세요."));
            control.getControl(0, "MAIN_INVENTOR_YN").focus();
            return false;
        }

        if (quotaRatioSum != 100) {
            alert(any.message("msg.quota.ratio.sum.100.not.error", "지분율 합계가 100 이 되지 않습니다."));
            control.getControl(0, "QUOTA_RATIO").focus();
            return false;
        }

        return true;
    }
});
