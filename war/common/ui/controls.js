// 프레임워크 컨트롤들
(function() {
    var controlHome = any.home + "/controls";
    var pluginsHome = "/common/ui/jquery/plugins";

    any.control("any-button").resource(controlHome + "/any-button/any-button.js");

    any.control("any-buttonset").resource(controlHome + "/any-button/any-buttonset.js");
    any.control("any-buttonset").resource(controlHome + "/util/util-codedata.js");

    any.control("any-text").resource(pluginsHome + "/jquery.mask/jquery.ui.mask.js");
    any.control("any-text").resource(controlHome + "/any-text/any-text.js");
    any.control("any-text").resource(controlHome + "/util/util-maxbyte.js");

    any.control("any-number").resource(controlHome + "/any-number/any-number.js");

    any.control("any-textarea").resource(controlHome + "/any-textarea/any-textarea.js");
    any.control("any-textarea").resource(controlHome + "/util/util-maxbyte.js");

    any.control("any-select").resource(controlHome + "/any-select/any-select.js");
    any.control("any-select").resource(controlHome + "/util/util-codedata.js");

    any.control("any-multiselect").resource(pluginsHome + "/jquery.multiselect/jquery.multiselect.css");
    any.control("any-multiselect").resource(pluginsHome + "/jquery.multiselect/jquery.multiselect.js");
    any.control("any-multiselect").resource(controlHome + "/any-multiselect/any-multiselect.js");
    any.control("any-multiselect").resource(controlHome + "/util/util-codedata.js");

    any.control("any-radio").resource(controlHome + "/any-radio/any-radio.js");
    any.control("any-radio").resource(controlHome + "/util/util-codedata.js");

    any.control("any-check").resource(controlHome + "/any-check/any-check.js");
    any.control("any-check").resource(controlHome + "/util/util-codedata.js");

    any.control("any-slider").resource(controlHome + "/any-slider/any-slider.js");

    any.control("any-search").resource(controlHome + "/any-search/any-search.js");

    any.control("any-date").resource("/common/ui/jquery/i18n/datepicker/jquery.ui.datepicker-" + any.meta.langCode + ".js");
    any.control("any-date").resource(controlHome + "/any-date/any-date.js");

    any.control("any-date2").resource("any-date");
    any.control("any-date2").resource(controlHome + "/any-date/any-date2.js");

    any.control("any-time").resource(pluginsHome + "/jquery.timepicker/jquery-ui-timepicker-addon.js");
    any.control("any-time").resource(controlHome + "/any-time/any-time.js");

    any.control("any-datetime").resource("any-date");
    any.control("any-datetime").resource("any-time");
    any.control("any-datetime").resource(controlHome + "/any-datetime/any-datetime.js");

    any.control("any-tab").resource(controlHome + "/any-tab/any-tab.js");

    any.control("any-progressbar").resource(controlHome + "/any-progressbar/any-progressbar.js");

    any.control("any-file").resource(controlHome + "/any-file/any-file.js");
    any.control("any-file").resource(controlHome + "/util/util-codedata.js");
    any.control("any-file").config("url.download", "/common.file.FileAct/download");
    any.control("any-file").config("url.upload", "/common.file.FileAct/upload");
    any.control("any-file").config("url.retrieveConfig", "/common.file.FileAct/retrieveConfig");
    any.control("any-file").config("url.retrieveList", "/common.file.FileAct/retrieveList");
    any.control("any-file").config("column.downloadKey", "DOWNLOAD_KEY");
    any.control("any-file").config("column.fileName", "FILE_NAME");
    any.control("any-file").config("column.fileSize", "FILE_SIZE");
    any.control("any-file").config("upload.dragAndDrop", true);
    any.control("any-file").config("download.multiple", true);

    any.control("any-htmlviewer").resource(controlHome + "/any-htmlviewer/any-htmlviewer.js");

    any.control("any-smarteditor").resource("/common/ui/smarteditor/js/HuskyEZCreator.js");
    any.control("any-smarteditor").resource(controlHome + "/any-smarteditor/any-smarteditor.js");
    any.control("any-smarteditor").config("url.editorSkin", "/common/ui/smarteditor/SmartEditor2Skin.html");
    any.control("any-smarteditor").config("url.uploadImage", "/common.file.FileAct/uploadImage");
    any.control("any-smarteditor").config("url.downloadImage", "/common.file.FileAct/downloadImage");
    any.control("any-smarteditor").config("column.fileName", "FILE_NAME");

    any.control("any-contextmenu").resource(pluginsHome + "/jquery.contextmenu/jquery.contextmenu.css");
    any.control("any-contextmenu").resource(pluginsHome + "/jquery.contextmenu/jquery.contextmenu.js");
    any.control("any-contextmenu").resource(controlHome + "/any-contextmenu/any-contextmenu.js");
    any.control("any-contextmenu").config("url.icons", pluginsHome + "/jquery.contextmenu/icons");

    any.control("any-dsgrid").resource(controlHome + "/any-dsgrid/any-dsgrid.js");

    any.control("any-jqgrid").resource(pluginsHome + "/jquery.jqGrid/css/ui.jqgrid.css");
    any.control("any-jqgrid").resource("/common/ui/jquery/i18n/jqgrid/grid.locale-" + any.meta.langCode + ".js", false);
    any.control("any-jqgrid").resource(pluginsHome + "/jquery.jqGrid/js/jquery.jqGrid.min.js");
    any.control("any-jqgrid").resource(controlHome + "/any-jqgrid/any-jqgrid.js");
    any.control("any-jqgrid").config("url.plugins", pluginsHome + "/jquery.jqGrid/plugins");
    any.control("any-jqgrid").config("paging.rowList", [ 20, 50, 100, 150, 200 ]);
    any.control("any-jqgrid").config("paging.rowNum", 50);
    any.control("any-jqgrid").config("excelDownload.view", "/common.grid.GridCommonAct/viewExcelDownload");
    any.control("any-jqgrid").config("config.view", "/common.grid.GridCommonAct/viewConfig");
    any.control("any-jqgrid").config("config.load", "/common.grid.GridCommonAct/retrieveConfig");
    any.control("any-jqgrid").config("config.save", "/common.grid.GridCommonAct/updateConfig");

    any.control("any-jstree").resource(pluginsHome + "/jquery.jsTree/jquery.jstree.js");
    any.control("any-jstree").resource(pluginsHome + "/jquery.jsTree/jquery.hotkeys.js");
    any.control("any-jstree").resource(controlHome + "/any-jstree/any-jstree.js");

    any.control("any-jqplot").resource(pluginsHome + "/jquery.jqPlot/jquery.jqplot.css");
    any.control("any-jqplot").resource(pluginsHome + "/jquery.jqPlot/jquery.jqplot.js");
    if (jQuery.browser.msie && Number(jQuery.browser.version) < 9) {
        any.control("any-jqplot").resource(pluginsHome + "/jquery.jqPlot/excanvas.js");
    }
    any.control("any-jqplot").resource(controlHome + "/any-jqplot/any-jqplot.js");
    any.control("any-jqplot").config("url.plugins", pluginsHome + "/jquery.jqPlot/plugins");
    any.control("any-jqplot").config("jqplot.options", {
        "seriesColors":[ "#A5DBE5", "#F5F2A4", "#C44D58", "#FF6B6B", "#556270",
                         "#A2DF40", "#57D2CC", "#D9BCA1", "#FCE15C", "#74533B",
                         "#B3BD2E", "#007FA9", "#20BAD3", "#C44D58", "#E8D358",
                         "#79AC69", "#E9804C", "#B34C74", "#BABABA", "#FFD8D0"
                       ]
    });
})();

// 워크플로우 관련 컨트롤들
(function() {
    var controlHome = "/common/ui/controls";

    // 워크플로우 컨트롤
    any.control("wf-button").resource(controlHome + "/wf-button/wf-button.js");
    any.control("wf-cominfo").resource(controlHome + "/wf-cominfo/wf-cominfo.js");

    any.control("wf-mgt-activity").resource(controlHome + "/wf-mgt-activity/wf-mgt-activity.js");
    any.control("wf-mgt-view").resource(controlHome + "/wf-mgt-view/wf-mgt-view.js");
    any.control("wf-mgt-query").resource(controlHome + "/wf-mgt-query/wf-mgt-query.js");
    any.control("wf-mgt-code").resource(controlHome + "/wf-mgt-code/wf-mgt-code.js");
    any.control("wf-mgt-name").resource(controlHome + "/wf-mgt-name/wf-mgt-name.js");
    any.control("wf-mgt-event").resource(controlHome + "/wf-mgt-event/wf-mgt-event.js");
    any.control("wf-mgt-event").resource("/common/ui/konva/konva.js");
})();

// 업무 컨트롤들
(function() {
    var controlHome = "/common/ui/controls";
    var pluginsHome = "/common/ui/jquery/plugins";
    var echartHome = "/common/ui/echart";

    any.control("any-jqgrid").plugin("any-jqgrid-thumbnail", controlHome + "/plugins/any-jqgrid-thumbnail/any-jqgrid-thumbnail.css");
    any.control("any-jqgrid").plugin("any-jqgrid-thumbnail", controlHome + "/plugins/any-jqgrid-thumbnail/any-jqgrid-thumbnail.js");

    // 시스템 컨트롤
    any.control("sys-langcodelist").resource(controlHome + "/sys-langcodelist/sys-langcodelist.js");
    any.control("sys-langselector").resource(controlHome + "/sys-langselector/sys-langselector.js");
    any.control("sys-title").resource(controlHome + "/sys-title/sys-title.js");

    // 공통 컨트롤
    any.control("com-approval").resource(controlHome + "/com-approval/com-approval.js");
    any.control("com-widget").resource(controlHome + "/com-widget/com-widget.js");
    any.control("com-echart").resource(echartHome + "/echarts.js");
    any.control("com-echart").resource(controlHome + "/com-echart/com-echart.js");
    any.control("com-echart").config("url.themes", echartHome + "/theme");

    // 출원 컨트롤
    any.control("app-abstract").resource(controlHome + "/app-abstract/app-abstract.js");
    any.control("app-inventorlist").resource(controlHome + "/app-inventorlist/app-inventorlist.js");
    any.control("app-projectlist").resource(controlHome + "/app-projectlist/app-projectlist.js");
    any.control("app-techcodelist").resource(controlHome + "/app-techcodelist/app-techcodelist.js");
    any.control("app-refpatlist").resource(controlHome + "/app-refpatlist/app-refpatlist.js");
    any.control("app-refdsnlist").resource(controlHome + "/app-refdsnlist/app-refdsnlist.js");
    any.control("app-reftmklist").resource(controlHome + "/app-reftmklist/app-reftmklist.js");
    any.control("app-patcountrylist").resource(controlHome + "/app-patcountrylist/app-patcountrylist.js");
    any.control("app-dsncountrylist").resource(controlHome + "/app-dsncountrylist/app-dsncountrylist.js");
    any.control("app-tmkcountrylist").resource(controlHome + "/app-tmkcountrylist/app-tmkcountrylist.js");
    any.control("app-tmarkclslist").resource(controlHome + "/app-tmarkclslist/app-tmarkclslist.js");
    any.control("app-familydiagram").resource(controlHome + "/app-familydiagram/app-familydiagram.js");
    any.control("app-familydiagram").resource("/common/ui/kineticjs/kinetic.js");

    // 조사 컨트롤
    any.control("research-abstract").resource(controlHome + "/research-abstract/research-abstract.js");

    // 경쟁사 컨트롤
    any.control("competitor-abstract").resource(controlHome + "/competitor-abstract/competitor-abstract.js");

    // ipbiz 컨트롤
    any.control("ipbiz-contractcountrylist").resource(controlHome + "/ipbiz-contractcountrylist/ipbiz-contractcountrylist.js");

    // 분쟁 컨트롤
    any.control("dspt-refnolist").resource(controlHome + "/dspt-refnolist/dspt-refnolist.js");
    any.control("dspt-outrefnolist").resource(controlHome + "/dspt-outrefnolist/dspt-outrefnolist.js");

    // 저작권 컨트롤
    any.control("copyright-inventor").resource(controlHome + "/copyright-inventor/copyright-inventor.js");
    any.control("copyright-company").resource(controlHome + "/copyright-company/copyright-company.js");

    // 프로그램 컨트롤
    any.control("program-inventor").resource(controlHome + "/program-inventor/program-inventor.js");
    any.control("program-company").resource(controlHome + "/program-company/program-company.js");

})();
