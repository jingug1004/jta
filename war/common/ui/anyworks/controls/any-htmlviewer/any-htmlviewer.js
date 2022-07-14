any.control("any-htmlviewer").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = jQuery(control).css({ "line-height": "0" });
        o.config = any.control(control).config;

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("resizeHeight", resizeHeight);

        o.$control.defineProperty("styles", { get: getStyles, set: setStyles });
        o.$control.defineProperty("viewer", { get: getViewer, set: setViewer });
        o.$control.defineProperty("value", { get: getValue, set: setValue });
        o.$control.defineProperty("readOnly2", { get: getReadOnly2, set: setReadOnly2 });

        any.control(control).initialize();

        initialize();
    })();

    function element()
    {
        return o.$element;
    }

    function getStyles()
    {
        return o.styles;
    }

    function setStyles(styles)
    {
        o.styles = styles;
    }

    function getViewer()
    {
        return o.viewer;
    }

    function setViewer(viewer)
    {
        o.viewer = viewer;
    }

    function getValue()
    {
        return o.value;
    }

    function setValue(val)
    {
        if (arguments.length > 0) {
            o.value = val;
        }

        if (o.element != null && o.element.contentWindow != null) {
            o.element.contentWindow.location.replace(any.url(any.text.blank(o.viewer, any.home + "/controls/any-htmlviewer/any-htmlviewer.htm")));
        }
    }

    function getReadOnly2()
    {
        return o.readOnly2;
    }

    function setReadOnly2(val)
    {
        o.readOnly2 = any.object.toBoolean(val, true);

        if (o.value != null) {
            setValue(o.value);
        }
    }

    function initialize()
    {
        o.$element = jQuery('<iframe>').css({ "border": "none", "width": "100%", "height": "1px" }).attr({ "frameBorder": "0" }).appendTo(o.$control);

        o.element = o.$element[0];

        o.element.setContentsValue = function()
        {
            var doc = this.contentWindow.document;

            var bodyContents;

            if (any.text.startsWith(o.value, "<html>", true) || any.text.startsWith(o.value, "<html ", true)) {
                jQuery(doc).find('head').empty();

                var bodyStart = '<body' + any.text.cropIgnoreCase(o.value, "<body", ">") + '>';
                var bodyEnd = '</body>';
                var htmlStart = o.value.substr(0, o.value.toUpperCase().indexOf(bodyStart.toUpperCase()) + bodyStart.length);
                var htmlEnd = o.value.substr(o.value.toUpperCase().lastIndexOf(bodyEnd.toUpperCase()));

                doc.write(htmlStart + htmlEnd);

                bodyContents = any.text.cropIgnoreCase(o.value, bodyStart, bodyEnd);
            } else {
                doc.write('<body></body>');

                bodyContents = o.value;
            }

            if (typeof(o.styles) === "string") {
                jQuery(doc.body).attr("style", o.styles);
            } else if (typeof(o.styles) === "object") {
                for (var name in o.styles) {
                    doc.body.style[name] = o.styles[name];
                }
            }

            doc.body.style.overflowX = "hidden";
            doc.body.style.margin = "0px";

            doc.body.onpaste = function() { return false; };
            doc.body.oncut = function() { return false; };

            doc.body.onkeydown = function(event)
            {
                if (event.ctrlKey != true) {
                    return false;
                }
            };

            doc.body.onkeyup = function()
            {
                var $container = jQuery(this).children('div[any-htmlviewer-container=""]:first');

                if (o.contentsHTML != $container.html()) {
                    resetValue();
                }
            };

            doc.body.onblur = function()
            {
                resetValue();
            };

            resetValue();

            function resetValue()
            {
                var bodyHTML;
                var preText;

                if (bodyContents == null) {
                    bodyHTML = '';
                } else if (bodyContents.replace(/(<([^>]+)>)/ig, "") == bodyContents) {
                    bodyHTML = '<pre>' + bodyContents + '</pre>';
                    preText = true;
                } else {
                    bodyHTML = bodyContents;
                }

                doc.body.innerHTML = '<div any-htmlviewer-container' + (o.readOnly2 == true ? ' contenteditable="true"' : '') + '>' + bodyHTML + '</div>';

                if (preText == true) {
                    var $pre = jQuery(doc.body).find('pre');

                    if (typeof(o.styles) === "string") {
                        $pre.attr("style", o.styles);
                    } else if (typeof(o.styles) === "object") {
                        for (var name in o.styles) {
                            $pre[0].style[name] = o.styles[name];
                        }
                    }

                    $pre.css({ "margin": "0px" });
                }

                jQuery(doc.body).find('img').on("load", function() {
                    o.element.setContentsHeight(true);
                    o.element.setContentsHeight(true);
                });

                o.element.setContentsHeight(true);
                o.element.setContentsHeight(true);
            }
        };

        o.element.setContentsHeight = function(saveHTML)
        {
            window.setTimeout(function() {
                var $body = jQuery(o.element.contentWindow.document.body).css({ "overflow": "hidden" });
                var $container = $body.children('div[any-htmlviewer-container=""]:first').css({ "overflow-x": "auto", "overflow-y": "hidden" });

                o.$element.height($container.height());

                if (jQuery.browser.msie && Number(jQuery.browser.version) < 9) {
                    $container.css({ "overflow-y": "auto" });
                }

                if (saveHTML == true) {
                    o.contentsHTML = $container.html();
                }
            });
        };

        jQuery(window).resize(o.element.setContentsHeight);

        setValue();
    }

    function resizeHeight()
    {
        if (o.element.setContentsHeight != null) {
            o.element.setContentsHeight();
        }
    }
});
