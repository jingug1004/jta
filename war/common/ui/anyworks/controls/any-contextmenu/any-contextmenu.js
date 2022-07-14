any.control("any-contextmenu").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.config = any.control(control).config;
        o.options = [];
        o.menus = [];

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("clearAll", clearAll);
        o.$control.defineMethod("getMenus", getMenus);
        o.$control.defineMethod("addMenu", addMenu);
        o.$control.defineMethod("addSeparator", addSeparator);
        o.$control.defineMethod("setOption", setOption);
        o.$control.defineMethod("setDynamic", setDynamic);
        o.$control.defineMethod("attach", attach);

        any.control(control).initialize();
    })();

    function element()
    {
        return o.$element;
    }

    function clearAll()
    {
        o.menus.length = 0;
    }

    function getMenus()
    {
        return o.menus;
    }

    function addMenu(text, func, spec)
    {
        if (spec == null) {
            spec = {};
        }

        if (spec.icon != null && spec.icon != "") {
            spec.icon = any.meta.contextPath + o.config("url.icons") + "/" + spec.icon;
        }

        spec.onclick = func;

        var menu = {};
        menu[text] = spec;
        o.menus.push(menu);
    }

    function addSeparator()
    {
        o.menus.push(jQuery.contextMenu.separator);
    }

    function setOption()
    {
        any.copyArguments(o.options, arguments);
    }

    function setDynamic(func)
    {
        o.dynamic = function() {
            clearAll();
            func.apply(control);
            return o.menus;
        };
    }

    function attach(target)
    {
        jQuery(document.body).find('div.context-menu-shadow').remove();

        o.$element = jQuery(target).contextMenu(typeof(o.dynamic) === "function" ? o.dynamic : o.menus, o.options);
    }
});
