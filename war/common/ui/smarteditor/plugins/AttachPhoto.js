function createSEditor2Any(elIRField, htParams, elSeAppContainer)
{
    var elAppContainer = (elSeAppContainer || jindo.$("smart_editor2"));
    var oEditor = createSEditor2(elIRField, htParams, elSeAppContainer);

    oEditor.registerPlugin(new nhn.husky.SE2M_Any_Common(elAppContainer));

    if (htParams.filePolicy != null && htParams.filePolicy != "") {
        elAppContainer.filePolicy = htParams.filePolicy;
        oEditor.registerPlugin(new nhn.husky.SE2M_Any_AttachImage(elAppContainer));
    }

    return oEditor;
}

nhn.husky.SE2M_Any_Common = jindo.$Class({
    name : "SE2M_Any_Common",

    $init : function(elAppContainer)
    {
        jindo.$$.getSingle('DIV#smart_editor2', elAppContainer).style.width = "100%";

        this.elInputArea = jindo.$$.getSingle('DIV.se2_input_area', elAppContainer);

        this.elInputArea.style.width = "100%";
    },

    $ON_RESIZE_EDITING_AREA: function(ipNewWidth, ipNewHeight)
    {
        this.elInputArea.style.width = "100%";
    }
});

nhn.husky.SE2M_Any_AttachImage = jindo.$Class({
    name : "SE2M_Any_AttachImage",

    $init : function(elAppContainer)
    {
        this.elDropdownLayer = jindo.$$.getSingle('DIV.husky_se_image_attach_layer', elAppContainer);

        this.elTitle = jindo.$$.getSingle('H3', this.elDropdownLayer);
        this.aCloseButtons = jindo.$$('BUTTON.husky_se2m_cancel', this.elDropdownLayer);

        this.oImageUploadForm = jindo.$$.getSingle('FORM[name="image_upload_form"]', this.elDropdownLayer);
        this.oImageUploadFrame = jindo.$$.getSingle('IFRAME[name="image_upload_frame"]', this.elDropdownLayer);
        this.oImageUploadButton = jindo.$$.getSingle('BUTTON.husky_se2m_image_upload', this.elDropdownLayer);

        jindo.$$.getSingle('LI.husky_seditor_ui_photo_attach', elAppContainer).style.display = "block";

        this.filePolicy = elAppContainer.filePolicy;
    },

    $ON_MSG_APP_READY : function()
    {
        this.oApp.exec("REGISTER_UI_EVENT", ["photo_attach", "click", "SHOW_IMAGE_ATTACH_LAYER"]);

        this.oImageUploadFrame.that = this;

        this.oImageUploadFrame.onUploadSuccess = function(fileList)
        {
            var downloadUrl = parent.any.control("any-smarteditor").config("url.downloadImage");
            var sContents = [];

            for (var i = 0; i < fileList.length; i++) {
                var src = parent.any.text(parent.any.url(downloadUrl, fileList[i])).replaceAll("%2F", "/").toString();
                var title = fileList[i][parent.any.control("any-smarteditor").config("column.fileName")];
                sContents.push('<img src="' + src + '" title="' + title + '">');
                sContents.push('<br style="clear:both;">');
            }

            this.that.oApp.exec("PASTE_HTML", [sContents.join("")]);
            this.that.elDropdownLayer.style.display = "none";
            this.that.oImageUploadForm.reset();
        };
    },

    $ON_SHOW_ACTIVE_LAYER : function()
    {
        this.oApp.exec("HIDE_DIALOG_LAYER", [this.elDropdownLayer]);
    },

    $LOCAL_BEFORE_FIRST : function(sMsg)
    {
        for (var i = 0; i < this.aCloseButtons.length; i++) {
            jindo.$Fn(jindo.$Fn(this.oApp.exec, this.oApp).bind("HIDE_DIALOG_LAYER", [this.elDropdownLayer]), this).attach(this.aCloseButtons[i], "click");
        }

        jindo.$Fn(jindo.$Fn(this.oApp.exec, this.oApp).bind("UPLOAD_IMAGE", [this.elDropdownLayer]), this).attach(this.oImageUploadButton, "click");

        this.elDropdownLayer.style.display = "none";
    },

    $ON_SHOW_IMAGE_ATTACH_LAYER : function()
    {
        this.oApp.exec("HIDE_ALL_DIALOG_LAYER", []);

        if (this.nDefaultTop != null) {
            this.elDropdownLayer.style.top = this.nDefaultTop;
        }

        this.oApp.exec("SHOW_DIALOG_LAYER", [this.elDropdownLayer, {
            elHandle: this.elTitle,
            fnOnDragStart : jindo.$Fn(this.oApp.exec, this.oApp).bind("SHOW_EDITING_AREA_COVER"),
            fnOnDragEnd : jindo.$Fn(this.oApp.exec, this.oApp).bind("HIDE_EDITING_AREA_COVER"),
            sOnShowMsg : "IMAGE_ATTACH_LAYER_SHOWN"
        }]);

        if (this.nDefaultTop == null) {
            this.nDefaultTop = this.elDropdownLayer.style.top;
        }
    },

    $ON_IMAGE_ATTACH_LAYER_SHOWN : function()
    {
        this.oApp.exec("POSITION_TOOLBAR_LAYER", [this.elDropdownLayer]);
        this.oApp.exec("HIDE_CURRENT_ACTIVE_LAYER", []);
    },

    $ON_UPLOAD_IMAGE : function()
    {
        var url = parent.any.url(parent.any.control("any-smarteditor").config("url.uploadImage"));

        if (this.filePolicy != null) {
            url += ((url.indexOf("?") == -1 ? "?" : "&") + "policy=" + this.filePolicy);
        }

        var any = getParentAny(window.parent);

        if (any != null) {
            var rootWin = any.rootWindow();

            if (any.text.isEmpty(rootWin.any.meta.servletToken) != true) {
                var paramName = rootWin.any.config["/anyworks/servlet-token-check/param-name"];
                var paramId = "image_file_" + paramName;

                if (this.oImageUploadForm.csrfHidden == null) {
                    this.oImageUploadForm.csrfHidden = document.createElement('INPUT');
                    this.oImageUploadForm.csrfHidden.type = "hidden";
                    this.oImageUploadForm.csrfHidden.id = paramId;
                    this.oImageUploadForm.csrfHidden.name = paramName;
                    this.oImageUploadForm.csrfHidden.value = rootWin.any.meta.servletToken;
                    this.oImageUploadForm.appendChild(this.oImageUploadForm.csrfHidden);
                }
            }
        }

        this.oImageUploadForm.action = url;
        this.oImageUploadForm.submit();

        function getParentAny(win)
        {
            if (win == null) {
                return null;
            }

            if (win.any == null) {
                return getParentAny(win == win.parent ? null : win.parent);
            }

            return win.any;
        }
    }
});
