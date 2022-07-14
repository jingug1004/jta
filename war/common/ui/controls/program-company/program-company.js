any.control("program-company").inherit("any-dsgrid", function initialize(control, controlName)
{
    this.addColumn({ width:35  , align:"center" , name:"OWN_YN"        , label:any.message("lbl.OWN_YN","주"), control:"radio", edit:true, require:true });
    this.addColumn({ width:"*" , align:"center" , name:"COMPANY_NAME"  , label:any.message("lbl.COPYRIGHT_COMPANY_NAME", "회사명") , control:"any-text" });
    this.addColumn({ width:300 , align:"center" , name:"QUOTA_RATIO"   , label:any.message("lbl.QUOTA_RATIO", "지분율(%)"), control:"any-number", controlattr:{ max:100 }, edit:true, require:true });
    this.setOption({ rownumbers:true });
    this.setKeys("COMPANY_ID");
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

        o.$control.defineProperty("checkValid", { get:getCheckValid });

        any.control(control).initialize();
    })();

    function doSearch()
    {
        var win = any.window(true);
        win.url("/common.popup.PopupAct/viewPopup?path=CompanySearchListR.jsp");
        win.arg("multiselect", true);

        win.ok(function(data) {
            if (data == null) return;

            var exists = [];

            for (var i = 0; i < data.length; i++) {
                if (addData(data[i]) == "exists") {
                    exists.push("[" + data[i].COMPANY_CODE + "] " + data[i].COMPANY_NAME);
                }
            }

            if (exists.length > 0) {
                alert(any.message("msg.next.copyright.company.already.add", "다음 저작권자는 이미 추가되어 있습니다.") + "\n\n" + exists.join("\n"));
            }
        });

        win.show();
    }

    // 저작권자 추가
    function addData(data, isSearch)
    {
        if (data == null) return;

        if (isSearch == true && o.$control.prop("rowCount") == 0) {
            data.OWN_YN = o.checkValue;
            data.QUOTA_RATIO = "100";
        } else {
            data.OWN_YN = o.uncheckValue;
            data.QUOTA_RATIO = "";
        }

        return control.addRow(data);
    }

    // 지분율 자동 계산
    function resetPriShare()
    {
        var rowCount = control.getRowCount(true);
        var share = parseInt(100 / rowCount, 10); // 분할된 지분율
        var priShare = 100 - share * (rowCount - 1); // 잔여 지분율
        var isOwnYn = false;

        for (var i = 0; i < rowCount; i++) {
            if (control.getJobType(i) == "D") continue;
            var ownYn = control.getValue(i, "OWN_YN");

            if (ownYn == o.checkValue) isOwnYn = true;

            control.setValue(i, "QUOTA_RATIO", ownYn == o.checkValue ? priShare : share);
        }

        if (isOwnYn == true) return;

        // 주 저작권가 없을 경우 첫번째 저작권자에게 잔여 지분율 설정
        for (var i = 0; i < o.$control.prop("rowCount"); i++) {
            if (control.getJobType(i) == "D") continue;
            control.setValue(i, "QUOTA_RATIO", priShare);
            break;
        }
    }

    /*
     * 주 저작권자 선택 여부, 지분율 합계100 여부, 지분율입력 여부 확인
     */
    function getCheckValid()
    {
        if (control.getRowCount(true) == 0) return true;

        var quotaRatioSum = 0;
        var isOwnYn = false;

        for (var i = 0; i < o.$control.prop("rowCount"); i++) {
            if (control.getJobType(i) == "D") continue;

            var rowData = control.getRowData(i);

            if (rowData.QUOTA_RATIO == null || rowData.QUOTA_RATIO == "" || rowData.QUOTA_RATIO == "0") {
                if (rowData.isOwnYn == 1) {
                    alert(any.message("msg.quota.ratio.input.copyright.company", "저작권자 지분율을 입력하세요."));
                    control.getControl(i, "QUOTA_RATIO").focus();
                    return false;
                }
            }

            if (rowData.OWN_YN == o.checkValue) {
                isOwnYn = true;
            }

            quotaRatioSum += Number(rowData.QUOTA_RATIO);
        }

        if (isOwnYn != true) {
            alert(any.message("msg.main.copyright.company.select", "주 저작권자를 선택하세요."));
            control.getControl(0, "OWN_YN").focus();
            return false;
        }

        if (quotaRatioSum != 100) {
            alert(any.message("msg.quota.ratio.sum.100.not.error.copyright.company", "저작권자 지분율 합계가 100 이 되지 않습니다."));
            control.getControl(0, "QUOTA_RATIO").focus();
            return false;
        }

        return true;
    }

});
