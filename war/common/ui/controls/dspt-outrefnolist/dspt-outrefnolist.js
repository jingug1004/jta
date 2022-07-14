any.control("dspt-outrefnolist").inherit("any-dsgrid", function initialize(control, controlName)
{
    this.addColumn({ width:120, align:"center"  , name:"APP_NO"           , label:any.message("lbl.APP_NO","출원번호"), control:"any-text" , edit:true });
    this.addColumn({ width:100, align:"center"  , name:"APP_DATE"           , label:any.message("lbl.APP_DATE","출원일자"), control:"any-date" , edit:true });
    this.addColumn({ width:100, align:"center"  , name:"REG_NO"        , label:any.message("lbl.REG_NO","등록번호") , control:"any-text" , edit:true});
    this.addColumn({ width:120 , align:"center" , name:"REG_DATE"      , label:any.message("lbl.REG_DATE","등록일자"), control:"any-date" , edit:true });
    this.setOption({ rownumbers:true });
})

.define(function behavior(control, controlName)
{
    var o = {};
    (function main() {
        o.$control = $(control);
        o.config = any.control(controlName).config;
        o.controlIndex = any.control().newIndex();
        control.setAddButton(addData);
        o.edit = o.$control.prop("edit");
        o.checkValue = any.boolean(o.config("booleanValues")).trueValue();
        o.uncheckValue = any.boolean(o.config("booleanValues")).falseValue();
        any.control(control).initialize();
    })();
    function addData(data)
    {
        return control.addRow(data);
    }
});
