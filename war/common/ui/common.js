any.body().begin(function() {
    any.loading().show();
});

any.body().end(function() {
    var $h2 = $('div.page-middle').children('h2');
    $h2.next('div.buttons').css({ "margin-top":"-" + $h2.height() + "px" });

    $('[clone]').each(function() {
        $(this).replaceWith($($(this).attr("clone")).clone());
    });
});

any.ready(function() {
    any.preventDocumentDrop();

    if (any.pageType() == "subframe") {
        var $buttonsDiv = $('div.buttons');
        $buttonsDiv.find('button[auto="unload"],button[kind="edit"]').hide();
        $buttonsDiv.parent('div.page-footer').showHide($buttonsDiv.find('button:visible').length > 0);
    }
});

$.fn.extend({
    addHeaderClass : function()
    {
        this.find('table.view > tbody > tr > th, table.list > thead > tr > th').addClass("ui-widget-header");

        return this;
    },

    require : function()
    {
        this.each(function() {
            var $this = $(this);
            if ($this.data("require-name") != null) return true;
            if ($this.hasAttr("require") != true) {
                $this.attr("require", "");
            }
            var $th;
            var $pTable = $this.parents('table:first');
            if ($pTable.hasClass("layout")) {
                $th = $pTable.parent().prev();
            } else {
                $th = $this.parent().prev();
            }
            if ($th.tag() == "TH" && $th.data("default-label") == null) {
                $th.data("default-label", $th.text());
            }
            $this.data("require-name", any.text.empty($this.attr("requireName"), $th.tag() == "TH" ? $th.data("default-label") : this.id));
            if ($th.tag() == "TH") {
                if ($th.data("$requireMarker") == null) {
                    $th.data("$requireMarker", $('<span>').addClass("require").text("*").prependTo($th));
                }
                $this.data("$requireMarker", $th.data("$requireMarker"));
            }
            $this.defineProperty("require", {
                get : function() {
                    return String($(this).attr("require-enable")).toLowerCase() == "true";
                },
                set : function(val) {
                    var $this = $(this);
                    $this.attr("require-enable", any.object.toBoolean(val, true));
                    if ($this.data("$requireMarker") != null) {
                        $this.data("$requireMarker").showHide($this.parent().find('[require-enable="true"]').length > 0);
                    }
                }
            });
        });

        return this;
    }
});

$(function() {
    any.dialogTitle(document.title);

    $('body').addHeaderClass().mousedown(function() {
        try {
            any.topWindow().Menu.hideTopMenuSubList();
            any.topWindow().$('[sys-langselector=""]').exec("hideSelect");
        } catch(e) {
        }
    });

    if ($.browser.msie && Number($.browser.version) < 8) {
        $('div[any-container=""]').css("margin", "10px");
    }

    if (any.pageType() == "tabframe" || any.pageType() == "subframe") {
        $('div[any-container=""]').css("margin", "0px");
        $('div.page-header').hide();
    }

    if (any.pageType() == "dialog") {
        $('div.page-header').hide();
    }

    $('table.view').each(function() {
        if ($(this).hasAttr("nocontainer")) return true;
        var $div = $('<div>').addClass("ui-widget-content ui-corner-all");
        $(this).before($div);
        $div.append(this);
    });

    var $h1 = $('h1:first');

    if ($h1.text() == "") {
        $h1.text(document.title);
    }

    $('div.grid-space > div.toggle-condition').parent().children('div.buttons').css("text-align", "left").end().prev()
        .removeClass("ui-corner-all").addClass("ui-corner-tl ui-corner-tr ui-corner-bl").end().height(10).end().width(50).height(15)
        .addClass("ui-widget-content ui-state-default ui-corner-bl ui-corner-br")
        .append($('<span>').addClass("ui-icon ui-icon-arrowthickstop-1-n"))
        .mouseover(function() {
            $(this).addClass("ui-state-hover");
        })
        .mousedown(function() {
            $(this).addClass("ui-state-active");
        })
        .mouseup(function() {
            $(this).removeClass("ui-state-active");
        })
        .mouseout(function() {
            $(this).removeClass("ui-state-hover");
            $(this).removeClass("ui-state-active");
        })
        .toggle(function() { $(this).children().addClass("ui-icon-arrowthickstop-1-s"); }, function() { $(this).children().removeClass("ui-icon-arrowthickstop-1-s"); })
        .click(function() {
            $(this).parent().prev().animate({ "height":"toggle", "opacity":"toggle" }, {
                duration:300,
                complete:function() {
                    var $gridSpace = $(this).next('div.grid-space');
                    $gridSpace.children('div.buttons').css("margin-top", $(this).is(':visible') ? "0px" : "-" + $gridSpace.css("padding-top"));
                    $('div[any-jqgrid=""],span[any-jqgrid=""]').resize();
                    any.fullHeight();
                }
            });
        });

    $('[onEnter]').each(function() {
        $(this).enter(new Function($(this).attr("onEnter")));
    });

    $('[require]').require();

    cfResetH2Padding();
});

function cfResetH2Padding($element)
{
    if (any.pageType() == "tabframe" || any.pageType() == "subframe") return;

    var $h2 = $('h2:first');
    var first = true;

    ($element == null ? $h2 : $element).prevAll().each(function() {
        if (!$(this).hasClass("page-header") && $(this).css("display") != "none") {
            first = false;
            return false;
        }
    });

    if ($element != null) {
        $element.next('script').next('h2').removeClass("first");
        $element.next('h2').removeClass("first");
    }

    if (first == true) {
        $h2.addClass("first");
    } else {
        $h2.removeClass("first");
    }
}

function cfCheckValid(selector)
{
    if (selector == null) selector = "";

    var $requires;

    if (typeof(selector) === "string") {
        $requires = $(selector + '[require-enable="true"]').add(selector + '[valid-enable="true"]');
    }

    if ($requires == null || $requires.length == 0) {
        $requires = $(selector).find('[require-enable="true"],[valid-enable="true"]');
    }

    for (var i = 0, ii = $requires.length; i < ii; i++) {
        var $this = $requires.eq(i);

        if ($this.prop("disabled") == true) continue;

        if ($this.hasProp("checkValid") && $this.prop("checkValid") != true) return false;

        if ($this.attr("require-enable") != "true") continue;
        if ($this.hasProp("checkRequire") && $this.prop("checkRequire")) continue;
        if ($this.element() != null && $this.element().hasProp("checkRequire") && $this.element().prop("checkRequire")) continue;

        if ($this.controlName() == "any-date2") {
            if (any.text.trim($this.prop("value1")) != "" && any.text.trim($this.prop("value2")) != "") continue;
        } else if ($this.controlName(true) == "any-file") {
            if ($this.prop("totalCount") > 0) continue;
        } else if ($this.controlName() == "any-smarteditor") {
            var $div = $('<div>').hide().html($this.val());
            var bool = (any.text.trim($div.text()) != "");
            $div.remove();
            if (bool == true) continue;
        } else if ($this.hasProp("checkRequire") != true) {
            if ($this.val() != null && any.text.trim($this.val()) != "") continue;
        }

        alert(any.message("msg.com.input.required", "다음 필수항목을 입력하세요.\n\n[{0}]").arg($this.data("require-name")));

        if (any.config.scrollToPlugin == null && $.scrollTo == null) {
            $this.focus();
        } else {
            any.loadScript(any.config.scrollToPlugin, function() {
                try {
                    $('div[any-container=""]').parent('div').scrollTo($this, "slow", { offset:-5 });
                } catch(e) {
                    $this.focus();
                }
            });
        }

        $this.parent().stop(true, true).css("background-color", "red").animate({ "background-color":"white" }, 1000).focus();
        $this.stop(true, true).hide().fadeTo("slow", 1, function() {
            $this.focus();
        }).focus();

        return false;
    }

    return true;
}

function cfReturnSearchResult(controlId, zeroMessage, rowData)
{
    if (rowData != null) {
        any.unloadPage(rowData);
        return;
    }

    var $control = $('#' + controlId);
    var rowDatas = null;

    switch ($control.controlName()) {
    case "any-jqgrid":
        rowDatas = $control.prop("selectedRowDataList");
        break;
    case "any-jstree":
        if ($control.exec("getPlugin", "checkbox") != true) {
            rowData = $control.exec("getRowData");
            if (rowData == null) {
                if (zeroMessage != null) alert(zeroMessage);
            } else {
                any.unloadPage(rowData);
            }
            return;
        }
        rowDatas = $control.prop("checkedDataList");
        break;
    }

    if (zeroMessage != null && (rowDatas == null || rowDatas.length == 0)) {
        alert(zeroMessage);
    }

    any.unloadPage(rowDatas);
}

function cfSetPageTitle(title, withDocumentTitle)
{
    any.dialogTitle(title);

    $('h1').eq(0).text(title);

    if (withDocumentTitle == true) {
        document.title = title;
    }
}

function cfDownloadTemplate(path)
{
    if (path != null && path != "") {
        any.file().url(any.control("any-file").config("url.download")).param("TEMPLATE_PATH", path).download();
    }
}

function cfSetWorkflowParameters(obj, completeYn)
{
    obj.param("WF_COMPLETE_YN", completeYn);

    if (any.ds().exists("ds_wf_eventReadList") == true) {
        obj.data("ds_wf_eventReadList");
    }

    if (any.ds().exists("ds_wf_eventRecvList") == true) {
        obj.data("ds_wf_eventRecvList");
    }

    var wf = any.arg("wf");

    if (any.text.isEmpty(any.param("WF_ACTIVITY_KEY")) != true) {
        if (wf == null) {
            wf = {};
        }
        wf.ACTIVITY_KEY = any.param("WF_ACTIVITY_KEY");
        any.arg("wf", wf);
    }

    if (any.text.isEmpty(any.param("WF_ACT_CODE_KEY")) != true) {
        if (wf == null) {
            wf = {};
        }
        wf.ACT_CODE_KEY = any.param("WF_ACT_CODE_KEY");
        any.arg("wf", wf);
    }

    if (wf == null) return;

    for (var name in wf) {
        if ($.type(wf[name]) == "string") {
            obj.param("WF_" + name, wf[name]);
        }
    }

    if (wf.bizList != null) {
        obj.data(any.ds("ds_wfBizList").init().loadData(wf.bizList));
    }
}

any.unloadPage_orgin = any.unloadPage;

any.unloadPage = function(returnValue, replacePath)
{
    var $gridLayout;

    try {
        $gridLayout = parent.$('[com-gridlayout=""]');
    } catch(e) {
        return;
    }

    if ($gridLayout != null) {
        $gridLayout.exec("resetLayout");
    }

    any.unloadPage_orgin.apply(this, arguments);
};

window.UserConfig = function UserConfig()
{
    var f = {};

    (function main() {
        f.getValue = getValue;
        f.setValue = setValue;
        f.getObject = getObject;
        f.setObject = setObject;
    })();

    return f;

    function getRootConfig(name)
    {
        var rootConfig = any.rootWindow()["_USER_CONFIG_"];

        if (rootConfig == null) {
            rootConfig = any.rootWindow()["_USER_CONFIG_"] = {};
        }

        if (name != null) {
            return rootConfig[name];
        }

        return rootConfig;
    }

    function getValue(name, defaultValue)
    {
        // var rootValue = getRootConfig(name);
        //
        // if (rootValue != null) {
        //     return rootValue;
        // }
        //
        // var ds = any.ds("ds", UserConfig);
        //
        // var prx = any.proxy();
        // // prx.url("/common.user.config.UserConfigAct/retrieve");
        // prx.url("/common.user.config.UserConfigAct/retrieve");
        // prx.param("CONFIG_NAME", name);
        // prx.output(ds);
        //
        // prx.on("onError", function()
        // {
        //     this.error.show();
        // });
        //
        // prx.option("async", false);
        // prx.execute();
        //
        // if (prx.error.error == true) {
        //     return defaultValue;
        // }
        //
        // if (ds.rowCount() == 1) {
        //     return getRootConfig()[name] = ds.value(0, "CONFIG_VAL");
        // }
        //
        // return getRootConfig()[name] = defaultValue;
    }

    function setValue(name, value)
    {
        var prx = any.proxy();
        prx.url("/common.user.config.UserConfigAct/update");
        prx.param("CONFIG_NAME", name);
        prx.param("CONFIG_VAL", value);

        prx.on("onError", function()
        {
            this.error.show();
        });

        prx.option({ "loadingbar":false, "async":false });
        prx.execute();

        if (prx.error.error != true) {
            getRootConfig()[name] = value;
            return true;
        }
    }

    function getObject(name, defaultObject)
    {
        var value = getValue(name);

        if (value == null) {
            return defaultObject;
        }

        if (typeof(value) !== "object") {
            return getRootConfig()[name] = eval("(" + value + ")");
        }

        return value;
    }

    function setObject(name, object)
    {
        if (object == null) {
            deleteConfig(name);
            return;
        }

        var value = [];

        for (var key in object) {
            if (object[key] != null) {
                if ($.type(object[key]) === "number") {
                    value.push("\"" + key + "\":" + object[key]);
                } else {
                    value.push("\"" + key + "\":\"" + any.text.toJS(object[key]) + "\"");
                }
            }
        }

        if (setValue(name, "{" + value.join(",") + "}") == true) {
            getRootConfig()[name] = eval("({" + value.join(",") + "})");
        }
    }

    function deleteConfig(name)
    {
        var prx = any.proxy();
        prx.url("/common.user.config.UserConfigAct/delete");
        prx.param("CONFIG_NAME", name);

        prx.on("onError", function()
        {
            this.error.show();
        });

        prx.option({ "loadingbar":false, "async":false });
        prx.execute();
    }
}();

function cfGridImageFormatter(cellValue, options, rowObject) {
    var src;

    if (cellValue != null && cellValue != "") {
        src = any.url("/common.file.FileAct/downloadByPath", { DOWNLOAD_PATH: cellValue, THUMBNAIL: 1 });
    } else {
        src = any.url("/common/images/noimage.gif");
    }

    return '<img src="' + src + '" style="height: 80px; width: 80px;" />';
}

// KIPRIS 정보보기
function cfKiprissPopup(appNo)
{
    var match = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\(\=]/gi;
    var APP_NO = appNo.replace(match, "");
    if (APP_NO.length != 13) {
        alert(any.message("msg.error.appno", "출원번호가 잘못되어 있습니다."));
        return;
    }
    var win = any.window();
    win.url("/common.kipris.KiprisAct/viewKiprisBiblio");
    win.param("appNo", APP_NO);
    win.option({ resizable:"yes" });
    win.open();
}
