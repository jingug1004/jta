any.control("any-file").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control);
        o.config = any.control(control).config;
        o.controlIndex = any.control().newIndex();
        o.dropAvailable = (o.config("upload.dragAndDrop") == true && jQuery('<input type="file">').get(0).files !== undefined && window.FormData !== undefined);
        o.options = {};

        o.isReady1 = !o.$control.hasAttr("policy");
        o.isReady2 = !o.$control.hasAttr("fileType");

        control.isReady = (o.isReady1 == true && o.isReady2 == true);

        o.options.rownumWidth = 40;

        if (o.dropAvailable == true) {
            o.dataFiles = [];
        }

        initDataset();

        o.simpleList = (o.$control.hasAttr("simpleList") && any.object.toBoolean(o.$control.attr("simpleList"), true));
        o.singleMode = (o.$control.hasAttr("singleMode") && any.object.toBoolean(o.$control.attr("singleMode"), true));

        o.$headerTable = jQuery('<table>').addClass("layout").css({ "margin-bottom": isSimpleList() == true || o.singleMode == true ? "0px" : "2px" }).appendTo(control);
        o.$headerTableRow = jQuery('<tr>').appendTo(jQuery('<tbody>').appendTo(o.$headerTable));

        any.preventDocumentDrop();

        if (isSimpleList() == true || o.singleMode == true) {
            o.$headerTable.addClass("auto2").css({ "margin-left": "-2px" });
            o.$uploadFormArea = jQuery('<td>').addClass("any-file-upload-button").appendTo(o.$headerTableRow);
            o.$uploadForm = jQuery('<form>').appendTo(o.$uploadFormArea).css({ "position": "relative", "overflow": "hidden" });
            o.$addButton = jQuery('<button>').addClass("space").attr({ "size": "small" });
            o.$addButton.text(isSimpleList() == true ? any.message("any.btn.add", "Add") : any.message("any.btn.find", "Find"));
            o.$addButton.control("any-button").appendTo(o.$uploadForm);
        } else {
            o.$headerTable.addClass("auto");
            o.$buttonTable = jQuery('<table>').addClass("layout auto2").css({ "margin-left": "-2px" }).appendTo(jQuery('<td>').appendTo(o.$headerTableRow));
            o.$buttonTableRow = jQuery('<tr>').appendTo(jQuery('<tbody>').appendTo(o.$buttonTable));
            o.$uploadFormArea = jQuery('<td>').addClass("any-file-upload-button").appendTo(o.$buttonTableRow);
            o.$buttonArea = jQuery('<td>').appendTo(o.$buttonTableRow);
            o.$uploadForm = jQuery('<form>').appendTo(o.$uploadFormArea).css({ "position": "relative", "overflow": "hidden" });
            o.$addButton = jQuery('<button>').addClass("space").attr({ "size": "small" }).text(any.message("any.btn.add", "Add")).control("any-button").appendTo(o.$uploadForm);
            o.$deleteButton = addButton(any.message("any.btn.delete", "Delete"), deleteSelectedRows);

            if (isSimpleList() != true && o.singleMode != true && o.config("column.sortOrder") != null && o.dropAvailable == true) {
                o.$moveUpButton = addButton(any.message("any.btn.moveUp", "Up"), moveUpSelectedRows);
                o.$moveDownButton = addButton(any.message("any.btn.moveDown", "Down"), moveDownSelectedRows);
                o.sortOrderMode = true;
            }

            if (o.config("download.multiple") == true) {
                o.$downloadButton = addButton(any.message("any.btn.download", "Download"), downloadSelectedRows);
            }
        }

        o.$uploadForm.data("any-file-control", control);

        o.$headerRightCell = jQuery('<td>').addClass("any-file-upload-count").width("*").css({ "padding-left": "5px", "text-align": isSimpleList() == true || o.singleMode == true ? "left" : "right" }).appendTo(o.$headerTableRow);

        if (o.singleMode != true && !(isSimpleList() == true && o.dropAvailable == true)) {
            o.$countMessage = jQuery('<span>').hide().appendTo(o.$headerRightCell);
        }

        o.$listTable = jQuery('<table>').addClass("list").showHide(isSimpleList() != true && o.singleMode != true).appendTo(control);
        o.$listColgroup = jQuery('<colgroup>').appendTo(o.$listTable);
        o.$listThead = jQuery('<thead>').appendTo(o.$listTable);
        o.$listTbody = jQuery('<tbody>').appendTo(o.$listTable);

        o.$uploadedList = jQuery('<div>').css({ "position": "relative" }).showHide(isSimpleList() == true || o.singleMode == true).appendTo(o.singleMode == true ? o.$headerRightCell : control);
        o.$queueList = jQuery('<div>').css({ "position": "relative" }).showHide(isSimpleList() == true || o.singleMode == true).appendTo(o.singleMode == true ? o.$headerRightCell : control);

        o.$progTable = jQuery('<table>').addClass("layout").css({ "margin-top": "2px" }).hide().appendTo(control);
        o.$progTableRow = jQuery('<tr>').appendTo(jQuery('<tbody>').appendTo(o.$progTable));
        o.$progRatio = jQuery('<span>').css({ "font-weight": "bold" }).appendTo(jQuery('<td>').width("50px").css({ "text-align": "center" }).appendTo(o.$progTableRow));
        o.$progBar = jQuery('<div>').height("10px").appendTo(jQuery('<td>').width("*").css("padding-left", "5px").appendTo(o.$progTableRow));

        if (o.dropAvailable == true) {
            if (isSimpleList() != true && o.singleMode != true) {
                o.$dropMessage = jQuery('<div>').addClass("any-file-drop-message").css({ "text-align": "left", "padding-top": "1px" }).appendTo(control);
            } else {
                o.$dropMessage = jQuery('<span>').addClass("any-file-drop-message").appendTo(o.$headerRightCell);
            }
            o.$dropMessage.text(any.message("any.file.message.dragAndDropHere", "Drag files here.")).hide();
        }

        o.$listTbody.on("click", 'td[name="td_select"] > input:checkbox:enabled:visible', function() {
            o.$headCheck.prop("checked", o.$listTbody.find('td[name="td_select"] > input:checkbox:enabled:visible').not(':checked').length == 0);
        }).on("mousedown", function() {
            if (o.deselectRows === true) {
                o.$listTable.find('input:checkbox:checked').prop("checked", false);
                delete(o.deselectRows);
            }
        });

        o.$progBar.click(function() {
            hideProgressBar();
        });

        any.control.util.codedata.setDefault(o, "fileType");

        o.$control.defineMethod("reset", reset);
        o.$control.defineMethod("setOption", setOption);
        o.$control.defineMethod("setCodeDataObject", setCodeDataObject);
        o.$control.defineMethod("addFileType", addFileType);
        o.$control.defineMethod("getSelectedFileTypes", getSelectedFileTypes);
        o.$control.defineMethod("addButton", addButton);
        o.$control.defineMethod("addColumn", addColumn);
        o.$control.defineMethod("addAction", addAction);
        o.$control.defineMethod("addParam", addParam);
        o.$control.defineMethod("reloadList", reloadList);
        o.$control.defineMethod("upload", upload);
        o.$control.defineMethod("hideProgressBar", hideProgressBar);

        o.$control.defineProperty("ds", { get: getDs });
        o.$control.defineProperty("policy", { get: getPolicy, set: setPolicy });
        o.$control.defineProperty("fileType", { get: getFileType, set: setFileType });
        o.$control.defineProperty("simpleList", { get: isSimpleList });
        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("readOnly", { get: getReadOnly, set: setReadOnly });
        o.$control.defineProperty("readOnly2", { get: getReadOnly2, set: setReadOnly2 });
        o.$control.defineProperty("totalCount", { get: getTotalCount });
        o.$control.defineProperty("jsonObject", { get: getJsonObject, set: setJsonObject });

        any.control(control).initialize();

        initialize();
    })();

    function getDs()
    {
        return o.ds;
    }

    function initDataset()
    {
        if (o.$control.hasAttr("ds")) {
            o.ds = any.ds(o.$control.attr("ds"));
        } else if (o.$control.data("grid") != null || (o.$control.hasAttr("bind") && control.id.indexOf("_") <= 0)) {
            o.ds = any.ds("ds_" + control.id + "_" + any.control().newIndex());
        } else if (control.id.indexOf("_") > 0) {
            o.ds = any.ds("ds_" + control.id.substr(control.id.indexOf("_") + 1));
        } else {
            o.ds = any.ds(control.id);
        }

        o.ds.listData(true);

        jQuery(o.ds).on("onLoad", reset);

        o.ds.isChanged = function()
        {
            if (getQueueCount() != 0) {
                return true;
            }
            if (getDeleteCount() != 0) {
                return true;
            }

            var $sels = o.$control.find('select[name="' + o.config("column.fileType") + '"]');

            for (var i = 0, ii = $sels.length; i < ii; i++) {
                if ($sels.eq(i).data("original-value") != $sels.eq(i).val()) {
                    return true;
                }
            }

            return false;
        };
    }

    function reset()
    {
        if (o.dropAvailable != true) {
            o.$uploadForm.children('input:file').remove();
        } else {
            o.dataFiles.length = 0;
        }

        setUploadedFileList();
        addInputFile();
        hideProgressBar();
    }

    function setOption()
    {
        any.copyArguments(o.options, arguments);
    }

    function setCodeDataObject(codeDatas)
    {
        for (var i = 0, ii = codeDatas.length; i < ii; i++) {
            addFileType(codeDatas[i].data.CODE, codeDatas[i].data.NAME);
        }

        checkReady(2);
    }

    function getPolicy()
    {
        return o.policy;
    }

    function setPolicy(val)
    {
        o.policy = val;

        if (o.config("url.retrieveConfig") == null) {
            checkReady(1);
            return;
        }

        o.configDs = any.ds(control.id + "_" + o.controlIndex);

        var prx = any.proxy().output(o.configDs);
        prx.url(o.config("url.retrieveConfig"));
        prx.param("policy", o.policy);

        prx.on("onSuccess", function() {
            checkReady(1);
        });

        prx.on("onError", function() {
            this.error.show();

            checkReady(1);
        });

        prx.execute();
    }

    function getFileType()
    {
        return o.fileType;
    }

    function setFileType(val)
    {
        any.codedata(control).get(val);

        o.fileType = val;
    }

    function addFileType(code, name)
    {
        if (o.config("column.fileType") == null) {
            return;
        }

        if (o.fileTypes == null) {
            o.fileTypes = [];
        }

        o.fileTypes.push({ code: code, name: name });
    }

    function getSelectedFileTypes(value)
    {
        var fileTypes = [];

        o.$listTbody.children('tr[list-type="uploaded"],tr[list-type="queue"]').each(function(index) {
            var val = jQuery(this).find('select[name="' + o.config("column.fileType") + '"]').val();

            if (value == null) {
                fileTypes.push(val);
            } else if (value == val) {
                fileTypes.push(index);
            }
        });

        return fileTypes;
    }

    function isSimpleList()
    {
        return o.simpleList == true || (o.singleMode == true && isReadOnly() == true);
    }

    function addButton(text, func)
    {
        if (o.$buttonArea == null) {
            return;
        }

        return jQuery('<button>').addClass("space").attr({ "size": "small" }).text(text).control("any-button").appendTo(o.$buttonArea).click(function() {
            func.apply(control);
        });
    }

    function addColumn(columnInfo)
    {
        if (o.customColumns == null) {
            o.customColumns = [];
        }

        o.customColumns.push(columnInfo);
    }

    function addAction(colName, action, check)
    {
        if (o.actions == null) {
            o.actions = {};
        }

        o.actions[colName] = { action: action, check: check };
    }

    function addParam(name, value)
    {
        if (o.params == null) {
            o.params = {};
        }

        o.params[name] = value;
    }

    function hideProgressBar()
    {
        if (o.uploading != true) {
            o.$progTable.hide();
        }
    }

    function resetRowNumbers()
    {
        var row = 1;

        o.$listTbody.children('tr:not([delete="delete"])').each(function() {
            jQuery(this).children('th:first').text(row++);
        });
    }

    function deleteSelectedRows()
    {
        o.$listTbody.find('td[name="td_select"]').each(function() {
            var $this = jQuery(this);
            var $check = $this.children('input:checkbox:enabled:visible');

            if ($check.prop("checked") != true) {
                return true;
            }

            var $tr = $this.parent();

            if ($tr.attr("list-type") == "uploaded") {
                $tr.data("delete", 1).attr("delete", "delete").hide().children('th:first').text("");
            } else {
                deleteDataFile($tr.data("file"));

                if (o.sortOrderMode == true) {
                    $tr.empty().remove();
                }
            }
        });

        o.$headCheck.prop("checked", false);

        if (o.sortOrderMode != true) {
            setQueueFileList();
        }

        resetRowNumbers();
    }

    function moveUpSelectedRows()
    {
        o.$listTbody.find('td[name="td_select"]').each(function() {
            var $this = jQuery(this);
            var $check = $this.children('input:checkbox:enabled:visible');

            if ($check.prop("checked") != true) {
                return true;
            }

            var $tr = $this.parent();
            var $targetTr = $tr.prevAll('tr:visible').first();

            if ($targetTr.length == 0) {
                return false;
            }

            o.ds.moveRow($tr.index(), $targetTr.index());

            $tr.insertBefore($targetTr);
        });

        o.deselectRows = true;

        resetRowNumbers();
    }

    function moveDownSelectedRows()
    {
        jQuery(o.$listTbody.find('td[name="td_select"]').get().reverse()).each(function() {
            var $this = jQuery(this);
            var $check = $this.children('input:checkbox:enabled:visible');

            if ($check.prop("checked") != true) {
                return true;
            }

            var $tr = $this.parent();
            var $targetTr = $tr.nextAll('tr:visible').first();

            if ($targetTr.length == 0) {
                return false;
            }

            o.ds.moveRow($tr.index(), $targetTr.index());

            $tr.insertAfter($targetTr);
        });

        o.deselectRows = true;

        resetRowNumbers();
    }

    function downloadSelectedRows()
    {
        var file = any.file().url(o.config("url.download"));
        var count = 0;

        o.$listTbody.find('td[name="td_select"]').each(function() {
            var $this = jQuery(this);
            var $check = $this.children('input:checkbox:enabled:visible');

            if ($check.prop("checked") != true) {
                return true;
            }

            var $tr = $this.parent();

            if ($tr.attr("list-type") == "uploaded") {
                file.param(o.config("column.downloadKey"), $tr.data("fileInfo")[o.config("column.downloadKey")], true);
                count++;
            }
        });

        if (count == 0) {
            alert(any.message("any.file.download.notSelected"));
            return;
        }

        var compressFileName = function()
        {
            return any.date().timestamp() + "_" + (S4() + S4() + "-" + S4() + "-4" + S4().substr(0,3) + "-" + S4() + "-" + S4() + S4() + S4()).toLowerCase();

            function S4()
            {
                return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
            }
        }();

        file.param("readOnly", any["boolean"]().value(isReadOnly()));
        file.param("compressFileName", compressFileName);

        o.$control.fire("onBeforeDownload", [file, control]);

        o.$downloadButton.children('span:first').css("display", "inline");
        o.$downloadButton.after(o.$downloadButton.$progress = jQuery('<span>').css({ "margin-left": "2px", "vertical-align": "middle" }));
        o.$downloadButton.prop("disabled", true);

        any.progress(file).interval(500).callback(function(data) {
            if (data != null) {
                o.$downloadButton.$progress.text("(" + any.text.formatNumber(data.progress * 100, 2) + "%)");
            }
            if (data == null || data.completed == true) {
                this.stop();
            }
        }).on("onStop", function() {
            o.$downloadButton.prop("disabled", false);
            o.$downloadButton.$progress.remove();
        }).start();

        file.download();
    }

    function upload(url)
    {
        if (isReadOnly() == true) {
            o.$control.fire("onUploadComplete", [true]);
            return;
        }

        if (getQueueCount() > 0) {
            o.$progTable.show();
            o.$progRatio.text("");
            o.$progBar.progressbar();

            setUploadProgress(-1);
        }

        if (o.sortOrderMode == true) {
            o.$listTbody.children('tr[list-type="uploaded"]').each(function() {
                var $tr = jQuery(this);
                $tr.data("row-data", o.ds.rowData($tr.index()));
            });
        }

        for (var i = o.ds.rowCount() - 1; i >= 0; i--) {
            if (o.ds.jobType(i) == "C") {
                o.ds.deleteRow(i);
            }
        }

        o.$listTbody.children('tr[list-type="uploaded"]').each(function(index) {
            var $tr = jQuery(this);
            o.ds.jobType(index, $tr.data("delete") == 1 ? "D" : "U");
            var fileInfo = $tr.data("fileInfo");
            for (var item in fileInfo) {
                o.ds.value(index, item, fileInfo[item]);
            }
            if (o.fileTypes == null || o.fileTypes.length == 0) {
                o.ds.value(index, o.config("column.fileType"), "");
            } else if (o.fileTypes.length == 1) {
                o.ds.value(index, o.config("column.fileType"), o.fileTypes[0].code);
            } else {
                o.ds.value(index, o.config("column.fileType"), $tr.find('select[name="' + o.config("column.fileType") + '"]').val());
            }
        });

        o.$uploadedList.children('div').each(function(index) {
            var $div = jQuery(this);
            if (o.$uploadedList.isVisible() && $div.data("delete") != 1) {
                return true;
            }
            o.ds.jobType(index, "D");
            var fileInfo = $div.data("fileInfo");
            for (var item in fileInfo) {
                o.ds.value(index, item, fileInfo[item]);
            }
        });

        o.ds.meta("[==FILE-DATA==]", true);
        o.ds.meta("policy", o.policy);
        o.ds.meta("value", o.value);

        var params = [];
        if (o.policy != null && o.policy != "") {
            params.push("policy=" + encodeURIComponent(o.policy));
        }
        if (o.value != null && o.value != "") {
            params.push("value=" + encodeURIComponent(o.value));
        }

        o.prog = any.progress(params).interval(500).callback(function(data) {
            if (data != null) {
                setUploadProgress(parseInt(data.progress * 100, 10));
            }
        });

        var file = any.file();
        file.url(any.text.nvl(url, o.config("url.upload")) + (params.length == 0 ? "" : "?" + params.join("&")));
        if (o.params != null) {
            for (var name in o.params) {
                file.param(name, o.params[name]);
            }
        }
        file.data(o.ds, "ds");
        o.$listTbody.children('tr[list-type="queue"]').each(function() {
            if (o.fileTypes == null || o.fileTypes.length == 0) {
                file.param("fileType", "", true);
            } else if (o.fileTypes.length == 1) {
                file.param("fileType", o.fileTypes[0].code, true);
            } else {
                file.param("fileType", jQuery(this).find('select[name="' + o.config("column.fileType") + '"]').val(), true);
            }
        });

        file.event("onUploadSuccess", function(result) {
            this.isUploadSuccessed = true;
            closeUploadMonitor();
            disableButtons(false);
            if (result != null) {
                var $queueListTr = o.$listTbody.children('tr[list-type="queue"]');
                if (typeof(result.model) === "object") {
                    var fileList;
                    for (var item in result.model) {
                        fileList = result.model[item];
                        break;
                    }
                    for (var i = 0, ii = fileList.length; i < ii; i++) {
                        var row = o.ds.addRow();
                        var $tr = (o.sortOrderMode == true ? jQuery(jQuery(o.dataFiles[i]).data("tr")) : $queueListTr.eq(i));
                        o.ds.jobType(row, "C");
                        for (var item in fileList[i]) {
                            o.ds.value(row, item, fileList[i][item]);
                        }
                        if (o.sortOrderMode == true) {
                            $tr.data("row-data", o.ds.rowData(row));
                        }
                        if (o.fileTypes == null || fileList[i][o.config("column.fileType")] != null) {
                            continue;
                        }
                        if (o.fileTypes.length == 0) {
                            o.ds.value(row, o.config("column.fileType"), null);
                        } else if (o.fileTypes.length == 1) {
                            o.ds.value(row, o.config("column.fileType"), o.fileTypes[0].code);
                        } else {
                            o.ds.value(row, o.config("column.fileType"), $tr.find('select[name="' + o.config("column.fileType") + '"]').val());
                        }
                    }
                } else {
                    if (result.meta != null && result.meta.value != null) {
                        o.ds.meta("value", o.value = result.meta.value);
                    }
                    if (result.meta != null && String(result.meta.updated).toLowerCase() == "true") {
                        o.$uploadForm.children('input:file').remove();
                        addInputFile();
                        o.ds.init().load(result);
                    } else {
                        for (var i = 0, ii = result.data.length; i < ii; i++) {
                            var row = o.ds.addRow();
                            var $tr = (o.sortOrderMode == true ? jQuery(jQuery(o.dataFiles[i]).data("tr")) : $queueListTr.eq(i));
                            o.ds.jobType(row, "C");
                            for (var item in result.data[i].data) {
                                o.ds.value(row, item, result.data[i].data[item]);
                            }
                            if (o.sortOrderMode == true) {
                                $tr.data("row-data", o.ds.rowData(row));
                            }
                            if (o.fileTypes == null || result.data[i].data[o.config("column.fileType")] != null) {
                                continue;
                            }
                            if (o.fileTypes.length == 0) {
                                o.ds.value(row, o.config("column.fileType"), null);
                            } else if (o.fileTypes.length == 1) {
                                o.ds.value(row, o.config("column.fileType"), o.fileTypes[0].code);
                            } else {
                                o.ds.value(row, o.config("column.fileType"), $tr.find('select[name="' + o.config("column.fileType") + '"]').val());
                            }
                        }
                    }
                }
            }
            if (o.sortOrderMode == true) {
                var sortOrder = 1;
                o.$listTbody.children('tr:not([delete="delete"])').each(function() {
                    var $this = jQuery(this);
                    if ($this.data("row-data") != null) {
                        $this.data("row-data")[o.config("column.sortOrder")] = sortOrder++;
                        $this.removeData("row-data");
                    }
                });
                for (var i = 0; i < o.ds.rowCount(); i++) {
                    if (o.ds.jobType(i) == "D") {
                        o.ds.value(i, o.config("column.sortOrder"), -1);
                    }
                }
            }
            o.$control.fire("onUploadSuccess");
            o.$control.fire("onUploadComplete", [true]);
        });

        file.event("onActionFailure", function(error) {
            closeUploadMonitor();
            disableButtons(false);
            hideProgressBar();
            any.error(error).show();
            o.$control.fire("onUploadError");
            o.$control.fire("onUploadComplete", [false]);
        });

        disableButtons(true);

        o.$control.fire("onUploadStart");

        if (o.dropAvailable != true) {
            file.upload(o.$uploadForm[0], control);
        } else {
            file.upload(o.dataFiles, control);
        }

        if (file.isUploadSuccessed != true) {
            o.prog.start();
        }
    }

    function disableButtons(uploading)
    {
        o.uploading = (uploading == true);

        o.$uploadForm.children('input:file').css("visibility", o.uploading ? "hidden" : "");
        o.$addButton.button("option", "disabled", o.uploading);

        if (o.$deleteButton != null) {
            o.$deleteButton.button("option", "disabled", o.uploading);
        }

        if (isSimpleList() == true || o.singleMode == true) {
            o.$control.find('span[name="span_delete"]').button("option", "disabled", o.uploading);
        } else {
            o.$headCheck.prop("disabled", o.uploading);
            o.$listTbody.find('td[name="td_select"]').children('input:checkbox').prop("disabled", o.uploading);
        }
    }

    function reloadList()
    {
        loadFileList();
    }

    function getValue()
    {
        return o.value;
    }

    function setValue(val)
    {
        o.value = val;

        if (val == null || val == "") {
            o.ds.init();
            setUploadedFileList();
        } else {
            loadFileList();
        }
    }

    function getReadOnly()
    {
        return o.readOnly;
    }

    function setReadOnly(val)
    {
        o.readOnly = (String(val).toLowerCase() == "readonly" || any.object.toBoolean(val, true));
        resetDisplay();
    }

    function getReadOnly2()
    {
        return o.readOnly2;
    }

    function setReadOnly2(val)
    {
        o.readOnly2 = (String(val).toLowerCase() == "readonly2" || any.object.toBoolean(val, true));
        resetDisplay();
    }

    function isReadOnly()
    {
        return o.readOnly == true || o.readOnly2 == true;
    }

    function getTotalCount()
    {
        return getUploadedCount() + getQueueCount();
    }

    function getJsonObject()
    {
        return o.ds.toJSON();
    }

    function setJsonObject(val)
    {
        if (o.$control.data("grid") == null) {
            o.ds.loadData(val, true);
        } else {
            window.setTimeout(function() {
                o.ds.loadData(val, true);
            });
        }
    }

    function loadFileList()
    {
        var prx = any.proxy().output(o.ds);
        prx.url(o.config("url.retrieveList"));
        prx.param("value", o.value);

        prx.on("onError", function() {
            this.error.show();
        });

        prx.option({ "loading-container": control });

        prx.execute();
    }

    function getUploadedCount()
    {
        if (isSimpleList() == true || o.singleMode == true) {
            return o.$uploadedList.children('div').length - getDeleteCount();
        }

        return o.$listTbody.children('tr[list-type="uploaded"]').length - getDeleteCount();
    }

    function getQueueCount()
    {
        if (isSimpleList() == true || o.singleMode == true) {
            return o.$queueList.children('div').length;
        }

        return o.$listTbody.children('tr[list-type="queue"]').length;
    }

    function getDeleteCount()
    {
        var $divs = o.$uploadedList.children('div');

        if ((isSimpleList() == true || o.singleMode == true) && o.$uploadedList.isVisible() != true) {
            return $divs.length;
        }

        var $tr = o.$listTbody.children('tr[list-type="uploaded"]');
        var deleteCount = 0;

        for (var i = 0, ii = $tr.length; i < ii; i++) {
            if (jQuery($tr[i]).data("delete") == 1) {
                deleteCount++;
            }
        }

        for (var i = 0, ii = $divs.length; i < ii; i++) {
            if (jQuery($divs[i]).data("delete") == 1) {
                deleteCount++;
            }
        }

        return deleteCount;
    }

    function checkReady(val)
    {
        o["isReady" + val] = true;

        control.isReady = (o.isReady1 == true && o.isReady2 == true);

        initialize();
    }

    function initialize()
    {
        if (control.isReady != true) {
            return;
        }

        if (o.$listThead.children('tr').length > 0) {
            return;
        }

        var $tr = jQuery('<tr>').appendTo(o.$listThead);

        jQuery('<col>').attr({ "width": o.options.rownumWidth }).appendTo(o.$listColgroup);
        jQuery('<th>').addClass("ui-widget-header").appendTo($tr).text(any.message("any.file.label.no"));

        if (isSimpleList() == true || o.singleMode == true) {
            jQuery('<col>').attr({ id: "col_select", width: "30px" }).appendTo(o.$listColgroup);
            jQuery('<th>').attr({ id: "th_select" }).addClass("ui-widget-header").appendTo($tr);
        } else {
            jQuery('<col>').attr({ "id": "col_select", "width": "30px" }).appendTo(o.$listColgroup);
            jQuery('<th>').attr({ "id": "th_select" }).addClass("ui-widget-header").appendTo($tr);
            o.$headCheck = jQuery('<input>').attr({ "type": "checkbox" }).appendTo($tr.children('th:last')).click(function() {
                o.$listTbody.find('td[name="td_select"]').children('input:checkbox:enabled:visible').prop("checked", this.checked);
            });
        }

        if (o.fileTypes != null && o.fileTypes.length > 1) {
            jQuery('<col>').attr({ id: "col_type", width: "*" }).appendTo(o.$listColgroup);
            jQuery('<th>').addClass("ui-widget-header").appendTo($tr).text(any.message("any.file.label.type"));
        }

        jQuery('<col>').attr({ width: "*" }).appendTo(o.$listColgroup);
        jQuery('<th>').addClass("ui-widget-header").appendTo($tr).text(any.message("any.file.label.name"));

        jQuery('<col>').attr({ width: "120px" }).appendTo(o.$listColgroup);
        jQuery('<th>').addClass("ui-widget-header").appendTo($tr).text(any.message("any.file.label.size"));

        if (o.customColumns != null) {
            for (var i = 0, ii = o.customColumns.length; i < ii; i++) {
                jQuery('<col>').attr({ width: any.text.nvl(o.customColumns[i].width, "*") }).appendTo(o.$listColgroup);
                jQuery('<th>').addClass("ui-widget-header").appendTo($tr).text(o.customColumns[i].label);
            }
        }

        initDragAndDrop();

        resetDisplay();

        addInputFile();
        setUploadCountMessage();
        setNoFileMessage(true);
    }

    function initDragAndDrop()
    {
        if (o.dropAvailable != true) {
            return;
        }

        o.$dropZone = jQuery('<div>').css({ "position": "absolute", "top": "0", "left": "0", "width": "100%", "height": "100%" }).hide().appendTo(control);
        o.$dropZone.css({ "background-color": "#0000ff", "opacity": "0.5" });
        o.$dropZone.addClass("any-file-dropzone");

        o.$control.css({ "position": "relative" }).on("dragenter", function() {
            if (isReadOnly() == true) {
                return;
            }
            o.$dropZone.show();
        }).on("mouseenter", function() {
            setTimeout(function () {
                o.$dropZone.hide();
            }, 500);
        });

        o.$dropZone.on("dragleave", function() {
            if (isReadOnly() == true) {
                return;
            }
            o.$dropZone.hide();
        }).on("drop", function(event) {
            if (isReadOnly() == true) {
                return;
            }
            o.$dropZone.hide();
            addDataFiles(event.originalEvent.dataTransfer.files);
            setQueueFileList();
        });
    }

    function setNoFileMessage(bool)
    {
        o.$listTbody.children('tr[noFileMessageRow="true"]').remove();

        if (bool != true || o.$listTbody.children('tr:not([delete="delete"])').length > 0) {
            return;
        }

        jQuery('<td>').attr({ "colspan": Math.max(o.$listColgroup.children().length - (isReadOnly() == true && o.config("download.multiple") != true ? 1 : 0), 1) })
                .css({ "text-align": "center", "color": "gray" }).text(any.message("any.file.message.noFile", "(No files)"))
                .appendTo(jQuery('<tr>').attr({ "noFileMessageRow": "true" }).appendTo(o.$listTbody));
    }

    function addInputFile()
    {
        if (o.singleMode == true && o.$uploadForm.children('input:file').length > 0) {
            return;
        }
        if (o.$uploadForm.children('input:file[value=""]').length > 0) {
            return;
        }

        if (o.dropAvailable == true) {
            o.$uploadForm.children('input:file').remove();
        }

        jQuery('<input>').prop("type", "file").attr({ "name": "file[]", "title": "Find file", "multiple": o.singleMode != true }).appendTo(o.$uploadForm)
            .css({ "position": "absolute", "top": "0px", "right": "0px", "width": "210px", "height": "100%", "cursor": "pointer", "border-color": "transparent", "border-width": "0px 0px 100px 200px", "opacity": "0" })
            .mouseover(function() { o.$addButton.fire("mouseover"); }).mousedown(function() { o.$addButton.fire("mousedown"); }).mouseout(function() { o.$addButton.fire("mouseout"); })
            .click(function() {
                hideProgressBar();
            })
            .change(function() {
                addDataFiles(this.files);
                setQueueFileList();
                addInputFile();
            })
        ;
    }

    function addDataFiles(files)
    {
        if (o.dropAvailable != true) {
            return;
        }
        if (isReadOnly() == true) {
            return;
        }

        if (o.singleMode == true) {
            o.dataFiles.length = 0;
        }

        if (files == null) {
            return;
        }

        initValidationMessage();

        for (var i = 0, ii = (o.singleMode == true ? 1 : files.length); i < ii; i++) {
            if (checkValidation([files[i]]) == true) {
                o.dataFiles.push(files[i]);
            }
        }
    }

    function deleteDataFile(file)
    {
        if (file == null) {
            return;
        }
        if (isReadOnly() == true) {
            return;
        }

        if (o.dropAvailable != true) {
            jQuery(file).remove();
            return;
        }

        for (var i = o.dataFiles.length - 1; i >= 0; i--) {
            if (o.dataFiles[i] == file) {
                o.dataFiles.splice(i, 1);
                break;
            }
        }
    }

    function setUploadedFileList()
    {
        if ((isSimpleList() == true || o.singleMode == true) && isReadOnly() == true) {
            o.$uploadedList.appendTo(control);
        }

        o.$listTbody.children('tr').remove();
        o.$uploadedList.empty().showHide(isSimpleList() == true || o.singleMode == true);
        o.$queueList.empty().hide();
        setNoFileMessage();

        for (var i = 0, ii = o.ds.rowCount(); i < ii; i++) {
            if (o.ds.jobType(i) != "D") {
                addUploadedFile(o.ds.rowData(i));
            }
        }

        setUploadCountMessage();
        setNoFileMessage(true);

        function addUploadedFile(fileInfo)
        {
            if (isSimpleList() != true && o.singleMode != true) {
                addTableList(fileInfo);
                return;
            }

            var $div = jQuery('<div>').data("fileInfo", fileInfo).appendTo(o.$uploadedList);

            if (isSimpleList() == true || o.$uploadedList.children('div').length > 1) {
                $div.css({ "margin-top": "2px" });
            }

            if (isReadOnly() == true) {
                if ((o.singleMode != true || o.ds.rowCount() > 1) && (jQuery.browser.msie != true || Number(jQuery.browser.version) >= 8)) {
                    jQuery('<span>').appendTo($div).addClass("ui-icon ui-icon-disk").css({ "margin-right": "3px", "vertical-align": "middle", "display": "inline-block" });
                }
            } else {
                if (o.singleMode == true) {
                    $div.css({ "margin-left": "-3px" });
                }
                jQuery('<span>').appendTo($div).button({ icons: { primary: "ui-icon-close" } }).css({ "width": "18px", "height": "18px", "margin-right": "4px", "vertical-align": "middle" }).click(function() {
                    $div.data("delete", $div.data("delete") == 1 ? 0 : 1);
                    var $this = jQuery(this);
                    var textDecoration = ($div.data("delete") == 1 ? "line-through" : "");
                    $this.button("option", "icons", { primary: $div.data("delete") == 1 ? "ui-icon-arrowreturn-1-w" : "ui-icon-close" });
                    $this.next().css("text-decoration", textDecoration).next().css("text-decoration", textDecoration);
                    $this.children('span:first').css({ "left": "1px" });
                    setUploadCountMessage();
                }).children('span:first').css({ "left": "1px" }).next().remove();
            }

            var $span = jQuery('<span>').attr("role", "download-link").appendTo($div).data("fileInfo", fileInfo).css({ "vertical-align": "middle" }).text(fileInfo[o.config("column.fileName")]).click(function() {
                if (o.readOnly2 != true) {
                    var file = any.file().url(o.config("url.download"));
                    file.param(o.config("column.downloadKey"), jQuery(this).data("fileInfo")[o.config("column.downloadKey")]);
                    file.param("readOnly", any["boolean"]().value(isReadOnly()));
                    o.$control.fire("onBeforeDownload", [file, control]);
                    file.download();
                }
            });

            if (o.readOnly2 != true) {
                $span.addClass("link");
            }

            jQuery('<span>').appendTo($div).css({ "margin-left": "3px", "vertical-align": "middle" }).text("(" + any.text.formatNumber(fileInfo[o.config("column.fileSize")]) + " Byte)");
        }
    }

    function setQueueFileList()
    {
        if (o.dropAvailable != true) {
            var $files = o.$uploadForm.children('input:file');

            if (checkValidation($files) != true) {
                return;
            }

            $files.each(function() {
                var $this = jQuery(this);
                if ($this.data("tr") == null) {
                    return true;
                }
                $this.data("fileTypeValues", []);
                if (this.files != null) {
                    for (var i = 0; i < this.files.length; i++) {
                        $this.data("fileTypeValues").push(jQuery($this.data("tr")[i]).find('select[name="' + o.config("column.fileType") + '"]').val());
                    }
                } else {
                    $this.data("fileTypeValues").push(jQuery($this.data("tr")[0]).find('select[name="' + o.config("column.fileType") + '"]').val());
                }
                $this.data("tr", null);
            });

            clearQueueList();

            $files.each(function() {
                var $this = jQuery(this);
                var files = getInputFiles(this);

                for (var i = 0, ii = files.length; i < ii; i++) {
                    var fileInfo = {};

                    if ($this.data("fileTypeValues") != null) {
                        fileInfo[o.config("column.fileType")] = $this.data("fileTypeValues")[i];
                    }

                    fileInfo[o.config("column.fileName")] = getFileName(files[i].name);
                    fileInfo[o.config("column.fileSize")] = files[i].size;

                    if (isSimpleList() != true && o.singleMode != true) {
                        if ($this.data("tr") == null) {
                            $this.data("tr", []);
                        }
                        $this.data("tr").push(addTableList(fileInfo, this, i == 0 ? files.length : 1));
                        continue;
                    }

                    var $div = jQuery('<div>').appendTo(o.$queueList);
                    var icon;

                    if (isSimpleList() == true) {
                        $div.css({ "margin-top": "2px" });
                        icon = (i == 0 ? "ui-icon-minus" : "ui-icon-carat-1-sw");
                    } else if (o.singleMode == true) {
                        $div.css({ "margin-left": "-3px" });
                        icon = "ui-icon-close";
                    }

                    jQuery('<span>').attr("name", "span_delete").appendTo($div).button({ icons: { primary: icon } })
                        .css({ "width": "18px", "height": "18px", "margin-right": "4px", "vertical-align": "middle" })
                        .data("file", this)
                        .click(function() {
                            jQuery(jQuery(this).data("file")).remove();
                            setQueueFileList();
                            addInputFile();
                        })
                        .children('span:first').css({ "left": "1px" }).next().remove();

                    jQuery('<span>').appendTo($div).css({ "vertical-align": "middle" }).text(function() {
                        var val = fileInfo[o.config("column.fileName")];
                        if (files[i].size != null) {
                            return val + " (" + any.text.formatNumber(files[i].size) + " Byte)";
                        }
                        return val;
                    }());
                }
            });
        } else {
            var files = o.dataFiles;

            for (var i = 0, ii = files.length; i < ii; i++) {
                var $this = jQuery(files[i]);

                if ($this.data("tr") != null) {
                    $this.data("fileTypeValue", jQuery($this.data("tr")).find('select[name="' + o.config("column.fileType") + '"]').val());
                }
            }

            if (o.sortOrderMode == true) {
                setNoFileMessage();
            } else {
                clearQueueList();
            }

            for (var i = 0, ii = files.length; i < ii; i++) {
                if (files[i] == null) {
                    continue;
                }

                var $this = jQuery(files[i]);

                if (o.sortOrderMode == true && $this.data("tr") != null) {
                    continue;
                }

                var fileInfo = {};

                fileInfo[o.config("column.fileName")] = getFileName(files[i].name);
                fileInfo[o.config("column.fileSize")] = files[i].size;

                if (o.config("column.fileType") != null) {
                    fileInfo[o.config("column.fileType")] = $this.data("fileTypeValue");
                }

                if (isSimpleList() != true && o.singleMode != true) {
                    $this.data("tr", addTableList(fileInfo, files[i], 1));
                    continue;
                }

                var $div = jQuery('<div>').appendTo(o.$queueList);
                var icon;

                if (isSimpleList() == true) {
                    $div.css({ "margin-top": "2px" });
                    icon = "ui-icon-minus";
                } else if (o.singleMode == true) {
                    $div.css({ "margin-left": "-3px" });
                    icon = "ui-icon-close";
                }

                jQuery('<span>').attr("name", "span_delete").appendTo($div).button({ icons: { primary: icon } })
                    .css({ "width": "18px", "height": "18px", "margin-right": "4px", "vertical-align": "middle" })
                    .data("file", files[i])
                    .click(function() {
                        o.$uploadForm.children('input:file').remove();
                        deleteDataFile(jQuery(this).data("file"));
                        setQueueFileList();
                        addInputFile();
                    })
                    .children('span:first').css({ "left": "1px" }).next().remove();

                jQuery('<span>').appendTo($div).css({ "vertical-align": "middle" }).text(function() {
                    var val = fileInfo[o.config("column.fileName")];
                    if (files[i].size != null) {
                        return val + " (" + any.text.formatNumber(files[i].size) + " Byte)";
                    }
                    return val;
                }());
            }
        }

        o.$control.removeCss("height");

        var queueCount = getQueueCount();

        o.$uploadedList.showHide(isSimpleList() == true || (o.singleMode == true && queueCount == 0));
        o.$queueList.showHide(isSimpleList() == true || (o.singleMode == true && queueCount != 0));

        setUploadCountMessage();
        setNoFileMessage(true);

        function clearQueueList()
        {
            o.$control.css("height", o.$control.height());
            o.$listTbody.children('tr[list-type="queue"]').empty().remove();
            o.$queueList.empty();

            setNoFileMessage();
        }
    }

    function initValidationMessage()
    {
        if (o.validationMessage == null) {
            o.validationMessage = {};
        }

        for (var item in o.validationMessage) {
            o.validationMessage[item] = false;
        }
    }

    function checkValidation($files)
    {
        if (o.configDs == null) {
            return true;
        }

        if ($files.jquery == jQuery.fn.jquery) {
            for (var i = 0, ii = $files.length; i < ii; i++) {
                if (checkFiles(getInputFiles($files.get(i))) != true) {
                    $files.eq(i).remove();
                    return false;
                }
            }
        } else {
            if (checkFiles($files) != true) {
                delete($files);
                return false;
            }
        }

        return true;

        function checkFiles(files)
        {
            for (var i = 0, ii = files.length; i < ii; i++) {
                if (files[i] == null) {
                    continue;
                }

                var fileName = getFileName(files[i].name);
                var includeExtensions = o.configDs.value(0, "include-extensions");
                var excludeExtensions = o.configDs.value(0, "exclude-extensions");
                var maxFileSize = parseInt(o.configDs.value(0, "max-file-size"), 10);

                if (checkExtension(fileName, includeExtensions) == 0) {
                    if (o.validationMessage == null || o.validationMessage["any.file.upload.valid.includeExtensions"] != true) {
                        any.dialog(true).alert(any.message("any.file.upload.valid.includeExtensions").arg(includeExtensions));
                    }
                    if (o.validationMessage != null) {
                        o.validationMessage["any.file.upload.valid.includeExtensions"] = true;
                    }
                    return false;
                }

                if (checkExtension(fileName, excludeExtensions) == 1) {
                    if (o.validationMessage == null || o.validationMessage["any.file.upload.valid.excludeExtensions"] != true) {
                        any.dialog(true).alert(any.message("any.file.upload.valid.excludeExtensions").arg(excludeExtensions));
                    }
                    if (o.validationMessage != null) {
                        o.validationMessage["any.file.upload.valid.excludeExtensions"] = true;
                    }
                    return false;
                }

                if (files[i].size != null && !isNaN(maxFileSize) && maxFileSize != -1 && files[i].size > maxFileSize) {
                    if (o.validationMessage == null || o.validationMessage["any.file.upload.valid.maxFileSize"] != true) {
                        any.dialog(true).alert(any.message("any.file.upload.valid.maxFileSize").arg(any.text.formatNumber(maxFileSize)));
                    }
                    if (o.validationMessage != null) {
                        o.validationMessage["any.file.upload.valid.maxFileSize"] = true;
                    }
                    return false;
                }
            }

            return true;

            function checkExtension(fileName, checkString)
            {
                if (checkString == null || checkString == "") {
                    return -1;
                }

                var fileExtension;
                var checkStrings = checkString.toUpperCase().split(",");

                if (fileName.lastIndexOf(".") != -1) {
                    fileExtension = fileName.substr(fileName.lastIndexOf(".") + 1).toUpperCase();
                }

                for (var i = 0; i < checkStrings.length; i++) {
                    if (any.text.trim(checkStrings[i]) == fileExtension) {
                        return 1;
                    }
                }

                return 0;
            }
        }
    }

    function getInputFiles(input)
    {
        var files = [];

        if (input.files != null) {
            for (var i = 0; i < input.files.length; i++) {
                files.push({ name: input.files[i].name, size: input.files[i].size, type: input.files[i].type });
            }
        } else if (input.value != null && input.value != "") {
            files.push({ name: input.value });
        }

        return files;
    }

    function getFileName(fullPath)
    {
        var val = fullPath;

        if (val.lastIndexOf("\\") != -1) {
            return val.substr(val.lastIndexOf("\\") + 1);
        }

        if (val.lastIndexOf("/") != -1) {
            return val.substr(val.lastIndexOf("/") + 1);
        }

        return val;
    }

    function addTableList(fileInfo, file, rowSpan)
    {
        var $tr = jQuery('<tr>').attr("list-type", file == null ? "uploaded" : "queue").data("fileInfo", fileInfo).data("file", file).appendTo(o.$listTbody);
        var $td;
        var $span;

        jQuery('<th>').addClass("ui-widget-header").text(o.$listTbody.children('tr:not([delete="delete"])').length).appendTo($tr);

        if (file == null || file != $tr.prev().data("file")) {
            jQuery('<td>').attr({ "name": "td_select", "align": "center", "rowspan": rowSpan }).appendTo($tr).html('<input type="checkbox">');
        }

        if (o.fileTypes != null && o.fileTypes.length > 1) {
            $td = jQuery('<td>').css({ "text-align": "center" }).appendTo($tr);
            var $sel = jQuery('<select>').attr("name", o.config("column.fileType")).appendTo($td);
            $sel.append(jQuery('<option>'));
            for (var i = 0, ii = o.fileTypes.length; i < ii; i++) {
                $sel.append(jQuery('<option>').val(o.fileTypes[i].code).text(o.fileTypes[i].name).attr({ title: o.fileTypes[i].name }));
            }
            $sel.data("original-value", fileInfo[o.config("column.fileType")]);
            $sel.val(fileInfo[o.config("column.fileType")]);
            jQuery('col#col_type', control).width($sel.outerWidth() + $td.innerWidth() - $td.width());
        }

        $td = jQuery('<td>').css({ "overflow": "hidden", "white-space": "nowrap", "text-overflow": "ellipsis", "text-align": "left" }).appendTo($tr);
        $span = jQuery('<span>').text(fileInfo[o.config("column.fileName")]).attr("title", fileInfo[o.config("column.fileName")]).appendTo($td);

        if (file == null) {
            $span.attr("role", "download-link").data("fileInfo", fileInfo).click(function() {
                if (o.readOnly2 != true) {
                    var file = any.file().url(o.config("url.download"));
                    file.param(o.config("column.downloadKey"), jQuery(this).data("fileInfo")[o.config("column.downloadKey")]);
                    file.param("readOnly", any["boolean"]().value(isReadOnly()));
                    o.$control.fire("onBeforeDownload", [file, control]);
                    file.download();
                }
            });

            if (o.readOnly2 != true) {
                $span.addClass("link")
            }
        }

        var fileSize = fileInfo[o.config("column.fileSize")];

        jQuery('<td>').css({ "text-align": fileSize == null ? "center" : "right" })
            .text(fileSize == null ? "-" : any.text.formatNumber(fileSize))
            .appendTo($tr);

        if (o.customColumns != null) {
            for (var i = 0, ii = o.customColumns.length; i < ii; i++) {
                var col = o.customColumns[i];
                var act = (o.actions == null ? null : o.actions[col.name]);
                $td = jQuery('<td>').css({ "text-align": any.text.nvl(col.align, "left") }).appendTo($tr);
                if (file == null && act != null && act.action != null && (act.check == null || act.check.apply(control, [fileInfo]) == true)) {
                    jQuery('<span>').addClass("link").data("action", act.action).text(fileInfo[col.name]).appendTo($td).click(function() {
                        jQuery(this).data("action").apply(control, [fileInfo]);
                    });
                } else {
                    $td.text(file == null ? fileInfo[col.name] : col.value);
                }
            }
        }

        resetDisplay();

        return $tr[0];
    }

    function setUploadCountMessage()
    {
        var totalCount = getTotalCount();

        if (o.$countMessage != null) {
            o.$countMessage.text(function() {
                var texts = [];

                texts.push("Total : " + totalCount);

                if (isReadOnly() != true) {
                    texts.push("Add : " + getQueueCount());
                    texts.push("Delete : " + getDeleteCount());
                }

                return texts.join(" | ");
            }()).show();
        }

        if (o.$dropMessage != null) {
            if (isSimpleList() == true) {
                o.$dropMessage.showHide(isReadOnly() != true && o.$countMessage == null);
            } else if (o.singleMode == true) {
                o.$dropMessage.showHide(isReadOnly() != true && totalCount == 0 && o.ds.rowCount() == 0);
            } else {
                o.$dropMessage.showHide(isReadOnly() != true);
            }
        }
    }

    function closeUploadMonitor()
    {
        setUploadProgress(100);

        if (o.prog != null) {
            o.prog.stop();
        }
    }

    function setUploadProgress(ratio)
    {
        if (o.$progTable.is(':visible') != true) {
            return;
        }

        if (any.config.scrollToPlugin == null && jQuery.scrollTo == null) {
            o.$progBar.focus();
        } else if (o.$progBar.data("scrollTo") != true) {
            any.loadScript(any.config.scrollToPlugin, function() {
                try {
                    jQuery('div[any-container=""]').parent('div').scrollTo(o.$progBar, "fast", { offset: -50 });
                    o.$progBar.data("scrollTo", true);
                } catch(e) {
                    o.$progBar.focus();
                }
            });
        }

        if (ratio == -1 || isNaN(ratio)) {
            ratio = 0;
        } else if (o.$progBar.data("radio") != null) {
            ratio = Math.max(o.$progBar.data("radio"), ratio);
        }

        o.$progRatio.css("color", ratio == 100 ? "blue" : "red").text(ratio + "%");
        o.$progBar.progressbar("value", ratio);
        o.$progBar.data("radio", ratio);
    }

    function resetDisplay()
    {
        o.$control.attr("any--proxy--file", isReadOnly() != true);

        if (o.$headerTable == null) {
            return;
        }

        if (o.dropAvailable == true && isReadOnly() != true) {
            o.$control.attr("title", any.message("any.file.message.dragAndDropHere", "Drag files here."));
        } else {
            o.$control.attr("title", "");
        }

        var showCheck = (o.readOnly2 != true && (o.readOnly != true || o.config("download.multiple") == true));

        o.$headerTable.showHide(showCheck);

        if (o.$uploadFormArea != null) {
            o.$uploadFormArea.showHide(isReadOnly() != true);
        }

        if (o.$deleteButton != null) {
            o.$deleteButton.showHide(isReadOnly() != true);
        }

        if (o.$moveUpButton != null) {
            o.$moveUpButton.showHide(isReadOnly() != true);
        }

        if (o.$moveDownButton != null) {
            o.$moveDownButton.showHide(isReadOnly() != true);
        }

        if (o.$downloadButton != null) {
            o.$downloadButton.showHide(isReadOnly() == true);
        }

        setUploadCountMessage();

        o.$listColgroup.children('col#col_select').showHide(showCheck);

        o.$listThead.children('tr').each(function() {
            jQuery(this).children('th#th_select').showHide(showCheck);
        });

        o.$listTbody.children('tr').each(function() {
            var $this = jQuery(this);
            $this.children('td[name="td_select"]').showHide(showCheck);
            var $select = $this.find('select[name="' + o.config("column.fileType") + '"]');
            if ($select.length == 0) {
                return true;
            }
            if ($select.data("readOnlySpan") == null) {
                $select.data("readOnlySpan", jQuery('<span>'));
                $select.after($select.data("readOnlySpan"));
            }
            $select.data("readOnlySpan").text($select.children(':selected').text()).showHide(isReadOnly() == true);
            $select.showHide(isReadOnly() != true);
        });

        if (o.readOnly2 == true) {
            o.$control.find('span[role="download-link"]').removeClass("link");
        } else {
            o.$control.find('span[role="download-link"]').addClass("link");
        }
    }
});
