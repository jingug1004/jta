<%@page pageEncoding="UTF-8"%><% response.setContentType("text/x-component; charset=utf-8"); %>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out, true, true); %>
<PUBLIC:COMPONENT tagName="FILE" lightWeight="false">
    <PUBLIC:DEFAULTS tabStop="true" viewInheritStyle="true" viewLinkContent="true" viewMasterTab="false" />
    <PUBLIC:ATTACH event="ondocumentready" onevent="document_onready();" />
    <PUBLIC:PROPERTY name="isReady" value="false" />
    <PUBLIC:PROPERTY name="policy" />
    <PUBLIC:PROPERTY name="mode" get="getMode" put="setMode" />
    <PUBLIC:PROPERTY name="value" get="getValue" put="setValue" />
    <PUBLIC:PROPERTY name="fileId" get="getFileId" put="setFileId" />
    <PUBLIC:PROPERTY name="ds" get="getDs" />
    <PUBLIC:PROPERTY name="singleMode" get="getSingleMode" put="setSingleMode" />
    <PUBLIC:PROPERTY name="imageMode" get="getImageMode" put="setImageMode" />
    <PUBLIC:PROPERTY name="rowCount" get="getRowCount" />
    <PUBLIC:METHOD name="addFile" />
    <PUBLIC:METHOD name="upload" />
    <PUBLIC:METHOD name="focus" />
    <PUBLIC:EVENT name="OnUploadSuccess" id="OnUploadSuccessEvent" />
    <PUBLIC:EVENT name="OnUploadFail" id="OnUploadFailEvent" />
</PUBLIC:COMPONENT>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/x-component; charset=utf-8">
<LINK rel="StyleSheet" type="text/css" href="<%= request.getContextPath() %>/anyfive/framework/css/style.css">
<LINK rel="StyleSheet" type="text/css" href="<%= request.getContextPath() %>/anyfive/framework/htc/anyworks.jsp">
<SCRIPT language="JScript">
var ds_main;
var ds_main_id;

if (element.id.substr(0, 4) == "any_") {
    ds_main_id = "ds_" + element.id.substr(4);
} else {
    ds_main_id = "ds_" + element.id;
}

var control_id = element.id + "_" + element.sourceIndex;

var ds_conf;
var ds_conf_id = "ds_conf_" + control_id;

var ds_list;
var ds_list_id = "ds_list_" + control_id;

var ds_load;
var ds_load_id = "ds_load_" + control_id;

var gFileInputBox;

var gDocument = (window.location == element.document.URL ? element.document : window.document);
var gMode = "R";
var gMode2 = "R";
var gFileId;
var gSingleMode;
var gImageMode;

function document_onready()
{
    if (element.document.media == "print") return;

    ds_conf = gDocument.appendChild(element.document.createElement('<ANY:DS id="' + ds_conf_id + '" />'));
    ds_main = gDocument.appendChild(element.document.createElement('<ANY:DS id="' + ds_main_id + '" />'));
    ds_list = gDocument.appendChild(element.document.createElement('<ANY:DS id="' + ds_list_id + '" />'));
    ds_load = gDocument.appendChild(element.document.createElement('<ANY:DS id="' + ds_load_id + '" />'));

    gFileInputBox = document.getElementsByName("file");

    reset();

    element.isReady = true;

    setFileId(gFileId);
}

function reset()
{
    td_fileList.vAlign = (gSingleMode ? "" : "top");

    for (var i = tbd_link.rows.length - 1; i >= 0; i--) {
        tbd_link.deleteRow(i);
    }

    for (var i = tbd_input.rows.length - 1; i >= 0; i--) {
        tbd_input.deleteRow(i);
    }

    for (var i = 0; i < ds_list.rowCount; i++) {
        addFileLink(ds_list.rowData(i));
    }

    if (gMode2 != "R" && (gSingleMode != true || ds_list.rowCount == 0)) {
        addFileInputBox();
    }
}

function getMode()
{
    return gMode;
}

function setMode(val)
{
    gMode = val;
    gMode2 = gMode.substr(0, 1);

    if (element.isReady == true) {
        reset();
    }
}

function getValue()
{
    return gFileId;
}

function setValue(val)
{
    setFileId(val);
}

function getFileId()
{
    return gFileId;
}

function setFileId(val)
{
    gFileId = val;

    if (element.isReady != true) return;

    for (var i = tbd_link.rows.length - 1; i >= 0; i--) {
        tbd_link.deleteRow(i);
    }

    if (ds_list != null && ds_list.isReady == true) {
        ds_list.init();
    }

    if (gFileId != null && gFileId != "") {
        addFile(gFileId);
    }
}

function getDs()
{
    return ds_main;
}

function getSingleMode()
{
    return gSingleMode;
}

function setSingleMode(val)
{
    gSingleMode = (String(val) == "true");

    if (element.isReady == true) {
        reset();
    }
}

function getImageMode()
{
    return gImageMode;
}

function setImageMode(val)
{
    gImageMode = (String(val) == "true");

    if (element.isReady == true) {
        reset();
    }
}

function getRowCount()
{
    var cnt = 0;

    for (var i = 0; i < tbd_link.rows.length; i++) {
        if (tbd_link.rows[i].isDelete == true) continue;
        cnt++;
    }

    for (var i = 0; i < gFileInputBox.length; i++) {
        if (any.trim(gFileInputBox[i].value) == "") continue;
        cnt++;
    }

    return cnt;
}

function getValues()
{
    var values = [];

    for (var i = 0; i < gFileInputBox.length; i++) {
        var value = getRealValue(gFileInputBox[i]);
        if (value != "") values.push(value);
    }

    return values;
}

function getRealValue(obj)
{
    if (obj.value.indexOf("\\fakepath\\") == -1) return obj.value;

    try {
        obj.select();
        var value = any.trim(document.selection.createRange().text.toString());
        obj.blur();
        return value;
    } catch(ex) {
        return obj.value.substr(obj.value.lastIndexOf("\\") + 1);
    }
}

function addFile(fileId)
{
    if (fileId == null || fileId == "") return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.framework.file.act.RetrieveFileList.do";
    prx.addParam("_DS_ID_", ds_load_id);
    prx.addParam("FILE_ID", fileId);

    prx.onSuccess = function()
    {
        for (var i = 0; i < ds_load.rowCount; i++) {
            ds_list.rowData(ds_list.addRow()) = ds_load.rowData(i);
        }

        reset();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute(false);
}

function addFileLink(obj)
{
    var tr, td, spn;

    tr = tbd_link.insertRow();
    tr.fileInfo = obj;

    //No
    if (gSingleMode != true) {
        td = tr.insertCell();
        td.innerHTML = tbd_link.rows.length + ".";
        td.align = "right";
        td.noWrap = true;
    }

    //파일정보 TD
    td = tr.insertCell();
    td.width = "100%";

    //다운로드 링크
    spn = document.createElement('<SPAN id="spn_download">');
    spn.innerText = obj.FILE_NAME_ORG;
    spn.style.marginLeft = "3px";
    spn.fileInfo = obj;
    td.appendChild(spn);

    //파일크기 표시
    spn = document.createElement('<LABEL>');
    spn.innerText = '(' + cfGetFormatNumber(obj.FILE_SIZE) + 'Byte)';
    spn.style.marginLeft = "3px";
    td.appendChild(spn);

    //미리보기 링크
    if (gImageMode == true) {
        spn = document.createElement('<SPAN id="spn_preview">');
        spn.innerText = '[미리보기]';
        spn.style.marginLeft = "3px";
        spn.fileInfo = obj;
        td.appendChild(spn);
    }

    var spans = td.getElementsByTagName("SPAN");

    for (var i = 0; i < spans.length; i++) {
        spans[i].style.color = "#0000FF";
        spans[i].style.cursor = "hand";

        spans[i].onmouseover = function()
        {
            this.style.textDecoration = "underline";
        }
        spans[i].onmouseout = function()
        {
            this.style.textDecoration = "none";
        }
    }

    //삭제 버튼
    if (gMode2 != "R") {
        td = tr.insertCell();
        td.innerHTML = '<INPUT type="button" id="btn_deleteLink" value="Delete" class="text" style="color:#000000; width:60px;">';
        td.width = "1px";
        td.style.paddingLeft = "2px";
        td.style.paddingTop = "1px";
        td.style.paddingBottom = "1px";
    }
}

function addFileInputBox()
{
    var tr, td;

    tr = tbd_input.insertRow();

    td = tr.insertCell();
    td.innerHTML = '<INPUT type="file" name="file" class="text">';
    td.width = "100%";

    if (gSingleMode == true) return;

    td = tr.insertCell();
    td.innerHTML = '<INPUT type="button" id="btn_deleteBox" value="Delete" class="text" style="color:#000000; width:60px;" disabled>';
    td.width = "1px";
    td.style.paddingLeft = "2px";

    var buttons = document.getElementsByName("btn_deleteBox");

    for (var i = 0; i < buttons.length; i++) {
        buttons[i].disabled = (i == buttons.length - 1);
    }
}

function upload()
{
    var targetFrame = gDocument.getElementById("__UPLOAD_TARGET_FRAME__");

    if (targetFrame != null) gDocument.body.removeChild(targetFrame);

    targetFrame = gDocument.createElement('<IFRAME name="__UPLOAD_TARGET_FRAME__" style="display:none;">');
    gDocument.body.appendChild(targetFrame);

    frm_upload.method = "post";
    frm_upload.target = targetFrame.name;
    frm_upload.encoding = "multipart/form-data";

    if (gMode2 == "R") {
        targetFrame.uploadSuccess = function()
        {
            OnUploadSuccessEvent.fire(element.document.createEventObject());
        }
        frm_upload.action = top.getRoot() + "/anyfive/framework/file/FileUploadDummy.jsp";
        frm_upload.submit();
        return;
    }

    if (element.policy == null || element.policy == "") {
        alert("[" + element.id + "] 파일 업로드정책이 정의되지 않았습니다.");
        OnUploadFailEvent.fire(element.document.createEventObject());
        return;
    }

    if (ds_conf.rowCount == 0 || ds_conf.value(0, "POLICY") != element.policy) {
        var prx = new any.proxy();
        prx.path = top.getRoot() + "/anyfive.framework.file.act.RetrieveFileConfig.do?policy=" + element.policy;
        prx.addParam("DS", ds_conf_id);
        prx.onFail = function() { this.error.show(); }
        prx.execute(false);
    }

    if (ds_conf.rowCount == 0) {
        alert("[" + element.id + "] 파일 업로드정책 설정을 확인할 수 없습니다.");
        OnUploadFailEvent.fire(element.document.createEventObject());
        return;
    }

    top.fileUploadMonitorTitle = null;

    if (element.policy == null || element.policy == "") {
        alert("[" + element.id + "] 첨부파일 업로드정책이 정의되지 않았습니다.");
        OnUploadFailEvent.fire(element.document.createEventObject());
        return;
    }

    var inExts = ds_conf.value(0, "INCLUDE_EXTENSIONS");
    var exExts = ds_conf.value(0, "EXCLUDE_EXTENSIONS");
    var files = document.getElementsByName("file");
    var errorMessage = null;
    var errorIndex = -1;

    if (errorMessage == null && inExts != "") {
        for (var i = 0; i < files.length; i++) {
            if (any.trim(files[i].value) == "") continue;
            if (checkExtension(files[i].value, inExts) == 0) {
                errorMessage = "다음 확장자의 파일만 업로드할 수 있습니다.\n\n[" + inExts + "]";
                errorIndex = i;
                break;
            }
        }
    }

    if (errorMessage == null && exExts != "") {
        for (var i = 0; i < files.length; i++) {
            if (any.trim(files[i].value) == "") continue;
            if (checkExtension(files[i].value, exExts) == 1) {
                errorMessage = "다음 확장자의 파일은 업로드할 수 없습니다.\n\n[" + exExts + "]";
                errorIndex = i;
                break;
            }
        }
    }

    if (errorMessage != null) {
        alert(errorMessage);
        files[errorIndex].focus();
        files[errorIndex].select();
        OnUploadFailEvent.fire(element.document.createEventObject());
        return;
    }

    function checkExtension(filePath, checkString)
    {
        if (checkString == "") return -1;

        var fileExtension;
        var checkStrings = checkString.toUpperCase().split(",");

        if (filePath.lastIndexOf(".") != -1) {
            fileExtension = filePath.substr(filePath.lastIndexOf(".") + 1).toUpperCase();
        }

        for (var i = 0; i < checkStrings.length; i++) {
            if (any.trim(checkStrings[i]) == fileExtension) return 1;
        }

        return 0;
    }

    var values = getValues();

    if (values.length > 0) {
        top.fileUploadMonitorTitle = values[0] + (values.length > 1 ? " 외 " + cfGetFormatNumber(values.length - 1) + " 개" : "");
    }

    targetFrame.uploadSuccess = function(fileId, fileList)
    {
        gFileId = fileId;

        ds_main.init();
        ds_main.addCol("[==FILE_DATA==]");

        for (var i = 0; i < tbd_link.rows.length; i++) {
            if (tbd_link.rows[i].isDelete != true) continue;
            var row = ds_main.addRow();
            ds_main.jobType(row) = "D";
            ds_main.value(row, "FILE_ID") = gFileId;
            ds_main.value(row, "FILE_SEQ") = tbd_link.rows[i].fileInfo.FILE_SEQ;
            ds_main.value(row, "FILE_POLICY") = tbd_link.rows[i].fileInfo.FILE_POLICY;
            ds_main.value(row, "FILE_REPOSITORY") = tbd_link.rows[i].fileInfo.FILE_REPOSITORY;
            ds_main.value(row, "FILE_PATH") = tbd_link.rows[i].fileInfo.FILE_PATH;
            ds_main.value(row, "FILE_NAME") = tbd_link.rows[i].fileInfo.FILE_NAME;
        }

        for (var i = 0; i < fileList.length; i++) {
            var row = ds_main.addRow();
            ds_main.jobType(row) = "C";
            ds_main.value(row, "FILE_ID") = gFileId;
            ds_main.value(row, "FILE_IDX") = i;
            ds_main.value(row, "FILE_POLICY") = fileList[i].FILE_POLICY;
            ds_main.value(row, "FILE_REPOSITORY") = fileList[i].FILE_REPOSITORY;
            ds_main.value(row, "FILE_PATH") = fileList[i].FILE_PATH;
            ds_main.value(row, "FILE_NAME_ORG") = fileList[i].FILE_NAME_ORG;
            ds_main.value(row, "FILE_NAME") = fileList[i].FILE_NAME;
            ds_main.value(row, "DOWNLOAD_KEY") = fileList[i].DOWNLOAD_KEY;
            ds_main.value(row, "FILE_EXT") = fileList[i].FILE_EXT;
            ds_main.value(row, "FILE_SIZE") = fileList[i].FILE_SIZE;
        }

        if (targetFrame != null) gDocument.body.removeChild(targetFrame);

        OnUploadSuccessEvent.fire(element.document.createEventObject());
    }

    targetFrame.uploadFail = function(errorMessage)
    {
        alert(errorMessage);

        if (targetFrame != null) gDocument.body.removeChild(targetFrame);

        OnUploadFailEvent.fire(element.document.createEventObject());
    }

    frm_upload.action = top.getRoot() + "/anyfive.framework.file.act.UploadFileList.do?policy=" + element.policy + (gFileId == null ? "" : "&fileId=" + gFileId);

    try {
        frm_upload.submit();
    } catch(ex) {
        alert("파일을 업로드할 수 없습니다.\n\n파일정보가 정확하게 입력되어 있는지 확인하시기 바랍니다.");
        OnUploadFailEvent.fire(element.document.createEventObject());
    }
}

function focus()
{
    for (var i = 0; i < gFileInputBox.length; i++) {
        if (any.trim(gFileInputBox[i].value) == "") gFileInputBox[i].focus();
    }
}
</SCRIPT>

<SCRIPT language="JScript" for="file" event="onchange()">
    if (gSingleMode != true) {
        if (gFileInputBox.length == 0 || any.trim(gFileInputBox[gFileInputBox.length - 1].value) != "") addFileInputBox();
    }
</SCRIPT>

<SCRIPT language="JScript" for="btn_deleteLink" event="onclick()">
    this.parentElement.parentElement.isDelete = (this.parentElement.parentElement.isDelete != true);

    if (this.parentElement.parentElement.isDelete == true) {
        this.style.textDecoration = this.parentElement.parentElement.style.textDecoration = "line-through";
        this.value = "Cancel";
    } else {
        this.style.textDecoration = this.parentElement.parentElement.style.textDecoration = "";
        this.value = "Delete";
    }

    if (gSingleMode != true) return;

    if (isDeleteAll()) {
        if (tbd_input.rows.length == 0) addFileInputBox();
    } else if (tbd_input.rows.length > 0) {
        for (var i = tbd_input.rows.length - 1; i >= 0; i--) {
            tbd_input.deleteRow(i);
        }
    }

    function isDeleteAll()
    {
        for (var i = 0; i < tbd_link.rows.length; i++) {
            if (tbd_link.rows[i].isDelete != true) return false;
        }
        return true;
    }
</SCRIPT>

<SCRIPT language="JScript" for="btn_deleteBox" event="onclick()">
    tbd_input.removeChild(this.parentElement.parentElement);
    try { bfSetTabFrameHeight(true); } catch(ex) {}
</SCRIPT>

<SCRIPT language="JScript" for="spn_download" event="onclick()">
    cfFileDownload(this.fileInfo.DOWNLOAD_KEY);
</SCRIPT>

<SCRIPT language="JScript" for="spn_preview" event="onclick()">
    var spn;
    var img;

    div_preview.parentElement.title = "";
    div_preview.parentElement.style.cursor = "default";
    div_preview.parentElement.onclick = null;
    div_preview.innerHTML = "";
    td_preview.style.display = "block";

    spn = element.document.createElement('<SPAN>');
    spn.innerText = '(Loading)';
    div_preview.appendChild(spn);
    div_preview.style.height = spn.offsetHeight;

    img = element.document.createElement('<IMG style="visibility:hidden;">');
    img.fileInfo = this.fileInfo;
    img.onload = function()
    {
        div_preview.parentElement.title = this.fileInfo.FILE_NAME_ORG + "\n(클릭하시면, 원본크기의 이미지를 보실 수 있습니다)";
        div_preview.parentElement.style.cursor = "hand";
        div_preview.parentElement.onclick = function()
        {
            var win = new any.window(2);
            win.path = top.getRoot() + "/anyfive/framework/file/ImageViewerR.jsp";
            win.arg.downloadKey = img.fileInfo.DOWNLOAD_KEY;
            win.arg.imgSrc = img.src;
            win.arg.imgName = div_preview.name;
            win.opt.width = div_preview.size.width + 20;
            win.opt.height = div_preview.size.height + 80;
            win.opt.resizable = "yes";
            win.show();
        }

        spn.style.display = "none";
        div_preview.size = { width:img.width, height:img.height };
        img[img.width >= img.height ? "width" : "height"] = 120;
        img.style.visibility = "visible";
        div_preview.style.height = img.height;
    }
    img.onerror = function()
    {
        div_preview.parentElement.title = this.fileInfo.FILE_NAME_ORG + "\n(이미지를 표시할 수가 없습니다)";
        spn.innerText = '(Error)';
        img.style.display = "none";
        div_preview.style.height = spn.offsetHeight;
    }
    div_preview.name = this.fileInfo.FILE_NAME_ORG;
    div_preview.appendChild(img);
    img.src = top.getRoot() + "/anyfive.framework.file.act.DownloadFile.do?DOWNLOAD_KEY=" + this.fileInfo.DOWNLOAD_KEY;
</SCRIPT>
</HEAD>

<BODY>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
    <TR>
        <TD id="td_fileList" width="100%">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TBODY id="tbd_link"></TBODY>
            </TABLE>
            <FORM name="frm_upload">
            <INPUT type="text" style="display:none;">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TBODY id="tbd_input"></TBODY>
            </TABLE>
            </FORM>
        </TD>
        <TD id="td_preview" vAlign="top" style="padding:1 0 1 2; display:none;">
            <TABLE border="0" cellspacing="1" cellpadding="0" bgColor="#CAC8C0">
                <TR>
                    <TD bgColor="#F0F0F0">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="14px">
                            <TR>
                                <TD style="padding-left:2px;">Preview</TD>
                                <TD width="1px">
                                    <IMG src="<%= request.getContextPath() %>/anyfive/framework/img/close.gif"
                                     width="14px" height="14px" alt="Close"
                                     style="cursor:hand;"
                                     onClick="javascript:td_preview.style.display = 'none';"
                                    >
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                </TR>
                <TR>
                    <TD bgColor="#FFFFFF" height="120px">
                        <DIV id="div_preview" style="width:120px; height:120px; text-align:center; overflow:hidden;"></DIV>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>

</BODY>
</HTML>
