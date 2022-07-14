any.control("any-jqplot").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.controlIndex = any.control().newIndex();
        o.$element = jQuery('<div>').attr("id", control.id + "_jqplot_" + o.controlIndex).css({ "width": "100%", "height": "100%" }).appendTo(o.$control);
        o.config = any.control(control).config;
        o.options = any.object.clone(o.config("jqplot.options"));

        if (o.options == null) {
            o.options = {};
        }

        control.isReady = false;

        initConfig();

        jQuery(window).resize(function() {
            resizePlot();
        });

        o.$control.resize(function() {
            resizePlot();
        });

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("jqplot", jqplot);
        o.$control.defineMethod("loadPlugin", loadPlugin);
        o.$control.defineMethod("getOption", getOption);
        o.$control.defineMethod("setOption", setOption);
        o.$control.defineMethod("setAxesDefaults", setAxesDefaults);
        o.$control.defineMethod("setAxes", setAxes);
        o.$control.defineMethod("setSeriesDefaults", setSeriesDefaults);
        o.$control.defineMethod("addSeries", addSeries);
        o.$control.defineMethod("setLegend", setLegend);
        o.$control.defineMethod("destroyPlot", destroyPlot);
        o.$control.defineMethod("drawAuto", drawAuto);
        o.$control.defineMethod("drawPlot", drawPlot);
        o.$control.defineMethod("getTickLabel", getTickLabel);
        o.$control.defineMethod("getSeriesName", getSeriesName);

        any.control(control).initialize();

        any.loadScripts(o.plugins, function() {
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

    function jqplot()
    {
        return o.$jqplot;
    }

    function initConfig()
    {
        var config = any.object.clone(o.config("jqplot.config"));

        if (config == null) {
            return;
        }

        for (var item in config) {
            jQuery.jqplot.config[item] = config[item];
        }
    }

    function loadPlugin(name)
    {
        if (o.plugins == null) {
            o.plugins = [];
        }

        if (name.substr(0, 1) == "/") {
            o.plugins.push(name);
        } else {
            o.plugins.push(o.config("url.plugins") + "/" + name);
        }
    }

    function getOption(name)
    {
        return o.options[name];
    }

    function setOption()
    {
        any.copyArguments(o.options, arguments);
    }

    function setAxesDefaults(name, value)
    {
        if (o.options.axesDefaults == null) {
            o.options.axesDefaults = {};
        }

        o.options.axesDefaults[name] = value;
    }

    function setAxes(axes, name, value)
    {
        if (o.options.axes == null) {
            o.options.axes = {};
        }

        if (o.options.axes[axes] == null) {
            o.options.axes[axes] = {};
        }

        o.options.axes[axes][name] = value;
    }

    function setSeriesDefaults(name, value)
    {
        if (o.options.seriesDefaults == null) {
            o.options.seriesDefaults = {};
        }

        o.options.seriesDefaults[name] = value;
    }

    function addSeries(series)
    {
        if (o.options.series == null) {
            o.options.series = [];
        }

        o.options.series.push(series);
    }

    function setLegend(legend)
    {
        o.options.legend = legend;
    }

    function destroyPlot()
    {
        if (o.$jqplot != null) {
            o.$jqplot.destroy();
        }
    }

    function drawAuto(ds, dsSpec, isArrayValue)
    {
        o.tickLabels = [];
        o.seriesNames = [];

        var seriesValues = {};

        for (var i = 0, ii = ds.rowCount(); i < ii; i++) {
            var tickLabel = ds.value(i, dsSpec.tick);
            if (jQuery.inArray(tickLabel, o.tickLabels) == -1) {
                o.tickLabels.push(tickLabel);
            }
            var seriesName = (dsSpec.series == null ? "SERIES" : ds.value(i, dsSpec.series));
            if (jQuery.inArray(seriesName, o.seriesNames) == -1) {
                o.seriesNames.push(seriesName);
            }
            if (seriesValues[seriesName] == null) {
                seriesValues[seriesName] = {};
            }
            seriesValues[seriesName][tickLabel] = Number(ds.value(i, dsSpec.value));
        }

        if (isArrayValue != true) {
            if (o.options.seriesDefaults != null && o.options.seriesDefaults.rendererOptions != null && o.options.seriesDefaults.rendererOptions.barDirection == "horizontal") {
                setAxes("yaxis", "ticks", o.tickLabels);
            } else {
                setAxes("xaxis", "ticks", o.tickLabels);
            }
        }

        o.options.series = null;

        for (var i = 0, ii = o.seriesNames.length; i < ii; i++) {
            addSeries({ label: o.seriesNames[i] });
        }

        var dataList = [];

        for (var i = 0, ii = o.seriesNames.length; i < ii; i++) {
            var values = seriesValues[o.seriesNames[i]];
            var data = [];

            if (values == null) {
                data.push([]);
            } else {
                for (var j = 0, jj = o.tickLabels.length; j < jj; j++) {
                    var name = o.tickLabels[j];
                    var value = values[name];
                    if (value == null) {
                        value = 0;
                    }
                    if (isArrayValue == true) {
                        data.push([name, value]);
                    } else {
                        data.push(value);
                    }
                }
            }

            dataList.push(data);
        }

        drawPlot(dataList);

        if (o.jqplotDataClickEventAttached == true) {
            return;
        }

        o.jqplotDataClickEventAttached = true;

        o.$element.on("jqplotDataClick", function (event, seriesIndex, pointIndex, data) {
            var obj = { seriesIndex: seriesIndex, pointIndex: pointIndex, data: data };
            obj.seriesName = getSeriesName(seriesIndex);
            obj.tickLabel = getTickLabel(pointIndex);
            o.$control.fire("onDataClick", [obj]);
        });
    }

    function drawPlot(data)
    {
        destroyPlot();

        if (data != null) {
            o.data = data;
        }

        if (o.data != null && o.data.length > 0 && jQuery('#' + o.$element.attr("id")).length > 0) {
            o.$jqplot = jQuery.jqplot(o.$element.attr("id"), o.data, o.options);
        }
    }

    function getTickLabel(index)
    {
        if (o.tickLabels != null && o.tickLabels.length > index) {
            return o.tickLabels[index];
        }
    }

    function getSeriesName(index)
    {
        if (o.seriesNames != null && o.seriesNames.length > index) {
            return o.seriesNames[index];
        }
    }

    function resizePlot()
    {
        if (o.size != null && o.size.width == o.$element.width() && o.size.height == o.$element.height()) {
            return;
        }

        o.size = { width: o.$element.width(), height: o.$element.height() };

        drawPlot();
    }
});
