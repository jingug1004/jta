(function main()
{
    any.control.util.maxbyte = {};

    any.control.util.maxbyte.setMessage = setMessage;

    function setMessage(o)
    {
        var maxByte = o.$control.prop("maxByte");

        if (maxByte == null) {
            return;
        }

        var $messageSpan = o.$control.data("$messageSpan");

        if ($messageSpan == null && o.$control.element().tag() == "TEXTAREA" && !(jQuery.browser.msie && Number(jQuery.browser.version) < 9)) {
            $messageSpan = jQuery('<span>');
            o.$control.data("$messageSpan", $messageSpan);
            o.$control.append($messageSpan);
        }

        if (o.$control.data("maxByteInitialized") != true) {
            o.$control.data("maxByteInitialized", true);
            o.$control.element().focus(function() {
                resetMessage(o);
            }).click(function() {
                resetMessage(o);
            }).keyup(function() {
                resetMessage(o);
            }).blur(function() {
                resetMessage(o, true);
            });
        }

        resetMessage(o);

        if ($messageSpan != null) {
            $messageSpan.showHide(o.$control.prop("readOnly") != true);
            $messageSpan.prop("disabled", o.$control.prop("disabled"));
        }
    }

    function resetMessage(o, truncate)
    {
        var maxByte = o.$control.prop("maxByte");

        if (maxByte == null) {
            return;
        }

        var $element = o.$control.element();
        var txt = $element.val();
        var totByte = 0;
        var idx = 0;

        for (var i = 0; i < txt.length; i++) {
            totByte += (txt.charCodeAt(i) <= 128 ? 1 : any.object.nvl(any.config.unicodeCharSize, 3));
            if (totByte <= maxByte) {
                idx = i;
            }
        }

        if ($element.tag() == "INPUT") {
            $element.prop("maxlength", Math.max(maxByte - (totByte - txt.length), 0));
        }

        if (truncate == true) {
            txt = txt.substring(0, idx + 1);
            if (txt.substr(txt.length - 1) == "\r") {
                txt = txt.substr(0, txt.length - 1);
            }
            $element.val(txt);
            resetMessage(o);
        } else {
            var $messageSpan = o.$control.data("$messageSpan");
            if ($messageSpan != null) {
                $messageSpan.html('<font color="' + (totByte > maxByte ? "red" : "blue") + '">' + totByte + ' byte</font> of ' + maxByte + ' byte input.');
            }
        }
    }
})();
