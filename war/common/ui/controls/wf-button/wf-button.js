any.control("wf-button").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);
        o.controlIndex = any.control().newIndex();
        o.ds = any.ds("ds_wfButtonList_" + o.controlIndex);

        var $temp = $('<button>').css({ "position":"absolute", "top":"-1000px", "left":"-1000px" }).appendTo(control).control("any-button");
        o.$control.height($temp.outerHeight(true));
        $temp.remove();

        o.activityButton = any.object.toBoolean(o.$control.attr("activityButton"), false);
        o.actionButton = any.object.toBoolean(o.$control.attr("actionButton"), false);

        if (o.activityButton == true) {
            o.$activityButtonArea = $('<span>').appendTo(control);
        }

        if (o.actionButton == true) {
            o.$eventActionButton = $('<button>').hide().attr({ "name":"btn_wfEventAction", "icon-secondary":"ui-icon-triangle-1-s" })
                .text(any.message("application.common.workflow.btn.eventAction", "사건처리").toString())
                .control("any-button")
                .appendTo(control)
                .click(function() {
                    if (o.$eventActionButton.prop("menuExpanded") == true) {
                        o.$eventActionButton.exec("hideMenu");
                        return;
                    }
                    resetGridInfo();
                    if (o.bizId == null) {
                        createActionButtonMenus();
                        showActionButtonMenu();
                    } else {
                        loadButtons(true);
                    }
                    return false;
                });
        }

        if (o.$control.attr("gridId") != null) {
            o.$grid = $('#' + o.$control.attr("gridId")).on("onHeaderCheckAll", function(event, checked) {
                delete(o.gridOnSelectRowDisabled);
                resetGridInfo();
                $('button[name="btn_wfEventAction"]').prop("disabled", o.gridList.length == 0);
                createActionButtonMenus();
            }).on("any-initialize", function() {
                this.addElementEvent("onSelectRow", function(rowId, status, e) {
                    if (o.gridOnSelectRowDisabled == true) return;
                    resetGridInfo();
                    if (o.bizId == null) {
                        createActionButtonMenus();
                    } else {
                        loadButtons();
                    }
                });
            });

            o.$grid.find('input:checkbox.cbox#cb_' + o.$control.attr("gridId") + '_table').live("mousedown", function(event) {
                o.gridOnSelectRowDisabled = true;
            });
        }

        o.$control.defineMethod("reset", reset);
        o.$control.defineMethod("reload", reload);
        o.$control.defineMethod("getWindow", getWindow);
        o.$control.defineMethod("addButton", addButton);
        o.$control.defineMethod("showHideButton", showHideButton);

        any.control(control).initialize();
    })();

    function reset(activityId, bizId)
    {
        if (activityId != null && o.activityId != null && bizId != null && o.bizId != null) {
            if (activityId == o.activityId && bizId == o.bizId) return;
        }

        if (o.activityId != activityId) {
            clearButtons();
        }

        o.activityId = activityId;
        o.bizId = bizId;

        reload();
    }

    function reload()
    {
        resetGridInfo();

        if (o.activityId == null) {
            clearButtons();
        } else {
            loadButtons();
        }
    }

    function loadButtons(showMenu)
    {
        var prx = any.proxy();
        prx.url("/common.workflow.button.WorkflowButtonAct/retrieveList");
        prx.param("ACTIVITY_ID", o.activityId);
        prx.param("BIZ_ID", o.bizId);
        prx.param("REF_DIV", any.param("REF_DIV"));
        prx.output(o.ds);

        prx.onSuccess = function()
        {
            clearButtons();

            createActivityButtons();
            createActionButtonMenus();

            if (showMenu == true) {
                showActionButtonMenu();
            }
        };

        prx.onError = function()
        {
            this.error.show();
        };

        prx.option({ loadingbar:false });

        prx.execute();
    }

    function clearButtons()
    {
        if (o.$activityButtonArea != null) {
            o.$activityButtonArea.empty();
        }

        if (o.$eventActionButton != null) {
            o.$eventActionButton.exec("clearMenu");
        }
    }

    function createActivityButtons()
    {
        if (o.$activityButtonArea == null) return;

        for (var i = 0; i < o.ds.rowCount(); i++) {
            var buttonInfo = getButtonInfo(o.ds.rowData(i));

            if (buttonInfo.ACTIVITY_BUTTON_YN != "1") continue;

            $('<button>').text(buttonInfo.BUTTON_NAME).control("any-button").data("buttonInfo", buttonInfo).click(function() {
                doEvent($(this).data("buttonInfo"));
            }).appendTo(o.$activityButtonArea).after('\n');
        }
    }

    function createActionButtonMenus()
    {
        if (o.$eventActionButton == null) return;

        o.$eventActionButton.exec("clearMenu");

        for (var i = 0; i < o.ds.rowCount(); i++) {
            var buttonInfo = getButtonInfo(o.ds.rowData(i));

            if (buttonInfo.ACTIVITY_BUTTON_YN == "1") continue;

            if (buttonInfo.VIEW_PATH == null || buttonInfo.VIEW_PATH == "") continue;

            if (o.gridList != null && o.gridList.length > 1 && buttonInfo.BUNDLE_AVAIL_YN != "1") continue;

            if (checkButtonStatus(buttonInfo.WF_STATUS_ID) != true) continue;

            o.$eventActionButton.exec("addMenu", buttonInfo.BUTTON_NAME, function(buttonInfo) {
                doEvent(buttonInfo);
            }, buttonInfo, { disabled:buttonInfo.ENABLE_YN != "1" });
        }

        if (o.addonButtons != null) {
            for (var i = 0; i < o.addonButtons.length; i++) {
                if (o.addonButtons[i].show != true) continue;

                o.$eventActionButton.exec("addMenu", o.addonButtons[i].label, function(buttonInfo) {
                    buttonInfo.action();
                }, o.addonButtons[i]);
            }
        }

        $('button[name="btn_wfEventAction"]').exec("hideMenu")
            .showHide(o.activityId != null && o.$eventActionButton.prop("menuCount") > 0)
            .prop("disabled", o.bizId == null && (o.gridList == null || o.gridList.length == 0));

        function checkButtonStatus(wfStatusId)
        {
            if (o.gridList != null) {
                for (var i = 0; i < o.gridList.length; i++) {
                    if (o.gridList[i].WF_STATUS_ID != wfStatusId) return false;
                }
                return true;
            }

            if (o.gridData != null) {
                return o.gridData.WF_STATUS_ID == wfStatusId;
            }

            return true;
        }
    }

    function resetGridInfo()
    {
        if (o.$grid == null) return;

        delete(o.gridList);
        delete(o.gridData);
        delete(o.bizId);

        if (o.$grid.element().jqGrid("getGridParam", "multiselect") == true) {
            o.gridList = o.$grid.prop("selectedRowDataList");
            if (o.gridList.length == 1) {
                o.gridData = o.gridList[0];
                o.bizId = o.gridList[0].WF_BIZ_ID;
            }
        } else {
            var rowId = o.$grid.prop("selectedRowId");
            if (rowId != null) {
                o.gridData = o.$grid.exec("getRowData", rowId);
            }
            if (o.gridData != null) {
                o.bizId = o.gridData.WF_BIZ_ID;
            }
        }
    }

    function showActionButtonMenu()
    {
        if (o.$eventActionButton != null) {
            o.$eventActionButton.exec("showMenu");
        }
    }

    function getWindow(viewInfo, buttonInfo)
    {
        var viewPath = any.text.nvl(viewInfo.path, "");

        if (viewPath == "") return;

        var viewParam = any.text.nvl(viewInfo.mode == "C" ? viewInfo.creParam : viewInfo.dtlParam, "");

        for (var name in buttonInfo) {
            viewPath = any.text.replaceAll(viewPath, "{#" + name + "}", buttonInfo[name]);
            viewParam = any.text.replaceAll(viewParam, "{#" + name + "}", buttonInfo[name]);
        }

        if (o.gridData != null) {
            for (var name in o.gridData) {
                viewPath = any.text.replaceAll(viewPath, "{#" + name + "}", o.gridData[name]);
                viewParam = any.text.replaceAll(viewParam, "{#" + name + "}", o.gridData[name]);
            }
        }

        for (var i = 0, params = any.param().all(); i < params.length; i++) {
            viewPath = any.text.replaceAll(viewPath, "{#" + params[i].name + "}", params[i].value);
            viewParam = any.text.replaceAll(viewParam, "{#" + params[i].name + "}", params[i].value);
        }

        if (viewParam != "") {
            viewPath += (viewPath.indexOf("?") == -1 ? "?" : "&") + viewParam;
        }

        var wf = {};

        wf.ACTIVITY_ID = buttonInfo.WF_ACTIVITY_ID;
        wf.ACT_CODE_ID = buttonInfo.WF_ACT_CODE_ID;

        if (!(buttonInfo.ACTIVITY_BUTTON_YN == "1" && viewInfo.mode == "C")) {
            wf.BIZ_ID = buttonInfo.WF_BIZ_ID;
            if (buttonInfo.BUNDLE_AVAIL_YN == "1") {
                wf.bizList = (o.gridList == null ? [buttonInfo] : o.gridList);
            }
        }

        var win;

        if (viewInfo.type == "V") {
            win = any.viewer();
        } else {
            win = any.window(true);
        }

        win.url(any.text.replaceAll(viewPath, "{#", "{"));

        if (viewInfo.mode == null || viewInfo.mode == "C") {
            for (var item in wf) {
                if (wf[item] != null && wf[item] != "" && $.type(wf[item]) == "string") {
                    win.param("WF_" + item, wf[item]);
                }
            }
        }

        if (o.params != null) {
            for (var name in o.params) {
                win.param(name, o.params[name]);
            }
        }

        if (o.args != null) {
            for (var name in o.args) {
                win.arg(name, o.args[name]);
            }
        }

        if (viewInfo.mode != "" && viewParam.indexOf("?mode=") == -1 && viewParam.indexOf("&mode=") == -1) {
            win.param("mode", viewInfo.mode);
        }

        win.arg("wf", wf);

        return win;
    }

    function addButton(id, label, action)
    {
        if (o.addonButtons == null) {
            o.addonButtons = [];
        }

        o.addonButtons.push({ id:id, label:label, action:action, show:true });
    }

    function showHideButton(id, show)
    {
        if (o.addonButtons == null) return;

        for (var i = 0; i < o.addonButtons.length; i++) {
            if (o.addonButtons[i].id == id) {
                o.addonButtons[i].show = show;
            }
        }
    }

    function getButtonInfo(rowData)
    {
        var buttonInfo = {};

        for (var item in rowData) {
            buttonInfo[item] = rowData[item];
        }

        if (o.bizId == null) {
            buttonInfo.WF_HIST_ID = "";
            buttonInfo.WF_BIZ_ID = "";
            buttonInfo.WF_PROC_BIZ_ID = "";
            buttonInfo.VIEW_MODE = "C";
            buttonInfo.ENABLE_YN = "1";
        }

        return buttonInfo;
    }

    function doEvent(buttonInfo)
    {
        var viewInfo = {};

        if (buttonInfo.BUNDLE_AVAIL_YN == "1" && o.gridList != null && o.gridList.length > 1 && buttonInfo.BUNDLE_VIEW_PATH != null && buttonInfo.BUNDLE_VIEW_PATH != "") {
            viewInfo.path = buttonInfo.BUNDLE_VIEW_PATH;
            viewInfo.creParam = buttonInfo.BUNDLE_CRE_PARAM;
            viewInfo.dtlParam = buttonInfo.BUNDLE_DTL_PARAM;
        } else {
            viewInfo.path = buttonInfo.VIEW_PATH;
            viewInfo.creParam = buttonInfo.CRE_PARAM;
            viewInfo.dtlParam = buttonInfo.DTL_PARAM;
        }

        viewInfo.type = buttonInfo.VIEW_TYPE;
        viewInfo.mode = buttonInfo.VIEW_MODE;

        var win = getWindow(viewInfo, buttonInfo);

        win.onReload = function()
        {
            o.$control.fire("onReload");

            loadButtons();
        };

        if (win.option != null) {
            win.option({ resizable:true });
        }

        o.$control.fire("onBeforeWindowOpen", [win, buttonInfo]);

        if (viewInfo.type == "W") {
            win.open();
        } else {
            win.show();
        }
    }
});
