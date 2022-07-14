window.Layout = function Layout()
{
    var f = {};
    var o = {};

    (function main() {
        f.getOpenWindowLinkColModel = getOpenWindowLinkColModel;
        f.addPreviewFileExtensions = addPreviewFileExtensions;
        f.checkPreviewFileExtensions = checkPreviewFileExtensions;
        f.getFilePreviewUtils = getFilePreviewUtils;
        f.setFilePreviewUrl = setFilePreviewUrl;

        o.filePreviewUtils = getFilePreviewUtils();

        o.layoutSizesConfig = getLayoutSizesConfig();

        $(window).on("resize", function() {
            resizeLayoutPanes();
        });

        var isParentLayoutWindow;

        try {
            if (parent != window) {
                isParentLayoutWindow = parent.any.arg("isLayoutWindow");
            }
        } catch(e) {
        }

        if (isParentLayoutWindow != true && any.arg("isLayoutWindow") == true) {
            $(function() {
                setLayoutWindow();
            });
        } else {
            any.ready(function() {
                setFilePreviewLoad();
            });
            $(window).on("unload", function() {
                setFilePreviewClose();
            });
        }
    })();

    return f;

    function getOpenWindowLinkColModel(model)
    {
        var colModel = { width:20, align:"center", sortable:false, label:"+", fixed:true, formatter:function() { return "+"; } };

        for (var item in model) {
            colModel[item] = model[item];
        }

        return colModel;
    }

    function setLayoutWindow()
    {
        any.loadStyle("/common/ui/jquery/plugins/jquery.layout/jquery.layout.css");

        any.loadScript("/common/ui/jquery/plugins/jquery.layout/jquery.layout.js", function() {
            o.layoutDiv = {};

            o.$wrapper = $('<div fullHeight>').insertAfter('div.page-header');

            o.layoutDiv.$detail = $('<div style="height:100%;">').appendTo($('<div class="ui-layout-center">').appendTo(o.$wrapper));
            o.layoutDiv.$preview = $('<div style="height:100%;">').appendTo($('<div class="ui-layout-east" style="overflow:hidden;">').appendTo(o.$wrapper));

            o.$wrapper.nextUntil('div.page-footer').appendTo(o.layoutDiv.$detail);

            any.fullHeight();

            var options = {};

            options.east__size = 400;
            options.east__initHidden = true;

            if (any.config.blockActivated != true) {
                options.maskIframesOnResize = true;
            }

            options.onopen_end = function()
            {
                var $ifr = o.layoutDiv.$preview.children('iframe');

                if ($ifr.length == 1 && $ifr[0].contentWindow.location.href != o.layoutDiv.$preview.data("currentFilePreviewPath")) {
                    var loc = any.location($ifr[0].contentWindow);
                    loc.url("/common.file.FileAct/viewPreview");
                    loc.arg("filePreviewPath", o.layoutDiv.$preview.data("currentFilePreviewPath"));
                    loc.arg("isLayoutWindow", false);
                    loc.replace();
                }
            };

            options.onresize_end = function(pane, $pane, state, options)
            {
                $('[any-jqgrid=""]').exec("resizeAll");

                if (any.config.blockActivated == true) {
                    showHideDragLayoutContent(true);
                }

                if (o.layoutResizeStart == true && pane != "center") {
                    setLayoutSizesConfig(pane, state);
                    delete(o.layoutResizeStart);
                }
            };

            o.layout = o.$wrapper.layout(options);

            o.$wrapper.find('div.ui-layout-resizer,div.ui-layout-toggler').removeCss("z-index");

            o.$wrapper.children('div.ui-layout-resizer-east').on("dragstart", function() {
                if (any.config.blockActivated == true) {
                    showHideDragLayoutContent(false);
                }
                o.layoutResizeStart = true;
            });

            if (any.config.blockActivated == true) {
                o.$wrapper.children('div.ui-layout-resizer-east').on("dragend", function() {
                    showHideDragLayoutContent(true);
                });
            }

            var filePreviewUtils = {};

            filePreviewUtils.load = function(fileInfo)
            {
                o.layoutDiv.$preview.empty();

                if (fileInfo == null) return;

                if (typeof(fileInfo) === "object") {
                    o.layoutDiv.$preview.data("currentFilePreviewPath", any.url("/common.file.FileAct/preview", { DOWNLOAD_KEY:fileInfo.DOWNLOAD_KEY }));
                } else {
                    o.layoutDiv.$preview.data("currentFilePreviewPath", fileInfo);
                }

                o.layout.show("east");
                o.layout.open("east");

                resizeLayoutPanes();

                window.setTimeout(function() {
                    var $ifr = $('<iframe style="border:none; overflow:hidden; width:100%; height:100%;">').appendTo(o.layoutDiv.$preview);
                    var loc = any.location($ifr[0].contentWindow);
                    loc.url("/common.file.FileAct/viewPreview");
                    loc.arg("filePreviewPath", o.layoutDiv.$preview.data("currentFilePreviewPath"));
                    loc.arg("isLayoutWindow", false);
                    loc.replace();
                }, 500);
            };

            setFilePreviewLoad(filePreviewUtils);
        });
    }

    function showHideDragLayoutContent(show)
    {
        if (any.config.blockActivated != true) {
            return;
        }

        if (show == true) {
            o.layoutDiv.$detail.parent().css("background-color", "");
            o.layoutDiv.$detail.show();
            o.layoutDiv.$preview.parent().css("background-color", "");
            o.layoutDiv.$preview.show();
        } else {
            o.layoutDiv.$detail.parent().css("background-color", "#eeeeee");
            o.layoutDiv.$detail.hide();
            o.layoutDiv.$preview.parent().css("background-color", "#eeeeee");
            o.layoutDiv.$preview.hide();
        }
    }

    function getFilePreviewUtils()
    {
        if (typeof(o.filePreviewUtils) === "object") {
            return o.filePreviewUtils;
        }

        try {
            if (any.pageType() != "dialog" && parent.Layout != null && parent.Layout.getFilePreviewUtils != null && typeof(parent.Layout.getFilePreviewUtils) === "function") {
                o.filePreviewUtils = parent.Layout.getFilePreviewUtils();
            }
            if (typeof(o.filePreviewUtils) !== "object" && window.frameElement != null) {
                o.filePreviewUtils = window.frameElement.FilePreviewUtils;
            }
        } catch(e) {
        }

        return o.filePreviewUtils;
    }

    function setFilePreviewLoad(filePreviewUtils)
    {
        if (filePreviewUtils != null) {
            o.filePreviewUtils = filePreviewUtils;
        }

        if (o.filePreviewUtils == null) return;

        if (o.filePreviewUtils.load == null) return;

        if (o.filePreviewUrl != null) {
            o.filePreviewUtils.load(o.filePreviewUrl);
            return;
        }

        $('[any-file=""]').each(function() {
            var $this = $(this).attr("file-preview-link", "0");

            $($this.prop("ds")).on("onLoad", function() {
                $this.find('span.link').each(function() {
                    var $link = $(this);
                    var fileInfo = $link.data("fileInfo");

                    if (fileInfo == null) return true;

                    if (checkPreviewFileExtensions(fileInfo.FILE_NAME) != true) return true;

                    $('<span name="span_filePreview">').addClass("link").css({ "margin-right":"5px", "font-weight":"bold" })
                        .data("fileInfo", fileInfo)
                        .text("[" + any.message("lbl.PREVIEW", "미리보기") + "]")
                        .insertBefore($link)
                        .click(function() {
                            $('span[name="span_filePreview"][preview-loaded="1"]').css({ "color":"" }).removeAttr("preview-loaded");
                            var $this = $(this);
                            o.filePreviewUtils.load($this.data("fileInfo"));
                            $this.css({ "color":"red" }).attr("preview-loaded", "1");
                        });
                });

                $this.attr("file-preview-link", "1");

                if ($('[any-file=""][file-preview-link="0"]').length == 0) {
                    var $abstractFiles = $('[app-abstract=""]:visible').find('[any-file=""]:visible');
                    var $otherFiles = $('[any-file=""]:visible').not($abstractFiles);
                    var $link;

                    if ($otherFiles.length == 0) {
                        $link = $abstractFiles.find('span[name="span_filePreview"]');
                    } else {
                        $link = $otherFiles.find('span[name="span_filePreview"]');
                    }

                    if ($link.length == 0) {
                        setFilePreviewClose();
                    } else {
                        $link.eq(0).click();
                    }
                }
            });
        });
    }

    function setFilePreviewClose()
    {
        if (o.filePreviewUtils == null) return;

        if (o.filePreviewUtils.close == null) return;

        o.filePreviewUtils.close();
    }

    function addPreviewFileExtensions(extensions)
    {
        if (o.previewFileExtensions == null) {
            o.previewFileExtensions = [];
        }

        for (var i = 0; i < extensions.length; i++) {
            o.previewFileExtensions.push(any.text.trim(extensions[i]).toUpperCase());
        }
    }

    function checkPreviewFileExtensions(fileName)
    {
        if (o.previewFileExtensions == null) return true;

        var fileExt;

        if (fileName.indexOf(".") == -1) {
            fileExt = fileName.toUpperCase();
        } else {
            fileExt = fileName.substr(fileName.lastIndexOf(".") + 1).toUpperCase();
        }

        for (var i = 0; i < o.previewFileExtensions.length; i++) {
            if (o.previewFileExtensions[i] == fileExt) {
                return true;
            }
        }
    }

    function setFilePreviewUrl(url)
    {
        o.filePreviewUrl = url;
    }

    function getServletPath()
    {
        return jQuery('meta[name="X-Any-Servlet-Path"]').attr("content");
    }

    function getLayoutSizesConfig()
    {
        return UserConfig.getObject("common.layout[" + getServletPath() + "].sizes", { width:1000, east:400 });
    }

    function setLayoutSizesConfig(pane, state)
    {
        if (o.$wrapper == null) return;
        if (o.layoutSizesConfig == null) return;
        if (o.layout == null || o.layout.state == null || o.layout.state.east == null || o.layout.state.east.isClosed == true) return;

        o.layoutSizesConfig.width = o.$wrapper.width();
        o.layoutSizesConfig[pane] = state.outerWidth;

        UserConfig.setObject("common.layout[" + getServletPath() + "].sizes", o.layoutSizesConfig);
    }

    function resizeLayoutPanes()
    {
        if (o.$wrapper == null) return;
        if (o.layoutSizesConfig == null) return;
        if (o.layout == null || o.layout.state == null || o.layout.state.east == null || o.layout.state.east.isClosed == true) return;

        var wrapperSizes = { width:o.$wrapper.width(), height:o.$wrapper.height() };

        if (o.wrapperSizes == null) {
            o.wrapperSizes = {};
        }

        if (o.wrapperSizes.width != wrapperSizes.width) {
            o.layout.resizeAll();
            o.layout.sizePane("east", o.layoutSizesConfig.east / o.layoutSizesConfig.width * wrapperSizes.width);
            o.wrapperSizes.width = wrapperSizes.width;
        }
    }
}();
