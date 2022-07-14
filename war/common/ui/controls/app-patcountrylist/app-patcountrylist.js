any.control("app-patcountrylist").inherit("any-dsgrid", function initialize(control, controlName)
{
    var edit = $(control).prop("edit");
    var isPct = ($(control).hasAttr("isPct") && any.object($(control).attr("isPct")).toBoolean(true));
    var isEP = ($(control).hasAttr("isEP") && any.object($(control).attr("isEP")).toBoolean(true));

    this.addColumn({ width:50 , align:"center"  , name:"COUNTRY_NAME"          , label:any.message("lbl.COUNTRY_NAME", "국가") });
    if (!isEP) {
        this.addColumn({ width:75 , align:"center"  , name:"EXAMREQ_YN"            , label:any.message("lbl.EXAMREQ_YN","심사청구"), control:"any-radio", controltag:'span', controlattr:{ codeData:"{EXAMREQ_YN}" }, edit:true, require:true });
    }
    this.addColumn({ width:80 , align:"center"  , name:"OFFICE_ID"             , label:any.message("lbl.OFFICE_NAME", "사무소")      , control:"any-select", controlattr:{ codedata:"/app/officeListIn", firstName:"sel"}, edit:true, require:true });
    this.addColumn({ width:100, align:"center"  , name:"BIZ_PROC_DIV"          , label:any.message("lbl.BIZ_PROC_DIV", "업무구분") , control:"any-select", controlattr:{ firstName:"sel" }, edit:true, require:true});
    this.addColumn({ width:90 , align:"center"  , name:"BIZ_LIMIT_DATE"        , label:any.message("lbl.BIZ_LIMIT_DATE", "업무기한"), control:"any-date", controltag:'span',edit:true, require:true });
    this.setOption({ rownumbers:true });
    this.setKeys("COUNTRY_CODE");

    this.addControlInitializer("BIZ_PROC_DIV", function(event, row) {
        if (isPct) {
            $(this).prop("codeData", "{BIZ_PROC_DIV_P_A}");
        } else if(isEP) {
            $(this).prop("codeData", "{BIZ_PROC_DIV_P_R}");
        } else {
            $(this).prop("codeData", "{BIZ_PROC_DIV_P_K}");
        }
    });

    if (!isEP) {
        this.addControlInitializer("EXAMREQ_YN", function(event, row) {
            if (control.getValue(row, "COUNTRY_CODE")   == "EP" || control.getValue(row, "COUNTRY_CODE")   == "WO" || control.getValue(row, "COUNTRY_CODE")   == "US") {
                $(this).prop("value", "1");
                $(this).prop("readOnly2","true");
            } else {
                $(this).prop("value", "1");
            }
        });
    }
})
.define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);
        o.isPct = (o.$control.hasAttr("isPct") && any.object(o.$control.attr("isPct")).toBoolean(true));
        o.isEp = (o.$control.hasAttr("isEp") && any.object(o.$control.attr("isEp")).toBoolean(true));
        o.officeId = $(control).attr("officeId");

        control.setAddButton(doSearch);

        any.control(control).initialize();
    })();

    function doSearch()
    {
        var win = any.window(true);
        win.url("/common.popup.PopupAct/viewPopup?path=CountrySearchListR.jsp");
        win.arg("multiselect", true);
        win.arg("IS_PCT", o.isPct ? "1" : "0");
        win.arg("IS_EP", o.isEp ? "1" : "0");
        win.arg("IS_PAT", "1");


        win.ok(function(data) {
            if (data == null) return;

            var exists = [];

            for (var i = 0; i < data.length; i++) {

                // 우선권의 사무소 정보가 있을 경우 디폴드 처리
                if (o.officeId != null && o.officeId != "") {
                    data[i].OFFICE_ID = o.officeId;
                }
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
