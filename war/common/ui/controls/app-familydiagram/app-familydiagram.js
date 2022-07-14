any.control("app-familydiagram").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control);

        o.$control.addClass("ui-widget-content").css({ overflow:"auto" });

        o.$element = $('<div>').attr("id", control.id + "_canvasContainer_" + any.control().newIndex()).css({ position:"relative", width:"100%" }).appendTo(control);

        o.items = [];
        o.links = [];

        o.drawItems = {};

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("setItemDistance", setItemDistance);
        o.$control.defineMethod("addItem", addItem);
        o.$control.defineMethod("addLink", addLink);
        o.$control.defineMethod("draw", draw);
        o.$control.defineMethod("highlight", highlight);
        o.$control.defineMethod("showLinkCaption", showLinkCaption);

        o.$control.defineProperty("layer", { get:getLayer });

        any.control(control).initialize();
    })();

    function element()
    {
        return o.$element;
    }

    function getLayer()
    {
        return o.layer;
    }

    function setItemDistance(x, y)
    {
        o.itemDistance = { x:x, y:y };
    }

    function addItem(itemId, sectionNo, rectAttrs, textAttrs)
    {
        sectionNo = parseInt(sectionNo, 10);

        if (isNaN(sectionNo)) sectionNo = 0;

        o.items.push({ itemId:itemId, sectionNo:sectionNo, rectAttrs:rectAttrs, textAttrs:textAttrs });
    }

    function addLink(fromItemId, toItemId, lineAttrs, textAttrs)
    {
        o.links.push({ fromItemId:fromItemId, toItemId:toItemId, lineAttrs:lineAttrs, textAttrs:textAttrs });
    }

    function arrangeItem()
    {
        var minSectionNo = -1;

        for (var i = 0; i < o.items.length; i++) {
            if (minSectionNo == -1 || minSectionNo > o.items[i].sectionNo) {
                minSectionNo = o.items[i].sectionNo;
            }
        }

        var xItems = {};

        for (var i = 0; i < o.items.length; i++) {
            var item = o.items[i];

            item.positionX = item.sectionNo - minSectionNo + 1;

            if (xItems[item.positionX] == null) {
                xItems[item.positionX] = [];
            }

            xItems[item.positionX].push(item);
        }

        var num = 1;

        while (xItems[num] != null) {
            var items = [];
            for (var i = 0; i < xItems[num].length; i++) {
                if (checkLink(xItems[num][i])) {
                    items.push(xItems[num][i]);
                }
            }
            if (items.length > 0) {
                for (var i = any.object.size(xItems); i > num; i--) {
                    for (var j = 0; j < xItems[i].length; j++) {
                        addItemPosition(xItems[i][j]);
                    }
                }
                for (var i = 0; i < items.length; i++) {
                    addItemPosition(items[i]);
                }
            }
            num++;
        }

        for (var positionX in xItems) {
            for (var i = xItems[positionX].length - 1; i >= 0; i--) {
                if (xItems[positionX][i] == null) {
                    xItems[positionX].splice(i, 1);
                }
            }
        }

        var xPosMax = 0;
        var xCntMax = 0;

        for (var positionX in xItems) {
            if (positionX > xPosMax) {
                xPosMax = positionX;
            }

            if (xItems[positionX].length > xCntMax) {
                xCntMax = xItems[positionX].length;
            }
        }

        for (var positionX in xItems) {
            for (var i = 0, ii = xItems[positionX].length; i < ii; i++) {
                xItems[positionX][i].positionY = i + 1 + parseInt((xCntMax - ii) / 2, 10);
            }
        }

        o.stageWidth = o.itemDistance.x * xPosMax;
        o.stageHeight = o.itemDistance.y * xCntMax;

        function checkLink(item)
        {
            if (item == null) return false;

            for (var i = 0; i < o.links.length; i++) {
                var fromItem = getItem(o.links[i].fromItemId);
                var toItem = getItem(o.links[i].toItemId);

                if (fromItem == null || toItem == null) continue;

                if (fromItem.itemId != item.itemId && toItem.itemId == item.itemId && toItem.positionX <= fromItem.positionX) {
                    return true;
                }
            }

            return false;
        }

        function addItemPosition(item)
        {
            if (item == null) return;

            var x = item.positionX;

            for (var i = 0; i < xItems[x].length; i++) {
                if (xItems[x][i] == item) {
                    xItems[x][i] = null;
                    break;
                }
            }

            if (xItems[x + 1] == null) {
                xItems[x + 1] = [];
            }

            xItems[x + 1].push(item);

            item.positionX++;
        }
    }

    function draw()
    {
        arrangeItem();

        o.layer = new Kinetic.Layer();

        for (var i = 0; i < o.items.length; i++) {
            drawItem(o.items[i]);
        }

        for (var i = 0; i < o.links.length; i++) {
            drawLink(o.links[i]);
        }

        o.stage = new Kinetic.Stage({ container:o.$element.attr("id") }).add(o.layer);

        $(window).resize(function() {
            o.stage.setWidth(Math.max(o.stageWidth, o.$control.width() - any.scrollbarWidth()));
            o.stage.setHeight(Math.max(o.stageHeight, o.$control.height() - any.scrollbarWidth()));
        }).fire("resize");

        showLinkCaption(o.showLinkCaption);
    }

    function highlight(selectedId)
    {
        for (var i = 0; i < o.items.length; i++) {
            if (o.items[i].itemId == selectedId) {
                var selectedItem = o.drawItems[o.items[i].itemId];

                o.$control.scrollControlPointX = selectedItem.getX();
                o.$control.scrollControlPointY = selectedItem.getY();

                selectedItem.text.attrs.fontStyle = "bold";
                selectedItem.attrs.stroke = "red";
                selectedItem.attrs.width = selectedItem.text.getWidth() + 20;

                redrawLinks(selectedItem);

                break;
            }
        }

        var offsetWidth = control.offsetWidth;
        var offsetHeight = control.offsetHeight;

        if (o.$control.scrollControlPointX >= offsetWidth * 0.7) {
            o.$control.scrollLeft(o.$control.scrollControlPointX / 2);
        }

        if (o.$control.scrollControlPointY >= offsetHeight * 0.7) {
            o.$control.scrollTop(o.$control.scrollControlPointY / 2);
        }
    }
    function drawItem(itemInfo)
    {
        var attrs = { rect:{}, text:{} };

        attrs.rect.x = itemInfo.positionX * o.itemDistance.x - o.itemDistance.x / 2;
        attrs.rect.y = itemInfo.positionY * o.itemDistance.y - o.itemDistance.y / 2;
        attrs.rect.fill = "white";
        attrs.rect.stroke = "black";
        attrs.rect.strokeWidth = 2;
        attrs.rect.cornerRadius = 5;
        attrs.rect.draggable = true;

        for (var name in itemInfo.rectAttrs) {
            attrs.rect[name] = itemInfo.rectAttrs[name];
        }

        var item = new Kinetic.Rect(attrs.rect);
        item.fromLinks = [];
        item.toLinks = [];

        attrs.text.x = item.getX();
        attrs.text.y = item.getY();
        attrs.text.padding = 0;
        attrs.text.fontSize = 12;
        attrs.text.fontFamily = "Tahoma";
        attrs.text.fill = "black";
        attrs.text.align = "center";
        attrs.text.draggable = true;

        for (var name in itemInfo.textAttrs) {
            attrs.text[name] = itemInfo.textAttrs[name];
        }

        item.text = new Kinetic.Text(attrs.text);
        item.text.setOffset({ x:item.text.getWidth() / 2, y:item.text.getHeight() / 2 });

        item.id = itemInfo.itemId;
        item.setWidth(item.text.getWidth() + 10);
        item.setHeight(item.text.getHeight() + 6);
        item.setOffset({ x:item.getWidth() / 2, y:item.getHeight() / 2 });

        item.on("dragmove", function() {
            item.text.setX(this.getX());
            item.text.setY(this.getY());
            redrawLinks(item);
        });

        item.text.on("dragmove", function() {
            item.setX(this.getX());
            item.setY(this.getY());
            redrawLinks(item);
        });

        item.on("dblclick", function() {
            o.$control.fire("onItemDoubleClick", [item, itemInfo]);
        });
        item.text.on("dblclick", function() {
            o.$control.fire("onItemDoubleClick", [item, itemInfo]);
        });

        o.layer.add(item);
        o.layer.add(item.text);

        o.drawItems[itemInfo.itemId] = item;

        return item;
    }

    function drawLink(linkInfo)
    {
        if (o.drawItems[linkInfo.fromItemId] == null) return;
        if (o.drawItems[linkInfo.toItemId] == null) return;

        var fromItem = o.drawItems[linkInfo.fromItemId];
        var toItem = o.drawItems[linkInfo.toItemId];

        var attrs = { line:{}, text:{} };

        attrs.line.stroke = "black";
        attrs.line.strokeWidth = 1;
        attrs.line.points = getPoints(fromItem, toItem);

        for (var name in linkInfo.lineAttrs) {
            attrs.line[name] = linkInfo.lineAttrs[name];
        }

        var link = new Kinetic.Line(attrs.line);

        fromItem.fromLinks.push({ link:link, toItem:toItem });
        toItem.toLinks.push({ link:link, fromItem:fromItem });

        attrs.text.text = "";
        attrs.text.width = attrs.line.width;
        attrs.text.padding = 0;
        attrs.text.fontSize = 12;
        attrs.text.fontFamily = "Tahoma";
        attrs.text.fill = "black";
        attrs.text.align = "center";
        attrs.text.draggable = false;

        for (var name in linkInfo.textAttrs) {
            attrs.text[name] = linkInfo.textAttrs[name];
        }

        link.text = new Kinetic.Text(attrs.text);
        link.text.setOffset({ x:link.text.getWidth() / 2, y:link.text.getHeight() / 2 });
        link.text.setX(link.getPoints()[0].x + (link.getPoints()[1].x - link.getPoints()[0].x) / 2);
        link.text.setY(link.getPoints()[0].y + (link.getPoints()[1].y - link.getPoints()[0].y) / 2);

        link.text.on("mouseover", function() {
            link.text.defaultFontSize = link.text.getFontSize();
            link.text.setFontSize(link.text.defaultFontSize * 1.6);
            link.text.setFontStyle("bold");
            link.text.setOffset({ x:link.text.getWidth() / 2, y:link.text.getHeight() / 2 });
            link.setStrokeWidth(4);
            link.parent.drawScene();
        });

        link.text.on("mouseout", function() {
            link.text.setFontSize(link.text.defaultFontSize);
            link.text.setFontStyle("normal");
            link.text.setOffset({ x:link.text.getWidth() / 2, y:link.text.getHeight() / 2 });
            link.setStrokeWidth(1);
            link.parent.drawScene();
        });

        o.layer.add(link);
        o.layer.add(link.text);

        link.text.moveToBottom();
        link.moveToBottom();

        if (o.linkCaptions == null) {
            o.linkCaptions = [];
        }

        o.linkCaptions.push(link.text);

        return link;
    }

    function getPoints(fromItem, toItem)
    {
        var points = [];
        var headLen = 8;

        var atan2 = Math.atan2(toItem.getY() - fromItem.getY(), toItem.getX() - fromItem.getX());
        var fromX, fromY, toX, toY;

        fromY = fromItem.getY();

        if (fromItem.getX() - fromItem.getOffsetX() > toItem.getX() + toItem.getOffsetX()) {
            fromX = fromItem.getX() - fromItem.getOffsetX();
            toX = toItem.getX() + toItem.getOffsetX();
            toY = toItem.getY();
        } else if (fromItem.getX() + fromItem.getOffsetX() > toItem.getX() - toItem.getOffsetX()) {
            fromX = fromItem.getX();
            toX = toItem.getX();
            if (fromItem.getY() == toItem.getY()) {
                toY = toItem.getY();
            } else if (fromItem.getY() > toItem.getY()) {
                toY = toItem.getY() + toItem.getOffsetY();
            } else {
                toY = toItem.getY() - toItem.getOffsetY();
            }
        } else if (fromItem.getX() - fromItem.getOffsetX() < toItem.getX() - toItem.getOffsetX()) {
            fromX = fromItem.getX() + fromItem.getOffsetX();
            toX = toItem.getX() - toItem.getOffsetX();
            toY = toItem.getY();
        } else {
            fromX = fromItem.getX() + fromItem.getOffsetX();
            toX = toItem.getX() + toItem.getOffsetX();
            toY = toItem.getY();
        }

        var angle = Math.atan2(toY - fromY, toX - fromX);

        points.push(fromX);
        points.push(fromY);
        points.push(toX);
        points.push(toY);
        points.push(toX - headLen * Math.cos(angle - Math.PI / 6));
        points.push(toY - headLen * Math.sin(angle - Math.PI / 6));
        points.push(toX);
        points.push(toY);
        points.push(toX - headLen * Math.cos(angle + Math.PI / 6));
        points.push(toY - headLen * Math.sin(angle + Math.PI / 6));

        return points;
    }

    function redrawLinks(item)
    {
        for (var i = 0; i < item.fromLinks.length; i++) {
            var link = item.fromLinks[i].link;
            link.setPoints(getPoints(item, item.fromLinks[i].toItem));
            link.text.setX(link.getPoints()[0].x + (link.getPoints()[1].x - link.getPoints()[0].x) / 2);
            link.text.setY(link.getPoints()[0].y + (link.getPoints()[1].y - link.getPoints()[0].y) / 2);
        }

        for (var i = 0; i < item.toLinks.length; i++) {
            var link = item.toLinks[i].link;
            link.setPoints(getPoints(item.toLinks[i].fromItem, item));
            link.text.setX(link.getPoints()[0].x + (link.getPoints()[1].x - link.getPoints()[0].x) / 2);
            link.text.setY(link.getPoints()[0].y + (link.getPoints()[1].y - link.getPoints()[0].y) / 2);
        }

        o.layer.drawScene();
    }

    function getItem(itemId)
    {
        for (var i = 0; i < o.items.length; i++) {
            if (o.items[i].itemId == itemId) return o.items[i];
        }
    }

    function showLinkCaption(show)
    {
        o.showLinkCaption = show;

        if (o.linkCaptions == null) return;

        for (var i = 0; i < o.linkCaptions.length; i++) {
            if (show == true) {
                o.linkCaptions[i].show();
            } else {
                o.linkCaptions[i].hide();
            }
        }

        o.layer.draw();
    }
});
