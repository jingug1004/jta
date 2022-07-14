any.control("com-widget").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control).css({ "background-color":"#ffffff" });

        setMargin(5);

        o.$container = $('<div>').addClass("widgetContainer").css({ "width":"100%", "height":"100%" }).appendTo(control);

        o.$control.defineMethod("reset", reset);
        o.$control.defineMethod("reload", reload);
        o.$control.defineMethod("resetSize", resetSize);

        o.$control.defineProperty("widgetInfo", { get:getWidgetInfo, set:setWidgetInfo });
        o.$control.defineProperty("margin", { get:getMargin });

        any.control(control).initialize();

        reset();
    })();

    function reset()
    {
        if (o.widget == null) return;

        o.$control.css({ "display":"table", "width":o.widget.width, "height":o.widget.height });

        o.$container.attr({ "widgetId":o.widget.id, "widgetPath":o.widget.path });

        o.params = null;
        o.size = {};

        resetSize(o.widget.width, o.widget.height, true);

        try {
            o.$control.resizable("destroy");
        } catch(e) {
        }

        if (o.widget.widthFix != true || o.widget.heightFix != true) {
            var opt = { grid:50 };

            if (o.widget.minWidth != null && o.widget.minWidth != "") {
                opt.minWidth = o.widget.minWidth;
            }
            if (o.widget.maxWidth != null && o.widget.maxWidth != "") {
                opt.maxWidth = o.widget.maxWidth;
            }
            if (o.widget.minHeight != null && o.widget.minHeight != "") {
                opt.minHeight = o.widget.minHeight;
            }
            if (o.widget.maxHeight != null && o.widget.maxHeight != "") {
                opt.maxHeight = o.widget.maxHeight;
            }

            o.$control.resizable(opt).on("resize", function(event, ui) {
                if (o.widget.widthFix == true) {
                    o.size.width = o.widget.width;
                } else {
                    o.size.width = ui.size.width;
                }

                if (o.widget.heightFix == true) {
                    o.size.height = o.widget.height;
                } else {
                    o.size.height = ui.size.height;
                }

                resetSize(o.size.width, o.size.height);

                o.$control.fire("onResize", [ui.size]);
            });
        }

        reload();
    }

    function reload(params)
    {
        if (o.widget == null) return;

        if (params != null) {
            o.params = params;
        }

        o.$container.empty().css({ "margin":o.margin });

        $('<table><tr><td style="text-align:center;"></td></tr></table>').addClass("layout").css({ "width":"100%", "height":"100%" }).appendTo(o.$container);

        $('<img>').attr({ "src":any.meta.contextPath + "/common/widget/images/loading.gif" }).appendTo(o.$container.find('td'));

        var prx = any.proxy().url(o.widget.path);

        if (o.params != null) {
            for (var name in o.params) {
                prx.param(name, o.params[name]);
            }
        }

        prx.html(o.$container, function() {
            o.$container.children('div').addHeaderClass("ui-widget-header").css({ "width":"100%", "height":"100%" });
            resetSize(o.size.width, o.size.height, true);
        });

        prx.onSuccess = function()
        {
        };

        prx.onError = function()
        {
            o.$container.children('pre').css({ "overflow":"auto", "width":"100%", "height":"100%" });
        };

        prx.execute();
    }

    function resetSize(width, height, containerOnly)
    {
        o.size.width = any.text.nvl(toNumber(width), o.widget.width);
        o.size.height = any.text.nvl(toNumber(height), o.widget.height);

        o.$container.width(o.size.width - o.margin2);
        o.$container.height(o.size.height - o.margin2);

        if (containerOnly != true) {
            o.$control.width(o.size.width);
            o.$control.height(o.size.height);
        }
    }

    function getWidgetInfo()
    {
        return o.widget;
    }

    function setWidgetInfo(widgetInfo)
    {
        o.widget = {};

        o.widget.id = widgetInfo.WIDGET_ID;
        o.widget.path = widgetInfo.WIDGET_PATH;

        o.widget.width = toNumber(widgetInfo.WIDGET_WIDTH);
        o.widget.widthFix = widgetInfo.WIDTH_FIX_YN;
        o.widget.minWidth = toNumber(widgetInfo.MIN_WIDTH);
        o.widget.maxWidth = toNumber(widgetInfo.MAX_WIDTH);

        o.widget.height = toNumber(widgetInfo.WIDGET_HEIGHT);
        o.widget.heightFix = widgetInfo.HEIGHT_FIX_YN;
        o.widget.minHeight = toNumber(widgetInfo.MIN_HEIGHT);
        o.widget.maxHeight = toNumber(widgetInfo.MAX_HEIGHT);

        if (o.widget.minWidth != null) {
            o.widget.width = Math.max(o.widget.width, o.widget.minWidth);
        }
        if (o.widget.maxWidth != null) {
            o.widget.width = Math.min(o.widget.width, o.widget.maxWidth);
        }

        if (o.widget.minHeight != null) {
            o.widget.height = Math.max(o.widget.height, o.widget.minHeight);
        }
        if (o.widget.maxHeight != null) {
            o.widget.height = Math.min(o.widget.height, o.widget.maxHeight);
        }
    }

    function getMargin()
    {
        return o.margin;
    }

    function setMargin(margin)
    {
        o.margin = toNumber(margin);
        o.margin2 = o.margin * 2;
    }

    function toNumber(val)
    {
        if (val == null || val == "" || isNaN(val)) return null;

        return parseInt(val, 10);
    }
});
