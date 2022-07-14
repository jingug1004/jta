any.control("any-jstree").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.$element = o.$control.children('div');
        o.config = any.control(control).config;

        o.autoHeight = (o.$control.attr("height") == "auto");

        if (o.$element.length == 0) {
            o.$element = jQuery('<div>').appendTo(o.$control);
        }

        o.$element.addClass("ui-widget-content ui-corner-all").css({ "background": "white", "padding-top": "3px", "padding-bottom": "3px" });

        if (o.autoHeight != true) {
            o.$element.css({ "overflow-y": "auto" });

            jQuery(window).resize(function() {
                resizeAll();
            }).resize();
        }

        o.$element.css(any.object.parse({}, o.$control.attr("element-style"), ";", ":"));

        initDataset();

        o.plugins = {};
        o.plugins.themes = true;
        o.plugins.html_data = false;
        o.plugins.json_data = false;
        o.plugins.xml_data = false;
        o.plugins.ui = true;
        o.plugins.hotkeys = true;
        o.plugins.crrm = false;
        o.plugins.checkbox = false;

        o.settings = {};

        o.settings.core = {};
        o.settings.core.animation = 200;

        o.settings.ui = {};
        o.settings.ui.select_limit = 1;

        o.settings.checkbox = {};
        o.settings.checkbox.two_state = true;

        o.checkOption = { undeterminedValue: "2", checkedValue: "1", uncheckedValue: "0", lastChildCheckboxOnly: false, rowCheckboxVisibile: null };

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("resizeAll", resizeAll);
        o.$control.defineMethod("setRootCode", setRootCode);
        o.$control.defineMethod("setRootNode", setRootNode);
        o.$control.defineMethod("setColumn", setColumn);
        o.$control.defineMethod("setNodeIcon", setNodeIcon);
        o.$control.defineMethod("getPlugin", getPlugin);
        o.$control.defineMethod("setPlugin", setPlugin);
        o.$control.defineMethod("setContextMenu", setContextMenu);
        o.$control.defineMethod("setSetting", setSetting);
        o.$control.defineMethod("setAjax", setAjax);
        o.$control.defineMethod("setExpandLevel", setExpandLevel);
        o.$control.defineMethod("setInitiallySelect", setInitiallySelect);
        o.$control.defineMethod("setCheckOption", setCheckOption);
        o.$control.defineMethod("getRowData", getRowData);
        o.$control.defineMethod("getValue", getValue);
        o.$control.defineMethod("selectNode", selectNode);
        o.$control.defineMethod("isChildNode", isChildNode);
        o.$control.defineMethod("drawTree", drawTree);

        o.$control.defineProperty("ds", { get: getDs });
        o.$control.defineProperty("loader", { get: getLoader });
        o.$control.defineProperty("checkedCodeList", { get: getCheckedCodeList });
        o.$control.defineProperty("checkedDataList", { get: getCheckedDataList });

        any.control(control).initialize();

        if (o.$element.children('ul').length > 0) {
            createTree({ html_data: true });
        }

        if (o.settings.json_data != null && o.settings.json_data.ajax != null) {
            any.ready(function() {
                drawTree();
            });
        }
    })();

    if (jQuery.jstree._fn.set_focus_origin == null) {
        jQuery.jstree._fn.set_focus_origin = jQuery.jstree._fn.set_focus;

        jQuery.jstree._fn.set_focus = function()
        {
            jQuery.jstree._fn.set_focus_origin.apply(this);

            this.get_container().removeClass("jstree-focused");
        };
    }

    function initDataset()
    {
        if (o.$control.hasAttr("ds")) {
            o.ds = any.ds(o.$control.attr("ds"));
        } else if (control.id.indexOf("_") > 0) {
            o.ds = any.ds("ds_" + control.id.substr(control.id.indexOf("_") + 1));
        } else {
            o.ds = any.ds(control.id);
        }

        o.ds.listData(true);

        o.ds.setBinder(drawTree, function() {
            if (o.checkOption == null || getPlugin("checkbox") != true) {
                return;
            }

            o.$element.find('li').each(function() {
                var $this = jQuery(this);
                var value = null;
                if ($this.hasClass("jstree-undetermined")) {
                    value = o.checkOption.undeterminedValue;
                } else if ($this.hasClass("jstree-checked")) {
                    value = o.checkOption.checkedValue;
                } else if ($this.hasClass("jstree-unchecked")) {
                    value = o.checkOption.uncheckedValue;
                }
                o.ds.value($this.data("ds-index"), o.checkOption.columnName, value);
            });
        });
    }

    function getDs()
    {
        return o.ds;
    }

    function element()
    {
        return o.$element;
    }

    function resizeAll()
    {
        o.$element.outerWidth(o.$control.width()).outerHeight(o.$control.height());
    }

    function setRootCode(code)
    {
        o.rootCode = code;
    }

    function setRootNode(code, name, check, icon)
    {
        if (arguments.length == 1 && typeof(arguments[0]) === "object") {
            o.rootNode = arguments[0];
        } else {
            o.rootNode = { code: code, name: name, check: check, icon: icon };
        }
    }

    function setColumn(parent, code, name, rel)
    {
        if (arguments.length == 1 && typeof(arguments[0]) === "object") {
            o.column = arguments[0];
        } else {
            o.column = { parent: parent, code: code, name: name, rel: rel };
        }
    }

    function setNodeIcon(column, path, root)
    {
        if (arguments.length == 1 && typeof(arguments[0]) === "object") {
            o.nodeIcon = arguments[0];
        } else {
            o.nodeIcon = { column: column, path: path, root: root };
        }
    }

    function getPlugins()
    {
        var plugins = [];

        for (var item in o.plugins) {
            if (o.plugins[item] == true) {
                plugins.push(item);
            }
        }

        return plugins;
    }

    function getPlugin(name)
    {
        return o.plugins[name];
    }

    function setPlugin(name, enable)
    {
        if (any.text.endsWith(name, "_data")) {
            for (var item in o.plugins) {
                if (any.text.endsWith(item, "_data")) {
                    o.plugins[item] = false;
                }
            }
        }

        o.plugins[name] = enable;

        return control;
    }

    function setContextMenu(name, spec)
    {
        o.plugins.contextmenu = true;

        if (o.contextmenu == null) {
            o.contextmenu = {};
        }

        o.contextmenu[name] = spec;
    }

    function getSettings()
    {
        var settings = { "plugins": getPlugins() };

        if (o.contextmenu != null) {
            settings.contextmenu = { "select_node": true, "items": function() { return o.contextmenu } };
        }

        for (var item in o.settings) {
            settings[item] = o.settings[item];
        }

        return settings;
    }

    function setSetting(name, key, value)
    {
        if (o.settings[name] == null) {
            o.settings[name] = {};
        }

        o.settings[name][key] = value;

        return control;
    }

    function setAjax(spec)
    {
        if (spec == null) {
            return;
        }

        resetInitiallySelect();

        if (o.settings.json_data == null) {
            o.settings.json_data = {};
        }

        o.settings.json_data.ajax = {};

        o.settings.json_data.ajax.url = any.url(spec.url);
        o.settings.json_data.ajax.type = "POST";
        o.settings.json_data.ajax.dataType = "html";
        o.settings.json_data.ajax.headers = { "X-AnyWorks-Servlet-Token": any.rootWindow().any.meta.servletToken };

        if (spec.params != null) {
            o.settings.json_data.ajax.data = function($node)
            {
                return spec.params.apply(this, [$node.data("rowData")]);
            };
        }

        o.settings.json_data.ajax.success = function(json)
        {
            var data = eval("(" + json + ")");
            var children = [];

            if (spec.state == null) {
                spec.state = function() { return "closed"; };
            }

            if (jQuery.type(data) === "array") {
                for (var i = 0, ii = data.length; i < ii; i++) {
                    children.push(getTreeNode(data[i], null, spec.state.apply(this, [data[i]])));
                }
            } else {
                for (var i = 0, ii = data.data.length; i < ii; i++) {
                    children.push(getTreeNode(data.data[i].data, null, spec.state.apply(this, [data.data[i].data])));
                }
            }

            return children;
        };

        if (o.rootNode != null || spec.root == null) {
            return;
        }

        o.ajaxRootLoaderProxy = any.proxy();
        o.ajaxRootLoaderProxy.url(spec.url);

        if (spec.params != null) {
            var args = {};
            args[o.column.code] = spec.root;
            var params = spec.params.apply(this, [args]);
            for (var item in params) {
                o.ajaxRootLoaderProxy.param(item, params[item]);
            }
        }

        o.ajaxRootLoaderProxy.on("onSuccess", function() {
            var data = eval("(" + this.result + ")");

            if (jQuery.type(data) === "array") {
                for (var i = 0, ii = data.length; i < ii; i++) {
                    addNode(data[i], null, spec.state.apply(this, [data[i]]));
                }
            } else {
                for (var i = 0, ii = data.data.length; i < ii; i++) {
                    addNode(data.data[i].data, null, spec.state.apply(this, [data.data[i].data]));
                }
            }

            createTree({ json_data: true });
        });

        o.ajaxRootLoaderProxy.on("onError", function() {
            this.error.show();
        });
    }

    function setExpandLevel(val)
    {
        o.expandLevel = val;
    }

    function setInitiallySelect(val, reset)
    {
        o.initiallySelect = val;

        if (reset == true) {
            resetInitiallySelect();
        }
    }

    function resetInitiallySelect(val)
    {
        if (arguments.length == 0) {
            val = o.initiallySelect;
        }

        o.settings.ui.initially_select = "tree_" + control.id + "_" + val;
    }

    function setCheckOption()
    {
        any.copyArguments(o.checkOption, arguments);
    }

    function getRowData()
    {
        var $node = o.$element.jstree("get_selected");

        if ($node.length > 0 && $node.data("rowData") != null) {
            return $node.data("rowData");
        }

        return null;
    }

    function getValue(column)
    {
        var rowData = getRowData();

        if (rowData != null) {
            var val = rowData[column == null ? o.column.code : column];
            return val == null ? null : val;
        }

        return null;
    }

    function selectNode(val)
    {
        o.$element.jstree("select_node", '#tree_' + control.id + "_" + val, true);
    }

    function isChildNode(code1, code2)
    {
        return o.$element.find('li[code="' + code1 + '"]').find('li[code="' + code2 + '"]').length > 0;
    }

    function getLoader()
    {
        if (o.loader != null) {
            return o.loader;
        }

        o.loader = {};

        if (o.settings.json_data == null || o.settings.json_data.ajax == null) {
            o.loader.proxy = function()
            {
                resetInitiallySelect();

                o.loader.prx = any.proxy().output(o.ds);

                o.loader.prx.executeGrid = o.loader.prx.execute;

                o.loader.prx.execute = function()
                {
                    if (o.loader.loading == true) {
                        return;
                    }

                    o.loader.loading = true;

                    o.loader.prx.option({ loadingbar: false });
                    o.loader.prx.executeGrid();
                };

                if (o.$loading == null) {
                    o.$loading = jQuery('<div>').css({ "position": "absolute", "top": "45%", "text-align": "center", "width": "100%" }).appendTo(o.$control);
                    o.$control.css({ "position": "relative" });
                }

                jQuery(o.loader.prx)
                    .on("onStart", function() {
                        o.$element.empty();
                        o.$loading.text("Loading...").show();
                    })
                    .on("onSuccess", function() {
                        o.loader.loading = false;
                    })
                    .on("onError", function() {
                        o.loader.loading = false;
                        o.$loading.text("(Error)");
                    })
                ;

                return o.loader.prx;
            };

            o.loader.reload = function()
            {
                if (o.loader.prx == null) {
                    return;
                }

                o.loader.prx.reloadParams = {};

                o.loader.prx.reloadParams.scrollTop = o.$element.scrollTop();

                o.settings.core.initially_open = function() {
                    var ids = [];
                    o.$element.find('li').each(function() {
                        var $this = jQuery(this);
                        if (o.$element.jstree("is_open", $this) == true && $this.is(':visible') == true) {
                            ids.push($this[0].id);
                        }
                    });
                    return ids;
                }();

                resetInitiallySelect(getValue());

                o.loader.prx.reload();
            };
        } else {
            o.loader.reload = function()
            {
                var $node = o.$element.jstree("get_selected");

                $node.children('ul').remove();

                if (o.$element.jstree("is_open", $node) == true) {
                    o.$element.jstree("close_node", $node, true);
                    o.$element.jstree("open_node", $node, null, true);
                }
            };
        }

        return o.loader;
    }

    function drawTree(options)
    {
        o.$element.empty();

        if (o.column == null) {
            return;
        }

        if (o.settings.json_data == null) {
            o.settings.json_data = {};
        }

        o.settings.json_data.spec = { level: 0 };
        o.settings.json_data.data = [];
        o.nodeItems = {};

        if (o.ajaxRootLoaderProxy != null) {
            o.ajaxRootLoaderProxy.execute();
            return;
        }

        if (o.rootNode != null) {
            var rowData = {};
            rowData[o.column.code] = o.rootNode.code;
            rowData[o.column.name] = o.rootNode.name;
            addNode(rowData, null, o.settings.json_data.ajax == null ? null : "closed", "root");
        }

        var ds;

        if (options == null) {
            ds = o.ds;
        } else {
            ds = (options.ds == null ? o.ds : options.ds);
            if (o.rootCode != null) {
                delete(o.nodeItems);
            }
        }

        for (var i = 0, ii = ds.rowCount(); i < ii; i++) {
            addNode(ds.rowData(i), i);
        }

        if (options != null && typeof(options.setting) === "function") {
            options.setting.apply(control, [o.settings]);
        }

        createTree({ json_data: true });

        resizeAll();
    }

    function addNode(data, dsIndex, state, rel)
    {
        var parent = data[o.column.parent];

        if (o.nodeItems == null || o.nodeItems[parent] == null) {
            if (o.rootCode != null && o.rootCode != parent) {
                return;
            }
        }

        if (o.nodeItems == null) {
            o.nodeItems = {};
        }

        var node = getTreeNode(data, dsIndex, state, rel);
        var parentNode;

        if (parent == null || (o.rootNode == null && o.nodeItems[parent] == null)) {
            if (o.rootCode != null && o.rootCode != parent) {
                return;
            }
            if (o.nodeIcon == null || o.nodeIcon.root == null) {
                node.icon = (o.rootNode == null ? node.icon : (o.rootNode.icon == null ? node.icon : o.rootNode.icon));
            } else if (any.text.endsWith(o.nodeIcon.path, "/") != true && any.text.startsWith(o.nodeIcon.root, "/") != true) {
                node.icon = o.nodeIcon.path + "/" + o.nodeIcon.root;
            } else {
                node.icon = o.nodeIcon.path + o.nodeIcon.root;
            }
            parentNode = o.settings.json_data;
            parentNode.data.push(node);
        } else if (o.nodeItems[parent] != null) {
            if (o.nodeItems[parent].children == null) {
                o.nodeItems[parent].children = [];
            }
            parentNode = o.nodeItems[parent];
            parentNode.children.push(node);
        } else {
            return;
        }

        node.spec.level = parentNode.spec.level + 1;
    }

    function getTreeNode(data, dsIndex, state, rel)
    {
        var code = data[o.column.code];
        var name = data[o.column.name];
        var node = {};

        node.spec = {};
        node.metadata = { rowData: data };
        node.data = { title: name, attr: { href: "javascript:void(0);" } };
        node.attr = { id: "tree_" + control.id + "_" + code, code: code, rel: rel == null ? data[o.column.rel] : rel };

        if (state != null) {
            node.state = state;
        }

        if (dsIndex != null) {
            node.metadata["ds-index"] = dsIndex;
        }

        o.nodeItems[code] = node;

        if (o.checkOption != null && getPlugin("checkbox") == true) {
            node.attr["initially-checked"] = (data[o.checkOption.columnName] == o.checkOption.checkedValue);
        }

        if (o.nodeIcon != null) {
            var icon = data[o.nodeIcon.column];

            if (icon != null && icon != "") {
                if (any.text.endsWith(o.nodeIcon.path, "/") != true && any.text.startsWith(icon, "/") != true) {
                    node.icon = o.nodeIcon.path + "/" + icon;
                } else {
                    node.icon = o.nodeIcon.path + icon;
                }
            }
        }

        return node;
    }

    function createTree(plugins)
    {
        o.plugins.html_data = false;
        o.plugins.json_data = false;
        o.plugins.xml_data = false;

        for (var item in plugins) {
            o.plugins[item] = plugins[item];
        }

        if (o.expandLevel != null && o.expandLevel != -1 && (o.loader == null || o.loader.prx == null || o.loader.prx.reloadParams == null)) {
            o.settings.core.initially_open = function() {
                var ids = [];
                for (var code in o.nodeItems) {
                    if (o.nodeItems[code].spec.level <= o.expandLevel) {
                        ids.push(o.nodeItems[code].attr.id);
                    }
                }
                return ids;
            }();
        }

        o.$element.jstree(getSettings());

        o.$element.on("loaded.jstree", function() {
            loadComplete();
        });

        if (o.expandLevel != -1 && o.settings.core.initially_open != null) {
            var openCount = o.settings.core.initially_open.length - 1;
            o.$element.on("open_node.jstree", function() {
                if (openCount > 0) {
                    openCount--;
                } else {
                    openComplete();
                }
            });
        }

        o.$element.on("select_node.jstree", function(event, data) {
            if (o.currentNode == data.rslt.obj[0]) {
                return;
            }
            o.$control.fire("onChangeNode", { code: data.rslt.obj.attr("code"), $node: data.rslt.obj });
            o.currentNode = data.rslt.obj[0];
        });
    }

    function loadComplete()
    {
        if (o.rootNode != null && o.rootNode.check != true) {
            o.$element.children('ul').children('li[code="' + o.rootNode.code + '"]').children('a').children('ins.jstree-checkbox').hide();
        }

        if (o.expandLevel == -1) {
            o.$element.jstree("open_all");
            openComplete();
        }

        if (o.checkOption != null && getPlugin("checkbox") == true) {
            o.$element.find('li[initially-checked="true"]').each(function() {
                o.$element.jstree("check_node", this);
            });
            o.$element.find('li[initially-checked="false"]').each(function() {
                o.$element.jstree("uncheck_node", this);
            });
        }

        o.$element.find('a').dblclick(function() {
            jQuery(this).prev('ins.jstree-icon').click();
        });

        if (o.checkOption.lastChildCheckboxOnly == true) {
            o.$element.find('ins.jstree-checkbox').each(function() {
                var $this = jQuery(this);
                if ($this.parent('a').next('ul').children('li').length > 0) {
                    $this.hide();
                }
            });
        } else if (typeof(o.checkOption.rowCheckboxVisibile) === "function") {
            o.$element.find('ins.jstree-checkbox').each(function() {
                var $this = jQuery(this);
                if (o.checkOption.rowCheckboxVisibile($this.closest('li').data("rowData")) !== true) {
                    $this.hide();
                }
            });
        }

        if (o.$loading != null) {
            o.$loading.hide();
        }

        if (o.autoHeight == true) {
            window.setTimeout(function() {
                any.autoHeight();
            });
        }
    }

    function openComplete()
    {
        if (o.loader != null && o.loader.prx != null) {
            if (o.loader.prx.reloadParams != null) {
                o.$element.scrollTop(o.loader.prx.reloadParams.scrollTop);
            }
            o.loader.prx.reloadParams = null;
        }
    }

    function getCheckedCodeList()
    {
        var list = [];

        o.$element.jstree("get_checked").each(function() {
            list.push(jQuery(this).attr("code"));
        });

        return list;
    }

    function getCheckedDataList()
    {
        var list = [];

        o.$element.jstree("get_checked").each(function() {
            list.push(jQuery(this).data("rowData"));
        });

        return list;
    }
});
