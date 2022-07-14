any.control("any-jqgrid").plugin(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);

        o.highlightClass = "grid-thumbnail-li-selected ui-state-highlight";

        o.$control.defineMethod("setThumbnailViewer", setThumbnailViewer);

        o.$control.on("onResetGridActivated", function() {
            if (o.thumbnailActivated == true) {
                o.$control.find('div.ui-jqgrid').hide();
            }
        });

        o.$control.on("onGridActivated", function() {
            if (o.thumbnailActivated == true && o.$control.exec("getButton", "thumbnail").toggleButton != null) {
                o.$control.exec("getButton", "thumbnail").toggleButton(true);
            }
        });

        o.$control.on("onButtonToggleAfter", function(event, name, toggleActivated) {
            if (name == "thumbnail") {
                o.thumbnailActivated = toggleActivated;
            }
        });
    })();

    function setThumbnailViewer(options, defaultActivate)
    {
        o.options = options;

        if (defaultActivate != null) {
            o.thumbnailActivated = defaultActivate;
        }

        o.loader = o.$control.prop("loader");
        o.$loader = $(o.loader);

        o.$control.on("onResizeAll", function() {
            resizeThumbnailViewer();
        });

        o.$loader.on("onLoadStart", function() {
            if (o.$thumbnailViewer == null) return;

            if (o.loader.reloading === true) {
                o.reloadParams = {};
                o.reloadParams.scrollTop = o.$thumbnailViewer.scrollTop();
                o.reloadParams.scrollLeft = o.$thumbnailViewer.scrollLeft();

                if (o.multiselect != true) {
                    o.reloadParams.selectedRowId = o.$thumbnailViewer.find('li.grid-thumbnail-li-selected').attr("row-id");
                }
            }

            o.$thumbnailViewer.empty();
        });

        o.$loader.on("onLoadSuccess", function() {
            if (o.$thumbnailViewer == null) return;

            drawThumbnailViewer();

            if (o.loader.reloading === true && o.reloadParams != null) {
                if (o.reloadParams.scrollTop != null) {
                    o.$thumbnailViewer.scrollTop(o.reloadParams.scrollTop);
                }
                if (o.reloadParams.scrollLeft != null) {
                    o.$thumbnailViewer.scrollLeft(o.reloadParams.scrollLeft);
                }
                if (o.reloadParams.selectedRowId != null) {
                    o.$thumbnailViewer.find('li[row-id="' + o.reloadParams.selectedRowId + '"]').addClass(o.highlightClass);
                }
            }
        });

        if (o.$thumbnailViewer != null) {
            o.$thumbnailViewer.remove();
            o.$thumbnailViewer = null;
        }

        control.addButton("thumbnail", {
            icon : "image",
            text : "Thumbnail",
            title : "Thumbnail View",
            func : function(activated) {
                activateThumbnailViewer(activated);
            },
            toggle : true,
            show : true
        });
    }

    function activateThumbnailViewer(activated)
    {
        o.$control.exec("setButton", { "filter":activated != true, "config":activated != true });

        if (o.$thumbnailViewer == null) {
            o.$thumbnailViewer = $('<div>').addClass("grid-thumbnail-viewer").hide().appendTo(o.$control.find('div.ui-jqgrid-view'));
        }

        var $hdiv = o.$control.find('div.ui-jqgrid-hdiv');
        var $bdiv = o.$control.find('div.ui-jqgrid-bdiv');

        $hdiv.showHide(activated != true);
        $bdiv.showHide(activated != true);

        o.$thumbnailViewer.showHide(activated == true);

        if ($bdiv.length > 1) {
            var scrollTop = $bdiv.eq($bdiv.length - 1).scrollTop();

            if (scrollTop > 0) {
                $bdiv.scrollTop(scrollTop);
            }
        }

        o.$control.exec("resizeAll");

        resizeThumbnailViewer();
        drawThumbnailViewer();
    }

    function resizeThumbnailViewer()
    {
        if (o.$thumbnailViewer == null || o.$thumbnailViewer.is(':visible') != true) {
            return;
        }

        window.setTimeout(function() {
            var $header = o.$control.find('div.ui-jqgrid-titlebar');
            var $pager = o.$control.find('div.ui-jqgrid-pager');

            o.$thumbnailViewer.height(o.$control.height() - $header.outerHeight() - $pager.outerHeight() - 2);
        });
    }

    function drawThumbnailViewer()
    {
        if (o.$thumbnailViewer == null || o.$thumbnailViewer.is(':visible') != true) {
            return;
        }

        o.$thumbnailViewer.empty();

        o.multiselect = o.$control.exec("getOption", "multiselect")
        o.$element = o.$control.element();

        o.$ul = $('<ul>').appendTo(o.$thumbnailViewer);

        for (var i = 0, ii = o.$control.prop("rowCount"); i < ii; i++) {
            var rowId = o.$control.exec("getRowId", i);
            var rowData = o.$control.exec("getRowData", i);
            var $tr = o.$control.find('table.ui-jqgrid-btable').find('tr[role="row"]#' + rowId);

            if ($tr.css("display") == "none") continue;

            var $li = $('<li>').attr("row-id", rowId).data("row-data", rowData).appendTo(o.$ul);
            var $wrapperDiv = $('<div>').addClass("grid-thumbnail-wrapper").appendTo($li);
            var $imageDiv = $('<div>').addClass("grid-thumbnail-image").appendTo($wrapperDiv);
            var imgSrc = o.options.imgSrc(rowData);
            var $img = $('<img>').attr("src", imgSrc + (imgSrc.indexOf("?") == -1 ? "?" : "&") + any.date().timestamp()).appendTo($imageDiv);

            if (o.options.imgSize != null) {
                $li.css({ "width":o.options.imgSize.width, "height":o.options.imgSize.height + 2 });
                $img.css({ "max-width":o.options.imgSize.width, "max-height":o.options.imgSize.height });
            }

            if (o.options.label != null) {
                var $label = $('<label>').addClass("grid-thumbnail-label").css({ "cursor":"default" }).data("row-data", rowData).appendTo($li);
                if (o.multiselect == true && $tr.find('td[role="gridcell"] > input:checkbox[role="checkbox"].cbox').length == 1) {
                    $('<input>').attr({ "type":"checkbox", "row-id":rowId }).css({ "vertical-align":"middle" }).prependTo($label).click(function() {
                        o.$element.jqGrid("setSelection", $(this).attr("row-id"));
                        resetSelection();
                    });
                }
                $('<span>').text(o.options.label(rowData)).css({ "vertical-align":"middle" }).appendTo($label);
                $li.css({ "padding-bottom":"20px" });
            }

            if (o.options.title != null) {
                $li.attr({ "title":o.options.title(rowData) });
            }

            if (o.options.link != null) {
                $wrapperDiv.css({ "cursor":"pointer" }).click(function() {
                    var $li = $(this).closest('li');
                    if (o.multiselect != true) {
                        o.$element.jqGrid("setSelection", $li.attr("row-id"));
                        resetSelection();
                    }
                    o.options.link($li.data("row-data"));
                });
            }
        }

        resizeThumbnailViewer();
        resetSelection();
    }

    function resetSelection()
    {
        if (o.multiselect == true) {
            var $chks = o.$thumbnailViewer.find('input:checkbox');
            var rowIds = o.$control.prop("selectedRowIds");

            for (var i = 0; i < $chks.length; i++) {
                var chk = $chks.get(i);
                var $chk = $chks.eq(i);

                chk.checked = ($.inArray($chk.attr("row-id"), rowIds) != -1);

                if (chk.checked == true) {
                    $chk.closest('li').addClass(o.highlightClass);
                } else {
                    $chk.closest('li').removeClass(o.highlightClass);
                }
            }
        } else {
            o.$ul.children('li').removeClass(o.highlightClass);

            var rowId = o.$control.prop("selectedRowId");

            if (rowId != null && rowId != "") {
                o.$ul.find('li[row-id="' + rowId + '"]').addClass(o.highlightClass);
            }
        }
    }
});
