any.control("com-echart").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.controlIndex = any.control().newIndex();
        o.$element = jQuery('<div>').attr("id", control.id + "_echart_" + o.controlIndex).css({ "width": "100%", "height": "100%", "margin-top": "10px", "margin-bottom": "5px" }).appendTo(o.$control);
        o.config = any.control(control).config;
        o.options = null;

        jQuery(window).resize(function() {
            resizeEchart();
        });

        o.$control.resize(function() {
            resizeEchart();
        });

        control.isReady = false;

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("echart", echart);
        o.$control.defineMethod("getOption", getOption);
        o.$control.defineMethod("disposeEchart", disposeEchart);
        o.$control.defineMethod("loadTheme", loadTheme);
        o.$control.defineMethod("drawEchart", drawEchart);

        any.control(control).initialize();

        any.loadScripts(o.themes, function() {
            window.setTimeout(function() {
                o.$control.fire("onReady");
                control.isReady = true;
            });
        });

    })();

    function element()
    {
        return o.$element;
    }

    function echart()
    {
        return o.echart;
    }

    function initConfig()
    {
        var config = any.object.clone(o.config("echart.config"));

        if (config == null) {
            return;
        }

        for (var item in config) {
            jQuery.echart.config[item] = config[item];
        }
    }

    function loadTheme(name)
    {
        if (o.themes == null) {
            o.themes = [];
        }

        if (name.substr(0, 1) == "/") {
            o.themes.push(name);
        } else {
            o.themes.push(o.config("url.themes") + "/" + name);
        }
    }

    function getOption(name)
    {
        return o.options[name];
    }

    function disposeEchart()
    {
        if (o.echart != null) {
            o.echart.dispose();
        }
    }

    function drawEchart(option, theme)
    {
        disposeEchart();

        if (option != null) {
            o.options = option
        }

        o.echart = echarts.init(document.getElementById(o.$element.attr("id")), theme);

        if (o.options && typeof o.options === "object") {
            o.echart.setOption(o.options, true);
        }
    }

    function resizeEchart()
    {
        if (o.echart != null) {
            o.echart.resize();
        }
    }
});
