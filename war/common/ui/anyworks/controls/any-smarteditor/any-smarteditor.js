any.control("any-smarteditor").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        control.isReady = false;

        o.$control = jQuery(control).css({ "line-height": "0" });
        o.config = any.control(control).config;
        o.elPlaceHolderId = "se2_" + control.id;
        o.filePolicy = o.config("filePolicy");
        o.editors = [];

        o.$control.defineMethod("element", element);

        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("filePolicy", { get: getFilePolicy, set: setFilePolicy });
        o.$control.defineProperty("readOnly", { get: getReadOnly, set: setReadOnly });
        o.$control.defineProperty("readOnly2", { get: getReadOnly2, set: setReadOnly2 });
        o.$control.defineProperty("readOnly3", { get: getReadOnly3, set: setReadOnly3 });

        any.control(control).initialize();

        resetDisplay();
    })();

    function element()
    {
        return o.readOnly == true || o.readOnly2 == true ? o.$readElement : o.$editElement;
    }

    function getValue()
    {
        if (o.readOnly == true || o.readOnly2 == true) {
            return o.$readElement.val();
        } else if (control.isReady == true) {
            return o.editor.getIR();
        } else if (o.$textarea != null) {
            return o.$textarea.val();
        } else {
            return o.defaultValue;
        }
    }

    function setValue(val)
    {
        o.value = val;

        if (o.readOnly == true || o.readOnly2 == true) {
            o.$readElement.val(o.value);
        } else if (control.isReady == true) {
            o.editor.setIR(val);
        } else if (o.$textarea != null) {
            o.$textarea.val(val);
        } else {
            o.defaultValue = val;
        }
    }

    function getFilePolicy()
    {
        return o.filePolicy;
    }

    function setFilePolicy(val)
    {
        o.filePolicy = val;
    }

    function getReadOnly()
    {
        return o.readOnly;
    }

    function setReadOnly(val)
    {
        o.readOnly = (String(val).toLowerCase() == "readonly" || any.object.toBoolean(val, true));

        if (o.readOnly != true) {
            o.value = getValue();
        }

        resetDisplay();
    }

    function getReadOnly2()
    {
        return o.readOnly2;
    }

    function setReadOnly2(val)
    {
        o.readOnly2 = any.object.toBoolean(val, true);

        resetDisplay();
    }

    function getReadOnly3()
    {
        return o.readOnly3;
    }

    function setReadOnly3(val)
    {
        o.readOnly3 = any.object.toBoolean(val, true);

        resetDisplay();
    }

    function resetDisplay()
    {
        if (o.readOnly == true || o.readOnly2 == true) {
            if (o.$readElement == null) {
                var $body = jQuery('body');
                var fontFamily = $body.css("font-family");
                var fontSize = $body.css("font-size");

                if (fontFamily == null || fontFamily == "") {
                    fontFamily = "돋움";
                }

                if (fontSize == null || fontSize == "") {
                    fontSize = "10pt";
                }

                o.$readElement = jQuery('<div>').prop({ "styles": "font-family: " + fontFamily + "; font-size: " + fontSize + ";", "viewer": o.config("url.viewer"), "readOnly2": o.readOnly2 }).hide().appendTo(o.$control).control("any-htmlviewer", function() {
                    control.isReady = true;
                });
            }
        } else if (o.$editElement == null) {
            o.$textarea = jQuery('<textarea>').attr({ "id": o.elPlaceHolderId }).css({ "height": "300px" }).hide().appendTo(o.$control);

            if (o.$control.hasAttr("height")) {
                o.$textarea.css("height", o.$control.attr("height"));
            }

            if (o.defaultValue != null) {
                o.$textarea.val(o.defaultValue);
                delete(o.defaultValue);
            }

            nhn.husky.EZCreator.createInIFrame({
                oAppRef: o.editors,
                elPlaceHolder: o.elPlaceHolderId,
                sSkinURI: any.url(o.config("url.editorSkin")),
                fCreator: "createSEditor2Any",
                fOnAppLoad: function()
                {
                    if (o.readOnly3 != true) {
                        return;
                    }

                    var doc = o.$editElement[0].contentWindow.document;

                    jQuery.each(doc.getElementsByClassName("husky_seditor_resize_notice"), function() {
                        this.style.display = "none";
                    });

                    jQuery.each(doc.getElementsByTagName("IFRAME"), function() {
                        var body = this.contentWindow.document.body;

                        body.onpaste = function() { return false; };
                        body.oncut = function() { return false; };

                        body.onkeydown = function(event)
                        {
                            if (event.ctrlKey != true) {
                                return false;
                            }
                        };

                        body.onblur = function()
                        {
                            o.editor.setIR(o.value);
                        };
                    });
                },
                htParams: {
                    bUseToolbar: o.readOnly3 != true,
                    bUseVerticalResizer: o.readOnly3 != true,
                    bUseModeChanger: o.readOnly3 != true,
                    filePolicy: o.filePolicy,
                    fOnBeforeUnload: function()
                    {
                    }
                }
            });

            o.$editElement = o.$control.children('iframe');

            o.$editElement.load(function() {
                checkReady();
            });
        }

        if (typeof(o.value) !== "undefined") {
            setValue(o.value);
        }

        if (o.$editElement != null) {
            o.$editElement.showHide(o.readOnly != true && o.readOnly2 != true);
        }

        if (o.$readElement != null) {
            o.$readElement.showHide(o.readOnly == true || o.readOnly2 == true);
        }
    }

    function checkReady()
    {
        if (control.isReady == true) {
            return;
        }

        try {
            if (o.editor == null) {
                o.editor = o.editors.getById[o.elPlaceHolderId];
            }
            if (o.editor != null && o.editor.setIR != null) {
                control.isReady = true;
                return;
            }
        } catch(e) {
        }

        window.setTimeout(function() {
            checkReady();
        }, 50);
    }
});
