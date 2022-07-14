any.control("sys-langselector").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);

        o.$control.defineMethod("hideSelect", hideSelect);

        any.control(control).initialize();

        any.codedata().get("{LANG_CODE}", function(codeData) {
            initHTML(codeData.data);
        });
    })();

    function initHTML(langCodes)
    {
        o.$element = $('<a>').attr("href", "javascript:;").html(function() {
            for (var i = 0; i < langCodes.length; i++) {
                if (langCodes[i].data.CODE == any.meta.langCode) {
                    return '<img src="' + any.meta.contextPath + '/main/images/language/' + any.meta.langCode + '.gif" style="vertical-align:middle;"> ' + langCodes[i].data.NAME;
                }
            }
            return "Language";
        }()).appendTo(control).click(function() {
            showLangSelect();
        });

        o.$selectDiv = $('<div>').hide().appendTo('body').html(function() {
            var html = [];
            html.push('<table border="0" cellpadding="0" cellspacing="0" class="select_Language">');
            html.push('    <tr>');
            html.push('        <td>');
            html.push('            <table width="100%" border="0" cellpadding="0" cellspacing="0">');
            html.push('                <tr>');
            html.push('                    <td class="lang_t_l"></td>');
            html.push('                    <td class="lang_t_r"></td>');
            html.push('                </tr>');
            html.push('            </table>');
            html.push('        </td>');
            html.push('    </tr>');
            html.push('    <tbody id="tbd_langCodeList" style="background-color:#ffffff;"></tbody>');
            html.push('    <tr>');
            html.push('        <td>');
            html.push('            <table width="100%" border="0" cellpadding="0" cellspacing="0">');
            html.push('                <tr>');
            html.push('                    <td class="lang_b_l"></td>');
            html.push('                    <td class="lang_b_r"></td>');
            html.push('                </tr>');
            html.push('            </table>');
            html.push('        </td>');
            html.push('    </tr>');
            html.push('</table>');
            return html.join("\n");
        }());

        var $tbody = o.$selectDiv.find('tbody#tbd_langCodeList');

        for (var i = 0; i < langCodes.length; i++) {
            var data = langCodes[i].data;
            var $td = $('<td>').addClass("lang_" + data.CODE).css({ "cursor":"pointer" }).appendTo($('<tr>').appendTo($tbody));

            $('<a>').attr("href", "javascript:;").text(data.NAME).appendTo($td);

            $td.data("langCode", data.CODE).mouseover(function() {
                o.autoHideDisabled = true;
            }).mouseout(function() {
                o.autoHideDisabled = false;
            }).click(function() {
                changeLangCode($(this).data("langCode"));
            });
        }
    }

    function showLangSelect()
    {
        var pos = o.$control.position();

        o.$selectDiv.css({ "position":"absolute", "top":pos.top + o.$control.outerHeight(), "left":pos.left - 10 });

        o.$selectDiv.show();
    }

    function hideSelect()
    {
        if (o.autoHideDisabled != true) {
            o.$selectDiv.hide();
        }
    }

    function changeLangCode(langCode)
    {
        if (langCode == null || langCode == "") return;

        var prx = any.proxy();
        prx.url("/main.MainAct/updateLangCode");
        prx.param("LANG_CODE", langCode);

        prx.onSuccess = function()
        {
            any.location(any.topWindow()).reload();
        };

        prx.onError = function()
        {
            this.error.show();
        };

        prx.option({ loadingbar:false });

        prx.execute();
    }
});
