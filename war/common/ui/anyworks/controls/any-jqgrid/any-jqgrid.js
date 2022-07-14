any.control("any-jqgrid").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.$element = getTableElement();
        o.config = any.control(control).config;
        o.controlIndex = any.control().newIndex();
        o.frozen = { index: -1 };
        o.options = {};
        o.sortings = [];
        o.actions = {};

        control.isReady = false;

        o.$control.css("cursor", "default");

        initDataset();
        initButtons();
        initFormatters();

        o.options.colModel = [];
        o.options.caption = any.message("any.grid.caption.ready").toString();
        o.options.headertitles = true;
        o.options.hidegrid = false;
        o.options.datatype = "local";
        o.options.autowidth = true;
        o.options.shrinkToFit = false;
        o.options.jsonReader = { repeatitems: false };
        o.options.loadui = "block";
        o.options.rownumWidth = 35;
        o.options.cellsubmit = "clientArray";
        o.options.autoencode = true;

        any.ready(function() {
            resizeAll();
        });

        jQuery(window).resize(function() {
            resizeAll();
        });

        o.$control.resize(function() {
            resizeAll();
        });

        o.$control.parent().on("onResizeHeight", function() {
            resizeAll();
        });

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("reset", reset);
        o.$control.defineMethod("reset2", reset2);
        o.$control.defineMethod("resizeAll", resizeAll);
        o.$control.defineMethod("resizeWidth", resizeWidth);
        o.$control.defineMethod("resizeHeight", resizeHeight);
        o.$control.defineMethod("removeTitlebar", removeTitlebar);
        o.$control.defineMethod("removeContextMenu", removeContextMenu);
        o.$control.defineMethod("getOption", getOption);
        o.$control.defineMethod("setOption", setOption);
        o.$control.defineMethod("addElementEvent", addElementEvent);
        o.$control.defineMethod("addGroupHeader", addGroupHeader);
        o.$control.defineMethod("addColumn", addColumn);
        o.$control.defineMethod("getColModel", getColModel);
        o.$control.defineMethod("addFormatter", addFormatter);
        o.$control.defineMethod("setFormatter", setFormatter);
        o.$control.defineMethod("showHideCol", showHideCol);
        o.$control.defineMethod("setSelection", setSelection);
        o.$control.defineMethod("setMultiSelect", setMultiSelect);
        o.$control.defineMethod("setGrouping", setGrouping);
        o.$control.defineMethod("getGroupingSelectedData", getGroupingSelectedData);
        o.$control.defineMethod("setFrozen", setFrozen);
        o.$control.defineMethod("setPaging", setPaging);
        o.$control.defineMethod("resetPagingInfo", resetPagingInfo);
        o.$control.defineMethod("addSorting", addSorting);
        o.$control.defineMethod("setRowspan", setRowspan);
        o.$control.defineMethod("setSummary", setSummary);
        o.$control.defineMethod("setTreeGrid", setTreeGrid);
        o.$control.defineMethod("setButton", setButton);
        o.$control.defineMethod("addButton", addButton);
        o.$control.defineMethod("getButton", getButton);
        o.$control.defineMethod("addAction", addAction);
        o.$control.defineMethod("delAction", delAction);
        o.$control.defineMethod("setRowAction", setRowAction);
        o.$control.defineMethod("setRowSelectionByActionColumn", setRowSelectionByActionColumn);
        o.$control.defineMethod("setTableDnD", setTableDnD);
        o.$control.defineMethod("tableDnDUpdate", tableDnDUpdate);
        o.$control.defineMethod("addRow", addRow);
        o.$control.defineMethod("addRows", addRows);
        o.$control.defineMethod("deleteRow", deleteRow);
        o.$control.defineMethod("deleteSelectedRows", deleteSelectedRows);
        o.$control.defineMethod("stopEdit", stopEdit);
        o.$control.defineMethod("resetOrderNo", resetOrderNo);
        o.$control.defineMethod("getSelectedData", getSelectedData);
        o.$control.defineMethod("getDataTableRow", getDataTableRow);
        o.$control.defineMethod("getDataTableCell", getDataTableCell);
        o.$control.defineMethod("downloadExcel", downloadExcel);
        o.$control.defineMethod("getRowId", getRowId);
        o.$control.defineMethod("getRowIndex", getRowIndex);
        o.$control.defineMethod("getRowData", getRowData);
        o.$control.defineMethod("getValue", getValue);
        o.$control.defineMethod("setValue", setValue);
        o.$control.defineMethod("getValueRow", getValueRow);
        o.$control.defineMethod("getValueRowId", getValueRowId);
        o.$control.defineMethod("getTotalCount", getTotalCount);
        o.$control.defineMethod("clearData", clearData);
        o.$control.defineMethod("moveSelection", moveSelection);
        o.$control.defineMethod("resetConfig", resetConfig);

        o.$control.defineProperty("ds", { get: getDs });
        o.$control.defineProperty("loader", { get: getLoader });
        o.$control.defineProperty("headerRowHeight", { get: getHeaderRowHeight, set: setHeaderRowHeight });
        o.$control.defineProperty("frozenTableCorrect", { get: getFrozenTableCorrect, set: setFrozenTableCorrect });
        o.$control.defineProperty("rownumberDesc", { get: getRownumberDesc, set: setRownumberDesc });
        o.$control.defineProperty("autoColumn", { get: getAutoColumn, set: setAutoColumn });
        o.$control.defineProperty("rowCount", { get: getRowCount });
        o.$control.defineProperty("downloadTitle", { get: getDownloadTitle, set: setDownloadTitle });
        o.$control.defineProperty("headerDataset", { get: getHeaderDataset });
        o.$control.defineProperty("columnDataset", { get: getColumnDataset });
        o.$control.defineProperty("selectedRowDataList", { get: getSelectedRowDataList });
        o.$control.defineProperty("selectedRowIds", { get: getSelectedRowIds });
        o.$control.defineProperty("selectedRowId", { get: getSelectedRowId });
        o.$control.defineProperty("selectedRowIndex", { get: getSelectedRowIndex });

        var disabled = o.$control.attr("disabled"); o.$control.removeAttr("disabled");
        o.$control.defineProperty("disabled", { get: getDisabled, set: setDisabled });
        setDisabled(disabled == null ? false : disabled);

        for (var key in o.config()) {
            if (any.text.startsWith(key, "options.")) {
                o.options[key.substr("options.".length)] = o.config(key);
            }
        }

        any.control(control).initialize();

        control.isReady = (o.buttons["config"].show != true);

        resetConfig();

        addElementEvent("loadComplete", function(data) {
            loadComplete();
        });

        addElementEvent("onSortCol", function(index, iCol, sortorder) {
            if (o.options.multiSort != true) {
                o.sortings = [{ name: index, order: sortorder }];
                return;
            }

            o.sortings = [];

            if (index == "") {
                return;
            }

            var sortings = index.split(",");

            for (var i = 0, ii = sortings.length; i < ii; i++) {
                var sorting = any.text.trim(sortings[i]).split(" ");

                if (sorting.length >= 2) {
                    o.sortings.push({ name: any.text.trim(sorting[0]), order: any.text.trim(sorting[1]) });
                } else {
                    o.sortings.push({ name: any.text.trim(sorting[0]), order: sortorder });
                }
            }
        });

        addElementEvent("beforeEditCell", function(rowid, cellname, value, iRow, iCol) {
            if (o.editCell == null) {
                o.editCell = {};
            }
            o.editCell.row = iRow;
            o.editCell.col = iCol;
        });

        if (o.treeGridInfo != null && getColModel(o.treeGridInfo.keyColumn) == null) {
            addColumn({ name: o.treeGridInfo.keyColumn, key: true, hidden: true });
        }

        if (o.options.treeGrid == true) {
            o.options.datatype = new Function();
        }

        if (o.options.rowEdit == true || o.options.cellEdit == true) {
            jQuery(document.body).on("mousedown", function(event) {
                if (o.editCell == null || o.editCell.row == null || o.editCell.col == null) {
                    return;
                }

                if (o.$control.find('div.ui-jqgrid-bdiv').find(event.srcElement).length == 0) {
                    stopEdit();

                    delete(o.editCell.row);
                    delete(o.editCell.col);

                    window.setTimeout(function() {
                        jQuery(event.srcElement).focus();
                    });
                }
            });
        }

        o.defaultColModel = any.object.clone(o.options.colModel);
        o.defaultSortings = any.object.clone(o.sortings);

        activateGrid(control.isReady);

        initCodeData();

        o.$control.fire("onReady");
    })();

    function element()
    {
        return o.$element;
    }

    function getDs()
    {
        return o.ds;
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

        o.ds.dataLoader(function(data) {
            if (jQuery.type(data) === "object") {
                if ("totalCount" in data && "list" in data) {
                    this.loadData(data.list, true, { "_TOTAL_COUNT_": data.totalCount });
                } else {
                    this.loadData([data], true, data["_META_MAP"]);
                }
            } else if (jQuery.type(data) === "array") {
                this.loadData(data, true);
            }
        });

        o.ds.setBinder(function() {
            if (o.loader == null) {
                o.loader = {};
            }

            if (o.autoColumn === true) {
                reset(function() {
                    for (var i = 0, ii = o.ds.colCount(); i < ii; i++) {
                        this.addColumn({ width: 200, sortable: true, name: o.ds.colId(i), label: o.ds.colId(i) });
                    }
                });
            }

            o.loader.result = {};

            resetPagingInfo(o.loader.result);

            if (o.options.pager == null) {
                o.$element.jqGrid("setGridParam", { rowNum: o.loader.result.records });
            }

            if (o.loader.result.records == 0) {
                o.$element.jqGrid("setCaption", any.message("any.grid.caption.noRecords").toString());
            } else if (o.options.pager == null) {
                o.$element.jqGrid("setCaption", any.message("any.grid.caption.countWithoutPage").arg(any.text.formatNumber(o.loader.result.records)).toString());
            } else {
                o.$element.jqGrid("setCaption", any.message("any.grid.caption.countWithPage").arg(any.text.formatNumber(o.loader.result.records), (o.loader.result.page - 1) * o.loader.postdata.rows + 1, Math.min(o.loader.result.page * o.loader.postdata.rows, o.loader.result.records)).toString());
            }

            o.loader.result.rows = [];
            o.rowData = {};

            if (o.treeGridInfo != null) {
                this.hierarchy(o.treeGridInfo.keyColumn, o.treeGridInfo.parentKeyColumn, o.treeGridInfo.levelColumn);

                if (o.treeGridInfo.rootName != null) {
                    var rowData = {};
                    rowData[o.treeGridInfo.keyColumn] = o.treeGridInfo.rootKey;
                    rowData[o.treeGridInfo.parentKeyColumn] = null;
                    rowData[o.treeGridInfo.expandColumn] = o.treeGridInfo.rootName;
                    rowData[o.treeGridInfo.levelColumn] = o.options.tree_root_level;
                    rowData[o.options.treeReader.leaf_field] = false;
                    rowData[o.options.treeReader.expanded_field] = function() {
                        if (o.treeGridInfo.expandLevel == null) {
                            return false;
                        }
                        if (o.treeGridInfo.expandLevel == -1) {
                            return true;
                        }
                        if (o.treeGridInfo.expandLevel >= o.options.tree_root_level) {
                            return true;
                        }
                        return false;
                    }();
                    o.rowData[o.treeGridInfo.rootKey] = rowData;
                    o.loader.result.rows.push(rowData);
                }
            }

            for (var i = 0, ii = this.rowCount(); i < ii; i++) {
                var rowId;
                if (o.treeGridInfo == null) {
                    rowId = i + 1;
                } else {
                    rowId = this.rowData(i)[o.treeGridInfo.keyColumn];
                }
                o.rowData[rowId] = this.rowData(i);
                o.rowData[rowId]["=JQGRID-ROW-ID="] = String(i + 1);
                var rowData = {};
                for (var item in o.rowData[rowId]) {
                    rowData[item] = o.rowData[rowId][item];
                }
                if (o.treeGridInfo != null) {
                    rowData[o.options.treeReader.leaf_field] = !this.hasChild(i);
                    rowData[o.options.treeReader.expanded_field] = function() {
                        if (o.treeGridInfo.expandLevel == null) {
                            return false;
                        }
                        if (o.treeGridInfo.expandLevel == -1) {
                            return true;
                        }
                        if (o.treeGridInfo.expandLevel >= Number(rowData[o.treeGridInfo.levelColumn])) {
                            return true;
                        }
                        return false;
                    }();
                }
                o.loader.result.rows.push(rowData);
            }

            if (o.options.pager == null) {
                o.$element.jqGrid("setGridParam", { datatype: "json", loadonce: true });
            }

            o.$element[0].addJSONData(o.loader.result);

            if (o.options.pager == null && o.treeGridInfo == null) {
                var sortorder = any.text.blank(o.$element.jqGrid("getGridParam", "sortorder"), "asc").toLowerCase();
                if (o.options.multiSort == true) {
                    o.$element.jqGrid("setGridParam", { datatype: "local", multiSort: true, sortname: o.options.sortname }).trigger("reloadGrid");
                    if (o.frozen.index != -1) {
                        o.$element.jqGrid("setFrozenColumns");
                        o.$control.find('div.ui-jqgrid-hdiv.frozen-div').not(':first').remove();
                        if (o.$contextMenu != null) {
                            o.$contextMenu.exec("attach", o.$control.find('div.ui-jqgrid-hdiv, div.ui-jqgrid-bdiv, div.ui-jqgrid-hdiv.frozen-div, div.ui-jqgrid-bdiv.frozen-bdiv'));
                        }
                    }
                } else {
                    o.$element.jqGrid("setGridParam", { datatype: "local", sortorder: sortorder == "asc" ? "desc" : "asc" }).jqGrid("sortGrid");
                }
            }

            o.maxRowId = getDataTableRows().length;

            tableDnDUpdate();
            loadComplete();
            resizeAll();
        }, function() {
            stopEdit();

            if (o.options.rowEdit == true || o.options.cellEdit == true) {
                o.$element.jqGrid("saveRow", o.$element.jqGrid("getGridParam", "selrow"));
                if (o.rowData == null) {
                    o.rowData = {};
                }
                var rowIds = o.$element.jqGrid("getDataIDs");
                for (var i = 0, ii = rowIds.length; i < ii; i++) {
                    var rowId = rowIds[i];
                    var rowData = o.$element.jqGrid("getRowData", rowId);
                    if (o.rowData[rowId] == null) {
                        o.rowData[rowId] = o.ds.rowData(o.ds.addRow(rowData));
                    } else {
                        o.ds.rowData(o.ds.dataRow(o.rowData[rowId]), rowData, true);
                    }
                    o.rowData[rowId]["=JQGRID-ROW-ID="] = rowId;
                }
                for (var i = o.ds.rowCount() - 1, ii = 0; i >= ii; i--) {
                    var $tr = o.$element.find('tr[role="row"][id="' + o.ds.rowData(i)["=JQGRID-ROW-ID="] + '"].jqgrow');
                    if ($tr.length == 0 || $tr.data("isDeleted") == true) {
                        o.ds.deleteRow(i);
                    }
                }
            } else if (o.options.multiselect == true && o.selection != null) {
                o.ds.addColumn(o.selection.name);
                for (var rowId in o.rowData) {
                    o.rowData[rowId][o.selection.name] = o.selection.unselectValue;
                }
                var selRowIds = getSelectedRowIds();
                for (var i = 0, ii = selRowIds.length; i < ii; i++) {
                    o.rowData[selRowIds[i]][o.selection.name] = o.selection.selectValue;
                }
            }
        });
    }

    function initButtons()
    {
        o.buttons = {};

        addButton("refresh", {
            icon: "refresh",
            text: any.message("any.grid.button.reload.name"),
            title: any.message("any.grid.button.reload.title"),
            func: function() {
                if (o.loader != null && o.loader.reload != null) {
                    o.loader.reload();
                }
            },
            show: true
        });

        addButton("excel", {
            icon: "disk",
            text: any.message("any.grid.button.excel.name"),
            title: any.message("any.grid.button.excel.title"),
            func: function() {
                downloadExcel();
            },
            show: true
        });

        addButton("filter", {
            icon: "search",
            text: any.message("any.grid.button.filter.name"),
            title: any.message("any.grid.button.filter.title"),
            func: function() {
                toggleFilterToolbar();
                doFilter();
            },
            toggle: true,
            show: true
        });

        addButton("config", {
            icon: "gear",
            text: any.message("any.grid.button.config.name"),
            title: any.message("any.grid.button.config.title"),
            func: function() {
                doConfig();
            }
        });
    }

    function initFormatters()
    {
        o.formatter = {};

        addFormatter("any-number", function(cellValue, options, rowObject) {
            var formatoptions = options.colModel.formatoptions;

            if (formatoptions == null) {
                formatoptions = {};
            }

            if ("thousandsSeparator" in formatoptions) {
                return any.text.formatNumber(o.formatter.getCellValue(options, cellValue), formatoptions.decimalPlaces, formatoptions.thousandsSeparator);
            }

            return any.text.formatNumber(o.formatter.getCellValue(options, cellValue), formatoptions.decimalPlaces);
        });

        addFormatter("any-timestamp", function(cellValue, options, rowObject) {
            return any.text.empty(any.date(o.formatter.getCellValue(options, cellValue)).toString(any.meta.dateFormat + " hh:ii:ss.lll"), any.text.nvl(cellValue, ""));
        });

        addFormatter("any-datetime", function(cellValue, options, rowObject) {
            return any.text.empty(any.date(o.formatter.getCellValue(options, cellValue)).toString(any.meta.dateFormat + " hh:ii:ss"), any.text.nvl(cellValue, ""));
        });

        addFormatter("any-date", function(cellValue, options, rowObject) {
            return any.text.empty(any.date(o.formatter.getCellValue(options, cellValue)).toString(any.meta.dateFormat), any.text.nvl(cellValue, ""));
        });

        addFormatter("any-html", function(cellValue, options, rowObject) {
            return any.text.toHTML(o.formatter.getCellValue(options, cellValue), true);
        });

        o.formatter.getCellValue = function(options, cellValue)
        {
            if (options.rowId == null || options.rowId == "") {
                return cellValue;
            }

            var rowData = getRowData(options.rowId);

            if (rowData == null) {
                return cellValue;
            }

            return rowData[options.colModel.name];
        };
    }

    function initCodeData()
    {
        var codeDataLoader = any.codedata();

        for (var i = 0, ii = o.options.colModel.length; i < ii; i++) {
            var option = o.options.colModel[i]["column-option"];
            if (option != null) {
                codeDataLoader.append(option.codeData);
            }
        }

        codeDataLoader.load();
    }

    function getTableElement()
    {
        return jQuery('<table>').attr("id", control.id + "_table").appendTo(o.$control);
    }

    function activateGrid(fireEvent)
    {
        delete(o.$loadUI);

        o.$element.jqGrid(o.options).jqGrid("navGrid", "#" + o.options.pager, { edit: false, add: false, del: false, search: false, refresh: false }, {}, {}, {}, {multipleSearch:true});

        if (o.groupHeaders != null) {
            var groupHeaders = [];
            for (var i = 0, ii = o.groupHeaders.length; i < ii; i++) {
                var groupHeader = { startColumnName: o.groupHeaders[i].start, numberOfColumns: 0, titleText: o.groupHeaders[i].label };
                for (var j = 0, jj = o.options.colModel.length; j < jj; j++) {
                    if (o.options.colModel[j].name == o.groupHeaders[i].start) {
                        groupHeader.numberOfColumns = 1;
                    } else if (groupHeader.numberOfColumns != 0) {
                        groupHeader.numberOfColumns++;
                    }
                    if (o.options.colModel[j].name == o.groupHeaders[i].end) {
                        break;
                    }
                }
                groupHeaders.push(groupHeader);
            }
            o.$element.jqGrid("setGroupHeaders", { useColSpanStyle: o.frozen.index == -1, groupHeaders: groupHeaders });
        }

        if (o.removeTitlebar == true) {
            o.$control.find('div.ui-jqgrid-titlebar').remove();
        } else {
            o.$control.find('div.ui-jqgrid-titlebar').css("padding-left", "8px").css("padding-right", "5px");
        }

        for (var name in o.buttons) {
            var spec = o.buttons[name];

            if (spec == null) {
                continue;
            }

            delete(spec.toggleActivated);

            spec.toggleButtonStyle = function()
            {
                if (this.toggleActivated === true) {
                    this.$button.addClass("ui-state-hover").css("padding", "0px");
                } else {
                    this.$button.removeClass("ui-state-hover").removeCss("padding");
                }
            };

            spec.toggleButton = function(isActivate, isClick)
            {
                if (this.toggle == true) {
                    if (isActivate == null) {
                        this.toggleActivated = (this.toggleActivated !== true);
                    } else {
                        if (this.toggleActivated === isActivate) {
                            return;
                        }
                        this.toggleActivated = isActivate;
                    }
                }

                if (isClick != true) {
                    this.toggleButtonStyle();
                }

                this.func.apply(this, [this.toggleActivated]);

                if (this.toggle == true) {
                    o.$control.fire("onButtonToggleAfter", [this.$button.attr("name"), this.toggleActivated]);
                }
            };

            if (o.$buttons == null) {
                o.$buttons = jQuery('<tr>').appendTo(jQuery('<tbody>').appendTo(jQuery('<table>').attr({ "border": "0", "cellspacing": "0", "cellpadding": "0" }).addClass("ui-pg-table navtable").css({ "table-layout": "auto", "float": "right" }).appendTo(o.$control.find('div.ui-jqgrid-titlebar'))));
            }

            spec.$button = jQuery('<td>').attr({ "name": name, "title": any.text.nvl(spec.title, spec.text) }).addClass("ui-pg-button ui-corner-all").css("cursor", "pointer").showHide(spec.show).appendTo(o.$buttons);
            spec.$button.append(jQuery('<div>').addClass("ui-pg-div").css("margin-right", "3px").append(jQuery('<span>').addClass("ui-icon ui-icon-" + spec.icon)).append(jQuery('<span>').css("margin-top", "2px").text(spec.text)));

            spec.$button.on("mouseover", function() {
                jQuery(this).addClass("ui-state-hover");
            });

            spec.$button.on("click", function() {
                o.buttons[jQuery(this).attr("name")].toggleButton(null, true);
            });

            spec.$button.on("mouseout", function() {
                o.buttons[jQuery(this).attr("name")].toggleButtonStyle();
            });
        }

        if (o.buttons["filter"].show === true) {
            o.$element.jqGrid("filterToolbar", { stringResult: true, searchOnEnter: false, autosearch: false });
        }

        if (o.frozen.index != -1) {
            if (o.options.cellEdit == true) {
                o.$element.jqGrid("setGridParam", { cellEdit: false });
                o.$element.jqGrid("setFrozenColumns");
                o.$element.jqGrid("setGridParam", { cellEdit: o.options.cellEdit });
            } else {
                o.$element.jqGrid("setFrozenColumns");
            }
            o.$control.find('div.ui-jqgrid-hdiv.frozen-div').children('table.ui-jqgrid-htable').find('th').css("white-space", "nowrap");
            o.$frozenSearchToolbarTr = o.$control.find('div.ui-jqgrid-hdiv.frozen-div').css("overflow-y", "hidden").find('tr.ui-search-toolbar');
            o.$frozenSearchToolbarDummy = jQuery('<tr>').addClass("ui-search-toolbar").append(jQuery('<th>').attr("colspan", o.$frozenSearchToolbarTr.children('th').length));
            o.$frozenSearchToolbarTr.after(o.$frozenSearchToolbarDummy);
        }

        if (o.buttons["filter"].show === true) {
            o.$control.find('tr.ui-search-toolbar').find('input:text').enter(function() {
                doFilter();
            });
            o.$control.find('tr.ui-search-toolbar').find('td.ui-search-clear').children('a').click(function() {
                doFilter();
            });
            toggleFilterToolbar();
        }

        appendFrozenGroupHeaderDummyTh();

        if (o.$contextMenu != null) {
            o.$contextMenu.remove();
        }

        if (o.removeContextMenu != true && o.options.rowEdit != true && o.options.cellEdit != true) {
            o.$contextMenu = jQuery('<div>').control("any-contextmenu", function() {
                this.setDynamic(function() {
                    if (o.clipboardText != null && o.clipboardText != "") {
                        this.addMenu(any.message("any.grid.button.copyCell.title", "Copy Cell") + " : " + (o.clipboardText.length > 30 ? o.clipboardText.substr(0, 30) + "..." : o.clipboardText));
                        this.addSeparator();
                    }
                    if (o.buttons["refresh"].show === true) {
                        this.addMenu(any.message("any.grid.button.reload.title", "Reload"), function(menuItem, menu) {
                            o.loader.reload();
                        }, { disabled: o.loader == null || o.loader.prx == null });
                    }
                    if (o.buttons["excel"].show === true) {
                        this.addMenu(any.message("any.grid.button.excel.title", "Excel Download"), function(menuItem, menu) {
                            downloadExcel();
                        }, { disabled: o.loader == null || o.loader.prx == null });
                    }
                    if (o.buttons["config"].show === true) {
                        this.addSeparator();
                        this.addMenu(any.message("any.grid.button.config.title", "Configuration"), function(menuItem, menu) {
                            doConfig();
                        });
                    }
                });
                this.setOption("theme", "vista");
                this.setOption("beforeShow", function(target, e) {
                    jQuery('div.context-menu').closest('table').remove();
                    if (typeof(window.Clipboard) === "function") {
                        try {
                            delete(o.clipboardText);
                            var event = (e == null ? window.event : e);
                            if (event != null && event.target != null) {
                                var $target = jQuery(event.target);
                                if (!($target.tag() == "DIV" && ($target.hasClass("ui-jqgrid-hdiv") == true || $target.hasClass("ui-jqgrid-bdiv") == true))) {
                                    o.clipboardText = event.target.innerText;
                                }
                            }
                        } catch(e) {
                            delete(o.clipboardText);
                        }
                    }
                    return true;
                });
                this.attach(o.$control.find('div.ui-jqgrid-hdiv, div.ui-jqgrid-bdiv'));
            }).appendTo(document.body);

            if (o.contextMenuClipboard == null && typeof(window.Clipboard) === "function") {
                o.contextMenuClipboard = new Clipboard('.context-menu-item-inner', {
                    triggerListen: "mousedown",
                    text: function(trigger) {
                        var clipboardText = any.text.replaceAll(o.clipboardText, "\u00A0", " ");
                        delete(o.clipboardText);
                        return clipboardText;
                    }
                });
            }
        }

        resetDummyDataDiv();

        if (o.headerRowHeight != null) {
            setHeaderRowHeight(o.headerRowHeight);
        }

        if (fireEvent === true) {
            o.$control.fire("onGridActivated");
        }
    }

    function toggleFilterToolbar()
    {
        if (o.$element[0].toggleToolbar == null) {
            return;
        }

        var $toolbar = o.$control.find('tr.ui-search-toolbar').not(o.$frozenSearchToolbarDummy);

        if ($toolbar == null || $toolbar.length == 0) {
            return;
        }

        if (o.buttons["filter"].toggleActivated == $toolbar.is(':visible')) {
            return;
        }

        o.$element[0].toggleToolbar();

        if (o.buttons["filter"].toggleActivated != $toolbar.is(':visible')) {
            o.buttons["filter"].toggleActivated = ($toolbar.is(':visible') == true);
            o.buttons["filter"].toggleButtonStyle();
        }

        if (o.$frozenSearchToolbarDummy != null) {
            o.$frozenSearchToolbarDummy.show();
        }

        if (o.$element[0].grid.fhDiv != null) {
            jQuery(o.$element[0].grid.fhDiv).css(jQuery(o.$element[0].grid.hDiv).position());
        }

        if (o.$element[0].grid.fbDiv != null) {
            jQuery(o.$element[0].grid.fbDiv).css(jQuery(o.$element[0].grid.bDiv).position());
        }

        resizeHeight();
    }

    function reset(func, check, callback, addon)
    {
        if (typeof(check) === "function") {
            if (check.apply(control) !== true) {
                if (typeof(callback) === "function") {
                    callback();
                }
                return;
            }
        }

        o.sortings = [];
        o.actions = {};

        o.options.colModel = [];
        o.options.grouping = false;

        delete(o.options.sortname);
        delete(o.options.sortorder);
        delete(o.options.multiselect);
        delete(o.options.groupingView);
        delete(o.options.footerrow);
        delete(o.actionClassIndex);
        delete(o.tableDnD);

        o.$element.jqGrid("GridDestroy");
        o.$element = getTableElement();

        o.$buttons.remove();
        o.$buttons = null;

        delete(resetConfig.executed);

        if (typeof(func) === "function") {
            func.apply(control);

            o.defaultColModel = any.object.clone(o.options.colModel);
            o.defaultSortings = any.object.clone(o.sortings);

            if (o.configInfo != null && o.configInfo.ds != null && o.configInfo.ds.column != null) {
                for (var i = 0, ii = o.configInfo.ds.column.rowCount(); i < ii; i++) {
                    if (o.configInfo.ds.column.value(i, "SHOW") != "1") {
                        var colModel = getColModel(o.configInfo.ds.column.value(i, "NAME"))

                        if (colModel != null) {
                            colModel.hidden = true;
                        }
                    }
                }
            }

            o.$control.fire("onResetFunctionAfter");
        }

        activateGrid();

        if (typeof(func) === "function") {
            o.$control.fire("onResetGridActivated");
        }

        resizeHeight();

        if (o.buttons["config"].show === true && typeof(func) === "function" && resetConfig.executed == null) {
            resetConfig(function() {
                if (typeof(addon) === "function") {
                    return addon.apply(control);
                }
            }(), callback);
        } else if (typeof(callback) === "function") {
            callback();
        }
    }

    function reset2(func)
    {
        var f = {};
        var o = { func: func };

        f.executeCheck = function(check)
        {
            o.check = check;

            return f;
        };

        f.callback = function(callback)
        {
            o.callback = callback;

            return f;
        };

        f.configAddonPath = function(addon)
        {
            o.addon = addon;

            return f;
        };

        f.execute = function()
        {
            reset(o.func, o.check, o.callback, o.addon);
        };

        return f;
    }

    function resizeAll()
    {
        window.setTimeout(function() {
            jQuery('div[any-container=""]').parent('div').css("overflow-x", "hidden");

            resizeWidth();
            resizeHeight();

            o.$control.fire("onResizeAll");
        });
    }

    function resizeWidth(force)
    {
        if (o.$control.width() == 0) {
            return;
        }

        var $gbox = o.$control.find('div#gbox_' + control.id + '_table');
        var $gview = o.$control.find('div#gview_' + control.id + '_table');

        if ($gbox.width() == 0) {
            $gbox.width("");
        }
        if ($gview.width() == 0) {
            $gview.width("");
        }

        var controlWidth = o.$control.innerWidth();

        if (force != true && controlWidth == o.controlWidth) {
            return this;
        }

        var $gbox = o.$control.children('div#gbox_' + control.id + '_table');

        o.$element.jqGrid("setGridWidth", controlWidth - ($gbox.outerWidth(true) - $gbox.width()));

        o.controlWidth = controlWidth;
    }

    function resizeHeight()
    {
        if (o.options.height == "auto" || o.options.height == "100%") {
            return;
        }

        if (o.$control.height() == 0) {
            return;
        }

        var titlebarHeight = any.object.nvl(o.$control.find('div.ui-jqgrid-titlebar').outerHeight(true), 0);
        var hdivHeight = any.object.nvl(o.$control.find('div.ui-jqgrid-hdiv').outerHeight(true), 0);
        var sdivHeight = any.object.nvl(o.$control.find('div.ui-jqgrid-sdiv').outerHeight(true), 0);
        var pagerHeight = any.object.nvl(o.$control.find('div.ui-jqgrid-pager').outerHeight(true), 0);
        var $gbox = o.$control.children('div#gbox_' + control.id + '_table');

        o.$element.jqGrid("setGridHeight", o.$control.height() - titlebarHeight - hdivHeight - sdivHeight - pagerHeight - ($gbox.outerHeight(true) - $gbox.height()));

        if (o.frozen.correctTableHeight == true) {
            o.$control.find('div.ui-jqgrid-hdiv.frozen-div').css({ "top": titlebarHeight, "height": "" });
            o.$control.find('div.ui-jqgrid-bdiv.frozen-bdiv').css({ "top": titlebarHeight + hdivHeight });
        }
    }

    function removeTitlebar()
    {
        o.removeTitlebar = true;

        var $titlebar = o.$control.find('div.ui-jqgrid-titlebar');

        if ($titlebar.length > 0) {
            $titlebar.remove();
            resizeHeight();
        }
    }

    function removeContextMenu()
    {
        o.removeContextMenu = true;
    }

    function getOption(name)
    {
        return o.options[name];
    }

    function setOption()
    {
        any.copyArguments(o.options, arguments);
    }

    function addElementEvent(key, func)
    {
        func.origin = o.options[key];

        o.options[key] = function()
        {
            if (func.origin != null) {
                func.origin.apply(this, arguments);
            }

            func.apply(this, arguments);
        };
    }

    function addGroupHeader(obj)
    {
        if (o.groupHeaders == null) {
            o.groupHeaders = [];
        }

        o.groupHeaders.push(obj);
    }

    function addColumn(model, option)
    {
        if (model.sorttype == null && (model.formatter == "number" || model.formatter == "any-number")) {
            model.sorttype = "number";
        }

        if (typeof(model.formatter) === "string") {
            model["formatter-name"] = model.formatter;

            var formatter = o.formatter[model.formatter];

            if (formatter != null) {
                if (formatter.formatter != null) {
                    model.formatter = formatter.formatter;
                }
                if (formatter.unformat != null) {
                    model.unformat = formatter.unformat;
                }
            }
        }

        model["column-option"] = option;

        if (option != null && option.codeData != null) {
            if (model.formatter == null) {
                model.formatter = function(cellValue, options, rowObject)
                {
                    return any.codedata().name(options.colModel["column-option"].codeData, cellValue);
                };
            }
            if (model.editoptions == null) {
                var codeData = any.codedata().get(option.codeData);
                var values = [];
                if (option.firstName != null) {
                    values.push(":" + any.codedata.getFirstName(option.firstName));
                }
                for (var i = 0, ii = codeData.data.length; i < ii; i++) {
                    values.push(codeData.data[i].data.CODE + ":" + codeData.data[i].data.NAME);
                }
                model.editoptions = { value: values.join(";") };
            }
        }

        if (model.label != null) {
            model.label = model.label + "";
        }

        if (option == null || option.unused !== true) {
            o.options.colModel.push(model);
        } else {
            if (o.unusedModel == null) {
                o.unusedModel = {};
            }
            o.unusedModel[model.name] = model;
        }
    }

    function getColModel(colName)
    {
        for (var i = 0, ii = o.options.colModel.length; i < ii; i++) {
            if (o.options.colModel[i].name == colName) {
                return o.options.colModel[i];
            }
        }
    }

    function addFormatter(name, formatter, unformat)
    {
        o.formatter[name] = { formatter: formatter, unformat: unformat };

        if (o.options.colModel == null) {
            return;
        }

        for (var i = 0, ii = o.options.colModel.length; i < ii; i++) {
            if (o.options.colModel[i].formatter == name) {
                setFormatter(o.options.colModel[i].name, formatter, unformat);
            }
        }
    }

    function setFormatter(colName, formatter, unformat)
    {
        var model = getColModel(colName);

        if (model == null) {
            return;
        }

        model.formatter = formatter;

        if (unformat != null) {
            model.unformat = unformat;
        }
    }

    function showHideCol(colName, showHide)
    {
        o.$element.jqGrid(showHide == true ? "showCol" : "hideCol", colName);

        resizeWidth(true);
    }

    function setSelection(name, selectValue, unselectValue)
    {
        o.selection = { name: name };

        if (selectValue == null) {
            o.selection.selectValue = any["boolean"](o.config("booleanValues")).trueValue();
        } else {
            o.selection.selectValue = selectValue;
        }

        if (unselectValue == null) {
            o.selection.unselectValue = any["boolean"](o.config("booleanValues")).falseValue();
        } else {
            o.selection.unselectValue = unselectValue;
        }
    }

    function setMultiSelect(func, linkSelection)
    {
        o.options.multiselect = true;
        o.multiSelectFunction = func;

        if (o.options.cellEdit == true) {
            return;
        }

        if (o.multiSelectOnBeforeSelectRowAdded == true) {
            return;
        }

        o.multiSelectOnBeforeSelectRowAdded = true;

        addElementEvent("beforeSelectRow", function(rowId, event) {
            if (o.options.multiselect != true) {
                o.$element.jqGrid("setSelection", rowId);
                return true;
            }

            var $src = jQuery(event.srcElement || event.target);

            if (!($src.tag() == "INPUT" && $src.attr("role") == "checkbox" && $src.hasClass("cbox") == true)) {
                $src = $src.closest('td');
            }

            var qry = 'input[role="checkbox"].cbox:enabled';

            if (o.config("multiselect.checkboxOnly") === true && $src.closest('td').children(qry).length == 0) {
                if (linkSelection !== true || $src.data("linkActionEnable") !== true) {
                    return;
                }
            }

            if ($src.data("linkActionEnable") === true) {
                if (linkSelection !== true) {
                    return;
                }
                if (event.ctrlKey === true) {
                    if (jQuery.inArray(rowId, getSelectedRowIds()) != -1) {
                        o.$element.jqGrid("setSelection", rowId);
                    }
                } else if (event.altKey !== true) {
                    o.$element.jqGrid("resetSelection");
                }
            }

            if (o.rowAction != null && $src.children(qry).length == 0 && $src.is(qry) != true) {
                return;
            }

            if (getDataTableRow(rowId).find(qry).length > 0) {
                o.$element.jqGrid("setSelection", rowId);
            }
        });
    }

    function setGrouping(groupingView, options)
    {
        if (options != null && options.checkbox == true) {
            groupingView.groupText[0] = '<input type="checkbox" style="vertical-align:middle;">&nbsp;' + groupingView.groupText[0];
        }

        setOption({ grouping: true, groupingView: groupingView });
    }

    function getGroupingSelectedData(colNames)
    {
        var ds = any.ds("ds_" + control.id + "_groupingSelected").dataOnly(true).init();

        o.$control.find('table#' + control.id + '_table').find('tr.jqgroup > td > input:checkbox').each(function() {
            if (this.checked != true) {
                return true;
            }
            var row = ds.addRow();
            for (var i = 0, ii = colNames.length; i < ii; i++) {
                ds.value(row, colNames[i], getValue(jQuery(this).parent().parent().next().attr("id"), colNames[i]));
            }
        });

        return ds;
    }

    function setFrozen(name, correctTableHeight)
    {
        o.frozen.name = name;

        for (var i = 0; i < o.options.colModel.length; i++) {
            if (o.options.colModel[i].name == name) {
                o.frozen.index = i;
                break;
            }
        }

        for (var i = 0; i <= o.frozen.index; i++) {
            o.options.colModel[i].frozen = true;
        }

        if (correctTableHeight != null) {
            o.frozen.correctTableHeight = correctTableHeight;
        }
    }

    function setPaging(rowList, rowNum)
    {
        if (o.options.treeGrid == true) {
            return;
        }

        o.options.pager = jQuery('<div>').attr("id", control.id + "_pager").appendTo(o.$control).attr("id");
        o.options.rowList = (rowList == null ? any.object.nvl(o.config("paging.rowList"), [ 20, 50, 100, 150, 200 ]) : rowList);
        o.options.rowNum = (rowNum == null ? any.object.nvl(o.config("paging.rowNum"), 50) : rowNum);
    }

    function resetPagingInfo(obj, ds)
    {
        if (ds == null) {
            ds = o.ds;
        }

        if (o.options.pager == null) {
            obj.records = ds.rowCount();
        } else {
            obj.records = getTotalCount(ds);
            obj.total = Math.max(parseInt((obj.records - 1) / o.loader.postdata.rows + 1, 10), 1);
            obj.page = o.loader.postdata.page;
        }
    }

    function addSorting(name, order)
    {
        o.sortings.push({ name: name, order: order });

        if (o.options.multiSort == true) {
            var sortnames = [];
            for (var i = 0, ii = o.sortings.length; i < ii; i++) {
                sortnames.push(o.sortings[i].name + " " + o.sortings[i].order.toLowerCase());
            }
            o.options.sortname = sortnames.join(", ");
            o.options.sortorder = order;
        } else if (o.sortings.length == 1) {
            o.options.sortname = name;
            o.options.sortorder = order;
        }
    }

    function appendFrozenGroupHeaderDummyTh()
    {
        if (o.frozen.index == -1) {
            return;
        }
        if (o.groupHeaders == null) {
            return;
        }

        o.$control.find('div.ui-jqgrid-hdiv.frozen-div').css("overflow-x", "hidden").children('table.ui-jqgrid-htable').find('tr[role="rowheader"]').not('.ui-search-toolbar').each(function() {
            if (jQuery(this).children('th[role="rowspan-dummy"]').length == 0) {
                jQuery('<th role="rowspan-dummy">').appendTo(this);
            }
        });
    }

    function appendFrozenRowspanDummyTd()
    {
        if (o.frozen.index == -1) {
            return;
        }
        if (o.rowspan == null) {
            return;
        }

        o.$control.find('div.ui-jqgrid-bdiv.frozen-bdiv').css("overflow-x", "hidden").children('table.ui-jqgrid-btable').find('tr[role="row"].jqgrow').each(function() {
            if (jQuery(this).children('td[role="rowspan-dummy"]').length == 0) {
                jQuery('<td role="rowspan-dummy">').appendTo(this);
            }
        });
    }

    function setRowspan(arg1, arg2, arg3)
    {
        if (arguments.length >= 2 && typeof(arguments[0]) === "string" && typeof(arguments[1]) === "string") {
            o.rowspan = { columns: [], restrict: arg3 };

            for (var i = 0, ii = o.options.colModel.length; i < ii; i++) {
                if (o.options.colModel[i].name == arg1 || o.rowspan.columns.length > 0) {
                    o.rowspan.columns.push(o.options.colModel[i].name);
                    if (o.rowspan.columns.length > 0 && o.options.colModel[i].name == arg2) {
                        break;
                    }
                }
            }
        } else {
            o.rowspan = { columns: arg1, restrict: arg2 };
        }
    }

    function applyRowspan(afterFilter)
    {
        if (o.rowspan == null) {
            return;
        }

        if (afterFilter == true) {
            for (var c = 0, cc = o.rowspan.columns.length; c < cc; c++) {
                var elemId = control.id + "_table_" + o.rowspan.columns[c];

                if (o.$control.find('div.ui-jqgrid-hbox table.ui-jqgrid-htable th[role="columnheader"]#' + elemId).is(':visible')) {
                    o.$control.find('div.ui-jqgrid-bdiv table.ui-jqgrid-btable td[role="gridcell"][aria-describedby="' + elemId + '"]').removeAttr("rowspan").show();
                }
            }
        }

        appendFrozenRowspanDummyTd();

        var $rows = getDataTableRows(true);

        for (var c = 0, cc = o.rowspan.columns.length; c < cc; c++) {
            var spanrow = 0;
            var spannum = 1;
            var firstRow = true;

            for (var r = 0, rr = $rows.length; r < rr; r++) {
                if (afterFilter == true && $rows.eq(r).css("display") == "none") {
                    continue;
                }

                var $td = $getTd(r, o.rowspan.columns[c]);
                var $prevTd;

                if (o.frozen.index != -1 && $td.closest('table')[0] != $getTd(spanrow, o.rowspan.columns[c]).closest('table')[0]) {
                    firstRow = true;
                }

                if (c > 0 && o.rowspan.restrict == true) {
                    $prevTd = $getTd(r, o.rowspan.columns[c - 1]);
                }

                if ($prevTd != null && $prevTd.attr("rowspan") == 1) {
                    $td.attr("rowspan", 1);
                } else {
                    if (firstRow != true && $td.text() == $getTd(spanrow, o.rowspan.columns[c]).text() && ($prevTd == null || $prevTd.attr("rowspan") == null)) {
                        $td.hide();
                        spannum++;
                    } else {
                        $getTd(spanrow, o.rowspan.columns[c]).attr("rowspan", spannum);
                        spanrow = r;
                        spannum = 1;
                    }
                }

                firstRow = false;
            }

            $getTd(spanrow, o.rowspan.columns[c]).attr("rowspan", spannum);
        }

        function $getTd(row, colName)
        {
            return $rows.eq(row).children('td[role="gridcell"][aria-describedby="' + control.id + '_table_' + colName + '"]');
        }
    }

    function setSummary(label, css)
    {
        o.options.footerrow = true;
        o.summary = { label: label, css: css };

        addElementEvent("beforeSaveCell", function(rowid, cellname, value, iRow, iCol) {
            resetSummaryData(cellname, value);
        });
    }

    function resetSummaryLabel()
    {
        if (o.summary == null) {
            return;
        }

        var $fTableCells = o.$control.find('div.ui-jqgrid-sdiv table.ui-jqgrid-ftable td[role="gridcell"]');
        var $labelCell;

        $fTableCells.each(function() {
            var $this = jQuery(this);
            var colName = $this.attr("aria-describedby").replace(control.id + "_table_", "");
            var colModel = getColModel(colName);

            if (colModel == null) {
                return true;
            }

            if (colModel.summaryType != null && colModel.summaryTpl == null) {
                return false;
            }

            if (colModel.hidden != true) {
                $labelCell = $this;
            }
        });

        if ($labelCell == null) {
            return;
        }

        for (var i = $labelCell.index(); i < $fTableCells.length; i++) {
            var $this = $fTableCells.eq(i);
            var colName = $this.attr("aria-describedby").replace(control.id + "_table_", "");
            var colModel = getColModel(colName);

            if (colModel.summaryType == null) {
                $this.empty().removeAttr("title");
            }
        }

        jQuery('<div>').text(o.summary.label).attr({ "title": o.summary.label }).css({ "float": "right", "padding-right": "2px" }).appendTo($labelCell.empty());

        $labelCell.attr({ "title": o.summary.label }).css({ "overflow": "visible" }).prevAll().each(function() {
            var $this = jQuery(this).empty().removeAttr("title").css("border-right", "transparent");

            if ($this.is(':first-child') != true) {
                $this.css("border-left", "transparent");
            }
        });

        if (o.summary.css != null) {
            if (o.summary.css.row != null) {
                $fTableCells.css(o.summary.css.row);
            }
            if (o.summary.css.label != null) {
                $labelCell.css(o.summary.css.label);
            }
        }
    }

    function resetSummaryData(name, value)
    {
        if (o.summary == null) {
            return;
        }

        value = any.text.replaceAll(value, ",", "");

        var footerData = {};

        for (var i = 0, ii = o.options.colModel.length; i < ii; i++) {
            if (o.options.colModel[i].summaryType == null) {
                continue;
            }
            if (name != null && name != o.options.colModel[i].name) {
                continue;
            }
            footerData[o.options.colModel[i].name] = function(colModel) {
                var colValues = o.$element.jqGrid("getCol", colModel.name);
                var sumValue = (value == null || value == "" || isNaN(value) ? 0 : Number(value));
                var avgCount = 0;
                for (var i = 0, ii = colValues.length; i < ii; i++) {
                    var colValue = any.text.replaceAll(colValues[i], ",", "");
                    if (colValue == null || colValue == "" || isNaN(colValue)) {
                        continue;
                    }
                    sumValue += Number(colValue);
                    avgCount++;
                }
                switch (colModel.summaryType) {
                case "sum":
                    return sumValue;
                case "avg":
                    return avgCount == 0 ? null : sumValue / avgCount;
                case "avg2":
                    return colValues.length == 0 ? null : sumValue / colValues.length;
                }
            }(o.options.colModel[i]);
        }

        o.$element.jqGrid("footerData", "set", footerData);
    }

    function setTreeGrid(obj)
    {
        delete(o.options.pager);
        delete(o.options.rowList);
        delete(o.options.rowNum);

        o.treeGridInfo = obj;

        o.options.treeGrid = true;
        o.options.treeGridModel = "adjacency";

        if (o.options.rownumbers == true) {
            for (var i = 0, ii = o.options.colModel.length - 1; i < ii; i++) {
                if (o.options.colModel[i].name == obj.expandColumn) {
                    o.options.ExpandColumn = o.options.colModel[i + 1].name;
                    break;
                }
            }
            if (o.options.ExpandColumn == null) {
                o.options.ExpandColumn = obj.expandColumn;
            }
        } else {
            o.options.ExpandColumn = obj.expandColumn;
        }

        if (o.options.tree_root_level == null) {
            o.options.tree_root_level = 0;
        }

        o.options.treeReader = {};
        o.options.treeReader.parent_id_field = obj.parentKeyColumn;
        o.options.treeReader.level_field = obj.levelColumn;
        o.options.treeReader.leaf_field = "=JQGRID-TREE-LEAF=";
        o.options.treeReader.expanded_field = "=JQGRID-TREE-EXPANDED=";
    }

    function setButton(obj)
    {
        for (var name in obj) {
            if (o.buttons[name] != null) {
                o.buttons[name].show = obj[name];
            }

            if (o.$buttons != null) {
                o.$buttons.children('td[name="' + name + '"]').showHide(obj[name]);
            }

            if (name == "filter") {
                window.setTimeout(function() {
                    doFilter();
                });
            }
        }
    }

    function addButton(name, spec)
    {
        o.buttons[name] = spec;
    }

    function getButton(name, elem)
    {
        var spec = o.buttons[name];

        if (elem === true) {
            return spec == null ? null : spec.$button;
        }

        return spec;
    }

    function addAction(colName, action, check, css, summary)
    {
        if (jQuery.type(colName) === "array") {
            for (var i = 0, ii = colName.length; i < ii; i++) {
                addAction(colName[i], action, check, css, summary);
            }
            return;
        }

        if (typeof(action) === "object") {
            o.actions[colName] = action;
        } else {
            o.actions[colName] = { action: action, check: check, summary: summary };
        }

        if (css == null) {
            var linkActions = o.config("link.actions");

            if (linkActions != null) {
                if (o.actionClassIndex == null) {
                    o.actionClassIndex = 0;
                }
                o.actions[colName].className = linkActions[o.actionClassIndex % linkActions.length];
                o.actionClassIndex++;
            }
        } else {
            if (typeof(css) === "string") {
                o.actions[colName].className = css;
            } else if (typeof(css) === "object") {
                o.actions[colName].css = css;
            }
        }
    }

    function delAction(colName)
    {
        o.$element.find('td[role="gridcell"][aria-describedby="' + control.id + '_table_' + colName + '"]').each(function() {
            var $this = jQuery(this);
            $this.removeData("linkActionEnable").css({ "text-decoration": "", "cursor": "" }).removeClass("any-jqgrid-linkaction");
            if (o.actions[colName].className != null) {
                $this.removeClass(o.actions[colName].className);
            }
            if (o.actions[colName].css != null && o.actions[colName].css.del) {
                $this.css(o.actions[colName].css.del);
            }
        });

        delete(o.actions[colName]);
    }

    function setRowAction(func, isDblClick)
    {
        o.rowAction = { func: func, isDblClick: isDblClick };
    }

    function setRowSelectionByActionColumn(colName)
    {
        o.rowSelectionByActionColumnName = colName;

        addElementEvent("beforeSelectRow", function(rowId, event) {
            if ($getCell(jQuery(event.srcElement || event.target)).data("linkActionEnable") === true) {
                o.$element.jqGrid("setSelection", rowId);
            }
        });

        function $getCell($elem)
        {
            return $elem.tag() == "TD" && $elem.attr("role") == "gridcell" ? $elem : $getCell($elem.parent());
        }
    }

    function setTableDnD(bool)
    {
        o.tableDnD = (bool == null ? true : bool);
    }

    function tableDnDUpdate()
    {
        if (o.tableDnD != true) {
            return;
        }

        if (jQuery.fn.tableDnD == null) {
            any.loadScript(o.config("url.plugins") + "/jquery.tablednd.js", function() {
                update();
            });
        } else {
            update();
        }

        function update()
        {
            if (o.$element[0].tableDnDConfig == null) {
                o.$element.tableDnD({ scrollAmount: 0 });
            }

            o.$element.tableDnDUpdate();
        }
    }

    function addRow(rowData, keyNames)
    {
        if (keyNames != null) {
            var keyData = {};

            for (var i = 0, ii = keyNames.length; i < ii; i++) {
                keyData[keyNames[i]] = rowData[keyNames[i]];
            }

            var row = o.ds.valueRow(keyData);

            if (row != -1) {
                var rowId = o.ds.rowData(row)["=JQGRID-ROW-ID="];
                var $tr = o.$element.find('tr[role="row"][id="' + rowId + '"].jqgrow');

                if ($tr.length == 0) {
                    o.$element.jqGrid("addRowData", rowId, rowData || {});
                }

                if (o.ds.jobType(row) == "D") {
                    o.ds.restoreRow(row);
                }

                return rowId;
            }
        }

        o.maxRowId = String(Number(any.object.nvl(o.maxRowId, 0)) + 1);

        if (o.rowData == null) {
            o.rowData = {};
        }

        if (rowData["=JQGRID-ROW-ID="] == null) {
            rowData["=JQGRID-ROW-ID="] = o.maxRowId;
        }

        o.rowData[o.maxRowId] = o.ds.rowData(o.ds.addRow(rowData));

        o.$element.jqGrid("addRowData", o.maxRowId, rowData || {});

        return o.maxRowId;
    }

    function addRows(rowDatas, keyNames)
    {
        for (var i = 0, ii = rowDatas.length; i < ii; i++) {
            addRow(rowDatas[i], keyNames);
        }
    }

    function deleteRow(rowId)
    {
        o.$element.jqGrid("delRowData", rowId);
    }

    function deleteSelectedRows()
    {
        var selRowIds = getSelectedRowIds();

        for (var i = selRowIds.length - 1; i >= 0; i--) {
            deleteRow(selRowIds[i]);
        }
    }

    function stopEdit(resetSelection)
    {
        if (o.editCell != null) {
            o.$element.jqGrid("saveCell", o.editCell.row, o.editCell.col);
        }

        if (resetSelection == true) {
            o.$element.jqGrid("resetSelection");
        }
    }

    function resetOrderNo(columnName)
    {
        for (var i = 0, ii = o.ds.rowCount(); i < ii; i++) {
            o.ds.value(i, columnName, getRowIndex(o.ds.value(i, "=JQGRID-ROW-ID=")) + 1);
        }
    }

    function resetDummyDataDiv(scrollLeft)
    {
        if (o.$dummyDataDiv != null) {
            o.$dummyDataDiv.remove();
        }

        var $dataTable = o.$control.find('table#' + control.id + '_table');
        var visibleRowCount = $dataTable.find('tr[role="row"].jqgrow:visible').length;
        var cssValue = (visibleRowCount == 0 ? "none" : "");

        if (o.frozen.index != -1) {
            o.$control.find('div.ui-jqgrid-hdiv.frozen-div').css({ "background": cssValue, "border-bottom": cssValue });
        }

        if (visibleRowCount == 0) {
            o.$dummyDataDiv = jQuery('<div>').width($dataTable.width()).height("1px").appendTo($dataTable.parent());

            if (scrollLeft != null) {
                o.$control.find('div.ui-jqgrid-bdiv').scrollLeft(scrollLeft);
            }
        }
    }

    function resetFrozenScrollGapDiv()
    {
        if (o.frozen.index == -1) {
            return;
        }

        var $frozenTable = o.$control.find('div.ui-jqgrid-bdiv.frozen-bdiv').children('table#' + control.id + '_table_frozen');

        $frozenTable.siblings('div[role="frozen-scroll-gap-dummy"]').remove();

        jQuery('<div>').attr("role", "frozen-scroll-gap-dummy").height("1px").insertAfter($frozenTable);
    }

    function getLoader()
    {
        if (o.loader != null) {
            return o.loader;
        }

        o.loader = {};

        o.$loader = jQuery(o.loader);

        o.loader.sortParam = function()
        {
            var arr = [];

            for (var i = 0, ii = o.sortings.length; i < ii; i++) {
                arr.push(o.sortings[i].name + ":" + any.text.blank(o.sortings[i].order, "ASC").toUpperCase() + any.text.nvl(o.config("paging.sortorderSuffix"), ""));
            }

            return arr.join(",");
        };

        o.loader.param = function(name)
        {
            if (o.loader.prx != null) {
                return o.loader.prx.param(name);
            }
        };

        o.loader.proxy = function()
        {
            if (o.loader.loading == true) {
                var prx = any.proxy();
                prx.execute = new Function();
                return prx;
            }

            o.loader.loading = true;

            o.$control.resize();

            o.loader.prx = any.proxy().output(o.ds);

            o.loader.prx.executeGrid = o.loader.prx.execute;

            o.$loader.fire("onStart");

            o.$control.resize();

            o.loader.prx.execute = function()
            {
                if (o.options.pager == null) {
                    loadData();
                } else {
                    o.loader.prx.param(any.pagingParameterName("type"), 1);
                    var page = 1;
                    if (o.loader.prx.reloadParams != null && o.loader.prx.reloadParams.pageNo != null) {
                        page = o.loader.prx.reloadParams.pageNo;
                    }
                    o.$element.jqGrid("setGridParam", { page: page, datatype: loadFunc }).trigger("reloadGrid");
                }
            };

            return o.loader.prx;

            function loadFunc(postdata)
            {
                if (o.loader.result != null) {
                    postdata.page = Math.min(postdata.page, o.loader.result.total);
                }

                o.loader.prx.param(any.pagingParameterName("recordCountPerPage"), postdata.rows);
                o.loader.prx.param(any.pagingParameterName("currentPageNo"), postdata.page);

                if (o.sortings.length > 0) {
                    o.loader.prx.param(any.pagingParameterName("sortingNames"), o.loader.sortParam());
                } else {
                    o.loader.prx.param(any.pagingParameterName("sortingNames"), null);
                }

                o.loader.postdata = postdata;

                loadData();
            }

            function loadData()
            {
                bindEvent();

                o.loader.prx.scrollLeft = o.$element.parent().parent().scrollLeft();
                o.loader.prx.option({ loadingbar: false });
                o.loader.prx.executeGrid(o.loader.prx.executed);
                o.loader.prx.executed = true;
            }

            function bindEvent()
            {
                if (o.loader.prx.eventBinded == true) {
                    return;
                }

                o.loader.prx.eventBinded = true;

                o.loader.prx.on("onStart", function() {
                    clearData();
                    resetSummaryLabel();
                    o.loader.loading = true;
                    o.loader.reloading = (o.loader.prx.reloadParams != null);
                    o.$loader.fire("onLoadStart");
                    o.$element.jqGrid("setCaption", "Loading...");
                    showHideLoadUI(true);
                });

                o.loader.prx.on("onSuccess", function() {
                    o.loader.loading = false;
                    showHideLoadUI(false);
                    var $hcb = o.$control.find('input:checkbox#cb_' + control.id + '_table');
                    if ($hcb.data("click-event-attached") != true) {
                        $hcb.data("click-event-attached", true).click(function() {
                            o.$control.fire("onHeaderCheckAll", [this.checked]);
                        });
                    }
                    o.$loader.fire("onLoadSuccess");
                });

                o.loader.prx.on("onError", function() {
                    o.loader.loading = false;
                    o.$element.jqGrid("setCaption", "(Error)");
                    showHideLoadUI(false);
                    o.$loader.fire("onLoadError");
                });

                o.loader.prx.on("onComplete", function() {
                    o.$loader.fire("onLoadComplete");
                    delete(o.loader.reloading);
                });
            }

            function showHideLoadUI(bool)
            {
                if (o.$loadUI == null) {
                    o.$loadUI = o.$control.find('div#lui_' + control.id + '_table, div#load_' + control.id + '_table');
                }

                o.$loadUI.appendTo(o.$loadUI.parent()).css("z-index", "auto").showHide(bool);
            }
        };

        o.loader.reload = function()
        {
            if (o.loader.prx == null) {
                return false;
            }

            o.loader.prx.reloadParams = {};
            o.loader.prx.reloadParams.scrollTop = o.$element.parent().parent().scrollTop();
            o.loader.prx.reloadParams.selectedRowId = o.$element.jqGrid("getGridParam", "selrow");
            o.loader.prx.reloadParams.pageNo = o.$element.jqGrid("getGridParam", "page");

            o.loader.prx.reload();

            return true;
        };

        return o.loader;
    }

    function loadComplete()
    {
        if (o.loader != null && o.loader.prx != null) {
            doFilter();
        }

        o.$control.find('table#' + control.id + '_table_frozen, table#' + control.id + '_table').unbind("contextmenu");

        resetFrozenScrollGapDiv();

        (function() {
            if (o.rowAction == null) {
                return;
            }
            o.$control.find('table#' + control.id + '_table').find('tr[role="row"].jqgrow > td').on(o.rowAction.isDblClick === true ? "dblclick" : "click", function() {
                var $src = jQuery(this);
                var qry = 'input[role="checkbox"].cbox:enabled';
                if ($src.children(qry).length == 0 && $src.is(qry) != true) {
                    o.rowAction.func.apply(this, [getRowData($src.parent().attr("id"))]);
                }
            });
        })();

        (function() {
            if (o.options.rownumbers != true || o.rownumberDesc != true) {
                return;
            }
            if (o.loader == null || o.loader.result == null) {
                return;
            }
            var pagingFactor = 0;
            if (o.options.pager != null) {
                pagingFactor = (o.loader.result.page - 1) * o.loader.postdata.rows;
            }
            var $rows = getDataTableRows();
            for (var r = 0, rr = $rows.length; r < rr; r++) {
                $rows.eq(r).children('td.jqgrid-rownum').text(o.loader.result.records - pagingFactor - r);
            }
        })();

        resetSummaryData();
        applyRowspan();

        (function() {
            if (o.rowData == null) {
                return;
            }
            var $bTableCells = o.$control.find('div.ui-jqgrid-bdiv table.ui-jqgrid-btable td[role="gridcell"]');
            var $fTableCells = o.$control.find('div.ui-jqgrid-sdiv table.ui-jqgrid-ftable td[role="gridcell"]');
            for (var colName in o.actions) {
                apply($bTableCells, colName);
                if (o.actions[colName].summary == true) {
                    apply($fTableCells, colName, true);
                }
            }
            function apply($gridCells, colName, summary)
            {
                $gridCells.filter('[aria-describedby="' + control.id + '_table_' + colName + '"]').each(function() {
                    var $this = jQuery(this);
                    if ($this.data("colName") != null) {
                        return true;
                    }
                    if (o.actions[colName].check != null) {
                        var rowId, rowData;
                        if (summary == true) {
                            rowId = null;
                            rowData = o.$element.jqGrid("footerData", "get");
                        } else {
                            rowId = $this.parent().attr("id");
                            rowData = o.rowData[rowId];
                        }
                        if (o.actions[colName].check.apply(control, [rowData, rowId, colName]) != true) {
                            return true;
                        }
                    }
                    var linkActionEnable = (o.rowSelectionByActionColumnName == null || o.rowSelectionByActionColumnName == colName);
                    $this.data({ "colName": colName, "linkActionEnable": linkActionEnable }).css({ "text-decoration": "underline", "text-underline-position": "under", "cursor": "pointer" }).addClass("any-jqgrid-linkaction").click(function() {
                        var $this = jQuery(this);
                        var colName = $this.data("colName");
                        if (o.actions[colName] != null) {
                            var rowId, rowData;
                            if (summary == true) {
                                rowId = null;
                                rowData = o.$element.jqGrid("footerData", "get");
                            } else {
                                rowId = $this.parent().attr("id");
                                rowData = o.rowData[rowId];
                            }
                            window.setTimeout(function() {
                                o.actions[colName].action.apply(control, [rowData, rowId, colName]);
                            });
                        }
                    });
                    if (o.actions[colName].className != null) {
                        $this.addClass(o.actions[colName].className);
                    }
                    if (o.actions[colName].css != null && o.actions[colName].css.add != null) {
                        $this.css(o.actions[colName].css.add);
                    }
                });
            }
        })();

        (function() {
            if (o.options.multiselect != true) {
                return;
            }
            if (o.selection == null) {
                return;
            }
            o.$element.jqGrid("resetSelection");
            o.$element.find('tr[role="row"][id]').each(function() {
                var rowId = jQuery(this).attr("id");
                if (o.rowData[rowId][o.selection.name] == o.selection.selectValue) {
                    o.$element.jqGrid("setSelection", rowId);
                }
            });
        })();

        (function() {
            if (o.loader == null || o.loader.prx == null) {
                return;
            }
            if (o.loader.prx.scrollLeft != null) {
                o.$element.parent().parent().scrollLeft(o.loader.prx.scrollLeft);
                delete(o.loader.prx.scrollLeft);
            }
            if (o.loader.prx.reloadParams == null) {
                return;
            }
            o.$element.parent().parent().scrollTop(o.loader.prx.reloadParams.scrollTop);
            if (o.options.multiselect != true) {
                o.$element.jqGrid("setSelection", o.loader.prx.reloadParams.selectedRowId);
            }
            if (o.options.pager != null) {
                o.loader.prx.reloadParams = null;
            }
        })();

        (function() {
            if (o.options.multiselect != true || o.multiSelectFunction == null) {
                return;
            }
            var $jqghDiv = jQuery('div#jqgh_' + control.id + '_table_cb');
            $jqghDiv.children('input[role="checkbox"]').remove().clone().prependTo($jqghDiv).click(function() {
                var checked = this.checked;
                o.$element.jqGrid("resetSelection");
                if (checked == true) {
                    o.$control.find('table#' + control.id + '_table').find('input[role="checkbox"].cbox').each(function() {
                        o.$element.jqGrid("setSelection", jQuery(this).parent().parent()[0].id);
                    });
                }
                this.checked = checked;
            });
            getDataTableRows(true).each(function() {
                if (o.multiSelectFunction.apply(o.$element[0], [getRowData(this.id), this.id]) != true) {
                    jQuery(this).find('input[role="checkbox"].cbox').remove();
                }
            });
            o.$element.jqGrid("resetSelection");
        })();
    }

    function getRowId(rowVar)
    {
        if (rowVar == -1) {
            return null;
        }

        if (typeof(rowVar) === "number") {
            return getDataTableRows()[rowVar].id;
        }

        return rowVar;
    }

    function getRowIndex(rowId)
    {
        if (rowId == null) {
            return -1;
        }

        if (o.jqgfirstrow == null) {
            o.jqgfirstrow = o.$element.find('tr[role="row"].jqgfirstrow').length;
        }

        return o.$element.jqGrid("getInd", rowId) - o.jqgfirstrow;
    }

    function getRowData(rowVar)
    {
        var rowId = getRowId(rowVar);
        var rowData = o.rowData[rowId];

        if (o.options.cellEdit == true) {
            var jqRowData = o.$element.jqGrid("getRowData", rowId);
            for (var item in jqRowData) {
                rowData[item] = jqRowData[item];
            }
        }

        var result = {};

        for (var item in rowData) {
            if (!any.text.startsWith(item, "=JQGRID-")) {
                result[item] = rowData[item];
            }
        }

        return result;
    }

    function getValue(rowVar, colName)
    {
        var rowId = getRowId(rowVar);

        if (rowId == null) {
            return null;
        }

        for (var i = 0, ii = o.options.colModel.length; i < ii; i++) {
            if (o.options.colModel[i].name == colName && o.options.colModel[i].editable == true) {
                return o.$element.jqGrid("getCell", rowId, colName);
            }
        }

        var value = o.rowData[rowId][colName];

        return value == null ? null : value;
    }

    function setValue(rowVar, colName, value, style)
    {
        var rowId = getRowId(rowVar);

        o.$element.jqGrid("setCell", rowId, colName, value, style);

        o.rowData[rowId][colName] = value;

        if (o.frozen.index != -1 && style != null) {
            o.$control.find('div.ui-jqgrid-bdiv.frozen-bdiv').children('table.ui-jqgrid-btable').find('tr[role="row"].jqgrow[id="' + rowId + '"]')
                .children('td[aria-describedby="' + control.id + '_table_' + colName + '"]').css(style);
        }
    }

    function getValueRow(obj, defaultRow)
    {
        for (var i = 0, ii = getRowCount(); i < ii; i++) {
            if (checkValueRow(i) == true) {
                return i;
            }
        }

        return defaultRow == null ? -1 : defaultRow;

        function checkValueRow(row)
        {
            for (var key in obj) {
                if (getValue(row, key) != obj[key]) {
                    return false;
                }
            }
            return true;
        }
    }

    function getValueRowId(obj, defaultRowId)
    {
        var row = getValueRow(obj);

        if (row != -1) {
            return getRowId(row);
        }

        return defaultRowId;
    }

    function getHeaderRowHeight()
    {
        return o.headerRowHeight;
    }

    function setHeaderRowHeight(val)
    {
        o.$control.find('div.ui-jqgrid-hdiv').find('table.ui-jqgrid-htable').find('tr.ui-jqgrid-labels[role="rowheader"]').height(val).find('div').height("auto");

        o.headerRowHeight = val;

        resizeHeight();
    }

    function getFrozenTableCorrect()
    {
        return o.frozen.correctTableHeight;
    }

    function setFrozenTableCorrect(val)
    {
        o.frozen.correctTableHeight = val;
    }

    function getRownumberDesc()
    {
        return o.rownumberDesc;
    }

    function setRownumberDesc(val)
    {
        o.rownumberDesc = (String(val).toLowerCase() == "true" || any.object.toBoolean(val, true));
    }

    function getAutoColumn()
    {
        return o.autoColumn;
    }

    function setAutoColumn(val)
    {
        o.autoColumn = (String(val).toLowerCase() == "true" || any.object.toBoolean(val, true));
    }

    function getTotalCount(ds)
    {
        if (ds == null) {
            ds = o.ds;
        }

        if (o.loader.prx.xhr != null) {
            var totalCount = o.loader.prx.xhr.getResponseHeader("_TOTAL_COUNT_");

            if (any.text.isEmpty(totalCount) != true) {
                ds.meta("_TOTAL_COUNT_", Number(totalCount));
            }
        }

        var meta = ds.json().meta;

        if (meta == null || meta["_TOTAL_COUNT_"] == null) {
            return ds.rowCount();
        }

        return Number(meta["_TOTAL_COUNT_"]);
    }

    function getRowCount()
    {
        return o.$element.jqGrid("getDataIDs").length;
    }

    function clearData()
    {
        o.$element.jqGrid("clearGridData");

        if (o.loader != null && o.loader.prx != null) {
            resetDummyDataDiv(o.loader.prx.scrollLeft);
        } else {
            resetDummyDataDiv();
        }

        resetFrozenScrollGapDiv();

        o.ds.init();

        if (o.summary == null) {
            return;
        }

        var footerData = o.$element.jqGrid("footerData", "get");

        for (var i = 0, ii = o.options.colModel.length; i < ii; i++) {
            var colModel = o.options.colModel[i];

            if (colModel.summaryType != null) {
                footerData[colModel.name] = null;
            }
        }

        o.$element.jqGrid("footerData", "set", footerData);
    }

    function moveSelection(num)
    {
        if (num == null) {
            num = 1;
        }

        var row;

        if (getSelectedRowId() == null) {
            if (getRowCount() == 0) {
                return false;
            }
            row = (num == -1 ? getDataTableRows().length : -1);
        } else {
            row = getRowIndex(getSelectedRowId());
            if (num == -1 && row == 0) {
                return false;
            }
            if (num == +1 && row == getRowCount() - 1) {
                return false;
            }
        }

        o.$element.jqGrid("setSelection", getRowId(row + num));

        return true;
    }

    function getSelectedRowDataList()
    {
        var rowDataList = [];
        var selRowIds = getSelectedRowIds();

        for (var i = 0, ii = selRowIds.length; i < ii; i++) {
            rowDataList.push(getRowData(selRowIds[i]));
        }

        return rowDataList;
    }

    function getSelectedData(columnNames)
    {
        var ds = any.ds("ds_" + control.id + "_selected").init().dataOnly(true);
        var rowDataList = getSelectedRowDataList();

        for (var i = 0, ii = rowDataList.length; i < ii; i++) {
            var row = ds.addRow();
            var rowData = rowDataList[i];

            if (columnNames == null) {
                ds.rowData(row, rowData);
            } else {
                for (var j = 0, jj = columnNames.length; j < jj; j++) {
                    if (columnNames[j] != null && columnNames[j] != "") {
                        ds.value(row, columnNames[j], rowData[columnNames[j]]);
                    }
                }
            }

            ds.jobType(row, "U");
        }

        return ds;
    }

    function getSelectedRowIds()
    {
        return o.$element.jqGrid("getGridParam", "selarrrow").sort(function(a, b) { return a - b; });
    }

    function getSelectedRowId()
    {
        return o.$element.jqGrid("getGridParam", "selrow");
    }

    function getSelectedRowIndex()
    {
        return getRowIndex(getSelectedRowId());
    }

    function getDataTableRows(withFrozen)
    {
        return o.$control.find('table#' + control.id + '_table' + (withFrozen == true ? ',table#' + control.id + '_table_frozen' : '')).find('tr[role="row"].jqgrow');
    }

    function getDataTableRow(rowVar)
    {
        return getDataTableRows().filter('#' + getRowId(rowVar));
    }

    function getDataTableCell(rowVar, colName)
    {
        return getDataTableRow(rowVar).children('[aria-describedby="' + control.id + '_table_' + colName + '"]');
    }

    function getDisabled()
    {
        return o.disabled;
    }

    function setDisabled(val)
    {
        o.disabled = (String(val).toLowerCase() == "disabled" || any.object.toBoolean(val, true));

        if (o.disabled == true) {
            o.$control.css({ "position": "relative" });
            if (o.$disabledScreen == null) {
                o.$disabledScreen = jQuery('<div>').css({ "position": "absolute", "left": "0px", "top": "0px", "width": "100%", "height": "100%" });
                o.$disabledScreen.css({ "background-color": "#ffffff" });
                o.$disabledScreen.appendTo(control);
                o.$disabledScreen.fadeTo(0, 0.5);
            }
        } else {
            o.$control.css({ "position": "" });
            if (o.$disabledScreen != null) {
                o.$disabledScreen.remove();
                delete(o.$disabledScreen);
            }
        }
    }

    function getDownloadTitle()
    {
        return o.downloadTitle;
    }

    function setDownloadTitle(name)
    {
        o.downloadTitle = name;
    }

    function getHeaderDataset(columnNames)
    {
        var ds = any.ds("ds_" + control.id + "_headerList").dataOnly(true).init();
        var colModel = o.$element.jqGrid("getGridParam", "colModel");

        if (columnNames == null) {
            for (var i = 0, ii = colModel.length; i < ii; i++) {
                if (colModel[i].name != "cb") {
                    ds.addColumn(colModel[i].name);
                }
            }
        } else {
            for (var i = 0, ii = columnNames.length; i < ii; i++) {
                ds.addColumn(columnNames[i]);
            }
        }

        var $trs = o.$control.find('div.ui-jqgrid-hdiv').not('div.frozen-div').find('table.ui-jqgrid-htable').find('tr.ui-jqgrid-labels[role="rowheader"]');

        for (var r = 0, rr = $trs.length; r < rr; r++) {
            ds.addRow();
        }

        for (var r = 0, rr = $trs.length; r < rr; r++) {
            var $ths = $trs.eq(r).children('th');
            var c = 0;
            for (var i = 0, ii = $ths.length; i < ii; i++) {
                var $th = $ths.eq(i);
                var label = any.text.trim($th.text());
                if ($th.attr("id") == null) {
                    if (ds.colId(c) != "cb") {
                        var colspan = any.text.toNumber(any.text.blank($th.attr("colspan"), 1));
                        for (var j = 0; j < colspan; j++) {
                            ds.value(r, c, label);
                            c++;
                        }
                    }
                } else {
                    var colName = $th.attr("id").replace(control.id + "_table_", "");
                    if (columnNames != null && ds.colIndex(colName) == -1) {
                        continue;
                    }
                    if (colName != "cb") {
                        var rowspan = any.text.toNumber(any.text.blank($th.attr("rowspan"), 1));
                        for (var j = 0; j < rowspan; j++) {
                            ds.value(r + j, colName, label);
                        }
                        c++;
                    }
                }
            }
        }

        if (columnNames != null && o.unusedModel != null) {
            for (var i = 0, ii = ds.rowCount(); i < ii; i++) {
                for (var name in o.unusedModel) {
                    ds.value(i, name, o.unusedModel[name].label);
                }
            }
        }

        return ds;
    }

    function getColumnDataset(columnNames)
    {
        var ds = any.ds("ds_" + control.id + "_columnList").dataOnly(true).init();
        var colModel = o.$element.jqGrid("getGridParam", "colModel");

        if (columnNames == null) {
            for (var i = 0, ii = colModel.length; i < ii; i++) {
                if (colModel[i].name != "cb") {
                    addModel(colModel[i]);
                }
            }
        } else {
            for (var i = 0, ii = columnNames.length; i < ii; i++) {
                addModel(getModel(columnNames[i]));
            }
        }

        return ds;

        function getModel(name)
        {
            for (var i = 0, ii = colModel.length; i < ii; i++) {
                if (colModel[i].name == name) {
                    return colModel[i];
                }
            }

            if (o.unusedModel != null) {
                return o.unusedModel[name];
            }
        }

        function addModel(model)
        {
            if (model == null) {
                return;
            }

            var row = ds.addRow();

            ds.value(row, "NAME", model.name);
            ds.value(row, "WIDTH", isNaN(model.width) ? 0 : model.width);
            ds.value(row, "ALIGN", model.align);
            ds.value(row, "HIDDEN", model.hidden);
            ds.value(row, "FORMATTER", model["formatter-name"]);

            var formatoptions = model["formatoptions"];

            if (formatoptions == null) {
                return;
            }

            var decimalPlaces = formatoptions["decimalPlaces"];

            if (decimalPlaces != null) {
                ds.value(row, "DECIMAL_PLACES", decimalPlaces);
            }
        }
    }

    function downloadExcel(columnNames)
    {
        if (o.loader == null || o.loader.prx == null) {
            return;
        }

        if (o.config("excelDownload.view") != null) {
            var win = any.window(true).url(o.config("excelDownload.view"));
            win.param("paging", o.options.pager == null ? "0" : 1);
            win.arg("functions", { download: download, cancel: cancel });
            win.option({ closeOnEscape: false });
            win.show();
            win.$div.parent().find('button.ui-dialog-titlebar-close[role="button"]').click(cancel);
            return;
        }

        var rjQuery = any.rootWindow().jQuery;
        var $div = rjQuery('<div>').css("overflow", "hidden");
        var opts = { modal: true, resizable: false, hide: "clip", closeOnEscape: false, buttons: {} };

        $div.$buttonTable = rjQuery('<table>').css({ "width":"100%", "height":"100%" }).appendTo($div);
        $div.$buttonTd = rjQuery('<td>').appendTo(rjQuery('<tr>').appendTo(rjQuery('<tbody>').appendTo($div.$buttonTable)));

        if (o.options.pager == null) {
            rjQuery('<button>').width("100%").text(any.message("any.grid.button.excel.downloadWithoutPage")).control("any-button").appendTo($div.$buttonTd).click(function() {
                doDownload(1);
            });
            opts.height = 130;
        } else {
            rjQuery('<button>').width("100%").text(any.message("any.grid.button.excel.downloadWithPage1")).control("any-button").appendTo($div.$buttonTd).click(function() {
                doDownload(1);
            });
            rjQuery('<div>').width("100%").height("5px").appendTo($div.$buttonTd);
            rjQuery('<button>').width("100%").text(any.message("any.grid.button.excel.downloadWithPage2")).control("any-button").appendTo($div.$buttonTd).click(function() {
                doDownload(2);
            });
            opts.height = 160;
        }

        opts.buttons[any.message("any.btn.cancel", "Cancel")] = function()
        {
            rjQuery(this).dialog("close");

            cancel();
        };

        opts.close = function(event, ui)
        {
            $div.remove();
            $div = null;
        };

        $div.attr("title", any.message("any.grid.button.excel.title")).dialog(opts);

        $div.parent().find('button.ui-dialog-titlebar-close[role="button"]').click(cancel);

        function doDownload(mode)
        {
            download(mode, null, { start: function() {
                $div.$buttonTable.hide();
                $div.$progressTable = rjQuery('<table>').css({ "width": "100%", "height": "100%" }).appendTo($div);
                $div.$progressTd = rjQuery('<td>').appendTo(rjQuery('<tr>').appendTo(rjQuery('<tbody>').appendTo($div.$progressTable)));
                $div.$progressBar = rjQuery('<div>').css({ "position": "relative" }).appendTo($div.$progressTd);
                $div.$progressLabel = rjQuery('<div>').css({ "position": "absolute", "font-weight": "bold", "text-align": "center", "text-shadow": "1px 1px 0 #fff", "width": "100%", "margin-top": "4px" }).appendTo($div.$progressBar);
                $div.$progressBar.progressbar({ value: false });
                $div.$progressLabel.text("Data Loading...");
            }, progress: function(data) {
                if ($div == null) {
                    this.stop();
                }
                if ($div == null || (data.completed != true && data.totalValue == 0)) {
                    return;
                }
                if (data.completed == true && data.totalValue == 0) {
                    data.progress = 1;
                }
                $div.$progressBar.progressbar("value", data.progress * 100);
                $div.$progressLabel.text(any.text.formatNumber(data.value) + "/" + any.text.formatNumber(data.totalValue) + " (" + any.text.formatNumber(data.progress * 100, 2) + "%)");
            }, stop: function() {
                if ($div == null) {
                    return;
                }
                $div.dialog("close");
            } });
        }

        function download(mode, options, functions)
        {
            if (o.$downloadForm == null) {
                o.$downloadForm = jQuery('<form>').hide().appendTo(control);
            } else {
                o.$downloadForm.empty();
            }

            var tokenParamName = any.config["/anyworks/servlet-token-check/param-name"];

            if (tokenParamName != null && tokenParamName != "") {
                addHidden(tokenParamName, any.rootWindow().any.meta.servletToken);
            }

            var params = o.loader.prx.param();

            for (var i = 0, ii = params.length; i < ii; i++) {
                addHidden(params[i].name, params[i].value);
            }

            if (o.loader.prx.param(any.pagingParameterName("sortingNames")) == null && o.sortings.length > 0) {
                addHidden(any.pagingParameterName("sortingNames"), o.loader.sortParam());
            }

            var pagingFactor = 0;

            if (o.options.pager != null && mode == 1) {
                pagingFactor = (o.loader.result.page - 1) * o.loader.postdata.rows;
            }

            addHidden("_DOWNLOAD_MODE_", mode);
            addHidden("_DOWNLOAD_TITLE_", any.text.nvl(o.downloadTitle, any.text.empty(jQuery('h1:first').text(), document.title)));
            addHidden("_DATA_SET_JSON_", '[' + o.loader.prx.jsons(true).join(",") + ']');
            addHidden("_DS_HEADER_LIST_", getHeaderDataset(columnNames).jsonString());
            addHidden("_DS_COLUMN_LIST_", getColumnDataset(columnNames).jsonString());
            addHidden("_FROZEN_COLUMN_NAME_", o.frozen.name);
            addHidden("_ROWNUMBER_START_", o.rownumberDesc == true ? o.loader.result.records - pagingFactor : pagingFactor + 1);
            addHidden("_ROWNUMBER_CALC_", o.rownumberDesc == true ? -1 : 1);
            addHidden("_TOTAL_VALUE_", mode == 1 ? getRowCount() : getTotalCount());

            if (o.rowspan != null) {
                addHidden("_ROWSPAN_COLUMNS_", o.rowspan.columns.join(","));
                addHidden("_ROWSPAN_RESTRICT_", o.rowspan.restrict == true ? 1 : 0);
            }

            if (options != null) {
                for (var name in options) {
                    addHidden(name, options[name]);
                }
            }

            if (o.loader.prx.param(any.pagingParameterName("type")) == 1 && mode == 2) {
                o.$downloadForm.children('input[name="' + any.pagingParameterName("recordCountPerPage") + '"]').val(-1);
            }

            if (o.downloadFrameIndex == null) {
                o.downloadFrameIndex = 0;
            }

            o.$downloadFrame = jQuery('<iframe name="ifr_' + control.id + '_excelDownload_' + o.controlIndex + '_' + (o.downloadFrameIndex++) + '">').hide().appendTo(control);

            o.$downloadFrame[0].onActionFailure = function(error)
            {
                any.error(error).show();
            };

            if (functions != null && functions.start != null) {
                functions.start.apply();
            }

            any.progress(o.$downloadForm[0]).interval(500).callback(function(data) {
                if (data != null && functions != null && functions.progress != null) {
                    try {
                        functions.progress.apply(this, [data]);
                    } catch(e) {
                        this.stop();
                    }
                }
                if (data == null || data.completed == true || o.$downloadFrame == null) {
                    this.stop();
                }
            }).on("onStop", function() {
                if (functions != null && functions.stop != null) {
                    try {
                        functions.stop.apply();
                    } catch(e) {
                    }
                }
            }).start();

            o.$downloadForm.attr({ action: o.loader.prx.url(), target: o.$downloadFrame.attr("name"), method: "POST" }).submit();

            function addHidden(name, value)
            {
                if (name != null && name != "" && value != null) {
                    jQuery('<input>').attr({ type: "hidden", name: name }).val(value).appendTo(o.$downloadForm);
                }
            }
        }

        function cancel()
        {
            if (o.$downloadFrame != null) {
                o.$downloadFrame.attr("src", "about:blank").remove();
                o.$downloadFrame = null;
            }
        }
    }

    function doFilter()
    {
        var scrollLeft = o.$control.find('div.ui-jqgrid-bdiv').scrollLeft();

        if (o.buttons["filter"].toggleActivated == true) {
            var $toolbar = o.$control.find('tr.ui-search-toolbar').not(o.$frozenSearchToolbarDummy);
            getDataTableRows(true).each(function() {
                if (this.id == null || this.id == "") {
                    return;
                }
                this.style.display = (function(rowId) {
                    var $filter = $toolbar.find('input:text');
                    for (var i = 0, ii = $filter.length; i < ii; i++) {
                        if (o.rowData[rowId] == null || o.rowData[rowId][$filter[i].name] == null || $filter[i].value == "") {
                            continue;
                        }
                        if (String(o.rowData[rowId][$filter[i].name]).toUpperCase().indexOf(any.text.trim($filter[i].value.toUpperCase())) == -1) {
                            return false;
                        }
                    }
                    return true;
                }(this.id) == true ? "" : "none");
            });
        } else {
            getDataTableRows(true).show();
        }

        resetDummyDataDiv(scrollLeft);

        applyRowspan(true);
    }

    function doConfig()
    {
        var win = any.window(true);
        win.url(o.config("config.view"));
        win.arg("grid", control);
        win.arg("colModel", o.$element.jqGrid("getGridParam", "colModel"));
        win.arg("configInfo", o.configInfo);
        win.arg("sortings", o.sortings);
        win.arg("actions", o.actions);
        win.arg("saveConfig", saveConfig);
        win.show();
    }

    function resetConfig(addonPath, callback)
    {
        if (o.buttons["config"].show != true && arguments.length == 0) {
            return;
        }

        o.buttons["config"].show = true;

        resetConfig.executed = true;

        if (o.options.multiSort == null) {
            o.options.multiSort = true;
        }

        if (o.configInfo == null) {
            o.configInfo = { ds: {} };
            o.configInfo.ds.config = any.ds("ds_configMain", control).dataOnly(true);
            o.configInfo.ds.column = any.ds("ds_columnList", control).dataOnly(true);
            o.configInfo.ds.sorting = any.ds("ds_sortingList", control).dataOnly(true);
        }

        if (arguments.length > 0) {
            o.configInfo.addonPath = addonPath;
        }

        loadConfig(callback);
    }

    function loadConfig(callback)
    {
        if (o.config("config.load") == null) {
            control.isReady = true;
            return;
        }

        var prx = any.proxy(control);
        prx.url(o.config("config.load"));
        prx.param("GRID_PATH", getGridPath());

        prx.on("onSuccess", function() {
            applyConfig(callback);
        });

        prx.on("onError", function() {
            this.error.show();
        });

        prx.on("onComplete", function() {
            control.isReady = true;
        });

        prx.option({ loadingbar: false });

        prx.execute();
    }

    function saveConfig(ds, any2)
    {
        var prx = any.proxy(control);
        prx.url(o.config("config.save"));
        prx.param("GRID_ID", o.configInfo.ds.config.value(0, "GRID_ID"));
        prx.param("GRID_PATH", getGridPath());
        prx.data(ds.config);
        prx.data(ds.column);
        prx.data(ds.sorting);

        prx.on("onSuccess", function() {
            any2.unloadPage();
            applyConfig();
        });

        prx.on("onError", function() {
            this.error.show();
        });

        prx.execute();
    }

    function applyConfig(callback)
    {
        if (o.configInfo.ds.config.value(0, "COLUMN_CONFIG") == "1") {
            var colModel = any.object.clone(o.defaultColModel);

            o.options.colModel = [];

            for (var i = 0, ii = o.configInfo.ds.column.rowCount(); i < ii; i++) {
                var model = null;

                for (var j = 0, jj = colModel.length; j < jj; j++) {
                    if (colModel[j].name == o.configInfo.ds.column.value(i, "NAME")) {
                        model = colModel[j];
                        break;
                    }
                }

                if (model == null) {
                    continue;
                }

                model.width = o.configInfo.ds.column.value(i, "WIDTH");
                model.hidden = (o.configInfo.ds.column.value(i, "SHOW") != "1");
                model.frozen = false;

                o.options.colModel.push(model);

                if (o.configInfo.ds.column.value(i, "FROZEN") == "1") {
                    setFrozen(model.name);
                }
            }

            for (var j = 0, jj = colModel.length; j < jj; j++) {
                var modelNameExists = false;

                for (var i = 0, ii = o.configInfo.ds.column.rowCount(); i < ii; i++) {
                    if (colModel[j].name == o.configInfo.ds.column.value(i, "NAME")) {
                        modelNameExists = true;
                        break;
                    }
                }

                if (modelNameExists != true) {
                    o.options.colModel.splice(j, 0, colModel[j]);
                }
            }
        } else {
            o.options.colModel = o.defaultColModel;
        }

        o.$element.jqGrid("GridDestroy");
        o.$element = getTableElement();

        o.$buttons.remove();
        o.$buttons = null;

        if (o.options.pager != null) {
            setPaging(o.options.rowList, o.options.rowNum);
        }

        o.sortings = [];

        delete(o.options.sortname);
        delete(o.options.sortorder);

        if (o.configInfo.ds.config.value(0, "SORTING_CONFIG") == "1") {
            for (var i = 0, ii = o.configInfo.ds.sorting.rowCount(); i < ii; i++) {
                addSorting(o.configInfo.ds.sorting.value(i, "NAME"), o.configInfo.ds.sorting.value(i, "ORDER"));
            }
        } else {
            for (var i = 0, ii = o.defaultSortings.length; i < ii; i++) {
                addSorting(o.defaultSortings[i].name, o.defaultSortings[i].order);
            }
        }

        activateGrid(true);

        resizeHeight();

        if (typeof(callback) === "function") {
            callback();
        } else if (o.loader != null && o.loader.prx != null) {
            o.loader.prx.execute();
        }
    }

    function getGridPath()
    {
        if (typeof(o.config("config.getGridPath")) === "function") {
            return o.config("config.getGridPath").apply(control, [o.configInfo.addonPath]);
        }

        var $meta = jQuery('meta[name="X-Any-Servlet-Path"]');
        var servletPath;

        if ($meta.length == 0) {
            servletPath = document.location.pathname;
            if (any.meta.contextPath != "" && any.meta.contextPath != "/" && any.text.startsWith(servletPath, any.meta.contextPath)) {
                servletPath = servletPath.substr(any.meta.contextPath.length);
            }
        } else {
            servletPath = $meta.attr("content");
        }

        var gridPath = [servletPath, control.id];

        if (o.configInfo.addonPath != null && o.configInfo.addonPath != "") {
            gridPath.push(o.configInfo.addonPath);
        }

        return gridPath.join("::");
    }
});
