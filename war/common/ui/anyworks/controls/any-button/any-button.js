any.control("any-button").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control).css({ "white-space": "nowrap", "height": "24px" });
        o.config = any.control(control).config;

        o.jQueryButtonEnable = (jQuery().button != null);

        try {
            control.type = "button";
        } catch(e) {
        }

        initAutoButtons();

        if (o.jQueryButtonEnable == true) {
            if (o.$control.hasAttr("icon") == true) {
                o.$control.button({ icons: { primary: o.$control.attr("icon") }, text: false }).css({ "vertical-align": "middle" });
            } else {
                o.$control.button({ icons: { primary: o.$control.attr("icon-primary"), secondary: o.$control.attr("icon-secondary") } }).css({ "vertical-align": "middle" });
            }
            resetStyle();
        }

        if (o.$control.attr("enableMenu") == "" || any.object.toBoolean(o.$control.attr("enableMenu"), false)) {
            o.$control.click(function() {
                toggleMenu();
                return false;
            });
        }

        jQuery(document).on("click", function() {
            hideMenu();
        });

        o.$control.defineMethod("clearMenu", clearMenu);
        o.$control.defineMethod("addMenu", addMenu);
        o.$control.defineMethod("toggleMenu", toggleMenu);
        o.$control.defineMethod("showMenu", showMenu);
        o.$control.defineMethod("hideMenu", hideMenu);

        o.$control.defineProperty("size", { get: getSize, set: setSize });
        o.$control.defineProperty("text", { get: getText, set: setText });
        o.$control.defineProperty("menuCount", { get: getMenuCount });
        o.$control.defineProperty("menuExpanded", { get: isMenuExpanded });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        any.control(control).initialize();
    })();

    function initAutoButtons()
    {
        switch (o.$control.attr("auto")) {
        case "unload":
            if (any.text.trim(control.innerText) == "") {
                if (any.pageType(true) == "window" || any.pageType(true) == "dialog") {
                    control.innerText = any.message("any.btn.close", "Close");
                } else {
                    control.innerText = any.message("any.btn.list", "List");
                }
            }
            o.$control.click(function() {
                any.unloadPage(null, o.$control.attr("path"));
            });
            break;
        case "cancel":
            if (any.text.trim(control.innerText) == "") {
                control.innerText = any.message("any.btn.cancel", "Cancel");
            }
            o.$control.click(function() {
                any.unloadPage();
            });
            break;
        case "print":
            if (any.text.trim(control.innerText) == "") {
                control.innerText = any.message("any.btn.print", "Print");
            }
            o.$control.click(function() {
                any.config.printWindow.open();
            });
            break;
        }

        if (o.$control.hasAttr("href") == true) {
            o.$control.click(function() {
                var href = o.$control.attr("href");

                if (any.text.startsWith(href, "redirect:")) {
                    window.location.replace(any.url(href.substr("redirect:".length)));
                } else {
                    window.location.href = any.url(href);
                }
            });
        }
    }

    function clearMenu()
    {
        if (o.$menuUL != null) {
            o.$menuUL.empty().menu("refresh");
        }
    }

    function addMenu(text, func, data, spec, keys)
    {
        if (o.jQueryButtonEnable != true) {
            return;
        }

        if (spec == null) {
            spec = {};
        }

        if (o.$menuUL == null) {
            o.$menuUL = jQuery('<ul>').css({ "position": "absolute" }).hide().menu().appendTo(document.body);
            o.$control.button("option", { icons: { primary: o.$control.attr("icon-primary"), secondary: "ui-icon-triangle-1-s" } });
            resetStyle();
        }

        var $ul;

        if (keys == null || keys.parent == null || keys.parent == "") {
            $ul = o.$menuUL;
        } else {
            var $li = o.$menuUL.find('li[key-id="' + keys.parent + '"]');
            if ($li != null && $li.length == 1) {
                $ul = $li.children('ul');
                if ($ul == null || $ul.length == 0) {
                    $ul = jQuery('<ul>').appendTo($li);
                }
            }
        }

        if ($ul == null) {
            return;
        }

        var $li = jQuery('<li>').css({ "white-space": "nowrap" }).appendTo($ul);

        if (keys != null) {
            $li.attr({ "key-id": keys.id, "key-parent": keys.parent });
        }

        if (spec.disabled === true) {
            $li.addClass("ui-state-disabled");
        }

        var $a = jQuery('<a>').attr("href", "javascript:void(0);").text(text).appendTo($li);

        o.$menuUL.menu("refresh");

        if (func == null || spec.disabled === true) {
            return;
        }

        $a.click(function() {
            func.apply($a.parent()[0], [data]);
        });
    }

    function toggleMenu()
    {
        if (o.$menuUL == null) {
            return;
        }

        if (o.$menuUL.is(':visible')) {
            hideMenu();
        } else {
            showMenu();
        }
    }

    function showMenu()
    {
        if (o.$menuUL == null || getMenuCount() == 0) {
            return;
        }

        o.$menuUL.show().position({ my: "left top", at: "left bottom", of: control });

        any.blocker().start();
    }

    function hideMenu()
    {
        any.blocker().stop();

        if (o.$menuUL == null) {
            return;
        }

        o.$menuUL.hide();
    }

    function getMenuCount()
    {
        return o.$menuUL == null ? 0 : o.$menuUL.children('li').length;
    }

    function isMenuExpanded()
    {
        return o.$menuUL != null && o.$menuUL.is(':visible');
    }

    function getSize()
    {
        return o.size;
    }

    function setSize(val)
    {
        o.size = val;

        if (val == "small") {
            o.$control.css({ "height": "20px", "font-weight": "normal" });
        } else {
            o.$control.css({ "height": "24px", "font-weight": "bold" });
        }
    }

    function getText()
    {
        return o.$control.find('span.ui-button-text').text();
    }

    function setText(val)
    {
        o.$control.find('span.ui-button-text').text(val);
    }

    function getDisabled()
    {
        return o.disabled;
    }

    function setDisabled(val)
    {
        if (o.disabled == val) {
            return;
        }

        o.disabled = (String(val).toLowerCase() == "disabled" || any.object.toBoolean(val, true));

        if (o.jQueryButtonEnable == true) {
            o.$control.button("option", "disabled", o.disabled);
        }

        o.$control.attr("disabled", o.disabled);

        resetStyle();
    }

    function resetStyle()
    {
        o.$control.css({ "margin-right": "0px" });

        o.$control.children('span.ui-button-text').css({ "padding-top": "0px", "padding-bottom": "0px" });

        if (o.size == "small") {
            var paddingLeft = 6;
            var paddingRight = 6;
            var $iconPrimary = o.$control.children('span.ui-button-icon-primary');
            if ($iconPrimary.length > 0) {
                paddingLeft += 16;
            }
            var $iconSecondary = o.$control.children('span.ui-button-icon-secondary');
            if ($iconSecondary.length > 0) {
                paddingRight += 16;
            }
            o.$control.children('span.ui-button-text').css({ "padding-left": paddingLeft, "padding-right": paddingRight });
        }
    }
});
