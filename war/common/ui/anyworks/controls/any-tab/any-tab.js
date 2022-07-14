any.control("any-tab").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.$element = jQuery('<div>').appendTo(control);
        o.$ul = jQuery('<ul>').appendTo(o.$element);

        o.options = {};
        o.buttons = [];

        o.$element.tabs(o.options);

        o.insidePanel = any.text(o.$control.attr("insidePanel")).nvl(false).toBoolean(true);

        if (o.$control.hasAttr("iframeArea")) {
            var iframeArea = o.$control.attr("iframeArea");
            if (iframeArea == "") {
                o.$iframeArea = jQuery('<div>').css({ "margin-top": "2px" }).appendTo(control);
            } else {
                o.$iframeArea = jQuery(iframeArea);
            }
        }

        if (o.insidePanel != true) {
            o.$control.find('div.ui-tabs').removeClass("ui-widget ui-widget-content ui-corner-all").css({ "padding": "0px" });
        }

        o.$element.on("tabsactivate", function(event, ui) {
            selectTab(o.$ul.children('li').index(ui.newTab), ui.newPanel[0]);
            o.$control.fire("onChange", [ui]);
        }).on("tabsshow", function(event, ui) {
            selectTab(ui.index, ui.panel);
            o.$control.fire("onChange", [ui]);
        });

        o.$control.defineProperty("buttonSize", { get: getButtonSize });
        o.$control.defineProperty("selectedIndex", { get: getSelectedIndex });

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("getButton", getButton);
        o.$control.defineMethod("getButtonIndex", getButtonIndex);
        o.$control.defineMethod("clearButton", clearButton);
        o.$control.defineMethod("addButton", addButton);
        o.$control.defineMethod("enableButton", enableButton);
        o.$control.defineMethod("goTab", goTab);

        any.control(control).initialize();
    })();

    function element()
    {
        return o.$element;
    }

    function getButtonSize()
    {
        return o.buttons.length;
    }

    function getSelectedIndex()
    {
        return o.index == null ? -1 : o.index;
    }

    function getButton(val)
    {
        if (val != null) {
            return o.buttons[typeof(val) == "number" ? val : getButtonIndex(val)];
        } else if (getSelectedIndex() != -1) {
            return o.buttons[getSelectedIndex()];
        }

        return null;
    }

    function getButtonIndex(val)
    {
        if (val == null) {
            return getSelectedIndex();
        }

        if (typeof(val) == "number") {
            return val;
        }

        for (var i = 0, ii = o.buttons.length; i < ii; i++) {
            if (o.buttons[i].name == val) {
                return i;
            }
        }

        return -1;
    }

    function getFirstEnableButtonIndex()
    {
        for (var i = 0, ii = o.buttons.length; i < ii; i++) {
            if (enableButton(i) == true) {
                return i;
            }
        }

        return -1;
    }

    function clearButton()
    {
        o.buttons = [];

        o.$ul.empty();
    }

    function addButton(btn)
    {
        o.buttons.push(btn);

        if (o.insidePanel == true && o.$iframeArea == null) {
            jQuery('<li>').append(jQuery('<a>').attr("href", btn.url).text(btn.label)).appendTo(o.$ul);
            jQuery(btn.url).appendTo(o.$element);
            o.$element.tabs("refresh").children('div.ui-tabs-panel').removeClass("ui-tabs-panel ui-widget-content ui-corner-bottom");
        } else {
            if (o.$iframeArea == null) {
                jQuery(btn.url).hide();
            }
            jQuery('<li>').append(jQuery('<a>').attr("href", "#tab_dummy_panel_" + o.buttons.length).text(btn.label)).appendTo(o.$ul);
            if (o.$dummyPanelContainer == null || o.$dummyPanelContainer.length == 0) {
                o.$dummyPanelContainer = jQuery('<div>').hide().appendTo(o.$element);
            }
            jQuery('<div>').attr("id", "tab_dummy_panel_" + o.buttons.length).hide().appendTo(o.$element);
            o.$element.tabs("refresh").find('#tab_dummy_panel_' + o.buttons.length).appendTo(o.$dummyPanelContainer);
        }
    }

    function enableButton(val, enable)
    {
        var idx = getButtonIndex(val);

        if (idx == -1) {
            if (arguments.length < 2) {
                return false;
            }
            return;
        }

        if (arguments.length < 2) {
            return o.$ul.children('li').eq(idx).hasClass("ui-state-disabled") != true;
        }

        if (enable != true && idx == o.index) {
            goTab(getFirstEnableButtonIndex());
        }

        o.$element.tabs(enable == true ? "enable" : "disable", idx);
    }

    function goTab(val, prev)
    {
        var idx = (val == null ? getSelectedIndex() : getButtonIndex(val));

        if (idx == -1) {
            idx = getFirstEnableButtonIndex();
        }

        if (idx == -1) {
            return;
        }

        if (prev == true) {
            for (var i = idx; i >= 0; i--) {
                if (enableButton(i) == true) {
                    idx = i;
                    break;
                }
            }
        } else {
            if (enableButton(idx) != true) {
                idx = getFirstEnableButtonIndex();
            }
        }

        if (idx == -1) {
            return;
        }

        if (o.index == idx) {
            if (o.$iframe != null) {
                o.$iframe.attr("src", getButton(idx).url);
            }
        } else {
            o.showIndex = idx;
            o.$element.tabs("option", "active", idx);
        }
    }

    function selectTab(index, panel)
    {
        if (o.buttons[index] == null) {
            return;
        }

        o.index = index;

        var url = o.buttons[index].url;

        if (o.$iframeArea != null && o.showIndex != -1) {
            o.$iframe = jQuery('<iframe>').css({ "width": "100%", "height": "100%" });
            o.$iframe.attr({ "src": any.url(url), "frameborder": "0", "scrolling": "no", "any-pageType": "tabframe", "autoHeight": "" });
            o.$iframeArea.empty().append(o.$iframe);
        }

        if (o.$iframeArea != null && o.$iframe != null) {
            if (o.buttons[index].fullHeight == true) {
                o.buttonFullHeightActivated = true;
                o.$iframe.removeAttr("autoHeight");
                o.$iframeArea.attr("fullHeight", "");
                any.fullHeight();
            } else if (o.buttonFullHeightActivated === true) {
                delete(o.buttonFullHeightActivated);
                jQuery('div[any-container=""]').parent().css("overflow", "auto");
                o.$iframeArea.removeAttr("fullHeight");
                o.$iframeArea.removeCss("height");
                o.$iframe.attr("autoHeight", "");
            }
        }

        if (o.$iframeArea != null) {
            return;
        }

        if (o.insidePanel != true) {
            for (var i = 0, ii = o.buttons.length; i < ii; i++) {
                jQuery(o.buttons[i].url).hide();
            }
            panel = jQuery(url).show()[0];
        }

        jQuery(panel).find('[any-jqgrid=""],[any-jqplot=""]').resize();
    }
});
