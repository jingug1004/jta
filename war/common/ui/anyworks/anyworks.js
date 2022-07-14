(function(window) {

var any = { window: window, meta: { contextPath: "" }, config: {} };

(function() {
    jQuery.window = window;
    if (jQuery.browser == null) {
        jQuery.browser = {};
    }
    jQuery('html').hide();
})();

(function() {
    if (!/*@cc_on!@*/0) {
        return;
    }
    var e = "abbr,article,aside,audio,bb,canvas,datagrid,datalist,details,dialog,eventsource,figure,footer,hgroup,header,mark,menu,meter,nav,output,progress,section,time,video".split(",");
    for (var i = 0, ii = e.length; i < ii; i++) {
        document.createElement(e[i]);
    }
})();

(function() {
    any.config.booleanValues = "1,0";
    any.config.unicodeCharSize = 3;
    any.config.loadingImage = {};
    any.config.blockActivated = false;
    any.config.jQueryDialog = false;
})();

(function() {
    try {
        HTMLElement.prototype.__defineGetter__("innerText", function() {
            return this.textContent;
        });
        HTMLElement.prototype.__defineSetter__("innerText", function(txt) {
            if (this.tagName == "PRE") {
                this.innerHTML = (txt == null ? "" : String(txt).replace(new RegExp("\r\n", "g"), "\n").split("").join("<wbr/>"));
            } else {
                this.textContent = txt;
            }
        });
    } catch(e) {
    }
    if (typeof(console) === "undefined") {
        console = { log: new Function(), err: new Function() };
    }
})();

jQuery.fn.prop_origin = jQuery.fn.prop;
jQuery.fn.val_origin = jQuery.fn.val;
jQuery.fn.on_origin = jQuery.fn.on;

jQuery.fn.extend({
    tag: function()
    {
        return this[0] && this[0].tagName != null ? this[0].tagName.toUpperCase() : null;
    },

    control: function()
    {
        var name = null;

        for (var i = 0, ii = arguments.length; i < ii; i++) {
            var arg = arguments[i];
            if (arg == null) {
                continue;
            }
            if (typeof(arg) === "function") {
                this.on("any-initialize", arg);
            } else if (typeof(arg) === "string" && any.control != null && any.control.controls != null && any.control.controls[arg.toLowerCase()] != null) {
                this.attr(arg, "");
                name = arg;
            }
        }

        this.each(function() {
            var $this = jQuery(this);
            if ($this.hasAttr("any-control-plugins") == true) {
                var controlName = $this.attrControlName();
                if (controlName != null) {
                    var pluginNames = $this.attr("any-control-plugins").split(",");
                    $this.data("any-control-plugin-names", pluginNames);
                    for (var i = 0, ii = pluginNames.length; i < ii; i++) {
                        var pluginName = any.text.trim(pluginNames[i]);
                        var pluginResources = any.control.controls[controlName].pluginResources[pluginName.toLowerCase()];
                        for (var i = 0, ii = pluginResources.length; i < ii; i++) {
                            if (pluginResources[i].resourceAdded === true) {
                                continue;
                            }
                            any.control(controlName).resource(pluginResources[i].src, pluginResources[i].async);
                            pluginResources[i].resourceAdded = true;
                        }
                    }
                }
            }
            if ($this.data("any-control-name") == null) {
                any.control(this).activate(name);
            }
        });

        if (this.length > 0) {
            any.control().initialize(this);
        }

        return this;
    },

    controls: function(callback)
    {
        if (this.length > 0) {
            if (any.control().initialize(this).length == 0) {
                if (callback != null) {
                    callback.apply(this);
                }
            } else if (callback != null && this.data("any-checkContextControlReady") != true) {
                this.data("any-checkContextControlReady", true);
                checkContextControlReady(this, function() {
                    this.removeData("any-checkContextControlReady");
                    callback.apply(this);
                });
            }
        }

        return this;

        function checkContextControlReady(context, callback)
        {
            if (any.control().checkActivated(context) != true) {
                window.setTimeout(function() { checkContextControlReady(context, callback); }, 50);
                return;
            }

            if (any.control().checkReady(context) != true) {
                window.setTimeout(function() { checkContextControlReady(context, callback); }, 50);
                return;
            }

            if (callback != null) {
                callback.apply(context);
            }
        }
    },

    attrControlName: function()
    {
        for (var item in any.control.controls) {
            if (this.hasAttr(item) == true) {
                return item.toLowerCase();
            }
        }
    },

    controlName: function(inheritLevel)
    {
        var controlName = this.data("any-control-name");

        if (inheritLevel === true || typeof(inheritLevel) === "number") {
            var loopCount = 0;
            while (any.control.controls[controlName] != null && any.control.controls[controlName].inherit != null) {
                if (inheritLevel !== true && loopCount >= inheritLevel) {
                    break;
                }
                controlName = any.control.controls[controlName].inherit.name;
                loopCount++;
            }
        }

        return controlName;
    },

    element: function()
    {
        if (this[0] && "element" in this[0]) {
            return this[0].element();
        }
    },

    hasAttr: function(name)
    {
        return typeof(this.attr(name)) !== "undefined" || (this[0] && typeof(this[0][name]) !== "undefined");
    },

    copyAttr: function(name, targetObject, targetName)
    {
        if (this.hasAttr(name) == true) {
            targetObject.attr(targetName == null ? name : targetName, this.attr(name));
        }

        return this;
    },

    defineMethod: function(name, func)
    {
        if (name == null || func == null) {
            return;
        }

        for (var i = 0, ii = this.length; i < ii; i++) {
            this[i][name] = func;
        }

        return this;
    },

    defineProperty: function(name, func)
    {
        if (name == null || func == null) {
            return;
        }

        for (var i = 0, ii = this.length; i < ii; i++) {
            var attr = this.eq(i).data("any-attr-" + name);

            if (attr == null) {
                this.eq(i).data("any-attr-" + name, attr = this.eq(i).attr(name));
            }

            if (attr == null) {
                attr = this[i][name];
            }

            try {
                Object.defineProperty(this[i], name, func);
            } catch(e) {
                if (func.get != null) {
                    try {
                        this[i].prototype.__defineGetter__(name, func.get);
                    } catch(e) {
                    }
                }
                if (func.set != null) {
                    try {
                        this[i].prototype.__defineSetter__(name, func.set);
                    } catch(e) {
                    }
                }
            }

            if (this.eq(i).data("any-properties") == null) {
                this.eq(i).data("any-properties", {});
            }

            this.eq(i).data("any-properties")[name] = func;

            if (attr != null) {
                this.eq(i).prop(name, attr);
            }
        }

        return this;
    },

    hasProp: function(name)
    {
        if (this[0] == null) {
            return;
        }
        if (name == null) {
            return;
        }

        var props = this.data("any-properties");

        if (props == null || props[name] == null) {
            return Object.prototype.hasOwnProperty.call(this[0], name);
        }

        return props[name] != null;
    },

    prop: function(name, value)
    {
        if (this.length == 0) {
            return this;
        }

        if (this[0] == null) {
            return;
        }
        if (name == null) {
            return;
        }

        var props = this.data("any-properties");

        if (props == null || props[name] == null) {
            return this.prop_origin.apply(this, arguments);
        }

        if (arguments.length == 1) {
            return props[name].get.apply(this[0]);
        }

        for (var i = 0, ii = this.length; i < ii; i++) {
            if (this.eq(i).data("any-properties")[name].set != null) {
                this.eq(i).data("any-properties")[name].set.apply(this[i], [value]);
            }
        }

        return this;
    },

    exec: function(name)
    {
        if (this.length == 0) {
            return this;
        }

        var args = Array.prototype.slice.call(arguments, 1);
        var result = null;

        this.each(function() {
            if (name in this) {
                result = this[name].apply(this, args || []);
            } else {
                throw new Error((this.tagName == null ? "" : this.tagName) + (this.id == null ? "" : "#" + this.id) + " - No such method : " + name);
            }
        });

        if (typeof(result) === "undefined") {
            return this;
        }

        return result;
    },

    val: function(value)
    {
        if (this[0]) {
            var props = this.data("any-properties");

            if (props != null) {
                if (props["jsonString"] != null && typeof(value) === "string") {
                    if (arguments.length == 0) {
                        return this.prop("jsonString");
                    }
                    return this.prop("jsonString", value);
                }

                if (props["jsonObject"] != null && typeof(value) === "object") {
                    if (arguments.length == 0) {
                        return this.prop("jsonObject");
                    }
                    return this.prop("jsonObject", value);
                }

                if (props["value"] != null) {
                    if (arguments.length == 0) {
                        return this.prop("value");
                    }
                    return this.prop("value", value);
                }
            }
        }

        return this.val_origin.apply(this, arguments);
    },

    enter: function(func)
    {
        this.keydown(function(event) {
            if (event.keyCode != 13) {
                return;
            }
            any.event(event).preventDefault();
            func.apply(this, arguments);
        });

        return this;
    },

    on: function()
    {
        if (arguments.length > 1 && arguments[0] === "any-initialize" && this.data("any-initialize.fired") === true) {
            arguments[1].apply(this[0]);
            return this;
        }

        return this.on_origin.apply(this, arguments);
    },

    fire: function(eventType, extraParameters)
    {
        this.triggerHandler(eventType, extraParameters);

        this.each(function() {
            if (eventType in this && this[eventType] != null) {
                if (extraParameters != null) {
                    extraParameters.splice(0, 0, {});
                }
                if (typeof(this[eventType]) != "function") {
                    new Function(this[eventType]).apply(this, extraParameters || [{}]);
                } else {
                    this[eventType].apply(this, extraParameters || [{}]);
                }
            }
        });

        return this;
    },

    showHide: function(bool)
    {
        if (bool == true) {
            this.show();
        } else {
            this.hide();
        }

        return this;
    },

    isDisabled: function()
    {
        if (this[0] == null) {
            return;
        }

        if (this[0].disabled == true) {
            return true;
        }
        if (String(this.attr("disabled")).toLowerCase() == "disabled") {
            return true;
        }
        if (this.prop("disabled") == true) {
            return true;
        }

        try {
            if (this.parent().length == 0 || this.parent().tag() == null) {
                return false;
            }
            return this.parent().isDisabled();
        } catch(e) {
            return false;
        }
    },

    isVisible: function()
    {
        if (this[0] == null) {
            return;
        }

        if (this[0].style.display == "none") {
            return false;
        }
        if (this[0].style.visibility == "hidden") {
            return false;
        }

        try {
            if (this.parent().length == 0 || this.parent().tag() == null) {
                return true;
            }
            return this.parent().isVisible();
        } catch(e) {
            return true;
        }
    },

    removeCss: function(cssNames)
    {
        this.each(function() {
            var $this = jQuery(this);
            jQuery.grep(cssNames.split(","), function(cssName) {
                $this.css(cssName, "");
            });
        });

        return this;
    }
});

jQuery(function() {
    try {
        if (navigator.userAgent.indexOf("Trident/") != -1) {
            document.body.focus();
        }
    } catch(e) {
    }

    var $container = jQuery('div[any-container=""]');

    if ($container.length == 1) {
        jQuery('html, body').height("100%");

        $container.parent('div').css({ "width": "100%", "height": "100%", "overflow": "auto" }).parent().css({ "overflow": "hidden" });

        if (typeof(any.containerWidth.calculator) === "function" && (any.pageType() == null || any.pageType() == "viewer")) {
            $container.width(any.containerWidth.calculator());
        }
    }

    any.loading(true).show();
    any.autoHeight();
    any.fullHeight2();
    any.window().resize();
    any.message().initialize();
    any.control().initialize();
    any.ready().check();

    jQuery(window).on("resize", function() {
        any.fullHeight();
    });

    jQuery(window).on("unload", function() {
        jQuery('*').unbind();
    });

    if (any.pageType() == "window") {
        window["any-unloadPage"] = function(returnValue)
        {
            if (returnValue != null) {
                window["any-returnValue"] = returnValue;
                if (window.opener.any.window.openWindows != null) {
                    var func = window.opener.any.window.openWindows[window.name].functions.ok;
                    if (func != null) {
                        if (func(returnValue) === false) {
                            return;
                        }
                    }
                }
            }

            window.close();
        };

        if (window.opener != null && window.opener.any != null && window.opener.any.window != null && window.opener.any.window.openWindows != null) {
            jQuery(window).unload(function() {
                window.opener.any.window.openWindows[window.name].$f.fire("onUnload", [window["any-returnValue"]]);
            });
        }
    }

    if (any.pageType() == "dialog") {
        try {
            jQuery(window.frameElement).parent('div.ui-dialog-content').width("auto");
        } catch(e) {
        }

        try {
            if (parent.jQuery != null && parent.jQuery(jQuery(window.frameElement).parent()).dialog("option", "closeOnEscape") === true) {
                jQuery(document).on("keydown", function(event) {
                    if (event.keyCode == 27) {
                        any.unloadPage();
                    }
                });
            }
        } catch(e) {
        }
    }

    if (window.attachEvent && !window.addEventListener) {
        window.attachEvent("onunload", function() {
            for (var id in jQuery.cache) {
                if (jQuery.cache[id].handle) {
                    try {
                        jQuery.event.remove(jQuery.cache[id].handle.elem);
                    } catch(e) {
                    }
                }
            }
        });
    }

    (function checkContainerHeightResize() {
        window.setTimeout(function() {
            try { checkContainerHeightResize(); } catch(e) {}
        }, 200);
        var $container = jQuery('div[any-container=""]');
        if ($container.length == 0) {
            return;
        }
        var oldHeight = $container.data("current-height");
        var newHeight = $container.outerHeight(true);
        if (oldHeight == newHeight) {
            return;
        }
        $container.data("current-height", newHeight);
        $container.fire("onResizeHeight", [oldHeight, newHeight]);
    })();
});

any.topWindow = function(win)
{
    if (win == null) {
        win = window;
    }

    try {
        return win.parent == win ? win : any.topWindow(win.parent);
    } catch(e) {
        return win;
    }
};

any.rootWindow = function(win)
{
    if (win == null) {
        win = window;
    }

    try {
        return parent == win || parent.any == null ? win : parent.any.rootWindow();
    } catch(e) {
        return win;
    }
};

any.containerWidth = function(val)
{
    if (typeof(val) === "function") {
        any.containerWidth.calculator = val;
        return;
    }

    if (typeof(any.containerWidth.calculator) !== "function") {
        return;
    }

    jQuery('div[any-container=""]').width(any.containerWidth.calculator());

    jQuery('iframe', val == null ? any.topWindow().document : val).each(function() {
        if (this.contentWindow.any != null && (this.contentWindow.any.pageType() == null || this.contentWindow.any.pageType() == "viewer")) {
            this.contentWindow.any.containerWidth(this.contentWindow.document);
        }
    });
};

any.autoHeight = function()
{
    try {
        if (window.frameElement == null) {
            return;
        }
    } catch(e) {
        return;
    }

    if (jQuery('[fullHeight=""],[fullHeight$="px"]').length > 0) {
        return;
    }

    var $frame = jQuery(window.frameElement);

    if ($frame.hasAttr("autoHeight") != true) {
        return;
    }

    var $container = jQuery('div[any-container=""]');

    if ($container.length == 0) {
        return;
    }

    $container.css("margin", "0px").parent().css("overflow", "hidden");

    $container.on("onResizeHeight", function() {
        resetHeight();
    });

    resetHeight();

    function resetHeight()
    {
        var height = $container.outerHeight(true);

        if ($container[0].offsetTop != null) {
            height += $container[0].offsetTop;
        }

        if (jQuery.browser.msie) {
            height += 1;
        }

        if ($frame.height() != height) {
            $frame.height(height);
        }
    }
};

any.fullHeight2 = function(obj)
{
    if (obj == null) {
        jQuery('[fullHeight2=""]').attr("fullHeight", "").each(function() {
            any.fullHeight2(this);
        });
    } else if (obj != document.body && obj != jQuery('div[any-container=""]')[0]) {
        any.fullHeight2(jQuery(obj).attr("fullHeight", "").parent()[0]);
    }
};

any.fullHeight = function()
{
    var $target = jQuery('[fullHeight=""],[fullHeight$="px"]').filter(':visible');

    if ($target.length == 0) {
        return;
    }

    jQuery('html, body').height("100%");

    var $container = jQuery('div[any-container=""]');
    var $body = jQuery('body');

    if ($container.data("any-size") == $container.width() + "-" + $container.height() && $body.data("any-size") == $body.width() + "-" + $body.height()) {
        return;
    }

    $container.data("any-size", $container.width() + "-" + $container.height());
    $body.data("any-size", $body.width() + "-" + $body.height());

    $target.each(function() {
        var $this = jQuery(this);

        if ($this.data("any-fullHeightResized") == true) {
            return true;
        }

        var $parent = $this.parent();
        var $containerParent;
        var correction;

        if ($parent.hasAttr("any-container") == true) {
            $containerParent = $parent.parent();
        } else {
            $containerParent = $parent;
        }

        if ($parent[0] == document.body) {
            correction = -3;
        } else {
            correction = 0;
        }

        var objects = [];
        var otherHeight = 0;

        $parent.children().each(function() {
            var $this = jQuery(this);
            if ($this.tag() == "SCRIPT") {
                return;
            }
            if ($this.css("position") == "absolute") {
                return;
            }
            if ($this.css("position") == "fixed") {
                return;
            }
            if ($this.css("display") == "none") {
                return;
            }
            if ($this.css("float") != "none") {
                return;
            }
            if ($this.hasAttr("fullHeight") == true) {
                var marginTop = parseInt($this.css("margin-top"), 10);
                var marginBottom = parseInt($this.css("margin-bottom"), 10);
                if (!isNaN(marginTop)) {
                    otherHeight += marginTop;
                }
                if (!isNaN(marginBottom)) {
                    otherHeight += marginBottom;
                }
                objects.push(this);
            } else {
                otherHeight += $this.outerHeight(true);
                $this.find('textarea').mouseup(function() {
                    any.fullHeight();
                });
            }
        });

        if (objects.length == 0) {
            return true;
        }

        $containerParent.css("overflow-y", "hidden");

        var containerParentHeight;

        if ($containerParent.tag() == "TD") {
            containerParentHeight = $containerParent.closest('table').data("real-height");

            if (containerParentHeight != null) {
                $containerParent.closest('tbody').children('tr').not($containerParent.parent()).each(function() {
                    containerParentHeight -= jQuery(this).outerHeight(true);
                });
            }
        }

        if (containerParentHeight == null) {
            containerParentHeight = $containerParent.height();
            var paddingTop = parseInt($container.css("padding-top"), 10);
            var paddingBottom = parseInt($container.css("padding-bottom"), 10);
            if (!isNaN(paddingTop)) {
                containerParentHeight -= paddingTop;
            }
            if (!isNaN(paddingBottom)) {
                containerParentHeight -= paddingBottom;
            }
        }

        var totHeight = containerParentHeight - otherHeight - ($parent.outerHeight(true) - $parent.innerHeight()) + correction;
        var objHeight = Math.floor(totHeight / objects.length);

        for (var i = 0, ii = objects.length; i < ii; i++) {
            var minHeight = parseInt($this.attr("fullHeight"), 10);
            if (isNaN(minHeight) == true) {
                minHeight = 0;
            }
            var height = objHeight + (i < ii - 1 ? 0 : totHeight - objHeight * objects.length);
            if (height < minHeight) {
                $containerParent.css("overflow-y", "auto");
                height = minHeight;
            } else {
                $containerParent.css("overflow", "hidden");
            }
            var $object = jQuery(objects[i]);
            $object.data("any-fullHeightResized", true).outerHeight(height == 0 ? "" : height).resize().fire("onFullHeight", [height]);
            if ($object.tag() == "TABLE") {
                $object.data("real-height", height == 0 ? "" : height);
            }
        }
    }).removeData("any-fullHeightResized");
};

any.preventDocumentDrop = function()
{
    if (any.preventDocumentDrop.attached == true) {
        return;
    }

    any.preventDocumentDrop.attached = true;

    jQuery(document).on("dragover drop", function(event) {
        any.event(event).stopPropagation().preventDefault();
        return false;
    });
};

any.pagingParameterName = function(key)
{
    if (any.pagingParameterName.parameterNames == null) {
        any.pagingParameterName.parameterNames = { type: null, recordCountPerPage: null, currentPageNo: null, sortingNames: null };

        var parameterKey = any.text.empty(any.config["/anyworks/paging/parameter-key"], null);

        if (parameterKey == null) {
            any.pagingParameterName.parameterNames.type = "_PAGING_TYPE_";
            any.pagingParameterName.parameterNames.recordCountPerPage = "_PAGING_SIZE_";
            any.pagingParameterName.parameterNames.currentPageNo = "_PAGING_NO_";
            any.pagingParameterName.parameterNames.sortingNames = "_PAGING_SORT_";
        } else {
            for (var name in any.pagingParameterName.parameterNames) {
                any.pagingParameterName.parameterNames[name] = parameterKey + "." + name;
            }
        }
    }

    return any.pagingParameterName.parameterNames[key];
};

any.reloadList = function()
{
    if (any.pageType() == "window" && window.opener != null) {
        var openerAny;
        try {
            openerAny = window.opener.any;
        } catch(e) {
            openerAny = null;
        }
        if (openerAny != null && openerAny.window != null) {
            var win = openerAny.window.openWindows;
            if (win != null && win[window.name] != null && win[window.name].f != null) {
                window.opener.jQuery(win[window.name].f).fire("onReload");
            }
        }
    }

    if (any.opener() != null && any.opener() != window && any.opener().any != null && any.opener().any.reloadList != null) {
        try {
            any.opener().any.reloadList();
        } catch(e) {
        }
    }

    try {
        if (window.frameElement == null || parent == null || parent.jQuery == null) {
            return;
        }
    } catch(e) {
        return;
    }

    var $frame = parent.jQuery(window.frameElement).fire("onReload");

    if ($frame.prop("any-viewer-$div") != null) {
        $frame.prop("any-viewer-$div").data("reloadList", true);
    } else {
        $frame.parent().data("reloadList", true)
    }

    if (parent.any != null && parent.any.reloadList != null) {
        parent.any.reloadList();
    }
};

any.pageType = function()
{
    var hierachy = false;

    if (arguments.length > 0) {
        if (typeof(arguments[0]) == "boolean") {
            hierachy = arguments[0];
        } else {
            any.pageType.value = arguments[0];
            return;
        }
    }

    if (any.pageType.value != null) {
        return any.pageType.value;
    }

    try {
        if (window == parent && window.name != null && window.name.indexOf("any_window_") == 0) {
            return "window";
        }
    } catch(e) {
    }

    try {
        if (window.frameElement == null) {
            return window.opener != null && window.opener.any.meta.contextPath == any.meta.contextPath ? "window" : "main";
        }
    } catch(e) {
        return "main";
    }

    var pageType = jQuery(window.frameElement).attr("any-pageType");

    if (hierachy != true || window == parent || pageType == "window" || pageType == "dialog") {
        return pageType;
    }

    try {
        return parent.any.pageType(true);
    } catch(e) {
        return pageType;
    }
};

any.reloadPage = function()
{
    window.location.replace(window.location.pathname + window.location.search);
};

any.unloadPage = function(returnValue, replacePath)
{
    if (typeof(any.unloadPage.before) === "function" && any.unloadPage.before() != true) {
        return;
    }

    if (window.frameElement != null && window.frameElement["any-unloadPage"] != null) {
        window.setTimeout(function() { window.frameElement["any-unloadPage"](returnValue); }, 0);
    } else if (parent != null && parent.frameElement != null && parent.frameElement["any-unloadPage"] != null) {
        parent.any.unloadPage.apply(parent.any.unloadPage, arguments);
    } else if (any.pageType(true) == "window") {
        window.setTimeout(function() { any.topWindow()["any-unloadPage"](returnValue); }, 0);
    } else if (replacePath != null) {
        window.location.replace(any.url.amp(any.url(replacePath)));
    } else if (parent != null && parent.any != null && parent.any != any && typeof(parent.any.unloadPage) == "function") {
        parent.any.unloadPage.apply(parent.any.unloadPage, arguments);
    }

    try {
        if (parent.frameElement != null) {
            parent.document.body.focus();
        }
    } catch(e) {
    }
};

any.dialogTitle = function(title)
{
    try {
        if (window.frameElement == null) {
            return;
        }
    } catch(e) {
        return;
    }

    if (any.pageType() == "dialog") {
        jQuery('span.ui-dialog-title', jQuery(window.frameElement).parent().parent()).text(any.text.empty(title, any.rootWindow().document.title));
    }
};

any.loadStyle = function(url, id)
{
    jQuery(function() {
        var $link = null;

        if (id != null) {
            $link = jQuery('link#' + id);
        }

        if ($link != null && $link.length > 0 && jQuery.browser.msie && Number(jQuery.browser.version) < 9) {
            $link.remove();
            $link = null;
        }

        if ($link == null || $link.length == 0) {
            $link = jQuery('<link>').attr({ rel: "StyleSheet", type: "text/css", charset: "utf-8" }).appendTo('head');
            if (id != null) {
                $link.attr("id", id);
            }
        }

        if ($link != null && $link.length > 0) {
            $link[0].href = any.meta.contextPath + url;
        }
    });
};

any.loadScript = function(src, callback)
{
    if (src == null || src == "") {
        if (callback != null) {
            callback.apply();
        }
        return;
    }

    var $script = jQuery('script[src="' + any.meta.contextPath + src + '"]');

    if ($script.length > 0 && $script.data("readyState") == "loaded") {
        if (callback != null) {
            callback.apply();
        }
        return;
    }

    var script = document.createElement("script");

    if (any.text.endsWith(src, ".vbs", true) == true || src.toLowerCase().indexOf(".vbs?") != -1) {
        script.setAttribute("type", "text/vbscript");
    } else {
        script.setAttribute("type", "text/javascript");
    }

    script.setAttribute("src", any.meta.contextPath + src);

    if (callback != null) {
        if (jQuery.browser.msie && Number(jQuery.browser.version) < 9) {
            script.onreadystatechange = function() {
                if (this.readyState == "loaded" || this.readyState == "complete") {
                    jQuery(this).data("readyState", "loaded");
                    callback.apply();
                }
            };
        } else {
            script.onload = function() {
                jQuery(this).data("readyState", "loaded");
                callback.apply();
            };
        }
    }

    jQuery('head')[0].appendChild(script);
};

any.loadScripts = function(srcs, callback, sequential)
{
    if (srcs == null || srcs.length == 0) {
        if (callback != null) {
            callback.apply();
        }
        return;
    }

    var scripts = [];

    for (var i = 0, ii = srcs.length; i < ii; i++) {
        scripts.push({ src: srcs[i] });
    }

    if (sequential === true) {
        loadScripts1();
    } else {
        loadScripts2();
    }

    function loadScripts1(index)
    {
        if (index == null) {
            index = 0;
        }

        if (scripts.length <= index) {
            if (callback != null) {
                callback.apply();
            }
            return;
        }

        any.loadScript(scripts[index].src, function() {
            loadScripts1(index + 1);
        });
    }

    function loadScripts2()
    {
        if (function() {
            for (var i = 0, ii = scripts.length; i < ii; i++) {
                if (scripts[i].state != "loaded") {
                    return false;
                }
            }
            return true;
        }() == true) {
            if (callback != null) {
                callback.apply();
            }
            return;
        }

        for (var i = 0, ii = scripts.length; i < ii; i++) {
            (function(scr) {
                if (scr.state != null) {
                    return;
                }
                scr.state = "loading";
                any.loadScript(scr.src, function() {
                    scr.state = "loaded";
                    loadScripts2();
                });
            })(scripts[i]);
        }
    }
};

any.copyArguments = function(obj, args)
{
    if (obj == null || args == null) {
        return;
    }

    if (args.length == 1 && typeof(args[0]) === "object") {
        for (var item in args[0]) {
            obj[item] = args[0][item];
        }
    } else if (args.length == 2) {
        obj[args[0]] = args[1];
    }
};

any.scrollbarWidth = function()
{
    if (any.scrollbarWidth.value != null && any.scrollbarWidth.value != 0) {
        return any.scrollbarWidth.value;
    }

    if (jQuery.browser.msie) {
        var $div = jQuery('<div>').css({ height: "100px" }).appendTo(jQuery('<div>').css({ width: "50px", height: "50px", overflow: "hidden", position: "absolute", top: "-200px", left: "-200px" }).appendTo('body'));
        var width = $div.innerWidth();
        $div.parent().css("overflow-y", "scroll");
        any.scrollbarWidth.value = width - $div.innerWidth();
        $div.parent().remove();
    } else {
        var $div = jQuery('<div>').css({ width: "100px", height: "100px", overflow: "auto", position: "absolute", top: "-1000px", left: "-1000px" }).prependTo('body').append('<div>').find('div').css({ width: "100%", height: "200px" });
        any.scrollbarWidth.value = 100 - $div.width();
        $div.parent().remove();
    }

    return any.scrollbarWidth.value;
};

any.elementWidthGap = function(container, elementSelector)
{
    var $container = (container.jquery == jQuery.fn.jquery ? container : jQuery(container));

    if (any.elementWidthGap.values == null) {
        any.elementWidthGap.values = {};
    }

    var $element = $container.find(elementSelector);
    var style = $container.attr("style") + "::" + $element.attr("style");
    var gap = any.elementWidthGap.values[style];

    if (gap == null) {
        if ($container.is(':visible')) {
            gap = $element.outerWidth(true) - $element.width();
        } else {
            var $cloneContainer = $container.clone().css("visibility", "hidden").appendTo('body');
            var $cloneElement = $cloneContainer.find(elementSelector);
            gap = $cloneElement.outerWidth(true) - $cloneElement.width();
            $cloneContainer.remove();
        }

        any.elementWidthGap.values[style] = gap;
    }

    return gap;
};

any.blocker = function($div)
{
    var f = {};

    if (any.config.blockActivated != true) {
        f.start = f.stop = f.block = f.unblock = new Function();
        return f;
    }

    f.start = function()
    {
        any.blocker.startCount = any.object.nvl(any.blocker.startCount, 0) + 1;

        jQuery('object,[blocker-target="true"]').each(function() {
            var $this = jQuery(this);
            if (this.defaultVisibility != null) {
                return true;
            }
            this.defaultVisibility = $this.css("visibility");
            $this.css("visibility", "hidden");
        });

        jQuery('iframe').each(function() {
            try {
                if (this.contentWindow.any == null) {
                    return;
                }
            } catch(e) {
                return;
            }
            this.contentWindow.any.blocker().start();
        });
    };

    f.stop = function()
    {
        any.blocker.startCount = Math.max(any.object.nvl(any.blocker.startCount, 0) - 1, 0);

        if (any.blocker.startCount > 0) {
            return;
        }

        jQuery('object,[blocker-target="true"]').each(function() {
            var $this = jQuery(this);
            $this.css("visibility", this.defaultVisibility);
            this.defaultVisibility = null;
        });

        jQuery('iframe').each(function() {
            try {
                if (this.contentWindow.any == null) {
                    return;
                }
            } catch(e) {
                return;
            }
            this.contentWindow.any.blocker().stop();
        });
    };

    f.block = function(zIndex)
    {
        if ($div == null) {
            any.blocker.blockCount = any.object.nvl(any.blocker.blockCount, 0) + 1;
            if (any.blocker.$iframe == null) {
                any.blocker.$iframe = getFrame();
                if (zIndex == true) {
                    any.blocker.$iframe.css("z-index", 2147483647);
                }
                any.blocker.$iframe.appendTo(document.body);
            } else if (zIndex != true) {
                any.blocker.$iframe.css("z-index", 0);
            }
        } else {
            $div.$blockFrame = getFrame();
            $div.$blockFrame.css("z-index", jQuery('div.ui-dialog[role="dialog"]:last').css("z-index"));
            $div.$blockFrame.appendTo(document.body);
        }
    };

    f.unblock = function(zeroCount)
    {
        if ($div == null) {
            any.blocker.blockCount = (zeroCount == true ? 0 : Math.max(any.object.nvl(any.blocker.blockCount, 0) - 1, 0));
            if (any.blocker.blockCount > 0) {
                return;
            }
            if (any.blocker.$iframe != null) {
                any.blocker.$iframe.remove();
                any.blocker.$iframe = null;
            }
        } else {
            $div.$blockFrame.remove();
            $div.$blockFrame = null;
        }
    };

    return f;

    function getFrame()
    {
        return jQuery('<iframe>').attr({ frameBorder: 0 }).css({ position: "absolute", left: "0px", top: "0px", width: "100%", height: "100%" });
    }
};

any.loading = function(arg0)
{
    if (arg0 != null && typeof(arg0) === "function") {
        if (any.loading.functions == null) {
            any.loading.functions = [];
        }
        any.loading.functions.push(arg0);
        return;
    }

    if (any.loading.type == null) {
        any.loading.type = "page";
        any.loading.page = {};
        any.loading.ajax = {};
    }

    if (typeof(arg0) === "string" && any.loading[arg0] != null) {
        any.loading.type = arg0;
    }

    var f = {};
    var o = {};

    o.loading = { page: {}, ajax: {} };

    f.container = function(container)
    {
        o.container = container;

        return f;
    };

    f.show = function()
    {
        if (o.container != null) {
            o.loading.ajax.show.apply(this, arguments);
            return;
        }

        if (arg0 === true) {
            any.loading.count = any.object.nvl(any.loading.count, 0) + 1;
        }

        if (o.loading[any.loading.type] != null) {
            o.loading[any.loading.type].show.apply(this, arguments);
        }
    };

    f.hide = function()
    {
        if (o.container != null) {
            o.loading.ajax.hide.apply(this, arguments);
            return;
        }

        if (arg0 === true) {
            any.loading.count = Math.max(any.object.nvl(any.loading.count, 0) - 1, 0);
            if (any.loading.count > 0) {
                return;
            }
        }

        if (o.loading[any.loading.type] != null) {
            o.loading[any.loading.type].hide.apply(this, arguments.length > 0 ? arguments : [true]);
        }
    };

    f.appendPageProgressBar = function()
    {
        if (any.loading.page.$progressBarLayer != null || any.home == null) {
            return;
        }

        any.loading.page.$progressBarLayer = jQuery('<div>').addClass("any-page-progressbar").css({
            "position": "absolute",
            "top": "0px",
            "width": "100%",
            "border": "none",
            "z-index": 2147483647
        }).appendTo(document.body);

        any.loading.page.$progressBarLayer.progressbar({ value: false });
        any.loading.page.$progressBarLayer.find('.ui-progressbar-value').css({ "border": "none" });
    };

    f.removePageProgressBar = function()
    {
        if (any.loading.page.$progressBarLayer == null) {
            return;
        }

        any.loading.page.$progressBarLayer.remove();
        any.loading.page.$progressBarLayer = null;
    };

    o.loading.page.show = function()
    {
        any.blocker().block(true);

        if (any.loading.page.$layer != null || any.home == null) {
            return;
        }

        any.loading.page.$layer = jQuery('<div>').css({
            "position": "absolute",
            "background-color": "#ffffff",
            "left": "0px",
            "top": "0px",
            "width": "100%",
            "height": "100%",
            "z-index": 2147483647
        }).appendTo(document.body);

        if (any.config["/anyworks/loading/page/progressbar-mode"] === true) {
            any.rootWindow().any.loading().appendPageProgressBar();

            any.loading.page.$layer.fadeTo(0, 0.25);
        } else {
            if (any.config.loadingImage.page == null) {
                any.config.loadingImage.page = any.home + "/images/loading-page.gif";
            }

            any.loading.page.$layer.html(' \
                <div style="display: table; width: 100%; height: 100%;"> \
                    <div style="display: table-cell; width: 100%; height: 100%; text-align: center; vertical-align: middle;"> \
                        <img src="' + any.meta.contextPath + any.config.loadingImage.page + '"> \
                    </div> \
                </div> \
            ');
        }

        jQuery('html').removeAttr("style");
    };

    o.loading.page.hide = function()
    {
        jQuery('html').removeAttr("style");

        if (any.config["/anyworks/loading/page/progressbar-mode"] === true) {
            any.rootWindow().any.loading().removePageProgressBar();
        }

        if (any.loading.page.$layer == null) {
            return;
        }

        any.loading.page.$layer.remove();
        any.loading.page.$layer = null;

        any.blocker().unblock(true);

        window.setTimeout(function() {
            if (any.loading.page.$layer == null) {
                any.loading.type = "ajax";
            }
        }, 500);
    };

    o.loading.ajax.show = function(duration, opacity)
    {
        any.blocker().block();

        var $container = jQuery(o.container == null ? document.body : o.container);
        var $layer = $container.data("$ajax-loading-layer");

        if ($layer == null) {
            $layer = jQuery('<div>').css({
                "display": "none",
                "background-color": any.text.nvl(any.config.ajaxLoadingBgColor, "#000000"),
                "position": "absolute",
                "left": "0px",
                "top": "0px",
                "width": "100%",
                "height": "100%",
                "z-index": 2147483647
            }).appendTo($container);

            $container.data("$ajax-loading-layer", $layer);

            if (o.container == null) {
                any.loading.ajax.$layer = $layer;
            }

            if (any.config.loadingImage.ajax == null) {
                any.config.loadingImage.ajax = any.home + "/images/loading-ajax.gif";
            }

            $layer.data("$loader", jQuery('<div>').css({
                "display": "none",
                "position": "absolute",
                "left": "0px",
                "top": "0px",
                "width": "100%",
                "height": "100%",
                "z-index": 2147483647
            }).appendTo($container));

            $layer.data("$loader").html(' \
                <div style="display: table; width: 100%; height: 100%;"> \
                    <div style="display: table-cell; width: 100%; height: 100%; text-align: center; vertical-align: middle;"> \
                        <img src="' + any.meta.contextPath + any.config.loadingImage.ajax + '"> \
                    </div> \
                </div> \
            ');
        }

        if (o.container == null) {
            jQuery('<input>').css({
                "position": "absolute",
                "margin-left": "-1000px",
                "margin-top": "-1000px"
            }).appendTo(document.body).focus().remove();
        } else {
            o.containerPosition = $container.css("position");
            $container.css("position", "relative");
        }

        $layer.fadeTo(duration, opacity);
        $layer.data("$loader").show();
    };

    o.loading.ajax.hide = function(zeroCount)
    {
        var $container = jQuery(o.container == null ? document.body : o.container);
        var $layer = $container.data("$ajax-loading-layer");

        if ($layer == null) {
            o.loading.page.hide();
        } else {
            $layer.data("$loader").hide();
            $layer.stop().hide();

            any.blocker().unblock(zeroCount && any.loading.page.$layer == null);

            if (o.container != null && o.containerPosition != null) {
                $container.css("position", o.containerPosition);
            }
        }
    };

    return f;
};

any.body = function()
{
    var f = {};

    f.begin = function(func)
    {
        if (func != null) {
            add("begin", func);
        } else {
            exec("begin");
        }

        return f;
    };

    f.end = function(func)
    {
        if (func != null) {
            add("end", func);
        } else {
            exec("end");
        }

        return f;
    };

    return f;

    function add(type, func)
    {
        if (any.body.functions == null) {
            any.body.functions = {};
        }

        if (any.body.functions[type] == null) {
            any.body.functions[type] = [];
        }

        any.body.functions[type].push(func);
    }

    function exec(type)
    {
        if (any.body.functions == null) {
            return;
        }
        if (any.body.functions[type] == null) {
            return;
        }

        for (var i = 0, ii = any.body.functions[type].length; i < ii; i++) {
            any.body.functions[type][0].apply(any.body.functions[type][0]);
            any.body.functions[type].splice(0, 1);
        }
    }
};

any.ready = function(func)
{
    if (func != null) {
        if (any.ready.functions == null) {
            any.ready.functions = [];
        }
        any.ready.functions.push(func);
        return;
    }

    var f = {};

    f.check = function(callback)
    {
        if (any.control().checkActivated() != true) {
            window.setTimeout(function() { f.check(callback); }, 50);
            return;
        }

        if (any.codedata.initialized != true) {
            any.codedata.initialized = true;
            any.codedata().initialize();
        }

        if (any.control().checkReady() != true) {
            window.setTimeout(function() { f.check(callback); }, 50);
            return;
        }

        any.autoHeight();
        any.fullHeight();

        if (callback == null) {
            for (var i = 0, ii = any.ready.functions == null ? 0 : any.ready.functions.length; i < ii; i++) {
                any.ready.functions[0].apply(any.ready.functions[0]);
                any.ready.functions.splice(0, 1);
            }
        } else {
            callback.apply(callback);
        }

        jQuery('body').data("any-size", null);

        any.autoHeight();
        any.fullHeight();

        any.loading(true).hide();
    };

    return f;
};

any["boolean"] = function(value, separator)
{
    if (value == null) {
        value = any.config.booleanValues;
    }

    if (separator == null) {
        if (value.indexOf(",") > 0) {
            separator = ",";
        } else if (value.indexOf(":") > 0) {
            separator = ":";
        } else if (value.indexOf(";") > 0) {
            separator = ";";
        }
    }

    var values = value.split(separator);

    var f = {};

    f.trueValue = function(defaultValue)
    {
        if (values.length > 0) {
            return values[0];
        }

        return defaultValue;
    };

    f.falseValue = function(defaultValue)
    {
        if (values.length > 1) {
            return values[1];
        }

        return defaultValue;
    };

    f.value = function(bool)
    {
        return bool == true ? f.trueValue() : f.falseValue();
    };

    return f;
};

any.object = function(obj)
{
    var f = {};

    f.init = function()
    {
        return exec(any.object.init, arguments);
    };

    f.clone = function()
    {
        return exec(any.object.clone, arguments);
    };

    f.copyFrom = function()
    {
        obj = exec(any.object.copyFrom, arguments);

        return f;
    };

    f.copyTo = function()
    {
        obj = exec(any.object.copyTo, arguments);

        return f;
    };

    f.nvl = function()
    {
        return exec(any.object.nvl, arguments);
    };

    f.join = function()
    {
        return exec(any.object.join, arguments);
    };

    f.parse = function()
    {
        obj = exec(any.object.parse, arguments);

        return f;
    };

    f.size = function()
    {
        return exec(any.object.size, arguments);
    };

    f.toBoolean = function()
    {
        return exec(any.object.toBoolean, arguments);
    };

    f.toObject = function()
    {
        return obj;
    };

    return f;

    function exec(func, args)
    {
        var a = Array.prototype.slice.call(args);
        a.splice(0, 0, obj);
        return func.apply(f, a);
    }
};

any.object.init = function(obj, path, last)
{
    var paths = path.split(".");
    var newObj = obj;

    for (var i = 0, ii = paths.length; i < ii; i++) {
        if (newObj[paths[i]] == null) {
            newObj[paths[i]] = (i < ii - 1 || arguments.length < 3 ? {} : last);
        }
        newObj = newObj[paths[i]];
    }

    return newObj;
};

any.object.clone = function(obj)
{
    if (obj == null) {
        return obj;
    }

    if (typeof(obj) !== "object" || jQuery.type(obj) === "date") {
        return obj;
    }

    var newObj = new obj.constructor();

    for (var prop in obj) {
        if (typeof(obj[prop]) === "object") {
            newObj[prop] = any.object.clone(obj[prop]);
        } else {
            newObj[prop] = obj[prop];
        }
    }

    return newObj;
};

any.object.copyFrom = function(obj, obj2, keepOriginal)
{
    if (obj == null || obj2 == null) {
        return obj;
    }

    for (var item in obj2) {
        if (keepOriginal == true && typeof(obj[item]) !== "undefined") {
            continue;
        }
        obj[item] = obj2[item];
    }

    return obj;
};

any.object.copyTo = function(obj, obj2, keepOriginal)
{
    any.object.copyFrom(obj2, obj, keepOriginal);

    return obj;
};

any.object.nvl = function(obj, obj2)
{
    return obj == null ? obj2 : obj;
};

any.object.join = function(obj, delimiter, separator)
{
    var arr = [];

    for (var item in obj) {
        arr.push(item + delimiter + obj[item]);
    }

    return arr.join(separator == null ? "," : separator);
};

any.object.parse = function(obj, string, separator, delimiter)
{
    if (obj == null) {
        obj = {};
    }

    if (string == null || string == "") {
        return obj;
    }
    if (separator == null || separator == "") {
        return obj;
    }
    if (delimiter == null || delimiter == "") {
        return obj;
    }

    var str1 = string.split(separator);

    for (var i = 0; i < str1.length; i++) {
        var str2 = str1[i].split(delimiter);
        if (str2.length == 2) {
            obj[any.text.trim(str2[0])] = any.text.trim(str2[1]);
        }
    }

    return obj;
};

any.object.size = function(obj, total)
{
    var size = 0;

    for (var item in obj) {
        if (total == true || item != null) {
            size++;
        }
    }

    return size;
};

any.object.toBoolean = function(obj, defaultValue)
{
    if (obj == null || obj === "") {
        return defaultValue;
    }

    return String(obj).toLowerCase() == "true";
};

any.text = function(txt)
{
    var f = {};

    f.trim = function()
    {
        txt = exec(any.text.trim, arguments);

        return f;
    };

    f.replaceAll = function()
    {
        txt = exec(any.text.replaceAll, arguments);

        return f;
    };

    f.string = function()
    {
        txt = exec(any.text.string, arguments);

        return f;
    };

    f.lpad = function()
    {
        txt = exec(any.text.lpad, arguments);

        return f;
    };

    f.rpad = function()
    {
        txt = exec(any.text.rpad, arguments);

        return f;
    };

    f.startsWith = function()
    {
        return exec(any.text.startsWith, arguments);
    };

    f.endsWith = function()
    {
        return exec(any.text.endsWith, arguments);
    };

    f.nvl = function()
    {
        txt = exec(any.text.nvl, arguments);

        return f;
    };

    f.nvl2 = function()
    {
        txt = exec(any.text.nvl2, arguments);

        return f;
    };

    f.isEmpty = function()
    {
        return exec(any.text.isEmpty, arguments);
    };

    f.isBlank = function()
    {
        return exec(any.text.isBlank, arguments);
    };

    f.empty = function()
    {
        txt = exec(any.text.empty, arguments);

        return f;
    };

    f.empty2 = function()
    {
        txt = exec(any.text.empty2, arguments);

        return f;
    };

    f.blank = function()
    {
        txt = exec(any.text.blank, arguments);

        return f;
    };

    f.blank2 = function()
    {
        txt = exec(any.text.blank2, arguments);

        return f;
    };

    f.format = function()
    {
        txt = exec(any.text.format, arguments);

        return f;
    };

    f.unformat = function()
    {
        txt = exec(any.text.unformat, arguments);

        return f;
    };

    f.formatNumber = function()
    {
        txt = exec(any.text.formatNumber, arguments);

        return f;
    };

    f.unformatNumber = function()
    {
        txt = exec(any.text.unformatNumber, arguments);

        return f;
    };

    f.crop = function()
    {
        return exec(any.text.crop, arguments);
    };

    f.cropIgnoreCase = function()
    {
        return exec(any.text.cropIgnoreCase, arguments);
    };

    f.bytes = function()
    {
        return exec(any.text.bytes, arguments);
    };

    f.toHTML = function()
    {
        return exec(any.text.toHTML, arguments);
    };

    f.toJSON = function()
    {
        return exec(any.text.toJSON, arguments);
    };

    f.toJS = function()
    {
        return exec(any.text.toJS, arguments);
    };

    f.toBoolean = function()
    {
        return exec(any.text.toBoolean, arguments);
    };

    f.toNumber = function()
    {
        return exec(any.text.toNumber, arguments);
    };

    f.toCamelCase = function()
    {
        return exec(any.text.toCamelCase, arguments);
    };

    f.toUnderscores = function()
    {
        return exec(any.text.toUnderscores, arguments);
    };

    f.toString = function()
    {
        return txt;
    };

    return f;

    function exec(func, args)
    {
        var a = Array.prototype.slice.call(args);
        a.splice(0, 0, txt);
        return func.apply(f, a);
    }
};

any.text.trim = function(txt)
{
    if (txt == null) {
        return txt;
    }

    return String(txt).replace(/(^\s*)|(\s*$)/g, "");
};

any.text.replaceAll = function(txt, sFindText, sReplaceText, bIgnoreCase)
{
    if (txt == null || sFindText == null) {
        return txt;
    }

    return String(txt).replace(new RegExp(sFindText, "g" + (bIgnoreCase == true ? "i" : "")), sReplaceText);
};

any.text.string = function(txt, len)
{
    if (txt == null) {
        return txt;
    }

    txt = String(txt);

    var str = txt;

    while (txt.length < len) {
        txt = txt + str;
    }

    return txt;
};

any.text.lpad = function(txt, len, pad, truncate)
{
    if (txt == null) {
        return txt;
    }

    txt = String(txt);

    if (truncate === true && txt.length > len) {
        return txt.substr(0, len);
    }

    while (txt.length < len) {
        txt = pad + txt;
    }

    return txt;
};

any.text.rpad = function(txt, len, pad, truncate)
{
    if (txt == null) {
        return txt;
    }

    txt = String(txt);

    if (truncate === true && txt.length > len) {
        return txt.substr(0, len);
    }

    while (txt.length < len) {
        txt = txt + pad;
    }

    return txt;
};

any.text.startsWith = function(txt, sPrefix, bIgnoreCase)
{
    if (txt == null || sPrefix == null) {
        return false;
    }

    txt = String(txt);

    if (txt.length < sPrefix.length) {
        return false;
    }

    if (bIgnoreCase == true) {
        return txt.substr(0, sPrefix.length).toUpperCase() == sPrefix.toUpperCase();
    }

    return txt.substr(0, sPrefix.length) == sPrefix;
};

any.text.endsWith = function(txt, sSuffix, bIgnoreCase)
{
    if (txt == null || sSuffix == null) {
        return false;
    }

    txt = String(txt);

    if (txt.length < sSuffix.length) {
        return false;
    }

    if (bIgnoreCase == true) {
        return txt.substr(txt.length - sSuffix.length).toUpperCase() == sSuffix.toUpperCase();
    }

    return txt.substr(txt.length - sSuffix.length) == sSuffix;
};

any.text.nvl = function(txt, nullValue)
{
    return txt == null ? nullValue : txt;
};

any.text.nvl2 = function(txt, notNullValue, nullValue)
{
    return txt == null ? nullValue : notNullValue;
};

any.text.isEmpty = function(txt)
{
    return txt == null || txt == "";
};

any.text.isBlank = function(txt)
{
    return any.text.isEmpty(txt) || any.text.trim(txt) == "";
};

any.text.empty = function(txt, emptyValue)
{
    return any.text.isEmpty(txt) ? emptyValue : txt;
};

any.text.empty2 = function(txt, notEmptyValue, emptyValue)
{
    return any.text.isEmpty(txt) ? emptyValue : notEmptyValue;
};

any.text.blank = function(txt, blankValue)
{
    return any.text.isBlank(txt) ? blankValue : txt;
};

any.text.blank2 = function(txt, notBlankValue, blankValue)
{
    return any.text.isBlank(txt) ? blankValue : notBlankValue;
};

any.text.format = function(txt, fmt, symbol, exactly)
{
    if (txt == null) {
        return txt;
    }

    txt = String(txt);

    if (txt == "") {
        return txt;
    }

    if (fmt == null || fmt == "") {
        return txt;
    }

    if (symbol == null) {
        symbol = "#";
    }

    var result = [];
    var txtIdx = 0;

    for (var i = 0, ii = fmt.length; i < ii; i++) {
        if (fmt.charAt(i) == symbol) {
            result.push(txt.charAt(txtIdx++));
        } else if (txt.charAt(i) == fmt.charAt(i)) {
            result.push(txt.charAt(i));
            txtIdx++;
        } else {
            result.push(fmt.charAt(i));
        }
    }

    if (exactly != true) {
        result.push(txt.substr(txtIdx));
    }

    return result.join("");
};

any.text.unformat = function(txt, fmt, symbol, exactly)
{
    if (txt == null) {
        return txt;
    }

    txt = String(txt);

    if (txt == "") {
        return txt;
    }

    if (fmt == null || fmt == "") {
        return txt;
    }

    if (symbol == null) {
        symbol = "#";
    }

    var result = [];
    var txtIdx = 0;

    for (var i = 0, ii = fmt.length; i < ii; i++) {
        if (fmt.charAt(i) == symbol) {
            result.push(txt.charAt(txtIdx++));
        } else if (txt.charAt(i) == fmt.charAt(i)) {
            txtIdx++;
        }
    }

    if (exactly != true) {
        result.push(txt.substr(txtIdx));
    }

    return result.join("");
};

any.text.formatNumber = function(txt, digits, thousandsSeparator)
{
    if (txt == null) {
        return txt;
    }

    txt = String(txt);

    if (txt == "") {
        return txt;
    }

    if (arguments.length < 3) {
        thousandsSeparator = ",";
    }

    if (thousandsSeparator == null) {
        thousandsSeparator = "";
    }

    if (thousandsSeparator != "") {
        txt = any.text.replaceAll(txt, thousandsSeparator, "");
    }

    if (!isNaN(digits)) {
        txt = String(Math.round(parseFloat(txt, 10) * Math.pow(10, digits)) / Math.pow(10, digits));
    }

    var minus = any.text.startsWith(txt, "-");
    var txts = (minus == true ? txt.substr(1) : txt).split(".");
    var fixed = any.text.blank(txts[0], "0").replace(new RegExp(thousandsSeparator, "g"), "").split("").reverse().join("").match(/.{1,3}/g).join(thousandsSeparator).split("").reverse().join("");
    var decimal = any.text.rpad(txts[1] == null ? "" : txts[1], digits, "0");

    return (minus == true ? "-" : "") + fixed + (decimal == "" ? "" : ".") + decimal;
};

any.text.unformatNumber = function(txt, thousandsSeparator)
{
    if (txt == null) {
        return txt;
    }

    txt = String(txt);

    if (txt == "") {
        return txt;
    }

    if (thousandsSeparator == null) {
        thousandsSeparator = ",";
    }

    return txt.replace(new RegExp(thousandsSeparator, "g"), "");
};

any.text.crop = function(txt, prefix, suffix)
{
    if (txt == null) {
        return null;
    }

    var result;

    if (prefix == null) {
        result = txt;
    } else {
        var prefixIndex = txt.indexOf(prefix);
        if (prefixIndex == -1) {
            return null;
        }
        result = txt.substring(prefixIndex + prefix.length);
    }

    if (suffix != null) {
        var suffixIndex = result.indexOf(suffix);
        if (suffixIndex == -1) {
            return null;
        }
        return result.substring(0, suffixIndex);
    }

    return result;
};

any.text.cropIgnoreCase = function(txt, prefix, suffix)
{
    if (txt == null) {
        return null;
    }

    var result;

    if (prefix == null) {
        result = txt;
    } else {
        var prefixIndex = txt.toUpperCase().indexOf(prefix.toUpperCase());
        if (prefixIndex == -1) {
            return null;
        }
        result = txt.substring(prefixIndex + prefix.length);
    }

    if (suffix != null) {
        var suffixIndex = result.toUpperCase().indexOf(suffix.toUpperCase());
        if (suffixIndex == -1) {
            return null;
        }
        return result.substring(0, suffixIndex);
    }

    return result;
};

any.text.bytes = function(txt)
{
    if (typeof(txt) === "number") {
        return txt <= 128 ? 1 : 3;
    }

    var str = String(txt);
    var bytes = 0;

    for (var i = 0, ii = str.length; i < ii; i++) {
        bytes += any.text.bytes(str.charCodeAt(i));
    }

    return bytes;
};

any.text.toHTML = function(txt, isPre)
{
    if (txt == null) {
        return txt;
    }

    txt = String(txt);

    var result = [];

    for (var i = 0, ii = txt.length; i < ii; i++) {
        var c = txt.charAt(i);
        switch (c) {
        case "<":
            result.push("&lt;");
            break;
        case ">":
            result.push("&gt;");
            break;
        case '"':
            result.push("&quot;");
            break;
        case "&":
            result.push("&amp;");
            break;
        case '+':
            result.push("&#43;");
            break;
        default:
            if (isPre == true) {
                result.push(c);
                break;
            }
            switch (c) {
            case " ":
                result.push("&nbsp;");
                break;
            case "\r":
                if (i + 1 < ii && txt.charAt(i + 1) == '\n') {
                    result.push("<br>\r\n");
                } else {
                    result.push("<br>\r");
                }
                break;
            case "\n":
                if ((i > 0 && txt.charAt(i - 1) == '\r') != true) {
                    result.push("<br>\n");
                }
                break;
            default:
                result.push(c);
                break;
            }
        }
    }

    return result.join("");
};

any.text.toJSON = function(txt)
{
    if (txt == null) {
        return txt;
    }

    txt = String(txt);

    var result = [];

    for (var i = 0, ii = txt.length; i < ii; i++) {
        var c = txt.charAt(i);
        switch (c) {
        case "\\":
            result.push("\\\\");
            break;
        case "\r":
            result.push("\\r");
            break;
        case "\n":
            result.push("\\n");
            break;
        case "\"":
            result.push("\\\"");
            break;
        default:
            result.push(c);
            break;
        }
    }

    return result.join("");
};

any.text.toJS = function(txt)
{
    if (txt == null) {
        return txt;
    }

    txt = String(txt);

    var result = [];

    for (var i = 0, ii = txt.length; i < ii; i++) {
        var c = txt.charAt(i);
        switch (c) {
        case "\\":
            result.push("\\\\");
            break;
        case "\r":
            result.push("\\r");
            break;
        case "\n":
            result.push("\\n");
            break;
        case "\"":
            result.push("\\042");
            break;
        case "\'":
            result.push("\\047");
            break;
        case "<":
            result.push("\\074");
            break;
        case ">":
            result.push("\\076");
            break;
        default:
            result.push(c);
        break;
        }
    }

    return result.join("");
};

any.text.toBoolean = function(txt, defaultValue)
{
    if (txt == null || txt === "") {
        return defaultValue;
    }

    return String(txt).toLowerCase() == "true";
};

any.text.toNumber = function(txt)
{
    if (txt == null) {
        return txt;
    }

    var str = String(txt);
    var num = [];

    for (var i = 0, ii = str.length; i < ii; i++) {
        if (str.charAt(i) >= '0' && str.charAt(i) <= '9') {
            num.push(str.charAt(i));
        }
        if (str.charAt(i) == '-' || str.charAt(i) == '.') {
            num.push(str.charAt(i));
        }
    }

    return Number(num.join(""));
};

any.text.toCamelCase = function(txt)
{
    if (txt == null) {
        return txt;
    }

    txt = String(txt);

    if (txt == "") {
        return txt;
    }

    var str = txt.toLowerCase();
    var isUpperCase = false;
    var result = [];

    for (var i = 0; i < str.length; i++) {
        var chr = str.charAt(i);
        if (chr == '_') {
            isUpperCase = true;
        } else if (chr >= '0' && chr <= '9') {
            result.push(chr);
            isUpperCase = false;
        } else if (chr < 'a' || chr > 'z') {
            result.push(chr);
            isUpperCase = true;
        } else if (isUpperCase) {
            result.push(chr.toUpperCase());
            isUpperCase = false;
        } else {
            result.push(chr);
        }
    }

    return result.join("");
};

any.text.toUnderscores = function(txt)
{
    if (txt == null) {
        return txt;
    }

    txt = String(txt);

    if (txt == "") {
        return txt;
    }

    var result = [];

    for (var i = 0; i < txt.length; i++) {
        if (txt.charAt(i) == txt.charAt(i).toUpperCase()) {
            result.push('_');
        }
        result.push(txt.charAt(i));
    }

    return result.join("").substring(result[0] == '_' ? 1 : 0);
};

any.date = function()
{
    var f = {};
    var o = {};

    o.date = function(val, fmt)
    {
        if (arguments.length == 0) {
            return new Date();
        }

        if (val == null || any.text.trim(val) == "") {
            return null;
        }

        var valType = jQuery.type(val);

        if (valType == "number") {
            return new Date(val);
        }

        if (valType == "date") {
            return val;
        }

        val = String(val);

        if (fmt == null) {
            fmt = (val.length == 8 ? "yyyymmdd" : any.meta.dateFormat);
        }

        if (val.length != fmt.length) {
            return null;
        }

        var obj = { y: [], m: [], d: [], h: [], i: [], s: [], l: [] };

        for (var i = 0, ii = fmt.length; i < ii; i++) {
            if (obj[fmt.charAt(i).toLowerCase()] != null) {
                obj[fmt.charAt(i).toLowerCase()].push(val.charAt(i));
            }
        }

        for (var item in obj) {
            if (obj[item] != null && isNaN(obj[item].join(""))) {
                return null;
            }
        }

        return new Date(
                  Number(obj.y.join(""))
                , Number(obj.m.join("")) - 1
                , Number(obj.d.join(""))
                , Number(obj.h.join(""))
                , Number(obj.i.join(""))
                , Number(obj.s.join(""))
                , Number(obj.l.join(""))
        );
    }.apply(null, arguments);

    f.add = function(num, part)
    {
        if (o.date == null || num == null) {
            return f;
        }

        var add = { year: 0, month: 0, week: 0, date: 0, hour: 0, minute: 0, second: 0, millisecond: 0 };

        add[part == null ? "date" : part] = parseInt(num, 10);

        o.date = new Date(
                  o.date.getFullYear() + add.year
                , o.date.getMonth() + add.month
                , o.date.getDate() + add.week * 7 + add.date
                , o.date.getHours() + add.hour
                , o.date.getMinutes() + add.minute
                , o.date.getSeconds() + add.second
                , o.date.getMilliseconds() + add.millisecond
        );

        return f;
    };

    f.toDate = function()
    {
        return o.date;
    };

    f.toDisplay = function()
    {
        return f.toString(any.meta.dateFormat);
    };

    f.toString = function(fmt)
    {
        if (o.date == null) {
            return "";
        }

        if (fmt == null) {
            fmt = "yyyymmdd";
        }

        var str = fmt.toLowerCase();

        str = str.replace("yyyy", o.date.getFullYear());
        str = str.replace("mm", any.text.lpad(o.date.getMonth() + 1, 2, "0"));
        str = str.replace("dd", any.text.lpad(o.date.getDate(), 2, "0"));
        str = str.replace("hh", any.text.lpad(o.date.getHours(), 2, "0"));
        str = str.replace("ii", any.text.lpad(o.date.getMinutes(), 2, "0"));
        str = str.replace("ss", any.text.lpad(o.date.getSeconds(), 2, "0"));
        str = str.replace("lll", any.text.lpad(o.date.getMilliseconds(), 3, "0"));

        return str;
    };

    f.timestamp = function(withSymbol)
    {
        if (withSymbol == true) {
            return f.toString("yyyy-mm-dd hh:ii:ss.lll");
        }

        return f.toString("yyyymmddhhiisslll");
    };

    return f;
};

any.event = function(event)
{
    var f = {};

    if (event == null) {
        event = window.event;
    }

    f.preventDefault = function()
    {
        if (typeof(event.preventDefault) === "function") {
            event.preventDefault();
        } else {
            event.returnValue = false;
        }

        return f;
    };

    f.stopPropagation = function()
    {
        if (typeof(event.stopPropagation) === "function") {
            event.stopPropagation();
        } else {
            event.cancelBubble = true;
        }

        return f;
    };

    return f;
};

any.error = function(error)
{
    var f = {};

    f.initialize = function()
    {
        if (any.error.handler != null) {
            return;
        }

        any.error.handler = {};

        any.error.handler["default"] = function(error, callback, proxy)
        {
            any.dialog(true).alert(getMessage(error, "System Error!")).ok(function() {
                if (callback != null) {
                    callback.apply(error);
                }
            });
        };

        any.error.handler["access"] = function(error, callback, proxy)
        {
            any.dialog(true).alert(getMessage(error, "Invalid Access!")).ok(function() {
                if (callback != null) {
                    callback.apply(error);
                }
            });
        };

        any.error.handler["session"] = function(error, callback, proxy)
        {
            any.dialog(true).alert(getMessage(error, "Invalid Session!")).ok(function() {
                if (callback != null) {
                    callback.apply(error);
                }
            });
        };

        any.error.handler["biz"] = function(error, callback, proxy)
        {
            any.dialog(true).alert(error.message + (error.code == null ? "" : "\n\n[" + error.code + "]")).ok(function() {
                if (callback != null) {
                    callback.apply(error);
                }
            });
        };

        function getMessage(error, deaultMessage)
        {
            var msg = [];

            msg.push("[ERROR");

            if (error.status == null) {
                msg.push(error.number == null || error.number == 0 ? "" : ":" + error.number);
                msg.push(error.code == null ? "" : ":" + error.code);
            } else {
                msg.push(":" + error.status);
            }

            msg.push("] ");

            if (error.error === true || error.error === "true") {
                msg.push(any.text.nvl(error.message, deaultMessage));
            } else {
                msg.push(error.error + " - " + any.text.nvl(error.message, deaultMessage));
            }

            if (error.path != null && error.path != "") {
                msg.push("\n\n" + error.path);
            }

            return msg.join("");
        }
    };

    f.parse = function(jqXHR, errorThrown, errorSuffix)
    {
        var error = {};

        try {
            any.object.copyTo(eval("(" + jqXHR.responseText + ")"), error);
            if (error.error == null && errorThrown != null) {
                setError(jqXHR, errorThrown);
            }
        } catch(e) {
            if (jqXHR.status != 200) {
                setError(jqXHR, jqXHR.statusText);
            }
        }

        return error;

        function setError(jqXHR, messageText)
        {
            error.error = true;
            error.status = jqXHR.status;
            error.number = jqXHR.status;
            error.type = "sys";
            error.message = messageText + errorSuffix;
            error.description = error.message;
        }
    };

    f.handler = function(func)
    {
        f.initialize();

        any.error.handler[error] = func;

        return f;
    };

    f.show = function(callback, proxy)
    {
        if (typeof(error) !== "object" && typeof(error) !== "function") {
            return false;
        }
        if (error.error == null) {
            return false;
        }

        f.initialize();

        if (any.error.handler[error.type] == null) {
            any.error.handler["default"](error, callback, proxy);
        } else {
            any.error.handler[error.type](error, callback, proxy);
        }

        return true;
    };

    return f;
};

any.cookie = function(name)
{
    var cookie = {};

    var f = {};

    f.expires = function(val)
    {
        var now = new Date();
        var expiresDate = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 0, 0, 0, 0);
        expiresDate.setDate(expiresDate.getDate() + val);
        cookie.expires = expiresDate.toGMTString();

        return f;
    };

    f.path = function(val)
    {
        cookie.path = val;

        return f;
    };

    f.domain = function(val)
    {
        cookie.domain = val;

        return f;
    };

    f.secure = function(val)
    {
        cookie.secure = val;

        return f;
    };

    f.get = function(defaultValue)
    {
        var arr = document.cookie.split(";");

        for (var i = 0, ii = arr.length; i < ii; i++) {
            var val = any.text.trim(arr[i]);
            if (val.indexOf("=") == -1 && val == name) {
                return "";
            } else if (val.split("=")[0] == name) {
                return any.text.trim(val.split("=")[1]);
            }
        }

        if (arguments.length < 1) {
            return null;
        }

        return defaultValue;
    };

    f.set = function(value)
    {
        var arr = [];

        if (cookie.path == null) {
            cookie.path = any.meta.contextPath + "/";
        }

        arr.push(name + "=" + (value == null ? "" : value));

        for (var item in cookie) {
            arr.push(item + "=" + cookie[item]);
        }

        document.cookie = arr.join("; ");
    };

    f.remove = function()
    {
        this.expires(-1).set();
    };

    return f;
};

any.session = function()
{
    var f = {};

    f.keep = function(path, interval)
    {
        try {
            if (parent.any != any) {
                return;
            }
        } catch(e) {
        }

        if (path == null || path == "") {
            return;
        }

        if (interval == null) {
            return;
        }
        if (interval.value == null || interval.value == "") {
            return;
        }
        if (interval.unit == null || interval.unit == "") {
            return;
        }

        var delay = Number(interval.value) * { hour: 1440, minute: 60, second: 1 }[interval.unit] * 1000;

        var prx = any.proxy().url(path).option({ method: "GET", loadingbar: false });

        prx.on("onStart", function() {
            window.setTimeout(prx.execute, delay);
        });

        window.setTimeout(prx.execute, delay);
    };

    return f;
};

any.url = function(fullPath, params, contextPath)
{
    if (contextPath == null) {
        contextPath = any.meta.contextPath;
    }

    if (arguments.length == 0) {
        return contextPath;
    }

    if (fullPath == null || fullPath == "") {
        return fullPath;
    }

    if (any.text.endsWith(fullPath, ":blank", true)) {
        return fullPath;
    }

    if (fullPath == "." || any.text.startsWith(fullPath, "..") == true) {
        var path = window.location.pathname.replace(contextPath, "");

        if (any.text.startsWith(fullPath, "...") == true && path.indexOf("/") != path.lastIndexOf("/")) {
            var tmp = path.substr(0, path.lastIndexOf("/"));
            if (any.text.endsWith(tmp, "Act") == true) {
                tmp = tmp.substr(0, tmp.length - 3) + "Ajax";
            }
            fullPath = tmp + fullPath.substr(3);
        } else if (any.text.startsWith(fullPath, "..") == true && path.indexOf("/") != path.lastIndexOf("/")) {
            fullPath = path.substr(0, path.lastIndexOf("/")) + fullPath.substr(2);
        } else {
            fullPath = path;
        }
    }

    var pathName;
    var paramStr;

    if (fullPath.indexOf("?") == -1) {
        pathName = fullPath;
        paramStr = "";
    } else {
        pathName = fullPath.substr(0, fullPath.indexOf("?"));
        paramStr = encodeParamStr(fullPath.substr(fullPath.indexOf("?")));
    }

    if (any.url.servletPattern == null) {
        any.url.servletPattern = {};
    }

    var urlPatterns = any.text.nvl(any.url.servletPattern.pattern, "").split("*");
    var urlPrefix;
    var urlSuffix;
    var realPath;

    if (fullPath.indexOf("?") != -1) {
        realPath = fullPath.substr(0, fullPath.indexOf("?"));
    } else {
        realPath = fullPath;
    }

    if (any.text.endsWith(realPath, ".jsp") || realPath.indexOf(".jsp?") != -1) {
        urlPrefix = urlPatterns[0];
        urlSuffix = "";
    } else if (urlPatterns.length != 2) {
        urlPrefix = any.text.blank(any.url.servletPattern.prefix, "");
        urlSuffix = any.text.blank(any.url.servletPattern.suffix, ".any");
    } else {
        urlPrefix = urlPatterns[0];
        urlSuffix = urlPatterns[1];
    }

    if (any.text.endsWith(pathName, urlSuffix) == true) {
    } else if (pathName == "" || pathName == "/" || pathName == contextPath || pathName == contextPath + "/") {
    } else if (pathName.substr(pathName.lastIndexOf("/")).indexOf(".") == -1) {
        pathName = pathName + urlSuffix;
    } else if (pathName.indexOf("::") != -1 && pathName.substr(pathName.lastIndexOf("::")).indexOf(".") == -1) {
        pathName = pathName + urlSuffix;
    } else if (pathName.lastIndexOf(".") != -1 && /[A-Z]/.test(pathName.substr(pathName.lastIndexOf(".") + 1, 1))) {
        pathName = pathName + urlSuffix;
    }

    if (any.text.startsWith(fullPath, "http", true) != true) {
        if (pathName.substr(0, 1) != "/") {
            if (pathName.indexOf("/") == -1 && pathName.indexOf("::") == -1) {
                var pathname = window.location.pathname;
                var lastIndex = pathname.lastIndexOf("/");
                if (lastIndex != -1) {
                    pathName = pathname.substring(0, lastIndex) + "/" + pathName;
                } else {
                    pathName = "/" + pathName;
                }
            } else {
                pathName = "/" + pathName;
            }
        }
        if (contextPath == "" || any.text.startsWith(pathName, contextPath) != true) {
            if (any.text.startsWith(pathName, urlPrefix) != true) {
                pathName = urlPrefix + pathName;
            }
            if (contextPath != "") {
                pathName = contextPath + pathName;
            }
        }
    }

    if (params == null) {
        return pathName + paramStr;
    }

    var prefix = (paramStr == "" ? "?" : "&");

    if (jQuery.type(params) == "string") {
        if (params.substr(0, 1) == "?" || params.substr(0, 1) == "&") {
            params = params.substr(1);
        }
        return pathName + paramStr + (params == "" ? "" : prefix + params);
    }

    var paramArr = [];

    if (jQuery.type(params) == "array") {
        for (var i = 0, ii = params.length; i < ii; i++) {
            var param = params[i];
            if (jQuery.type(param) == "object") {
                if (param.name != null && param.value != null) {
                    paramArr.push(param.name + "=" + encodeURIComponent(param.value));
                }
            } else {
                paramArr.push(param);
            }
        }
    } else if (jQuery.type(params) == "object") {
        for (var item in params) {
            var val = params[item];
            if (val != null) {
                paramArr.push(item + "=" + encodeURIComponent(val));
            }
        }
    }

    return pathName + paramStr + (paramArr == null || paramArr.length == 0 ? "" : prefix + paramArr.join("&"));

    function encodeParamStr(paramStr)
    {
        if (paramStr == null || paramStr == "") {
            return paramStr;
        }

        var paramStrs = paramStr.split("&");
        var result = [];

        for (var i = 0, ii = paramStrs.length; i < ii; i++) {
            var paramsStrs2 = paramStrs[i].split("=");

            if (paramsStrs2.length == 1) {
                result.push(paramsStrs2[0]);
            } else if (paramsStrs2.length == 2) {
                result.push(paramsStrs2[0] + "=" + encodeURIComponent(decodeURIComponent(paramsStrs2[1])));
            }
        }

        return result.join("&");
    }
};

any.url.amp = function(uri)
{
    if (navigator.userAgent.indexOf("Trident/") == -1) {
        return uri;
    }

    var idx = uri.indexOf("?");

    if (idx != -1) {
        return uri.substr(0, idx) + "?" + any.text.replaceAll(uri.substr(idx + 1), "&", "&amp;");
    }

    return uri;
};

any.param = function(arg1, arg2, arg3)
{
    if (any.param.values == null) {
        any.param.values = [];

        var $meta = jQuery('meta[name="X-Any-Parameter"]');

        if ($meta.length > 0) {
            for (var i = 0; i < $meta.length; i++) {
                var contents = $meta.eq(i).attr("content").split("=");
                any.param.values.push({ name: contents[0], value: contents[1] });
            }
        } else if (window.location.search != null && window.location.search != "") {
            var searches = window.location.search.substr(1).split("&");
            for (var i = 0, ii = searches.length; i < ii; i++) {
                var param = searches[i].split("=");
                any.param.values.push({ name: param[0], value: decodeURIComponent(param[1]) });
            }
        }
    }

    var f = {};
    var o = {};

    if (arguments.length == 0 || jQuery.type(arg1) != "array") {
        o.params = any.param.values;
    } else {
        o.params = arg1;
    }

    f.get = function(name)
    {
        var result = [];

        for (var i = 0, ii = o.params.length; i < ii; i++) {
            if (o.params[i].name == name) {
                result.push(o.params[i].value);
            }
        }

        if (result.length == 0) {
            return null;
        }

        if (result.length == 1) {
            return result[0];
        }

        return result;
    };

    f.set = function(name, value, multi)
    {
        if (name == null) {
            return f;
        }

        if (value == null) {
            for (var i = o.params.length - 1; i >= 0; i--) {
                if (o.params[i].name == name) {
                    o.params.splice(i, 1);
                }
            }
            return f;
        }

        var idx = -1;

        if (multi != true) {
            for (var i = 0, ii = o.params.length; i < ii; i++) {
                if (o.params[i].name == name) {
                    idx = i;
                    break;
                }
            }
        }

        if (idx == -1) {
            o.params.push({ name: name, value: value });
        } else {
            o.params[idx].value = value;
        }

        return f;
    };

    f.all = function()
    {
        return o.params;
    };

    f.count = function(name)
    {
        var cnt = 0;

        for (var i = 0, ii = o.params.length; i < ii; i++) {
            if (o.params[i].name == name) {
                cnt++;
            }
        }

        return cnt;
    };

    f.toString = function()
    {
        var result = [];

        for (var i = 0, ii = o.params.length; i < ii; i++) {
            result.push(o.params[i].name + "=" + o.params[i].value);
        }

        return result.join("&");
    };

    if (arguments.length < 1 || jQuery.type(arg1) == "array") {
        return f;
    }

    if (arguments.length < 2) {
        return f.get(arg1);
    }

    return f.set(arg1, arg2, arg3);
};

any.arg = function(name, value)
{
    if (any.arg.values == null) {
        if (any.pageType() == "window") {
            try {
                any.arg.values = window.opener.any.window.openWindows[window.name].arguments;
            } catch(e) {
            }
        }
        if (any.arg.values == null) {
            try {
                if (window.frameElement != null && window.frameElement["any-arguments"] != null) {
                    any.arg.values = window.frameElement["any-arguments"];
                }
            } catch(e) {
            }
        }
        if (any.arg.values == null) {
            try {
                if (any.pageType() != "dialog" && parent != window && parent.any != null && parent.any.arg != null) {
                    if (parent.any.arg.values == null) {
                        parent.any.arg.values = {};
                    }
                    any.arg.values = parent.any.arg.values;
                }
            } catch(e) {
            }
        }
        if (any.arg.values == null) {
            any.arg.values = {};
        }
    }

    var f = {};

    f.get = function(name)
    {
        if (name in any.arg.values) {
            return any.arg.values[name];
        }

        try {
            if (any.pageType() != "dialog" && parent != window && parent.any != null && parent.any.arg != null) {
                return parent.any.arg(name);
            }
        } catch(e) {
        }
    };

    f.set = function(name, value)
    {
        any.arg.values[name] = value;

        return f;
    };

    f.all = function()
    {
        return any.arg.values;
    };

    if (arguments.length < 1) {
        return f;
    }

    if (arguments.length < 2) {
        return f.get(name);
    }

    return f.set(name, value);
};

any.proxy = function(scope)
{
    var f = {};
    var o = { $f:jQuery(f), type: any.config.proxyType, params: [], datas: [], grids: [], files: [] };

    o.options = { async: true, cache: false, loadingbar: true, reloadList: true };

    f.url = function(url)
    {
        if (arguments.length == 0) {
            return any.url(o.url);
        }

        o.url = url;

        return f;
    };

    f.type = function(type)
    {
        if (arguments.length == 0) {
            return o.type;
        }

        o.type = type;

        return f;
    };

    f.header = function(name, value)
    {
        if (name == "") {
            return;
        }

        if (arguments.length == 0) {
            return;
        }

        if (arguments.length == 1) {
            return o.headers == null ? null : o.headers[name];
        }

        if (value == null) {
            return f;
        }

        if (o.headers == null) {
            o.headers = {};
        }

        o.headers[name] = value;

        return f;
    };

    f.param = function(name, value, multi)
    {
        if (arguments.length == 0) {
            return o.params;
        }

        if (arguments.length == 1) {
            return any.param(o.params).get(name);
        }

        any.param(o.params).set(name, value, multi);

        return f;
    };

    f.params = function(params, multi)
    {
        for (var i = 0; i < params.length; i++) {
            f.param(params[i].name, params[i].value, multi);
        }

        return f;
    };

    f.output = function(ds)
    {
        if (ds === false) {
            o.output = false;
            return f;
        }

        if (arguments.length == 0) {
            return o.output;
        }

        if (typeof(ds) === "object") {
            o.output = ds;
        } else {
            o.output = any.ds(ds, scope);
        }

        return f;
    };

    f.data = function(ds, id, output, withoutBind)
    {
        if (arguments.length == 0) {
            return o.datas;
        }

        if (ds == null) {
            return f;
        }

        if (typeof(ds) === "object") {
            if (ds.id == null) {
                return f;
            }
        } else {
            ds = any.ds(ds, scope);
        }

        for (var i = 0, ii = o.datas.length; i < ii; i++) {
            if (o.datas[i].ds == ds && o.datas[i].id == id) {
                return f;
            }
        }

        o.datas.push({ ds: ds, id: id, output: output, withoutBind: withoutBind });

        if (o.type != null && o.type.toLowerCase() === "json") {
            var selectors;

            selectors = [];
            selectors.push('[any--proxy--file="true"][bind^="' + ds.id + ':"]');
            selectors.push('[any--proxy--file="true"][bind="' + ds.id + '"]');
            selectors.push('[any--proxy--file="true"][name^="' + ds.id + '."]');
            selectors.push('[any--proxy--file="true"][id^="' + ds.id + '."]');

            jQuery(selectors.join(",")).each(function() {
                f.file(this, true);
            });

            selectors = [];
            selectors.push('[any--proxy--grid="true"][bind^="' + ds.id + ':"]');
            selectors.push('[any--proxy--grid="true"][bind="' + ds.id + '"]');
            selectors.push('[any--proxy--grid="true"][name^="' + ds.id + '."]');
            selectors.push('[any--proxy--grid="true"][id^="' + ds.id + '."]');

            jQuery(selectors.join(",")).each(function() {
                jQuery(this).find('[any--proxy--file="true"]').each(function() {
                    f.file(this, true);
                });
            });
        }

        return f;
    };

    f.grid = function(grid, id)
    {
        if (arguments.length == 0) {
            return o.grids;
        }

        if (grid == null) {
            return f;
        }

        if (typeof(grid) !== "object") {
            grid = document.getElementById(grid);
        }

        if (grid == null) {
            return f;
        }

        for (var i = 0, ii = o.grids.length; i < ii; i++) {
            if (o.grids[i].grid == grid) {
                return f;
            }
        }

        var $grid = jQuery(grid);
        var ds = $grid.prop("ds");

        f.data(ds, id == null ? ds.id : id);

        $grid.find('[any--proxy--file="true"]').each(function() {
            f.file(this);
        });

        return f;
    };

    f.file = function(file, id)
    {
        if (arguments.length == 0) {
            return o.files;
        }

        if (file == null) {
            return f;
        }

        if (typeof(file) !== "object") {
            file = document.getElementById(file);
        }

        if (file == null) {
            return f;
        }

        for (var i = 0, ii = o.files.length; i < ii; i++) {
            if (o.files[i] == file) {
                return f;
            }
        }

        var row = -1;

        for (var i = 0, ii = o.files.length; i < ii; i++) {
            var pos1 = jQuery(o.files[i]).position();
            var pos2 = jQuery(file).position();
            if (pos1.top > pos2.top || (pos1.top == pos2.top && pos1.left > pos2.left)) {
                row = i;
                break;
            }
        }

        if (row == -1) {
            o.files.push(file);
        } else {
            o.files.splice(row, 0, file);
        }

        if (id !== true) {
            var ds = jQuery(file).prop("ds");
            f.data(ds, id == null ? ds.id : id, false, true);
        }

        return f;
    };

    f.files = function(context)
    {
        jQuery('[any--proxy--file="true"]', context).each(function() {
            f.file(this);
        });

        return f;
    };

    f.json = function(key, json)
    {
        if (o.jsons == null) {
            o.jsons = {};
        }

        if (arguments.length < 2) {
            return o.jsons[key];
        }

        o.jsons[key] = json;
    };

    f.jsons = function(withoutBind)
    {
        var jsons = [];

        if (o.datas.length == 0) {
            return jsons;
        }

        for (var i = 0, ii = o.datas.length; i < ii; i++) {
            if (o.datas[i].output == true) {
                continue;
            }

            if (withoutBind == true || o.datas[i].withoutBind == true) {
                jsons.push(o.datas[i].ds.jsonStringWithoutBind(o.datas[i].id));
            } else {
                jsons.push(o.datas[i].ds.jsonString(o.datas[i].id));
            }
        }

        return jsons;
    };

    f.form = function(selector)
    {
        if (selector == null) {
            return f;
        }

        if (o.$forms == null) {
            o.$forms = (selector.jquery == jQuery.fn.jquery ? selector : jQuery(selector));
        } else {
            o.$forms = o.$forms.add(selector);
        }

        return f;
    };

    f.body = function(body)
    {
        o.body = body;
    }

    f.option = function()
    {
        if (arguments.length == 1 && typeof(arguments[0]) === "string") {
            return o.options[arguments[0]];
        }

        any.copyArguments(o.options, arguments);

        return f;
    };

    f.error = function(jqXHR, errorThrown)
    {
        for (var item in f.error) {
            delete(f.error[item]);
        }

        if (jqXHR.readyState == 0 && jqXHR.status == 0) {
            f.error.show = new Function();
        } else {
            f.error.show = function(callback) {
                any.error(this).show(callback, f);
            };
        }

        any.object.copyTo(any.error().parse(jqXHR, errorThrown, "\n\n" + f.url()), f.error);

        return f.error.error != null;
    };

    f.html = function(container, callback)
    {
        var $container;

        if (jQuery.type(container) == "object" && container.constructor == jQuery) {
            $container = container;
        } else {
            $container = jQuery(container);
        }

        f.on("onSuccess", function() {
            $container.html(this.result).controls(function() {
                var self = this;

                jQuery(this).find('script[type="text/any-initialize"]').each(function() {
                    if (jQuery(this).prev().controlName() == null) {
                        new Function(jQuery(this).text()).apply(self);
                    }
                });

                if (callback != null) {
                    callback.apply(this);
                }
            });
        });

        f.on("onError", function() {
            $container.empty().append(jQuery('<pre>').text(this.error.message));
        });

        o.options.loadingbar = false;

        return f;
    };

    f.progressbar = function(options)
    {
        if (arguments.length < 1) {
            return o.progressbar;
        }

        if (options === false) {
            return f;
        }

        o.progressbar = { options: options === true ? {} : options, progress: any.progress(f) };

        if (o.progressbar.options.defaultLabel == null) {
            o.progressbar.options.defaultLabel = any.message("any.com.progressbar.defaultLabel", "Please Wait...");
        }

        if (o.progressbar.options.completeLabel == null) {
            o.progressbar.options.completeLabel = any.message("any.com.progressbar.completeLabel", "Completed!");
        }

        if (o.progressbar.options.progressLabel == null) {
            o.progressbar.options.progressLabel = function(data) {
                return any.text.formatNumber(data.progress * 100, 2) + "%";
            };
        }

        return f;
    };

    f.on = function(name, func)
    {
        o.$f.on(name, func);

        return f;
    };

    f.prevent = function(targetObject, releaseEvent)
    {
        o.prevent = { targetObject: targetObject, releaseEvent: any.text.empty(releaseEvent, "complete") };

        return f;
    };

    f.execute = function(withoutBind)
    {
        if (o.url == null) {
            return;
        }

        if (o.prevent != null && o.prevent.targetObject != null) {
            if (o.prevent.targetObject["any-proxy-executing"] === true) {
                return;
            }
            o.prevent.targetObject["any-proxy-executing"] = true;
        }

        var $focusButton = jQuery('button:focus');

        if ($focusButton.length > 0) {
            jQuery('<button>').css({ "width": "1px", "height": "1px" }).insertAfter($focusButton).focus().remove();
        }

        o.$f.fire("onStart");

        any.autoHeight();
        any.fullHeight();

        uploadForms();

        function uploadForms()
        {
            if (o.$forms == null || o.$forms.find('input:file').length == 0) {
                uploadFiles();
                return;
            }

            any.loading().container(o.options["loading-container"]).show(0, 0.25);

            for (var i = 0, ii = o.$forms.length; i < ii; i++) {
                o.$forms.eq(i).data("next-form", o.$forms[i + 1]);
            }

            uploadNext();

            function uploadNext(obj)
            {
                var form = (o.$forms.length == 0 ? null : (obj == null ? o.$forms[0] : jQuery(obj).data("next-form")));

                if (form == null) {
                    any.loading().container(o.options["loading-container"]).hide();
                    uploadFiles();
                } else {
                    any.file().url(any.control("any-file").config("url.upload")).event("onUploadSuccess", function() {
                        jQuery(form).fire("onUploadSuccess", arguments);
                        uploadNext(form);
                    }).event("onUploadError", function(error) {
                        any.loading().container(o.options["loading-container"]).hide();
                        any.error(error).show();
                    }).upload(form);
                }
            }
        }

        function uploadFiles()
        {
            if (o.files.length == 0) {
                executeAjax(withoutBind);
                return;
            }

            any.loading().container(o.options["loading-container"]).show(0, 0.25);

            for (var i = 0, ii = o.files.length; i < ii; i++) {
                var $file = jQuery(o.files[i]);

                $file.data("next-file", o.files[i + 1]);

                o.files[i].onUploadSuccessHandler = function() {
                    var $file = jQuery(this);
                    var grid = $file.data("grid");
                    var colInfo = $file.data("grid-column");
                    var rowId = $file.data("grid-row-id");
                    if (grid != null && colInfo != null) {
                        var gridDsId = null;
                        for (var i = 0, ii = o.datas.length; i < ii; i++) {
                            if (o.datas[i].ds == jQuery(grid).prop("ds")) {
                                gridDsId = o.datas[i].id;
                                break;
                            }
                        }
                        if (gridDsId != null) {
                            for (var i = 0, ii = o.datas.length; i < ii; i++) {
                                if (o.datas[i].ds != $file.prop("ds")) {
                                    continue;
                                }
                                if (colInfo.controlds == null) {
                                    o.datas[i].id = gridDsId + "_" + $file.val();
                                } else {
                                    grid.setValue(grid.getRowIndex(rowId), colInfo.controlds, $file.prop("ds").jsonString());
                                    o.datas.splice(i, 1);
                                }
                                break;
                            }
                        }
                    }
                    uploadNext(this);
                };

                o.files[i].onUploadErrorHandler = function() {
                    any.loading().container(o.options["loading-container"]).hide();
                };

                if ($file.data("upload-event-binded") == true) {
                    continue;
                }

                $file.data("upload-event-binded", true);

                $file.on("onUploadComplete", function(event, isSuccess) {
                    if (isSuccess == true) {
                        this.onUploadSuccessHandler();
                    } else {
                        this.onUploadErrorHandler();
                    }
                });
            }

            uploadNext();

            function uploadNext(obj)
            {
                var file = (o.files.length == 0 ? null : (obj == null ? o.files[0] : jQuery(obj).data("next-file")));

                if (file == null) {
                    any.loading().container(o.options["loading-container"]).hide();
                    executeAjax(withoutBind);
                } else if (jQuery(file).isDisabled() == true) {
                    uploadNext(file);
                } else {
                    file.upload();
                }
            }
        }

        function executeAjax(withoutBind)
        {
            var metaToken = jQuery('meta[name="X-Any-Servlet-Token"]').attr("content");
            var rootWin = any.rootWindow();

            if (any.text.isEmpty(rootWin.any.meta.servletToken) == true) {
                rootWin.any.meta.servletToken = metaToken;
            }

            var options = {
                    url: f.url(),
                    method: any.text.blank(o.options.method, "POST"),
                    headers: o.headers,
                    async: o.options.async,
                    cache: o.options.cache
            };

            if (any.text.isEmpty(rootWin.any.meta.servletToken) != true) {
                if (options.headers == null) {
                    options.headers = {};
                }
                options.headers["X-AnyWorks-Servlet-Token"] = rootWin.any.meta.servletToken;
            }

            if (o.servletTokenRetry == true) {
                delete(o.servletTokenRetry);
                if (options.headers == null) {
                    options.headers = {};
                }
                options.headers["X-AnyWorks-Servlet-Token-Retry"] = "true";
            }

            if (o.type != null && o.type.toLowerCase() === "json") {
                options.contentType = "application/json";

                options.data = function()
                {
                    if ("body" in o) {
                        if (o.body == null || typeof(o.body) === "string") {
                            return o.body;
                        }
                        return JSON.stringify(o.body);
                    }
                    if (o.ajaxData == null || o.reload != true) {
                        o.ajaxData = {};
                        for (var i = 0, ii = o.params.length; i < ii; i++) {
                            o.ajaxData[o.params[i].name] = o.params[i].value;
                        }
                        for (var i = 0, ii = o.datas.length; i < ii; i++) {
                            o.ajaxData[any.text.empty(o.datas[i].id, o.datas[i].ds.id)] = o.datas[i].ds.toJSON();
                        }
                        if (o.jsons != null) {
                            for (var key in o.jsons) {
                                o.ajaxData[key] = o.jsons[key];
                            }
                        }
                    }
                    return JSON.stringify(o.ajaxData);
                }();
            } else {
                options.data = function()
                {
                    if (o.ajaxData == null || o.reload != true) {
                        o.ajaxData = [];
                        for (var i = 0, ii = o.params.length; i < ii; i++) {
                            o.ajaxData.push(o.params[i].name + "=" + encodeURIComponent(o.params[i].value));
                        }
                        var jsons = f.jsons(withoutBind);
                        if (jsons.length > 0) {
                            o.ajaxData.push('_DATA_SET_JSON_=' + encodeURIComponent('[' + jsons.join(",") + ']'));
                        }
                    }
                    if (o.$forms != null) {
                        if (o.ajaxData == null) {
                            o.ajaxData = [];
                        }
                        for (var i = 0, ii = o.$forms.length; i < ii; i++) {
                            o.ajaxData.push(o.$forms.eq(i).serialize());
                        }
                    }
                    return o.ajaxData.join("&");
                }();
            }

            delete(f.xhr);

            options.beforeSend = function(jqXHR, settings)
            {
                f.xhr = jqXHR;
                ajaxStart();
            };

            options.success = function(data, textStatus, jqXHR)
            {
                f.xhr = jqXHR;
                ajaxComplete();
                if (String(jqXHR.getResponseHeader("X-AnyWorks-Servlet-Token-Invalid")).toLowerCase() == "true") {
                    o.servletTokenRetry = true;
                    resetToken(jqXHR);
                    executeAjax(true);
                    return;
                }
                try {
                    f.response = { data: data, textStatus: textStatus, jqXHR: jqXHR };
                    f.result = any.text.trim(jqXHR.responseText);
                } catch(e) {
                    return;
                }
                if (f.error(jqXHR) == true) {
                    o.$f.fire("onError");
                    return;
                }
                for (var i = 0, ii = o.datas.length; i < ii; i++) {
                    o.datas[i].ds.clearJobType();
                }
                if (o.output !== false) {
                    if (jqXHR.getResponseHeader("X-AnyWorks-Json-Type") == "MODEL_JSON2") {
                        parseModelDataset(data);
                    } else if (jQuery.type(data) === "array") {
                        f.response.model = data;
                        parseModelDataset(data);
                    } else if (jqXHR.getResponseHeader("X-AnyWorks-Json-Type") == "MODEL_JSON") {
                        for (var item in data) {
                            f.response.model = data[item];
                            parseModelDataset(data[item]);
                            break;
                        }
                    } else {
                        parseDataset(f.result);
                    }
                }
                try {
                    if (o.options.reloadList == true && String(jqXHR.getResponseHeader("X-AnyWorks-Data-Updated")).toLowerCase() == "true") {
                        any.reloadList();
                    }
                } catch(e) {
                    throw e;
                } finally {
                    resetToken(jqXHR);
                    o.$f.fire("onSuccess");
                }
                if (o.prevent != null && o.prevent.releaseEvent == "success") {
                    delete(o.prevent.targetObject["any-proxy-executing"]);
                }
            };

            options.error = function(jqXHR, textStatus, errorThrown)
            {
                f.xhr = jqXHR;
                ajaxComplete();
                resetToken(jqXHR);
                if (String(jqXHR.getResponseHeader("X-AnyWorks-Servlet-Token-Invalid")).toLowerCase() == "true") {
                    o.servletTokenRetry = true;
                    executeAjax(true);
                    return;
                }
                f.error(jqXHR, errorThrown);
                o.$f.fire("onError");
                if (o.prevent != null && o.prevent.releaseEvent == "error") {
                    delete(o.prevent.targetObject["any-proxy-executing"]);
                }
            };

            options.complete = function(jqXHR, textStatus)
            {
                f.xhr = jqXHR;
                resetToken(jqXHR);
                o.$f.fire("onComplete");
                any.autoHeight();
                any.fullHeight();
                delete(o.reload);
                if (o.prevent != null && o.prevent.releaseEvent == "complete") {
                    delete(o.prevent.targetObject["any-proxy-executing"]);
                }
            };

            f.ajax = jQuery.ajax(options);

            function resetToken(jqXHR)
            {
                var responseToken = jqXHR.getResponseHeader("X-AnyWorks-Servlet-Token");

                if (any.text.isEmpty(responseToken) != true) {
                    rootWin.any.meta.servletToken = String(responseToken);
                } else if (metaToken != null) {
                    rootWin.any.meta.servletToken = metaToken;
                }
            }
        }
    };

    f.isReload = function()
    {
        return o.reload === true;
    };

    f.reload = function()
    {
        o.reload = true;
        f.execute();

        return f;
    };

    f.abort = function()
    {
        if (f.ajax != null) {
            f.ajax.abort();
        }

        return f;
    };

    f.clone = function()
    {
        return any.proxy(scope).copy(o);
    };

    f.copy = function(obj)
    {
        o.url = obj.url;

        o.params = any.object.clone(obj.params);
        o.datas = any.object.clone(obj.datas);
        o.grids = any.object.clone(obj.grids);
        o.files = any.object.clone(obj.files);

        return f;
    };

    return f;

    function ajaxStart()
    {
        if (o.options.loadingbar == true) {
            any.loading(true).container(o.options["loading-container"]).show(o.progressbar == null ? 3000 : 0, 0.8);

            if (o.progressbar != null) {
                if (any.loading.ajax.$layer == null) {
                    return;
                }

                if (o.$progressbar != null && o.$progressbar.length > 0) {
                    o.$progressbar.remove();
                }

                o.$progressbar = jQuery('<div>').attr({ "defaultLabel": o.progressbar.options.defaultLabel }).css({ "position": "absolute", "z-index": any.loading.ajax.$layer.css("z-index") });

                o.$progressbar.insertAfter(any.loading.ajax.$layer).on("onCreate", function() {
                    resetProgressbarPosition();
                }).control("any-progressbar", function() {
                    this.setOption({ value: false });
                });

                if (o.progressbar.progress != null) {
                    o.progressbar.progress.callback(function(data) {
                        resetProgressbarPosition();
                        if (o.$progressbar == null || (data.completed != true && data.totalValue == 0)) {
                            return;
                        }
                        o.$progressbar.val(data.progress);
                        if (data.completed == true || data.progress == 1) {
                            o.$progressbar.prop("label", o.progressbar.options.completeLabel);
                            this.stop();
                        } else if (typeof(o.progressbar.options.progressLabel) === "function") {
                            o.$progressbar.prop("label", o.progressbar.options.progressLabel.apply(o.progressbar, [data]));
                        } else {
                            o.$progressbar.prop("label", o.progressbar.options.progressLabel);
                        }
                    }).start();
                }
            }
        }

        function resetProgressbarPosition()
        {
            if (o.$progressbar != null && any.loading.ajax.$layer != null) {
                o.$progressbar.width(Math.min(Math.max(parseInt(any.loading.ajax.$layer.width() / 1.5, 10), 100), 400));
                o.$progressbar.css({ "top": (any.loading.ajax.$layer.height() - o.$progressbar.height()) / 2, "left": (any.loading.ajax.$layer.width() - o.$progressbar.width()) / 2 });
            }
        }
    }

    function ajaxComplete()
    {
        if (o.options.loadingbar == true) {
            any.loading(true).container(o.options["loading-container"]).hide();

            if (o.progressbar != null) {
                if (o.progressbar.progress != null) {
                    o.progressbar.progress.stop();
                }

                if (o.$progressbar != null) {
                    o.$progressbar.prop("label", o.progressbar.options.completeLabel).prop("value", 1);
                    o.$progressbar.remove();
                    o.$progressbar = null;
                }
            }
        }

        for (var i = 0, ii = o.files.length; i < ii; i++) {
            if (typeof(o.files[i].hideProgressBar) === "function") {
                o.files[i].hideProgressBar();
            }
        }
    }

    function parseModelDataset(model)
    {
        if (model == null) {
            return;
        }

        if (o.output != null) {
            parse(o.output, model);
            return;
        }

        for (var id in model) {
            parse(any.ds(id, scope), model[id]);
        }

        function parse(ds, model)
        {
            if (ds.dataLoader() != null) {
                ds.dataLoader().apply(ds, [model]);
            } else if (jQuery.type(model) === "object") {
                ds.loadData([model], true, model["_META_MAP"]);
            } else if (jQuery.type(model) === "array") {
                ds.loadData(model, true);
            }
        }
    }

    function parseDataset(str)
    {
        if (str == null || str == "") {
            return;
        }

        var result;

        try {
            result = eval("([" + str + "])");
        } catch(e) {
            return;
        }

        var jsons;

        if (result != null && result.length > 0 && result[0]["_DATA_SET_JSON_"] != null) {
            jsons = result[0]["_DATA_SET_JSON_"];
        } else {
            jsons = result;
        }

        for (var i = 0; i < jsons.length; i++) {
            if (jsons[i].data == null) {
                continue;
            }
            for (var j = 0; j < jsons[i].data.length; j++) {
                var data = jsons[i].data[j].data;
                for (var key in data) {
                    var val = data[key];
                    if (typeof(val) === "string" && any.text.startsWith(val, "new Date(") && any.text.endsWith(val, ")")) {
                        data[key] = eval(val);
                    }
                }
            }
        }

        if (o.output != null) {
            var json = (jsons.length > 0 ? jsons[0] : null);
            if (json == null || json.header == null || json.data == null) {
                o.output.load(null);
            } else {
                o.output.load(json);
            }
            return;
        }

        for (var i = 0, ii = jsons.length; i < ii; i++) {
            var json = jsons[i];
            if (json.id == null || json.header == null || json.data == null) {
                continue;
            }
            var loaded = false;
            for (var j = 0, jj = o.datas.length; j < jj; j++) {
                if (o.datas[j].id != json.id) {
                    continue;
                }
                o.datas[j].ds.load(json);
                loaded = true;
            }
            if (loaded != true) {
                any.ds(json.id, scope).load(json);
            }
        }
    }
};

any.form = function(selector)
{
    var f = {};
    var o = {};

    if (selector == null) {
        o.$form = jQuery('<form>').attr({ "method": "POST" }).appendTo(document.body);
    } else {
        o.$form = jQuery(selector);
    }

    f.attr = function()
    {
        o.$form.attr.apply(o.$form, Array.prototype.slice.call(arguments));

        return f;
    };

    f.param = function(name, value, multi)
    {
        var $elem = o.$form.find('input:hidden[name="' + name + '"]');

        if ($elem.length == 0 || multi == true) {
            $elem = jQuery('<input>').attr({ type: "hidden", name: name }).appendTo(o.$form);
        }

        $elem.val(value);

        return f;
    };

    f.params = function(params, multi)
    {
        for (var i = 0; i < params.length; i++) {
            f.param(params[i].name, params[i].value, multi);
        }

        return f;
    };

    f.data = function(ds, id, scope, withoutBind)
    {
        if (arguments.length == 0) {
            return o.datas;
        }

        if (ds == null) {
            return f;
        }

        if (o.datas == null) {
            o.datas = [];
        }

        if (typeof(ds) === "object") {
            if (ds.id == null) {
                return f;
            }
        } else {
            ds = any.ds(ds, scope);
        }

        for (var i = 0, ii = o.datas.length; i < ii; i++) {
            if (o.datas[i].ds == ds && o.datas[i].id == id) {
                return f;
            }
        }

        o.datas.push({ ds: ds, id: id, withoutBind: withoutBind });

        return f;
    };

    f.submit = function()
    {
        if (o.datas != null && o.datas.length > 0) {
            var jsons = [];
            for (var i = 0, ii = o.datas.length; i < ii; i++) {
                if (o.datas[i].withoutBind == true) {
                    jsons.push(o.datas[i].ds.jsonStringWithoutBind(o.datas[i].id));
                } else {
                    jsons.push(o.datas[i].ds.jsonString(o.datas[i].id));
                }
            }
            f.param('_DATA_SET_JSON_', '[' + jsons.join(",") + ']');
        }

        o.$form.submit();

        if (selector == null) {
            o.$form.remove();
        }
    };

    return f;
};

any.opener = function()
{
    try {
        if (window.frameElement != null && window.frameElement["any-opener"] != null) {
            return window.frameElement["any-opener"];
        }
    } catch(e) {
    }

    try {
        if (window.opener != null && window.opener.any != null && window.opener.any.window != null && window.opener.any.window.openWindows != null) {
            var f = window.opener.any.window.openWindows[window.name].f;
            if (f != null && f.opener() != null) {
                return f.opener();
            }
        }
    } catch(e) {
    }

    try {
        if (window.opener != window && window.opener.any != null) {
            return window.opener;
        }
    } catch(e) {
    }

    return window;
};

any.history = function()
{
    var f = {};
    var o = {};

    if (any.meta != null && any.meta.contextPath != null && any.home != null) {
        o.url = any.meta.contextPath + any.home + "/anyworks-history.htm";
    }

    (function initialize() {
        if (o.url == null || any.history.initialized == true) {
            return;
        }

        any.history.initialized = true;

        if (any.history.$iframe != null) {
            any.history.$iframe.remove();
        }

        any.history.functions = {};
        any.history.$iframe = jQuery('<iframe>').hide().attr("src", o.url).appendTo(document.body);
        any.history.index = 0;
    })();

    f.start = function(func)
    {
        if (o.url == null) {
            return f;
        }

        any.history.functions["#0"] = func;

        return f;
    };

    f.add = function(func)
    {
        if (o.url == null) {
            return f;
        }

        any.history.index++;
        any.history.functions["#" + any.history.index] = func;
        any.history.$iframe.attr("src", o.url + "?" + any.history.index + "#" + any.history.index);

        return f;
    };

    f.go = function(hash)
    {
        if (o.url == null || any.history.functions == null) {
            return f;
        }

        if (hash == null || hash == "") {
            hash = "#0";
        }

        var func = any.history.functions[hash];

        if (func != null) {
            (typeof(func) === "function" ? func : new Function(func)).apply();
        }

        return f;
    };

    return f;
};

any.location = function(win)
{
    if (win == null) {
        win = window;
    }

    var f = {};
    var o = { $f: jQuery(f) };

    f.url = function(url)
    {
        if (arguments.length == 0) {
            return any.url(o.url, o.params);
        }

        o.url = url;

        return f;
    };

    f.param = function(name, value, multi)
    {
        if (arguments.length == 0) {
            return;
        }

        if (o.params == null) {
            o.params = [];
        }

        if (arguments.length == 1) {
            return any.param(o.params).get(name);
        }

        any.param(o.params).set(name, value, multi);

        return f;
    };

    f.params = function(params, multi)
    {
        for (var i = 0; i < params.length; i++) {
            f.param(params[i].name, params[i].value, multi);
        }

        return f;
    };

    f.arg = function()
    {
        if (o.args == null) {
            o.args = {};
        }

        if (arguments.length == 1 && typeof(arguments[0]) === "string") {
            return o.args[arguments[0]];
        }

        any.copyArguments(o.args, arguments);

        return f;
    };

    f.window = function(w)
    {
        win = w;

        return f;
    };

    f.on = function(name, func)
    {
        o.$f.on(name, func);

        return f;
    };

    f.replace = function()
    {
        if (o.url == null) {
            return;
        }

        setFrameElement();

        win.location.replace(any.url.amp(any.url(o.url, o.params)));
    };

    f.href = function()
    {
        if (o.url == null) {
            return;
        }

        setFrameElement();

        win.location.href = any.url.amp(any.url(o.url, o.params));
    };

    f.reload = function(replace)
    {
        setFrameElement();

        if (replace === true) {
            win.location.replace(win.location.href);
        } else {
            win.location.reload();
        }
    };

    function setFrameElement()
    {
        try {
            if (win.frameElement == null) {
                return f;
            }
        } catch(e) {
            return f;
        }

        if (o.args != null) {
            win.frameElement["any-arguments"] = o.args;
        }

        if (o.frameElementEventAttached === true) {
            return;
        }

        o.frameElementEventAttached = true;

        jQuery(win.frameElement).on("onReload", function() {
            o.$f.fire("onReload");
        });
    }

    return f;
};

any.dialog = function(isRootWindow)
{
    var f = {};
    var o = {};

    f.init = function()
    {
        o.title = null;
        o.options = { autoOpen: false, resizable: false, width: 350 };
        o.functions = {};

        if (isRootWindow != null) {
            f.option("rootWindow", isRootWindow);
        }

        return f;
    };

    f.title = function(title)
    {
        o.title = title;

        return f;
    };

    f.option = function()
    {
        if (arguments.length == 1 && typeof(arguments[0]) === "string") {
            return o.options[arguments[0]];
        }

        any.copyArguments(o.options, arguments);

        return f;
    };

    f.alert = function(message)
    {
        o.functionName = "ok";

        if (any.config.jQueryDialog == true) {
            o.options.modal = true;
            o.options.buttons = {};
            o.options.buttons[any.message("any.btn.ok", "OK")] = function() {
                f.$div.dialog("close");
            };
            showDialog(message);
        } else {
            alert(message);
        }

        return f;
    };

    f.confirm = function(message)
    {
        o.functionName = "cancel";

        if (any.config.jQueryDialog == true) {
            o.options.modal = true;
            o.options.buttons = {};
            o.options.buttons[any.message("any.btn.ok", "OK")] = function() {
                o.functionName = "ok";
                f.$div.dialog("close");
            };
            o.options.buttons[any.message("any.btn.cancel", "Cancel")] = function() {
                f.$div.dialog("close");
            };
            showDialog(message);
        } else {
            if (confirm(message) == true) {
                o.functionName = "ok";
            }
        }

        return f;
    };

    f.ask = function(message)
    {
        o.functionName = "no";

        o.options.modal = true;
        o.options.buttons = {};
        o.options.buttons[any.message("any.btn.yes", "Yes")] = function() {
            o.functionName = "yes";
            f.$div.dialog("close");
        };
        o.options.buttons[any.message("any.btn.no", "No")] = function() {
            f.$div.dialog("close");
        };
        showDialog(message);

        return f;
    };

    f.ask2 = function(message)
    {
        o.functionName = "cancel";

        o.options.modal = true;
        o.options.buttons = {};
        o.options.buttons[any.message("any.btn.yes", "Yes")] = function() {
            o.functionName = "yes";
            f.$div.dialog("close");
        };
        o.options.buttons[any.message("any.btn.no", "No")] = function() {
            o.functionName = "no";
            f.$div.dialog("close");
        };
        o.options.buttons[any.message("any.btn.cancel", "Cancel")] = function() {
            f.$div.dialog("close");
        };
        showDialog(message);

        return f;
    };

    f.ok = function(func)
    {
        o.functions.ok = func;

        if (any.config.jQueryDialog != true && o.functionName == "ok") {
            func();
        }

        return f;
    };

    f.cancel = function(func)
    {
        o.functions.cancel = func;

        if (any.config.jQueryDialog != true && o.functionName == "cancel") {
            func();
        }

        return f;
    };

    f.yes = function(func)
    {
        o.functions.yes = func;

        if (any.config.jQueryDialog != true && o.functionName == "yes") {
            func();
        }

        return f;
    };

    f.no = function(func)
    {
        o.functions.no = func;

        if (any.config.jQueryDialog != true && o.functionName == "no") {
            func();
        }

        return f;
    };

    f.init();

    return f;

    function showDialog(message)
    {
        if (o.options.rootWindow == true && any.rootWindow().any != any) {
            o.jQuery = any.rootWindow().jQuery;
            o.blocker = any.rootWindow().any.blocker(f.$div);
            jQuery(window).unload(function() {
                if (f.$div != null) {
                    f.$div.dialog("option", "hide", null).dialog("close");
                }
            });
        } else {
            o.jQuery = jQuery;
            o.blocker = any.blocker(f.$div);
        }

        f.$div = o.jQuery('<div>').css({ "white-space": "pre-wrap", "word-break": "break-all" });

        f.$div.attr("title", any.text.nvl(o.title, any.topWindow().document.title)).text(String(message));

        o.options.close = function(event, ui)
        {
            o.blocker.unblock();

            if (f.$div != null) {
                f.$div.remove();
                f.$div = null;
            }

            if (o.functions[o.functionName] != null) {
                o.functions[o.functionName]();
            }
        };

        o.blocker.block();

        f.$div.dialog(o.options).dialog("open");

        jQuery(o.jQuery.window).resize(function() {
            setPosition();
        });

        setPosition();
    }

    function setPosition()
    {
        if (f.$div == null) {
            return;
        }

        var $dlg = f.$div.parent();

        $dlg.css("left", ($dlg.parent().innerWidth() - $dlg.outerWidth()) / 2);
        $dlg.css("top", ($dlg.parent().height() - $dlg.innerHeight()) / 2 + $dlg.parent().scrollTop());
    }
};

any.popup = function(selector)
{
    var f = {};
    var o = {};

    f.init = function()
    {
        o.$div = (selector.jquery == jQuery.fn.jquery ? selector : jQuery(selector));

        f.title(any.text.blank(o.$div.attr("title"), any.topWindow().document.title));

        o.cancelText = any.message("any.btn.cancel", "Cancel").toString();

        o.options = { autoOpen: false, modal: true, resizable: false, hide: "clip" };

        if (o.$div.attr("resizable") == "" || o.$div.attr("resizable") == "resizable") {
            o.options.resizable = true;
        }

        if (o.$div.data("any-popup-opened") != true) {
            var width = Number(o.$div.attr("width"));
            var height = Number(o.$div.attr("height"));

            if (isNaN(width) != true) {
                o.options.width = Math.min(width, jQuery(document.body).width() - 20);
            }

            if (isNaN(height) != true) {
                o.options.height = Math.min(height, jQuery(document.body).height() - 20);
            }
        }

        o.$div.data("any-popup-opened", true);
    };

    f.title = function(title)
    {
        o.$div.attr("title", title);

        return f;
    };

    f.button = function(text, func)
    {
        if (o.options.buttons == null) {
            o.options.buttons = {};
        }

        o.options.buttons[text] = func;

        return f;
    };

    f.cancel = function(val)
    {
        if (typeof(val) === "string") {
            o.cancelText = val;
        } else if (val !== true) {
            o.cancelText = null;
        }

        return f;
    };

    f.option = function()
    {
        if (arguments.length == 1 && typeof(arguments[0]) === "string") {
            return o.options[arguments[0]];
        }

        any.copyArguments(o.options, arguments);

        return f;
    };

    f.show = function()
    {
        if (o.cancelText != null) {
            f.button(o.cancelText, function() {
                o.$div.dialog("close");
            });
        }

        o.$div.dialog(o.options).dialog("open");

        return f;
    };

    f.close = function()
    {
        o.$div.dialog("close");

        return f;
    };

    f.init();

    return f;
};

any.window = function(isRootWindow)
{
    var f = {};
    var o = { $f: jQuery(f) };

    f.init = function()
    {
        o.title = null;
        o.url = null;
        o.params = null;
        o.args = null;
        o.options = { autoOpen: false, modal: true, resizable: false, hide: "clip" };
        o.functions = {};

        if (jQuery.browser.msie && Number(jQuery.browser.version) < 11) {
            o.options.hide = false;
        }

        if (isRootWindow != null) {
            f.option("rootWindow", isRootWindow);
        }

        return f;
    };

    f.opener = function(win)
    {
        if (arguments.length == 0) {
            return o.opener == null ? window : o.opener;
        }

        o.opener = win;

        return f;
    };

    f.title = function(title)
    {
        o.title = title;

        return f;
    };

    f.url = function(url)
    {
        if (arguments.length == 0) {
            return any.url(o.url, o.params);
        }

        o.url = url;

        return f;
    };

    f.param = function(name, value, multi)
    {
        if (arguments.length == 0) {
            return;
        }

        if (o.params == null) {
            o.params = [];
        }

        if (arguments.length == 1) {
            return any.param(o.params).get(name);
        }

        any.param(o.params).set(name, value, multi);

        return f;
    };

    f.params = function(params, multi)
    {
        for (var i = 0; i < params.length; i++) {
            f.param(params[i].name, params[i].value, multi);
        }

        return f;
    };

    f.arg = function()
    {
        if (o.args == null) {
            o.args = {};
        }

        if (arguments.length == 1 && typeof(arguments[0]) === "string") {
            return o.args[arguments[0]];
        }

        any.copyArguments(o.args, arguments);

        return f;
    };

    f.option = function()
    {
        if (arguments.length == 1 && typeof(arguments[0]) === "string") {
            return o.options[arguments[0]];
        }

        any.copyArguments(o.options, arguments);

        return f;
    };

    f.ok = function(func)
    {
        o.functions.ok = func;

        return f;
    };

    f.on = function(name, func)
    {
        o.$f.on(name, func);

        return f;
    };

    f.type = function(type)
    {
        if (arguments.length == 0) {
            return o.type;
        }

        o.type = type;

        return f;
    };

    f.show = function(name)
    {
        if (o.type == "open") {
            return f.open.apply(f, arguments);
        }

        if (o.url == null) {
            return;
        }

        if (o.options.rootWindow == true && any.rootWindow().any != any) {
            o.jQuery = any.rootWindow().jQuery;
            o.blocker = any.rootWindow().any.blocker(f.$div);
            jQuery(window).unload(function() {
                if (f.$div != null) {
                    f.$div.dialog("option", "hide", null).dialog("close");
                }
            });
        } else {
            o.jQuery = jQuery;
            o.blocker = any.blocker(f.$div);
        }

        if (name != null && o.jQuery('div#any_dialog_' + name).length > 0) {
            return;
        }

        f.$div = o.jQuery('<div>');

        if (name != null) {
            f.$div.attr("id", "any_dialog_" + name);
        }

        f.$div.attr("title", any.text.nvl(o.title, "Loading..."));

        o.options.beforeClose = function(event, ui)
        {
            if (f.$div == null) {
                return;
            }

            if (!jQuery.browser.msie || Number(jQuery.browser.version) >= 9) {
                f.$div.children('iframe').attr("src", "").remove();
            }
        };

        o.options.close = function(event, ui)
        {
            if (o.blockerUnblocked !== true) {
                o.blocker.unblock();
            }

            var reloadList;

            if (f.$div != null) {
                reloadList = f.$div.data("reloadList");

                if (reloadList == true) {
                    f.$div.fire("onReload");
                }

                f.$div.fire("onUnload", [o.returnValue]);

                f.$div.children('iframe').attr("src", "").remove();
                f.$div.remove();
                f.$div = null;
            }

            if (reloadList == true) {
                o.$f.fire("onReload");
            }

            o.$f.fire("onUnload", [o.returnValue]);
        };

        o.blocker.block();
        o.blockerUnblocked = false;

        f.$div.dialog(o.options).dialog("open");

        var $dlg = f.$div.parent();

        $dlg.css("left", ($dlg.parent().innerWidth() - $dlg.outerWidth()) / 2);
        $dlg.css("top", ($dlg.parent().height() - $dlg.innerHeight()) / 2 + $dlg.parent().scrollTop());

        var $iframe = o.jQuery('<iframe>').attr({ frameborder: "0", scrolling: "no", "any-pageType": "dialog" })
            .prop({ "any-opener": o.opener == null ? window : o.opener, "any-arguments": o.args == null ? {} : o.args })
            .css({ position: "absolute", left: "0", top: "0", width: "100%", height: "100%" })
            .appendTo(f.$div);

        $iframe[0]["any-unloadPage"] = function(returnValue)
        {
            o.returnValue = returnValue;

            if (o.functions.ok != null && returnValue != null) {
                if (o.functions.ok(returnValue) === false) {
                    return;
                }
            }

            o.blocker.unblock();

            o.blockerUnblocked = true;

            f.$div.dialog("close");
        };

        $iframe.attr("src", any.url(o.url, o.params));

        return f;
    };

    f.open = function(name)
    {
        if (o.type == "show") {
            return f.show.apply(f, arguments);
        }

        if (o.url == null) {
            return;
        }

        var specs = { width: "400px", height: "300px" };

        for (var item in o.options) {
            if (o.options[item] === true) {
                o.options[item] = "yes";
            } else if (o.options[item] === false) {
                o.options[item] = "no";
            }
        }

        if (o.options.width != null) {
            specs.width = o.options.width  + "px";
        }
        if (o.options.height != null) {
            specs.height = o.options.height + "px";
        }
        if (o.options.left != null) {
            specs.left = o.options.left   + "px";
        }
        if (o.options.top != null) {
            specs.top = o.options.top    + "px";
        }
        if (o.options.fullscreen != null) {
            specs.fullscreen = o.options.fullscreen;
        }

        specs.channelmode = any.text.nvl(o.options.channelmode, "no");
        specs.directories = any.text.nvl(o.options.directories, "no");
        specs.location    = any.text.nvl(o.options.location, "no");
        specs.menubar     = any.text.nvl(o.options.menubar, "no");
        specs.resizable   = any.text.nvl(o.options.resizable, "no");
        specs.scrollbars  = any.text.nvl(o.options.scrollbars, "no");
        specs.status      = any.text.nvl(o.options.status, "yes");
        specs.titlebar    = any.text.nvl(o.options.titlebar, "no");
        specs.toolbar     = any.text.nvl(o.options.toolbar, "no");

        if (name == null) {
            if (any.window.openCount == null) {
                any.window.openCount = 1;
            }
            name = "any_window_" + any.date().timestamp() + "_" + (any.window.openCount++);
        }

        if (any.window.openWindows == null) {
            any.window.openWindows = {};
        }

        any.window.openWindows[name] = {};
        any.window.openWindows[name].arguments = (o.args == null ? {} : o.args);
        any.window.openWindows[name].functions = o.functions;
        any.window.openWindows[name].f = f;
        any.window.openWindows[name].$f = o.$f;

        if (arguments.length == 0 || arguments[0] != name) {
            any.window.openWindows[name]["any-window-resize-enable"] = true;
            o.window = window.open(any.meta.contextPath + any.home + "/anyworks-window.htm", name, any.object.join(specs, "=", ","), true);
            return f;
        }

        if (any.window.openedWindows == null) {
            any.window.openedWindows = {};
        }

        o.window = any.window.openedWindows[name];

        if (o.window != null) {
            try {
                o.window.document.location.href;
            } catch(e) {
                delete(o.window);
            }
        }

        any.window.openWindows[name]["any-window-resize-enable"] = (o.window == null);

        if (o.window == null) {
            o.window = window.open("", name, any.object.join(specs, "=", ","), true);
            any.window.openedWindows[name] = o.window;
        }

        o.window.document.location.replace(any.meta.contextPath + any.home + "/anyworks-window.htm");

        return f;
    };

    f.window = function(name)
    {
        if (name == null) {
            return o.window;
        }

        if (any.window.openedWindows == null) {
            return null;
        }

        var win = any.window.openedWindows[name];

        try {
            win.document.location.href;
            return win;
        } catch(e) {
            return null;
        }
    };

    f.focus = function(name)
    {
        var win = f.window(name);

        if (win != null) {
            try {
                win.focus();
            } catch(e) {
            }
        }

        return f;
    };

    f.close = function(name)
    {
        var win = f.window(name);

        if (win != null) {
            try {
                win.close();
            } catch(e) {
            }
        }

        return f;
    };

    f.resize = function(width, height)
    {
        if (any.pageType() != "window" && any.pageType() != "dialog") {
            return f;
        }

        var resizeWindow = true;

        if (any.pageType() == "window") {
            try {
                resizeWindow = window.opener.any.window.openWindows[window.name]["any-window-resize-enable"];
                window.opener.any.window.openWindows[window.name]["any-window-resize-enable"] = false;
            } catch(e) {
            }
        }

        if (resizeWindow != true) {
            return f;
        }

        var $dlg = jQuery(window.frameElement).parent().parent();

        if (width == null) {
            width = Number(jQuery(document.body).attr("width"));
        }

        if (height == null) {
            height = Number(jQuery(document.body).attr("height"));
        }

        if (any.pageType() == "window" && isNaN(width) != true && isNaN(height) != true) {
            window.resizeTo(width, height);
            return f;
        }

        if (isNaN(width) != true) {
            width = Math.min(width, jQuery(parent.document.body).width() - 20);

            $dlg.width(width);
            $dlg.css("left", ($dlg.parent().innerWidth() - $dlg.outerWidth()) / 2);
        }

        if (isNaN(height) != true) {
            height = Math.min(height, jQuery(parent.document.body).height() - 20);

            $dlg.height(height);
            $dlg.css("top", ($dlg.parent().height() - $dlg.innerHeight()) / 2 + $dlg.parent().scrollTop());
            $dlg.children('div.ui-dialog-content').outerHeight(height - $dlg.children('div.ui-dialog-titlebar').outerHeight());
        }

        return f;
    };

    f.init();

    return f;
};

any.viewer = function()
{
    var f = {};
    var o = { $f: jQuery(f) };

    f.init = function()
    {
        o.url = null;
        o.params = null;
        o.args = null;

        return f;
    };

    f.url = function(url)
    {
        if (arguments.length == 0) {
            return any.url(o.url, o.params);
        }

        o.url = url;

        return f;
    };

    f.param = function(name, value, multi)
    {
        if (arguments.length == 0) {
            return;
        }

        if (o.params == null) {
            o.params = [];
        }

        if (arguments.length == 1) {
            return any.param(o.params).get(name);
        }

        any.param(o.params).set(name, value, multi);

        return f;
    };

    f.params = function(params, multi)
    {
        for (var i = 0; i < params.length; i++) {
            f.param(params[i].name, params[i].value, multi);
        }

        return f;
    };

    f.arg = function()
    {
        if (o.args == null) {
            o.args = {};
        }

        if (arguments.length == 1 && typeof(arguments[0]) === "string") {
            return o.args[arguments[0]];
        }

        any.copyArguments(o.args, arguments);

        return f;
    };

    f.on = function(name, func)
    {
        o.$f.on(name, func);

        return f;
    };

    f.show = function()
    {
        if (o.url == null) {
            return;
        }

        if (any.viewer.$div != null) {
            return;
        }

        any.viewer.$div = jQuery('<div>').addClass("any-viewer").css({ width: "100%", height: "100%", "z-index": 1 });

        var $frame;
        var autoHeight;

        try {
            $frame = jQuery(window.frameElement).prop("any-viewer-$div", any.viewer.$div);
            autoHeight = $frame.hasAttr("autoHeight");
        } catch(e) {
            $frame = null;
            autoHeight = false;
        }

        if (autoHeight == true) {
            any.viewer.$div.appendTo($frame.parent());
            $frame.hide();
        } else {
            any.viewer.$div.css({ position: "absolute", left: "0", top: "0" });
            any.viewer.$div.appendTo(document.body);
        }

        var $iframe = jQuery('<iframe>').attr({ frameborder: "0", scrolling: "no", "any-pageType": "viewer", src: jQuery.browser.webkit ? "about:dummy" : null })
            .prop({ "any-opener": window, "any-arguments": o.args == null ? {} : o.args, "any-url": any.url.amp(any.url(o.url, o.params)) })
            .css({ width: "100%", height: "100%", "background-color": "#ffffff" })
            .appendTo(any.viewer.$div);

        if (autoHeight == true) {
            $iframe.attr("autoHeight", "");
        }

        $iframe[0]["any-unloadPage"] = function(returnValue)
        {
            if (any.viewer.$div == null) {
                return;
            }

            jQuery('<iframe>').hide().appendTo(document.body).remove();

            any.viewer.$div.children('iframe').each(function() {
                this.contentWindow.location.replace("about:blank");
            });

            any.viewer.$div.empty().hide();

            if (any.viewer.$div.data("reloadList") == true) {
                o.$f.fire("onReload");
            }

            o.$f.fire("onUnload", [returnValue]);

            any.viewer.$div.remove();

            any.viewer.$div = null;

            if (autoHeight == true) {
                $frame.show();
            }
        };

        $iframe.attr("src", any.meta.contextPath + any.home + "/anyworks-viewer.htm");

        return f;
    };

    f.init();

    return f;
};

any.message = function(messageCode, defaultText)
{
    if (any.message.data == null) {
        any.message.data = {};
    }

    if (any.message.invalidText == null) {
        any.message.invalidText = { prefix: "", suffix: "" };
    }

    var f = {};
    var o = {};

    f.initialize = function()
    {
        var prx = any.proxy().output(false);
        prx.url(any.config.messageLoader);
        prx.param("MESSAGE_CODE", messageCode);
        prx.option({ loadingbar: messageCode == null, async: false });
        prx.execute();

        if (prx.result == null || prx.result == "") {
            return;
        }

        var result = eval("(" + prx.result + ")");

        for (var item in result) {
            if (item != result[item]) {
                any.message.data[item] = result[item];
            }
        }

        if (messageCode != null) {
            return any.message.data[messageCode];
        }
    };

    if (messageCode != null) {
        o.msg = any.message.data[messageCode];
        if (o.msg == null) {
            o.msg = f.initialize();
        }
        if (o.msg == null && defaultText != null) {
            o.msg = any.message.invalidText.prefix + defaultText + any.message.invalidText.suffix;
        }
        if (o.msg == null) {
            o.msg = any.message.invalidText.prefix + messageCode + any.message.invalidText.suffix;
        }
    }

    f.exists = function()
    {
        return any.message.data[messageCode] != null;
    };

    f.arg = function()
    {
        if (o.msg == null) {
            return f;
        }

        if (o.argIndex == null) {
            if (o.msg.indexOf("{0}") != -1 || o.msg.indexOf("{#0}") != -1) {
                o.argIndex = 0;
            } else {
                o.argIndex = 1;
            }
        }

        for (var i = 0, ii = arguments.length; i < ii; i++) {
            var argIndex = o.argIndex++;
            o.msg = any.text.replaceAll(o.msg, "\\{" + argIndex + "\\}", arguments[i]);
            o.msg = any.text.replaceAll(o.msg, "\\{#" + argIndex + "\\}", arguments[i]);
        }

        return f;
    };

    f.toString = function()
    {
        return o.msg;
    };

    f.toHTML = function()
    {
        return any.text.toHTML(o.msg);
    };

    f.toJSON = function()
    {
        return any.text.toJSON(o.msg);
    };

    f.toJS = function()
    {
        return any.text.toJS(o.msg);
    };

    return f;
};

any.codedata = function(control)
{
    var f = {};
    var o = {};

    if (any.codedata.container == null) {
        any.codedata.container = {};
    }

    any.codedata.getFirstName = function(firstName)
    {
        if (any.message("any.codeData.firstName." + firstName).exists() == true) {
            return any.message("any.codeData.firstName." + firstName, firstName).toString();
        }

        return firstName;
    };

    f.initialize = function(callback)
    {
        var attrName = any.text.nvl(control, "defaultCodeData");
        var $controls = jQuery('[' + attrName + ']');

        if ($controls.length == 0) {
            if (callback != null) {
                callback.apply();
            }
            return;
        }

        var codeDataPaths = {};

        $controls.each(function() {
            var path = jQuery(this).attr(attrName);
            if (path == null || any.text.trim(path) == "") {
                this.setCodeDataObject();
                return true;
            }
            var codeData = any.codedata.container[path];
            if (codeData == null) {
                if (codeDataPaths[path] == null) {
                    codeDataPaths[path] = [];
                }
                codeDataPaths[path].push(this);
            } else {
                resetCodeData(this, codeData, attrName);
            }
        });

        var pathList = [];

        for (var path in codeDataPaths) {
            pathList.push({ path: path, controls: codeDataPaths[path] });
        }

        if (pathList.length == 0) {
            if (callback != null) {
                callback.apply();
            }
            return;
        }

        var prx = any.proxy().output(false);
        prx.url(any.config.codedataLoader);

        for (var i = 0, ii = pathList.length; i < ii; i++) {
            prx.param("ID", i, true);
            prx.param("PATH", pathList[i].path, true);
        }

        prx.on("onSuccess", function() {
            var result = eval("([" + this.result + "])");
            var codeDatas;

            if (result != null && result.length > 0 && (result[0]["_DATA_SET_JSON_"] != null || result[0].model != null)) {
                codeDatas = result[0]["_DATA_SET_JSON_"];
                if (codeDatas == null) {
                    codeDatas = [];
                }
                if (result[0].model != null) {
                    for (var id in result[0].model) {
                        codeDatas.push({ "id": id, "error": result[0].model[id].error });
                    }
                }
            } else {
                codeDatas = result;
            }

            for (var i = 0, ii = codeDatas.length; i < ii; i++) {
                var pathInfo = pathList[parseInt(codeDatas[i].id, 10)];
                any.codedata.container[pathInfo.path] = codeDatas[i];
                for (var j = 0, jj = pathInfo.controls.length; j < jj; j++) {
                    resetCodeData(pathInfo.controls[j], codeDatas[i], attrName);
                }
            }

            if (callback != null) {
                callback.apply();
            }
        });

        prx.on("onError", function() {
            this.error.show();

            for (var i = 0; i < pathList.length; i++) {
                for (var j = 0, jj = pathList[i].controls.length; j < jj; j++) {
                    resetCodeData(pathList[i].controls[j], {});
                }
            }
        });

        prx.execute();
    };

    f.get = function(path, callback)
    {
        var codeData;

        if (path == null || any.text.trim(path) == "") {
            codeData = any.ds("_DS_DEFAULT_CODEDATA_").json();
        } else {
            codeData = any.codedata.container[path];
        }

        if (codeData != null) {
            if (control != null && "setCodeDataObject" in control) {
                control.setCodeDataObject(codeData.data);
            }
            if (callback != null) {
                callback.apply(callback, [codeData]);
            }
            return codeData;
        }

        var prx = any.proxy().output(false);
        prx.url(any.config.codedataLoader);
        prx.param("ID", "0");
        prx.param("PATH", path);

        prx.on("onSuccess", function() {
            var result = eval("(" + this.result + ")");

            if (result != null && (result["_DATA_SET_JSON_"] != null || result.model != null)) {
                if (result["_DATA_SET_JSON_"] != null && result["_DATA_SET_JSON_"].length > 0) {
                    codeData = result["_DATA_SET_JSON_"][0];
                }
                if (result.model != null) {
                    for (var id in result.model) {
                        codeData = { "id": id, "error": result.model[id].error };
                    }
                }
                if (codeData == null) {
                    codeData = {};
                }
            } else {
                codeData = result;
            }

            any.codedata.container[path] = codeData;
            resetCodeData(control, codeData);

            if (callback != null) {
                callback.apply(callback, [codeData]);
            }
        });

        prx.on("onError", function() {
            this.error.show();
        });

        prx.option({ loadingbar: false, async: callback != null });

        prx.execute();

        return codeData;
    };

    f.name = function(path, code)
    {
        var codeData = f.get(path);

        if (codeData == null || codeData.data == null) {
            return "";
        }

        for (var i = 0, ii = codeData.data.length; i < ii; i++) {
            var data = codeData.data[i].data;
            if (data.CODE == code) {
                return data.NAME;
            }
            if (data.code == code) {
                return data.name;
            }
        }

        return "";
    };

    f.append = function(path)
    {
        if (path == null || any.text.trim(path) == "") {
            return;
        }

        if (any.codedata.container[path] != null) {
            return;
        }

        if (o.pathList == null) {
            o.pathList = [];
        }

        if (jQuery.inArray(path, o.pathList) == -1) {
            o.pathList.push(path);
        }

        return f;
    };

    f.load = function(callback)
    {
        if (o.pathList == null || o.pathList.length == 0) {
            return;
        }

        var prx = any.proxy().output(false);
        prx.url(any.config.codedataLoader);

        for (var i = 0, ii = o.pathList.length; i < ii; i++) {
            if (any.codedata.container[o.pathList[i]] != null) {
                continue;
            }
            prx.param("ID", i, true);
            prx.param("PATH", o.pathList[i], true);
        }

        prx.on("onSuccess", function() {
            var result = eval("([" + this.result + "])");
            var codeDatas;

            if (result != null && result.length > 0 && result[0]["_DATA_SET_JSON_"] != null) {
                codeDatas = result[0]["_DATA_SET_JSON_"];
            } else {
                codeDatas = result;
            }

            for (var i = 0, ii = codeDatas.length; i < ii; i++) {
                any.codedata.container[o.pathList[i]] = codeDatas[i];
            }

            o.pathList = null;

            if (callback != null) {
                callback.apply();
            }
        });

        prx.on("onError", function() {
            o.pathList = null;

            this.error.show();
        });

        prx.option({ loadingbar: false, async: callback != null });

        prx.execute();
    };

    return f;

    function resetCodeData(control, codeData, attrName)
    {
        if (codeData.error == null) {
            if (control != null && "setCodeDataObject" in control) {
                control.setCodeDataObject(codeData.data);
            }
        } else {
            any.dialog(true).alert("[CodeData Error] " + (attrName == null ? "codedata[" + codeData.id + "]" : jQuery(control).attr(attrName)) + (codeData.error == "" ? "" : "\n\n" + codeData.error));
            if (control != null && "setCodeDataObject" in control) {
                control.setCodeDataObject([]);
            }
        }

        return codeData;
    }
};

any.control = function(control)
{
    if (any.control.controls == null) {
        any.control.controls = {};
        any.control.util = {};
        any.control.sourceIndex = 0;
    }

    var f = {};

    f.resource = function(src, async)
    {
        if (src == null) {
            return f;
        }

        if (any.control.controls[control.toLowerCase()] == null) {
            any.control.controls[control.toLowerCase()] = {};
        }

        if (src.indexOf(".") == -1) {
            var ctrl = any.control.controls[src.toLowerCase()];
            if (ctrl == null) {
                return f;
            }
            for (var i = 0, ii = ctrl.resource.styles.length; i < ii; i++) {
                f.resource(ctrl.resource.styles[i].src);
            }
            for (var i = 0, ii = ctrl.resource.scripts.length; i < ii; i++) {
                f.resource(ctrl.resource.scripts[i].src, ctrl.resource.scripts[i].async);
            }
        } else {
            var ctrl = any.control.controls[control.toLowerCase()];
            if (ctrl.resource == null) {
                ctrl.resource = { styles: [], scripts: [] };
            }
            if (any.text.endsWith(src, ".css", true) == true || src.toLowerCase().indexOf(".css?") != -1) {
                if (existsSrc(ctrl.resource.styles, src) != true) {
                    ctrl.resource.styles.push({ src: src });
                }
            } else {
                if (existsSrc(ctrl.resource.scripts, src) != true) {
                    ctrl.resource.scripts.push({ src: src, async: async !== false });
                }
                ctrl.behavior = null;
            }
        }

        return f;
    };

    f.plugin = function(nameOrBehavior, srcOrBehavior, async)
    {
        if (nameOrBehavior == null) {
            return f;
        }

        if (typeof(nameOrBehavior) === "function") {
            var behavior = nameOrBehavior;

            if (any.control.controls[control.toLowerCase()] == null) {
                any.control.controls[control.toLowerCase()] = {};
            }

            if (any.control.controls[control.toLowerCase()].plugins == null) {
                any.control.controls[control.toLowerCase()].plugins = [];
            }

            any.control.controls[control.toLowerCase()].plugins.push({ behavior: behavior });
        } else if (typeof(srcOrBehavior) === "function") {
            var name = nameOrBehavior;
            var behavior = srcOrBehavior;

            if (any.control.controls[control.toLowerCase()] == null) {
                any.control.controls[control.toLowerCase()] = {};
            }

            if (any.control.controls[control.toLowerCase()].plugins == null) {
                any.control.controls[control.toLowerCase()].plugins = [];
            }

            any.control.controls[control.toLowerCase()].plugins.push({ name: name, behavior: behavior });
        } else if (srcOrBehavior != null) {
            var name = nameOrBehavior;
            var src = srcOrBehavior;
            var ctrl = any.control.controls[control.toLowerCase()];

            if (ctrl.pluginResources == null) {
                ctrl.pluginResources = {};
            }

            if (ctrl.pluginResources[name.toLowerCase()] == null) {
                ctrl.pluginResources[name.toLowerCase()] = [];
            }

            if (existsSrc(ctrl.pluginResources[name.toLowerCase()], src) != true) {
                ctrl.pluginResources[name.toLowerCase()].push({ src: src, async: async !== false });
            }
        }

        return f;
    };

    f.config = function(key, value)
    {
        var controlName;
        var dataConfig;

        if (typeof(control) === "string") {
            controlName = control;
        } else {
            var $control = jQuery(control);
            controlName = $control.controlName(true);
            dataConfig = $control.data("any-config");
        }

        if (any.control.controls[controlName.toLowerCase()] == null) {
            any.control.controls[controlName.toLowerCase()] = {};
        }

        if (arguments.length < 1) {
            return any.control.controls[controlName.toLowerCase()].config;
        }

        if (any.control.controls[controlName.toLowerCase()].config == null) {
            any.control.controls[controlName.toLowerCase()].config = {};
        }

        if (arguments.length < 2) {
            if (dataConfig != null && key in dataConfig) {
                return dataConfig[key];
            }
            return any.control.controls[controlName.toLowerCase()].config[key];
        }

        any.control.controls[controlName.toLowerCase()].config[key] = value;

        return f;
    };

    f.define = function(behavior)
    {
        if (any.control.controls[control.toLowerCase()] == null) {
            any.control.controls[control.toLowerCase()] = {};
        }

        any.control.controls[control.toLowerCase()].behavior = behavior;

        return f;
    };

    f.inherit = function(name)
    {
        if (any.control.controls[control.toLowerCase()] == null) {
            any.control.controls[control.toLowerCase()] = {};
        }

        var inherit = { name: name.toLowerCase() };

        for (var i = 1, ii = arguments.length; i < ii; i++) {
            if (any.text.startsWith(arguments[i], "function ready", true)) {
                inherit.ready = arguments[i];
            } else if (any.text.startsWith(arguments[i], "function initialize", true)) {
                inherit.init = arguments[i];
            }
        }

        any.control.controls[control.toLowerCase()].inherit = inherit;

        return f;
    };

    f.newIndex = function()
    {
        return any.control.sourceIndex++;
    };

    f.initialize = function(context)
    {
        if (control == null) {
            return getControls(context).control();
        }

        var $control = jQuery(control);

        if ($control.data("any-control-name-current") == $control.controlName()) {
            var $script = $control.next('script[type="text/any-initialize"]');
            if ($script.length == 1) {
                new Function($script[0].text).apply(control);
            }
            if (typeof(window[control.id + "_initialize"]) === "function") {
                window[control.id + "_initialize"].apply(control);
            }
            $control.fire("any-initialize");
        } else {
            var init = $control.data($control.data("any-control-name-current") + "-initialize");
            if (init != null) {
                init.apply(control, [control, $control.data("any-control-name-current")]);
            }
            $control.fire("any-initialize", [$control.data("any-control-name-current")]);
        }

        $control.data("any-initialize.fired", true);
    };

    f.activate = function(name)
    {
        var $control = jQuery(control);

        if (name == null) {
            name = $control.attrControlName();
        }

        if (name == null && control.tagName.toUpperCase() == "BUTTON") {
            name = "any-button";
        }

        if (name == null) {
            return;
        }

        name = name.toLowerCase();

        $control.data("any-control-name-current", name);

        if ($control.data("any-control-name") == null) {
            $control.data("any-control-name", name);
        }

        if ($control.data("any-control-state") == null) {
            $control.data("any-control-state", {});
        }

        if (isScriptLoaded(name) !== true) {
            loadStyle(name);
            loadScript(control, name);
            return;
        }

        var inheritName = (any.control.controls[name] == null || any.control.controls[name].inherit == null ? null : any.control.controls[name].inherit.name);

        if (inheritName != null && $control.data("any-control-state")[inheritName] != "activated") {
            if ($control.data("any-control-queuenames") == null) {
                $control.data("any-control-queuenames", []);
            }
            $control.data("any-control-queuenames").splice(0, 0, name);
            if (any.control.controls[name].inherit.ready != null) {
                any.control.controls[name].inherit.ready.apply(control);
            }
            $control.data(inheritName + "-initialize", any.control.controls[name].inherit.init);
            any.control(control).activate(inheritName);
            return;
        }

        if ($control.data("any-control-state")[name] == "activated") {
            return;
        }

        $control.data("any-control-state")[name] = "activated";

        if (any.control.controls[name].plugins != null) {
            for (var i = 0, ii = any.control.controls[name].plugins.length; i < ii; i++) {
                var plugin = any.control.controls[name].plugins[i];
                if (plugin.name == null || jQuery.inArray(plugin.name, $control.data("any-control-plugin-names")) != -1) {
                    plugin.behavior.apply(control, [control, name]);
                }
            }
        }

        if (any.control.controls[name].behavior != null) {
            var dataConfig = $control.data("any-config");
            if (dataConfig != null && typeof(dataConfig) === "string") {
                $control.data("any-config", eval("(" + dataConfig + ")"));
            }
            any.control.controls[name].behavior.apply(control, [control, name]);
        }

        $control.removeData("any-control-name-current");

        var queueNames = $control.data("any-control-queuenames");

        if (queueNames == null) {
            $control.data("any-control-state")["[=ANY=]"] = "activated";
        } else {
            var queueName = queueNames[0];
            queueNames.splice(0, 1);
            if (queueNames.length == 0) {
                $control.removeData("any-control-queuenames");
            }
            $control.data("any-control-name-queue", queueName);
            any.control(control).activate(queueName);
        }
    };

    f.checkActivated = function(context)
    {
        var $controls = getControls(context).control();

        for (var i = 0, ii = $controls.length; i < ii; i++) {
            var state = $controls.eq(i).data("any-control-state");
            if (state != null && state["[=ANY=]"] != "activated") {
                return false;
            }
        }

        return true;
    };

    f.checkReady = function(context)
    {
        var $controls = getControls(context);

        for (var i = 0, ii = $controls.length; i < ii; i++) {
            if ($controls[i].isReady === false) {
                return false;
            }
        }

        return true;
    };

    return f;

    function existsSrc(arr, src)
    {
        var exists;

        for (var i = 0, ii = arr.length; i < ii; i++) {
            if (arr[i].src == src) {
                return true;
            }
        }

        return false;
    }

    function getControls(context)
    {
        var query = [];

        for (var item in any.control.controls) {
            query.push('[' + item + '=""]');
        }

        return jQuery(query.join(","), context);
    }

    function isScriptLoaded(name)
    {
        if (any.control.controls == null) {
            return true;
        }
        if (any.control.controls[name] == null) {
            return true;
        }
        if (any.control.controls[name].resource == null) {
            return true;
        }

        var scripts = any.control.controls[name].resource.scripts;

        if (scripts == null) {
            return true;
        }

        for (var i = 0, ii = scripts.length; i < ii; i++) {
            if (any.control.queues == null || any.control.queues.scripts[scripts[i].src] !== true) {
                return false;
            }
        }

        return true;
    }

    function loadStyle(name)
    {
        if (any.control.controls[name].resource == null) {
            return;
        }

        var styles = any.control.controls[name].resource.styles;

        if (styles == null) {
            return;
        }

        if (any.control.queues == null) {
            any.control.queues = { controls: {}, names: {}, styles: {}, scripts: {} };
        }

        for (var i = 0, ii = styles.length; i < ii; i++) {
            if (any.control.queues.styles[styles[i].src] != null) {
                continue;
            }
            any.control.queues.styles[styles[i].src] = true;
            any.loadStyle(styles[i].src);
        }
    }

    function loadScript(control, name, force)
    {
        if (any.control.controls[name].resource == null) {
            return;
        }

        var scripts = any.control.controls[name].resource.scripts;

        if (scripts == null) {
            return;
        }

        if (any.control.queues == null) {
            any.control.queues = { controls: {}, names: {}, styles: {}, scripts: {} };
        }

        if (any.control.queues.controls[name] == null) {
            any.control.queues.controls[name] = [];
        }

        var controls = any.control.queues.controls[name];

        if (control != null) {
            controls.push(control);
        }

        if (isScriptLoaded(name) === true) {
            for (var i = 0, ii = controls.length; i < ii; i++) {
                var controlState = jQuery(controls[i]).data("any-control-state");
                if (controlState != null && controlState[name] != "activate-started" && controlState[name] != "activated") {
                    controlState[name] = "activate-started";
                    any.control(controls[i]).activate(name);
                }
            }
            return;
        }

        if (force != true && control == null) {
            return;
        }

        for (var i = 0, ii = scripts.length; i < ii; i++) {
            if (any.control.queues.scripts[scripts[i].src] == false) {
                any.control.queues.names[name] = [null, name, true];
                if (scripts[i].async != true) {
                    break;
                }
            }

            if (any.control.queues.scripts[scripts[i].src] != null) {
                continue;
            }

            any.control.queues.scripts[scripts[i].src] = false;

            (function(script) {
                any.loadScript(script.src, function() {
                    any.control.queues.scripts[script.src] = true;
                    loadScript(null, name, script.async != true);
                    for (var item in any.control.queues.names) {
                        loadScript.apply(loadScript, any.control.queues.names[item]);
                    }
                });
            })(scripts[i]);

            if (scripts[i].async != true) {
                break;
            }
        }
    }
};

any.file = function(scope)
{
    var f = {};
    var o = { $f: jQuery(f), datas: [], params: [], events: {} };

    f.url = function(url)
    {
        if (arguments.length == 0) {
            return any.url(o.url);
        }

        o.url = url;

        return f;
    };

    f.header = function(name, value)
    {
        if (name == "") {
            return;
        }

        if (arguments.length == 0) {
            return;
        }

        if (arguments.length == 1) {
            return o.headers == null ? null : o.headers[name];
        }

        if (o.headers == null) {
            o.headers = {};
        }

        o.headers[name] = value;

        return f;
    };

    f.param = function(name, value, multi)
    {
        if (name == "") {
            return;
        }

        if (arguments.length == 0) {
            return;
        }

        if (o.params == null) {
            o.params = [];
        }

        if (arguments.length == 1) {
            return any.param(o.params).get(name);
        }

        any.param(o.params).set(name, value, multi);

        return f;
    };

    f.params = function(params, multi)
    {
        for (var i = 0; i < params.length; i++) {
            f.param(params[i].name, params[i].value, multi);
        }

        return f;
    };

    f.data = function(ds, id)
    {
        if (arguments.length == 0) {
            return o.datas;
        }

        if (ds == null) {
            return f;
        }

        if (typeof(ds) === "object") {
            if (ds.id == null) {
                return f;
            }
        } else {
            if (any.ds(null, scope).exists(ds) != true) {
                return f;
            }
            ds = any.ds(ds, scope);
        }

        for (var i = 0, ii = o.datas.length; i < ii; i++) {
            if (o.datas[i].ds == ds && o.datas[i].id == id) {
                return f;
            }
        }

        o.datas.push({ ds: ds, id: id });

        return f;
    };

    f.on = f.event = function(name, func)
    {
        o.events[name] = func;

        o.$f.on(name, function(event, data) {
            func.apply(f, [data]);
        });

        return f;
    };

    f.upload = function(form, control)
    {
        if (any.config["/anyworks/file/session-continuous-proxy"] == true) {
            any.proxy().url(o.url).on("onSuccess", function() {
                upload(form, control);
            }).on("onError", function() {
                this.error.show();
            }).option("loadingbar", false).execute();
        } else {
            upload(form, control);
        }

        return f;
    };

    function upload(form, control)
    {
        if (form != null && form.method != null && (form.enctype != null || form.encoding != null)) {
            uploadForm(form, control);
        } else {
            uploadAjax(form, control);
        }
    }

    function uploadForm(form, control)
    {
        if (o.url == null) {
            return f;
        }

        var $form = jQuery(form);
        var $ifr = getFrame("UPLOAD");
        var attrs = { "method": $form.attr("method"), "enctype": $form.attr("enctype") };
        var rootWin = any.rootWindow();

        $form.attr({ "method": "POST", "enctype": "multipart/form-data" });

        var $hiddenArea = $form.data("$upload-hidden-params-area");

        if ($hiddenArea == null) {
            $form.data("$upload-hidden-params-area", $hiddenArea = jQuery('<div>').appendTo($form));
        }

        $hiddenArea.empty();

        if (any.text.isEmpty(rootWin.any.meta.servletToken) != true) {
            $hiddenArea.append(jQuery('<input>').attr({ type: "hidden", name: any.config["/anyworks/servlet-token-check/param-name"], value: rootWin.any.meta.servletToken }));
        }

        for (var i = 0, ii = o.params.length; i < ii; i++) {
            $hiddenArea.append(jQuery('<input>').attr({ type: "hidden", name: o.params[i].name, value: o.params[i].value }));
        }

        for (var i = 0, ii = o.datas.length; i < ii; i++) {
            $hiddenArea.append(jQuery('<input>').attr({ type: "hidden", name: o.datas[i].id, value: o.datas[i].ds.jsonString(o.datas[i].id) }));
        }

        $form.attr({ "target": $ifr.attr("name"), "action": f.url() });

        if (control == null) {
            control = $form.data("any-file-control");
        }

        if (control != null) {
            jQuery(control).on("onUploadSuccess", function() {
                for (var name in attrs) {
                    if (attrs[name] == null) {
                        $form.removeAttr(name);
                    } else {
                        $form.attr(name, attrs[name]);
                    }
                }
            });
        }

        $ifr.on("onInvalidSessionError", function() {
            any.error({ error: true, type: "session" }).show(function() {
                $form.submit();
            });
        });

        $form.submit();

        return f;
    }

    function uploadAjax(files, control)
    {
        if (files == null || files.length == 0) {
            o.$f.fire("onUploadSuccess");
            return;
        }

        var options = {
            url: f.url(),
            method: "POST",
            headers: o.headers,
            processData: false,
            contentType: false
        };

        var rootWin = any.rootWindow();

        if (any.text.isEmpty(rootWin.any.meta.servletToken) != true) {
            if (options.headers == null) {
                options.headers = {};
            }
            options.headers["X-AnyWorks-Servlet-Token"] = rootWin.any.meta.servletToken;
        }

        options.data = function()
        {
            var formData = new FormData();

            for (var i = 0, ii = files.length; i < ii; i++) {
                formData.append("file[]", files[i]);
            }

            for (var i = 0, ii = o.params.length; i < ii; i++) {
                formData.append(o.params[i].name, o.params[i].value);
            }

            for (var i = 0, ii = o.datas.length; i < ii; i++) {
                formData.append(o.datas[i].id, o.datas[i].ds.jsonString(o.datas[i].id));
            }

            return formData;
        }();

        options.success = function(data, textStatus, jqXHR)
        {
            var error = any.error().parse(jqXHR, null, "\n\n" + f.url());

            if (error.error != true) {
                var result = eval("([" + any.text.trim(jqXHR.responseText) + "])");
                var jsons;
                if (result != null && result.length > 0 && result[0]["_DATA_SET_JSON_"] != null) {
                    jsons = result[0]["_DATA_SET_JSON_"][0];
                } else if (any.text.isEmpty(jqXHR.responseText) != true) {
                    jsons = eval("(" + any.text.trim(jqXHR.responseText) + ")");
                }
                o.$f.fire("onUploadSuccess", [jsons]);
            } else {
                o.$f.fire("onActionFailure", [error]);
            }
        };

        options.error = function(jqXHR, textStatus, errorThrown)
        {
            o.$f.fire("onActionFailure", [any.error().parse(jqXHR, errorThrown, "\n\n" + f.url())]);
        };

        jQuery.ajax(options);
    }

    f.download = function()
    {
        if (any.config["/anyworks/file/session-continuous-proxy"] == true) {
            any.proxy().url(o.url).on("onSuccess", function() {
                download();
            }).on("onError", function() {
                this.error.show();
            }).option("loadingbar", false).execute();
        } else {
            download();
        }

        return f;
    };

    function download()
    {
        var rootWin = any.rootWindow();
        var method = (o.datas.length > 0 ? "POST" : "GET");
        var $form = jQuery('<form>').attr({ "method": method }).appendTo(document.body);
        var $ifr = getFrame("DOWNLOAD");

        if (method == "POST" && any.text.isEmpty(rootWin.any.meta.servletToken) != true) {
            $form.append(jQuery('<input>').attr({ type: "hidden", name: any.config["/anyworks/servlet-token-check/param-name"], value: rootWin.any.meta.servletToken }));
        }

        for (var i = 0, ii = o.params.length; i < ii; i++) {
            $form.append(jQuery('<input>').attr({ type: "hidden", name: o.params[i].name, value: o.params[i].value }));
        }

        if (o.datas.length > 0) {
            var jsons = [];

            for (var i = 0, ii = o.datas.length; i < ii; i++) {
                jsons.push(o.datas[i].ds.jsonString(o.datas[i].id));
            }

            $form.append(jQuery('<input>').attr({ type: "hidden", name: "_DATA_SET_JSON_", value: '[' + jsons.join(",") + ']' }));
        }

        $form.attr({ "target": $ifr.attr("name"), "action": f.url() });

        $ifr.on("onInvalidSessionError", function() {
            any.error({ error: true, type: "session" }).show(function() {
                $form.submit();
            });
        });

        $form.submit();

        return f;
    }

    return f;

    function getFrame(type)
    {
        var ifr_name = "__IFR_FILE_" + type + "_" + any.control().newIndex() + "__";
        var $iframe = jQuery('iframe[name="' + ifr_name + '"]');

        if ($iframe.length > 0) {
            $iframe.remove();
        }

        $iframe = jQuery('<iframe name="' + ifr_name + '">').hide().appendTo(document.body);

        $iframe[0].onActionFailure = function(error)
        {
            $iframe.remove();

            any.error(error).show();

            o.$f.fire("onError");
        };

        for (var item in o.events) {
            $iframe[0][item] = o.events[item];
        }

        return $iframe;
    }
};

any.progress = function(obj)
{
    var f = {};
    var o = { keyName: "_SERVICE_PROGRESS_KEY_", interval: 1000 };

    function init()
    {
        o.count = 0;

        o.proxy = any.proxy().url(f.config("proxy.url"));

        o.proxy.param(o.keyName, o.keyValue = function()
        {
            var seeds = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var values = new Array();

            for (var i = 0; i < 8; i++) {
                values.push(seeds.substr(Math.floor(Math.random() * seeds.length), 1));
            }

            if (any.progress.keyIndex == null) {
                any.progress.keyIndex = 0;
            }

            return "KEY" + values.join("") + any.date().timestamp() + (any.progress.keyIndex++);
        }());

        o.proxy.onSuccess = function()
        {
            o.count++;

            var data = null;

            if (this.response != null && typeof(this.response.data) === "object") {
                data = this.response.data;
            } else if (this.result != null && this.result != "") {
                data = eval("(" + this.result + ")");
            }

            if (o.callback != null) {
                o.callback.apply(f, [data]);
            }

            if (data == null || data.completed == true || (data.startTime == 0 && o.count >= 5)) {
                f.stop();
            }

            if (o.interval != null && o.stopped != true) {
                window.setTimeout(o.proxy.execute, o.interval);
            }
        };

        o.proxy.onError = function()
        {
            this.error.show();
        };

        if (obj == null) {
            return;
        }

        if (typeof(obj) === "string") {
            obj += ((obj.indexOf("?") == -1 ? "?" : "&") + o.keyName + "=" + o.keyValue);
        } else if ("action" in obj) {
            jQuery('<input>').attr({ type: "hidden", name: o.keyName }).val(o.keyValue).appendTo(obj);
        } else if ("param" in obj) {
            obj.param(o.keyName, o.keyValue);
        } else if ("push" in obj) {
            obj.push(o.keyName + "=" + o.keyValue);
        }

        jQuery(obj).on("onError", function() {
            f.stop();
        });
    }

    f.config = function(name, value)
    {
        if (any.progress["config-data"] == null) {
            any.progress["config-data"] = {};
        }

        if (arguments.length < 2) {
            return any.progress["config-data"][name];
        }

        any.progress["config-data"][name] = value;

        return f;
    };

    f.keyName = function()
    {
        return o.keyName;
    };

    f.keyValue = function()
    {
        return o.keyValue;
    };

    f.proxy = function()
    {
        return o.proxy;
    };

    f.interval = function(interval)
    {
        if (arguments.length < 1) {
            return o.interval;
        }

        o.interval = interval;

        return f;
    };

    f.callback = function(callback)
    {
        if (arguments.length < 1) {
            return o.callback;
        }

        o.callback = callback;

        return f;
    };

    f.count = function()
    {
        return o.count;
    };

    f.on = function(name, func)
    {
        if (o.$f == null) {
            o.$f = jQuery(f);
        }

        o.$f.on(name, func);

        return f;
    };

    f.start = function()
    {
        delete(o.stopped);

        if (o.$f != null) {
            o.$f.fire("onStart");
        }

        if (o.proxy.url() != null) {
            o.proxy.option({ loadingbar: false }).execute();
        } else if (o.callback != null) {
            o.callback.apply(f);
        }

        return f;
    };

    f.stop = function()
    {
        if (o.stopped == true) {
            return f;
        }

        o.stopped = true;

        if (o.$f != null) {
            o.$f.fire("onStop");
        }

        return f;
    };

    init();

    return f;
};

any.search = function(obj)
{
    var f = {};
    var o = {};

    if (obj == null) {
        f.prx = any.proxy();
        f.win = any.window();
    } else {
        f.prx = any.object.nvl(obj.prx, any.proxy());
        f.win = any.object.nvl(obj.win, any.window());
    }

    if (any.search.proxyDsIndex == null) {
        any.search.proxyDsIndex = 0;
    }

    f.ds = function(ds)
    {
        if (arguments.length < 1) {
            if (o.ds == null) {
                o.ds = any.ds("ds_any.search.proxyDs_" + (any.search.proxyDsIndex++));
            }

            return o.ds;
        }

        o.ds = ds;

        return f;
    };

    f.ok = function(callback)
    {
        if (arguments.length < 1) {
            return o.callback;
        }

        o.callback = callback;

        return this;
    };

    f.param = function()
    {
        f.prx.param.apply(f.prx, arguments);
        f.win.param.apply(f.win, arguments);

        return f;
    };

    f.paramArg = function()
    {
        f.prx.param.apply(f.prx, arguments);
        f.win.arg.apply(f.win, arguments);

        return f;
    };

    f.paramArg2 = function()
    {
        f.prx.param.apply(f.prx, arguments);
        f.win.param.apply(f.win, arguments);
        f.win.arg.apply(f.win, arguments);

        return f;
    };

    f.windowMode = function(windowMode)
    {
        if (arguments.length < 1) {
            return o.windowMode;
        }

        o.windowMode = windowMode;

        return f;
    };

    f.search = function()
    {
        if (o.windowMode === true) {
            searchWindow();
        } else {
            searchProxy();
        }

        function searchProxy()
        {
            if (f.prx.url() == null) {
                searchWindow();
                return;
            }

            f.prx.param(any.pagingParameterName("recordCountPerPage"), 2);
            f.prx.param(any.pagingParameterName("currentPageNo"), 1);
            f.prx.param("_DS_ID_", f.ds().id);
            f.prx.output(o.ds);

            f.prx.onSuccess = function()
            {
                if (o.ds.rowCount() == 0) {
                    if (o.callback != null) {
                        o.callback();
                    }
                } else if (o.ds.rowCount() == 1) {
                    if (o.callback != null) {
                        o.callback(o.ds.rowData(0), true);
                    }
                } else {
                    searchWindow();
                }

                o.ds.destroy();
            };

            f.prx.onError = function()
            {
                this.error.show();
            };

            f.prx.execute();
        }

        function searchWindow()
        {
            if (f.win.url() == null) {
                return;
            }

            f.win.ok(o.callback);
            f.win.show();
        }
    };

    return f;
};

any.ds = function(id, scope)
{
    var f = {};

    f.exists = function(id)
    {
        return any.ds.container != null && any.ds.container[scope] != null && any.ds.container[scope][id] != null;
    };

    f.isChanged = function(includeIds, excludeIds)
    {
        if (includeIds == null) {
            jQuery('[bind^="ds_"]').each(function() {
                var attr = jQuery(this).attr("bind");
                var dsId = (attr.indexOf(":") == -1 ? attr : attr.substr(0, attr.indexOf(":")));
                if (any.ds().exists(dsId) != true) {
                    any.ds(dsId);
                }
            });
        } else {
            for (var i = 0, ii = includeIds.length; i < ii; i++) {
                if (any.ds().exists(includeIds[i]) != true) {
                    any.ds(includeIds[i]);
                }
            }
        }

        if (any.ds.container == null) {
            return false;
        }
        if (any.ds.container[scope] == null) {
            return false;
        }

        for (var id in any.ds.container[scope]) {
            var exclude = false;
            if (excludeIds != null) {
                for (var i = 0, ii = excludeIds.length; i < ii; i++) {
                    if (id == excludeIds[i]) {
                        exclude = true;
                        break;
                    }
                }
            }
            if (exclude != true) {
                if (any.ds(id).isChanged() == true) {
                    return true;
                }
            }
        }

        return false;
    };

    f.isValidJSON = function(obj)
    {
        return typeof(obj) === "object" && jQuery.type(obj.header) === "array" && jQuery.type(obj.data) === "array";
    };

    scope = parseScope(scope);

    if (id == null || id == "") {
        return f;
    }

    if (any.ds.container == null) {
        any.ds.container = {};
    }

    if (any.ds.container[scope] == null) {
        any.ds.container[scope] = {};
    }

    if (id === true) {
        if (any.ds.datasetIdIndex == null) {
            any.ds.datasetIdIndex = 0;
        }
        var dsId = "=ANY-DATASET#" + (any.ds.datasetIdIndex++) + "=";
        any.ds.container[scope][dsId] = new dataset(dsId).init();
        return any.ds.container[scope][dsId];
    }

    if (any.ds.container[scope][id] == null) {
        any.ds.container[scope][id] = new dataset(id).init();
    }

    return any.ds.container[scope][id];

    function parseScope(scope)
    {
        if (typeof(scope) !== "object") {
            return scope;
        }

        if ("id" in scope) {
            return scope.id;
        }

        if ("name" in scope) {
            return scope.name;
        }

        try {
            return JSON.stringify(scope);
        } catch(e) {
            return scope;
        }
    }

    function dataset(id)
    {
        var o = { self: this };

        this.id = id;
        this.disabled = false;

        this.scope = function(scope)
        {
            scope = parseScope(scope);

            if (arguments.length < 1) {
                for (var item in any.ds.container) {
                    if (any.ds.container[item][this.id] === this) {
                        return item;
                    }
                }
                return null;
            }

            for (var item in any.ds.container) {
                if (any.ds.container[item][this.id] === this) {
                    delete(any.ds.container[item][this.id]);
                }
            }

            if (any.ds.container[scope] == null) {
                any.ds.container[scope] = {};
            }

            any.ds.container[scope][this.id] = this;

            return this;
        };

        this.init = function()
        {
            o.json = { header: [], data: [] };
            o.keys = null;
            o.originalJSON = null;

            return this;
        };

        this.useNull = function(useNull)
        {
            if (arguments.length < 1) {
                return o.useNull === true;
            }

            o.useNull = useNull;

            return this;
        };

        this.dataOnly = function(dataOnly)
        {
            if (arguments.length < 1) {
                return o.dataOnly === true;
            }

            o.dataOnly = dataOnly;

            return this;
        };

        this.dataLoader = function(dataLoader)
        {
            if (arguments.length < 1) {
                return o.dataLoader;
            }

            o.dataLoader = dataLoader;
        };

        this.listData = function(isListData)
        {
            if (arguments.length < 1) {
                return o.isListData === true;
            }

            o.isListData = isListData;

            return this;
        };

        this.isEmpty = function()
        {
            return o.json.header.length == 0 && o.json.data.length == 0;
        };

        this.parse = function(json, stringify)
        {
            if (stringify === true && typeof(json) === "object") {
                this.json(getJsonString(json));
            } else {
                this.json(json);
            }

            o.originalJSON = any.object.clone(o.json);

            return this;
        };

        this.load = function(json, stringify)
        {
            this.parse(json, stringify);

            jQuery(this).fire("onLoad");

            return this;
        };

        this.loadData = function(data, withJobType, metaMap)
        {
            this.init();

            if (metaMap != null) {
                for (var name in metaMap) {
                    this.meta(name, metaMap[name]);
                }
            }

            o.forJsonValue = true;

            for (var i = 0, ii = data.length; i < ii; i++) {
                var row = this.addRow();
                for (var item in data[i]) {
                    this.value(row, item, data[i][item]);
                    if (withJobType === true) {
                        this.jobType(row, data[i]["_JOB_TYPE"]);
                    }
                }
            }

            executeDatasetToControlBind();

            delete(o.forJsonValue);

            jQuery(this).fire("onLoad");

            return this;
        };

        this.clearData = function(addDefaultRow)
        {
            o.json.data = [];

            if (addDefaultRow == true) {
                this.addRow();
            }

            executeDatasetToControlBind();

            return this;
        };

        this.addColumn = function(colId)
        {
            if (this.colIndex(colId) != -1) {
                return this;
            }

            o.json.header.push({ id: colId });

            return this;
        };

        this.addRow = function(data)
        {
            return this.insertRow(o.json.data.length, data);
        };

        this.insertRow = function(row, data)
        {
            o.json.data.splice(row, 0, { jobType: "C", data: {} });

            if (data != null) {
                this.rowData(row, data);
            }

            return row;
        };

        this.eraseRow = function(row)
        {
            for (var i = 0, ii = this.colCount(); i < ii; i++) {
                this.value(row, i, null);
            }
        };

        this.deleteAll = function(erase)
        {
            for (var i = this.rowCount(); i >= 0; i--) {
                if (erase == true) {
                    this.eraseRow(i);
                }
                this.deleteRow(i);
            }

            return this;
        };

        this.deleteRow = function(row)
        {
            if (row == -1) {
                return;
            }

            var jobType = o.self.jobType(row);

            if (jobType == "C") {
                o.json.data.splice(row, 1);
                return true;
            }

            if (jobType != "D" && o.json.data[row] != null) {
                o.json.data[row].orgJobType = jobType;
                o.self.jobType(row, "D");
            }

            return false;
        };

        this.restoreRow = function(row)
        {
            o.self.jobType(row, o.json.data[row].orgJobType);
        };

        this.moveRow = function(oldRow, newRow)
        {
            if (oldRow == newRow) {
                return newRow;
            }

            var data = o.json.data.splice(oldRow, 1)[0];

            if (data == null) {
                data = { jobType: "C", data: {} };
            }

            o.json.data.splice(newRow, 0, data);

            return newRow;
        };

        this.colCount = function()
        {
            return o.json.header.length;
        };

        this.rowCount = function(withoutDeletedRow)
        {
            if (this.disabled == true) {
                return -1;
            }

            if (withoutDeletedRow != true) {
                return o.json.data.length;
            }

            var rowCount = 0;

            for (var i = 0, ii = o.json.data.length; i < ii; i++) {
                if (this.jobType(i) != "D") {
                    rowCount++;
                }
            }

            return rowCount;
        };

        this.colId = function(colIndex)
        {
            if (colIndex == null) {
                return null;
            }
            if (colIndex < 0) {
                return null;
            }
            if (colIndex >= this.colCount()) {
                return null;
            }

            return o.json.header[colIndex].id;
        };

        this.colIndex = function(colId)
        {
            for (var c = 0; c < o.json.header.length; c++) {
                if (o.json.header[c].id == colId) {
                    return c;
                }
            }

            return -1;
        };

        this.meta = function(name, value)
        {
            if (o.json.meta == null) {
                o.json.meta = {};
            }

            if (arguments.length < 1) {
                return o.json.meta;
            }

            if (arguments.length < 2) {
                return o.json.meta[name];
            }

            o.json.meta[name] = value;

            return this;
        };

        this.colValues = function(col)
        {
            var colId;

            if (typeof(col) === "string") {
                colId = col;
            } else {
                colId = this.colId(col);
            }

            var values = [];

            for (var i = 0, ii = this.rowCount(); i < ii; i++) {
                values.push(this.rowData(i)[colId]);
            }

            return values;
        };

        this.value = function(row, col, val)
        {
            if (row == null || col == null) {
                return;
            }

            var colId;

            if (typeof(col) === "string") {
                colId = col;
            } else {
                colId = this.colId(col);
            }

            if (arguments.length < 3) {
                if (colId == null) {
                    return null;
                }

                jQuery(this).fire("onBeforeSend");

                bindControlToDataset(getControlIndex(row), colId);

                if (o.json.data[row] == null) {
                    return null;
                }

                val = o.json.data[row].data[colId];

                if (val == null && o.useNull !== true) {
                    return "";
                }

                return val;
            }

            if (colId == null) {
                return;
            }

            o.self.addColumn(colId);

            if (row == 0 && o.self.rowCount() == 0) {
                o.self.addRow();
            }

            if (o.json.data[row] == null) {
                return;
            }

            o.json.data[row].data[colId] = val;

            if (o.self.jobType(row) == "") {
                o.self.jobType(row, "U");
            }

            if (o.forJsonValue != true) {
                bindDatasetToControl(row, colId);
            }

            return this;
        };

        this.valueRow = function(obj)
        {
            jQuery(this).fire("onBeforeSend");

            for (var i = 0, ii = this.rowCount(); i < ii; i++) {
                if (function(row) {
                    for (var key in obj) {
                        var val = o.self.rowData(row)[key];
                        if (val == null || val != obj[key]) {
                            return false;
                        }
                    }
                    return true;
                }(i) == true) return i;
            }

            return -1;
        };

        this.dataRow = function(rowData)
        {
            for (var i = 0, ii = o.json.data.length; i < ii; i++) {
                if (o.json.data[i] == rowData || o.json.data[i].data == rowData) {
                    return i;
                }
            }

            return -1;
        };

        this.rowDataWithBind = function(row)
        {
            bindControlToDataset(row);

            return o.json.data[row].data;
        };

        this.rowData = function(row, obj, update)
        {
            if (arguments.length < 2) {
                return o.json.data[row].data;
            }

            if (update != true) {
                for (var i = 0, ii = o.self.colCount(); i < ii; i++) {
                    o.self.value(row, o.self.colId(i), null);
                }
            }

            if (row == 0 && o.self.rowCount() == 0) {
                o.self.addRow();
            }

            if (update != true) {
                o.json.data[row].data = {};
            }

            if (obj == null) {
                return this;
            }

            for (var item in obj) {
                o.json.data[row].data[item] = obj[item];
            }

            for (var item in obj) {
                o.self.value(row, item, obj[item]);
            }

            return this;
        };

        this.fromControl = function()
        {
            jQuery(this).fire("onBeforeSend");

            executeControlToDatasetBind();

            return this;
        };

        this.jobType = function(row, val)
        {
            if (row == -1) {
                return;
            }

            if (arguments.length >= 2) {
                o.json.data[row].jobType = val;
                return this;
            }

            if (typeof(row) === "number") {
                return any.text.nvl(o.json.data[row] == null ? null : o.json.data[row].jobType, "");
            }

            for (var i = 0, ii = o.json.data.length; i < ii; i++) {
                o.json.data[i].jobType = row;
            }

            return this;
        };

        this.clearJobType = function()
        {
            for (var r = 0, rr = o.json.data.length; r < rr; r++) {
                if (o.json.data[r].jobType == "D") {
                    o.json.data[r].isDeleted = true;
                } else {
                    o.json.data[r].jobType = null;
                }
            }

            return this;
        };

        this.resetJobType = function(jobType)
        {
            if (arguments.length >= 1) {
                for (var i = 0, ii = o.json.data.length; i < ii; i++) {
                    o.json.data[i].jobType = jobType;
                }
                return this;
            }

            for (var r = o.json.data.length - 1; r >= 0; r--) {
                if (o.json.data[r].jobType == "C") {
                    this.deleteRow(r);
                } else {
                    o.json.data[r].jobType = null;
                }
            }

            return this;
        };

        this.json = function(json)
        {
            if (arguments.length < 1) {
                executeControlToDatasetBind();
                return o.json;
            }

            if (json == null || json === "") {
                json = { header: [], data: [] };
            }

            if (typeof(json) === "string") {
                o.json = eval("(" + json + ")");
            } else {
                o.json = json;
            }

            executeDatasetToControlBind();

            return this;
        };

        this.jsonString = function(datasetId)
        {
            if (this.disabled == true) {
                return null;
            }

            jQuery(this).fire("onBeforeSend");

            executeControlToDatasetBind();

            return this.jsonStringWithoutBind(datasetId);
        };

        this.jsonStringWithoutBind = function(datasetId)
        {
            if (this.disabled == true) {
                return null;
            }

            return getJsonString(o.json, datasetId == null ? this.id : datasetId);
        };

        this.toJSON = function()
        {
            if (this.disabled == true) {
                return null;
            }

            if (this.listData() === true) {
                return this.toList();
            }

            return this.toData();
        };

        this.toData = function()
        {
            if (this.disabled == true) {
                return null;
            }

            jQuery(this).fire("onBeforeSend");

            o.forJsonValue = true;

            executeControlToDatasetBind();

            delete(o.forJsonValue);

            var json = (this.rowCount() == 0 ? {} : this.rowData(0));

            json["_JOB_TYPE"] = this.jobType(0);

            for (name in json) {
                if (json[name] === "") {
                    json[name] = null;
                }
            }

            return json;
        };

        this.toList = function()
        {
            if (this.disabled == true) {
                return null;
            }

            jQuery(this).fire("onBeforeSend");

            o.forJsonValue = true;

            executeControlToDatasetBind();

            delete(o.forJsonValue);

            var json = [];

            for (var i = 0, ii = this.rowCount(); i < ii; i++) {
                var rowData = this.rowData(i);

                rowData["_JOB_TYPE"] = this.jobType(i);

                for (name in rowData) {
                    if (rowData[name] === "") {
                        rowData[name] = null;
                    }
                }

                json.push(rowData);
            }

            return json;
        };

        this.setKeys = function()
        {
            o.keys = Array.prototype.slice.call(arguments);
        };

        this.setBinder = function(datasetToControl, controlToDataset)
        {
            o.binder = { datasetToControl: datasetToControl, controlToDataset: controlToDataset };
        };

        this.resetControlValues = function()
        {
            executeDatasetToControlBind();
        };

        this.saveDefault = function()
        {
            o.defaultJSON = any.object.clone(o.self.json());
        };

        this.loadDefault = function()
        {
            this.load(any.object.clone(o.defaultJSON));
        };

        this.hierarchy = function(keyColId, parentColId, levelColId)
        {
            for (var r = 0, rr = o.json.data.length; r < rr; r++) {
                var newRow = getNewRow(r);
                if (newRow != -1) {
                    this.moveRow(r, newRow);
                }
            }

            function getNewRow(row)
            {
                var parentRow = -1;
                var newRow = -1;

                for (var r = 0, rr = o.json.data.length; r < rr; r++) {
                    if (o.json.data[r].data[keyColId] == o.json.data[row].data[parentColId]) {
                        parentRow = r;
                        break;
                    }
                }

                if (parentRow == -1) {
                    return -1;
                }

                o.json.data[parentRow].hasChild = true;

                for (var r = parentRow + 1, rr = o.json.data.length; r < rr; r++) {
                    if (Number(o.json.data[r].data[levelColId]) < Number(o.json.data[row].data[levelColId])) {
                        newRow = r;
                        break;
                    }
                }

                return newRow;
            }
        };

        this.hasChild = function(row)
        {
            if (row != -1) {
                return o.json.data[row].hasChild === true;
            }
        };

        this.isChanged = function()
        {
            executeControlToDatasetBind();

            if (o.originalJSON == null || o.originalJSON.header == null || o.originalJSON.data == null) {
                for (var i = 0, ii = o.json.data.length; i < ii; i++) {
                    var data = o.json.data[i].data;
                    for (var id in data) {
                        if (data[id] != null && data[id] != "") {
                            return true;
                        }
                    }
                }
                return false;
            }

            if (o.originalJSON.header.length > o.json.header.length) {
                return true;
            }
            if (o.originalJSON.data.length != o.json.data.length) {
                return true;
            }

            for (var i = 0, ii = o.originalJSON.header.length; i < ii; i++) {
                if (o.originalJSON.header[i].id != o.json.header[i].id) {
                    return true;
                }
            }

            for (var i = 0, ii = o.originalJSON.data.length; i < ii; i++) {
                if (o.json.data[i].jobType == "D") {
                    return true;
                }
                var data1 = o.originalJSON.data[i].data;
                var data2 = o.json.data[i].data;
                for (var id in data1) {
                    var val1 = (data1[id] == null && o.useNull !== true ? "" : data1[id]);
                    var val2 = (data2[id] == null && o.useNull !== true ? "" : data2[id]);
                    if (val1 != val2) {
                        return true;
                    }
                }
            }

            return false;
        };

        this.destroy = function()
        {
            delete(any.ds.container[scope][id]);
        };

        function getControlIndex(dsRow)
        {
            if (o.keys == null) {
                return dsRow;
            }

            if (o.rowIndexMap != null && o.rowIndexMap.controlIndex[dsRow] != null) {
                return o.rowIndexMap.controlIndex[dsRow];
            }

            var ctrlCount = -1;

            for (var c = 0; c < o.keys.length; c++) {
                ctrlCount = Math.max(ctrlCount, $getBindControl(o.keys[c]).length);
            }

            if (ctrlCount > dsRow && checkRowIndex(dsRow, dsRow) == true) {
                if (o.rowIndexMap != null) {
                    o.rowIndexMap.save(dsRow, dsRow);
                }
                return dsRow;
            }

            for (var r = 0; r < ctrlCount; r++) {
                if (checkRowIndex(r, dsRow) == true) {
                    if (o.rowIndexMap != null) {
                        o.rowIndexMap.save(r, dsRow);
                    }
                    return r;
                }
            }

            if (ctrlCount > dsRow) {
                var dsRowReturn = true;
                for (var c = 0; c < o.keys.length; c++) {
                    if (o.json.data[dsRow].data[o.keys[c]] != null) {
                        dsRowReturn = false;
                        break;
                    }
                }
                if (dsRowReturn == true) {
                    return dsRow;
                }
            }

            return -1;
        }

        function getDatasetIndex(ctrlRow)
        {
            if (o.keys == null) {
                return ctrlRow;
            }

            if (o.rowIndexMap != null && o.rowIndexMap.datasetIndex[ctrlRow] != null) {
                return o.rowIndexMap.datasetIndex[ctrlRow];
            }

            var dsRowCount = o.self.rowCount();

            if (dsRowCount > ctrlRow && checkRowIndex(ctrlRow, ctrlRow) == true) {
                if (o.rowIndexMap != null) {
                    o.rowIndexMap.save(ctrlRow, ctrlRow);
                }
                return ctrlRow;
            }

            for (var i = 0; i < dsRowCount; i++) {
                if (checkRowIndex(ctrlRow, i) == true) {
                    if (o.rowIndexMap != null) {
                        o.rowIndexMap.save(ctrlRow, i);
                    }
                    return i;
                }
            }

            if (dsRowCount > ctrlRow) {
                var ctrlRowReturn = true;
                for (var c = 0; c < o.keys.length; c++) {
                    if (o.json.data[ctrlRow].data[o.keys[c]] != null) {
                        ctrlRowReturn = false;
                        break;
                    }
                }
                if (ctrlRowReturn == true) {
                    return ctrlRow;
                }
            }

            return -1;
        }

        function checkRowIndex(ctrlRow, dsRow)
        {
            for (var c = 0; c < o.keys.length; c++) {
                if (o.json.data[dsRow] == null || getBindControlValue($getBindControl(o.keys[c]).eq(ctrlRow), o.keys[c]) != o.json.data[dsRow].data[o.keys[c]]) {
                    return false;
                }
            }

            return true;
        }

        function getJsonString(json, datasetId)
        {
            var str = [];

            str.push('{\n');
            str.push('"id":"' + (datasetId == null ? json.id : datasetId) + '",\n');
            str.push('"header":[\n');
            for (var c = 0; c < json.header.length; c++) {
                str.push((c == 0 ? '' : ',') + '{"id":"' + any.text.toJSON(json.header[c].id) + '"}');
            }
            str.push('\n],\n');
            if (json.meta != null) {
                str.push('"meta":{\n');
                var delimiter = "";
                for (var item in json.meta) {
                    if (json.meta[item] == null) {
                        continue;
                    }
                    str.push(delimiter + '"' + item + '":"' + any.text.toJSON(json.meta[item]) + '"');
                    delimiter = ",";
                }
                str.push("\n},\n");
            }
            str.push('"data":[\n');
            for (var r = 0; r < json.data.length; r++) {
                var jobType = json.data[r].jobType;
                if (jobType == "D" && json.data[r].isDeleted == true) {
                    continue;
                }
                if (r > 0) {
                    str.push(',\n');
                }
                str.push('{' + (jobType == null || jobType == "" ? '' : '"jobType":"' + jobType + '",') + '"data":{');
                var delimiter = "";
                for (var c = 0; c < json.header.length; c++) {
                    var val = json.data[r].data[json.header[c].id];
                    if (val == null) {
                        continue;
                    }
                    if (any.ds().isValidJSON(val)) {
                        str.push(delimiter + '"' + any.text.toJSON(json.header[c].id) + '":' + getJsonString(val));
                    } else if (typeof(val) === "number" || typeof(val) === "boolean") {
                        str.push(delimiter + '"' + any.text.toJSON(json.header[c].id) + '":' + val);
                    } else if (jQuery.type(val) === "date") {
                        str.push(delimiter + '"' + any.text.toJSON(json.header[c].id) + '":' + val.getTime());
                    } else {
                        str.push(delimiter + '"' + any.text.toJSON(json.header[c].id) + '":"' + any.text.toJSON(String(val)) + '"');
                    }
                    delimiter = ",";
                }
                str.push('}}');
            }
            str.push('\n]}');

            return str.join("");
        }

        function initRowIndexMap()
        {
            if (o.keys == null) {
                return;
            }

            o.rowIndexMap = { controlIndex: {}, datasetIndex: {} };

            o.rowIndexMap.save = function(ctrlRow, dsRow)
            {
                o.rowIndexMap.controlIndex[dsRow] = ctrlRow;
                o.rowIndexMap.datasetIndex[ctrlRow] = dsRow;
            };
        }

        function executeDatasetToControlBind()
        {
            initRowIndexMap();

            if (o.binder != null && o.binder.datasetToControl != null) {
                o.binder.datasetToControl.apply(o.self);
            } else {
                bindDatasetToControl();
            }

            delete(o.rowIndexMap);
        }

        function executeControlToDatasetBind()
        {
            initRowIndexMap();

            if (o.binder != null && o.binder.controlToDataset != null) {
                o.binder.controlToDataset.apply(o.self);
            } else {
                bindControlToDataset();
            }

            delete(o.rowIndexMap);
        }

        function bindDatasetToControl(row, colId)
        {
            if (o.dataOnly === true) {
                return;
            }

            if (row == -1) {
                return;
            }

            $getBindControl.controls = {};

            if (colId == null) {
                for (var i = 0, ii = o.self.colCount(); i < ii; i++) {
                    bindCol(o.self.colId(i));
                }
            } else {
                bindCol(colId);
            }

            $getBindControl.controls = null;

            function bindCol(colId)
            {
                var $ctrl = $getBindControl(colId);

                if ($ctrl == null) {
                    return;
                }

                o.self.addColumn(colId);

                if (row == null) {
                    for (var i = 0, ii = o.self.rowCount(); i < ii; i++) {
                        bindRow(i);
                    }
                } else {
                    bindRow(row);
                }

                function bindRow(dsRow)
                {
                    var ctrlRow = getControlIndex(dsRow);

                    if (ctrlRow == -1) {
                        o.self.deleteRow(ctrlRow);
                        return;
                    }

                    if ($ctrl.get(ctrlRow) == null) {
                        return;
                    }

                    setBindControlValue($ctrl.eq(ctrlRow), colId, function()
                    {
                        if (String($ctrl.get(ctrlRow).isObjectValueSet).toLowerCase() == "true") {
                            return o.self.rowData(dsRow);
                        }

                        if ($ctrl.get(ctrlRow).tagName.toLowerCase() == "img") {
                            return any.url(any.text.nvl(o.json.data[dsRow].data[colId], ""));
                        }

                        return any.text.nvl(o.json.data[dsRow].data[colId], "");
                    }());
                }
            }
        }

        function bindControlToDataset(row, colId)
        {
            if (o.dataOnly === true) {
                return;
            }

            if (row == -1) {
                return;
            }

            $getBindControl.controls = {};

            if (colId == null) {
                var cols = {};
                jQuery('[bind="' + o.self.id + '"],[bind^="' + o.self.id + ':"],[name^="' + o.self.id + '."],[id^="' + o.self.id + '."]').each(function() {
                    var $this = jQuery(this);
                    var key;
                    if ($this.attr("bind") != null) {
                        if ($this.attr("bind").indexOf(":") != -1) {
                            key = $this.attr("bind").split(":")[1];
                        } else {
                            key = any.text.nvl($this.attr("name"), this.id);
                        }
                    } else if ($this.attr("name") != null && $this.attr("name").indexOf(".") != -1) {
                        key = $this.attr("name").split(".")[1];
                    } else if (this.id != null && this.id.indexOf(".") != -1) {
                        key = this.id.split(".")[1];
                    } else {
                        key = any.text.nvl($this.attr("name"), this.id);
                    }
                    if (key != null && any.text.trim(key) != "" && cols[key] != true) {
                        cols[key] = true;
                        bindCol(key);
                    }
                });
            } else {
                bindCol(colId);
            }

            $getBindControl.controls = null;

            function bindCol(colId)
            {
                var $ctrl = $getBindControl(colId);

                if ($ctrl == null) {
                    return;
                }

                o.self.addColumn(colId);

                if (row >= $ctrl.length) {
                    return;
                }

                if (row == null) {
                    for (var i = 0, ii = o.self.rowCount(); i < ii; i++) {
                        if (getControlIndex(i) == -1) {
                            o.self.deleteRow(i);
                        }
                    }
                    for (var i = 0; i < $ctrl.length; i++) {
                        bindRow(i);
                    }
                } else {
                    bindRow(row);
                }

                function bindRow(ctrlRow)
                {
                    var dsRow = getDatasetIndex(ctrlRow);

                    if (dsRow == -1 || o.self.rowCount() <= dsRow) {
                        dsRow = o.self.insertRow(ctrlRow);
                    }

                    if ($ctrl.eq(ctrlRow).isDisabled()) {
                        o.json.data[dsRow].data[colId] = null;
                    } else {
                        var val = getBindControlValue($ctrl.eq(ctrlRow), colId);
                        if (jQuery.type(val) == "object") {
                            for (var col in val) {
                                o.self.addColumn(col);
                                o.json.data[dsRow].data[col] = val[col];
                            }
                        } else {
                            o.json.data[dsRow].data[colId] = val;
                        }
                    }

                    if (o.self.jobType(dsRow) == "") {
                        o.self.jobType(dsRow, "U");
                    }
                }
            }
        }

        function $getBindControl(colId)
        {
            if (colId == null || any.text.trim(colId) == "") {
                return null;
            }

            if ($getBindControl.controls != null && $getBindControl.controls[colId] != null) {
                return $getBindControl.controls[colId];
            }

            var selectors = [];

            selectors.push('[bind="' + o.self.id + ':' + colId + '"]');
            selectors.push('[bind="' + o.self.id + '"][id="' + colId + '"]');
            selectors.push('[bind="' + o.self.id + '"][name="' + colId + '"]');
            selectors.push('[bind^="' + o.self.id + ':' + colId + ':"]');
            selectors.push('[bind^="' + o.self.id + '::"][id="' + colId + '"]');
            selectors.push('[bind^="' + o.self.id + '::"][name="' + colId + '"]');
            selectors.push('[bind1="' + o.self.id + ':' + colId + '"]');
            selectors.push('[bind2="' + o.self.id + ':' + colId + '"]');
            selectors.push('[name="' + o.self.id + '.' + colId + '"]');
            selectors.push('[id="' + o.self.id + '.' + colId + '"]');

            var $controls = jQuery(selectors.join(","));

            if ($getBindControl.controls != null) {
                $getBindControl.controls[colId] = $controls;
            }

            return $controls;
        }

        function getBindControlValue($ctrl, colId)
        {
            var propName = getBindPropertyName($ctrl);

            if (propName != null) {
                return $ctrl.prop(propName);
            }
        }

        function setBindControlValue($ctrl, colId, value)
        {
            var propName = getBindPropertyName($ctrl);

            if (propName != null) {
                $ctrl.prop(propName, value);
            }
        }

        function getBindPropertyName($ctrl)
        {
            var bind = $ctrl.attr("bind");

            if (bind != null) {
                var binds = bind.split(":");

                if (binds.length > 2) {
                    return binds[2];
                }
            }

            var ctrl = $ctrl.get(0);

            if (o.forJsonValue === true) {
                if ("time" in ctrl) {
                    return "time";
                }
                if ("jsonObject" in ctrl) {
                    return "jsonObject";
                }
            } else {
                if ("jsonString" in ctrl) {
                    return "jsonString";
                }
            }
            if ("value" in ctrl) {
                return "value";
            }
            if ("ds" in ctrl) {
                return null;
            }

            var props = $ctrl.data("any-properties");

            if (props != null) {
                if (o.forJsonValue === true) {
                    if (props.time != null) {
                        return "time";
                    }
                    if (props.jsonObject != null) {
                        return "jsonObject";
                    }
                } else {
                    if (props.jsonString != null) {
                        return "jsonString";
                    }
                }
                if (props.value != null) {
                    return "value";
                }
                if (props.ds != null) {
                    return null;
                }
            }

            switch (ctrl.tagName.toUpperCase()) {
            case "TD":
            case "LABEL":
            case "SPAN":
            case "DIV":
            case "PRE":
            case "XMP":
            case "A":
                return "innerText";
            case "IMG":
                return "src";
            default:
                return "value";
            }
        }
    }
};

(function() {
    any.config.printWindow = any.window();
    any.config.printWindow.option({ scrollbars: "yes", resizable: "yes", width: 700, height: 700 });
})();

window.any = any;

})(window);
