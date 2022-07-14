any.control("wf-mgt-event").define(function behavior(control, controlName)
{
    var o = {};

    (function main() {
        o.$control = $(control).css({ "overflow":"auto" });
        o.config = any.control(control).config;

        o.$element = $('<div>').attr("id", control.id + "_canvasContainer_" + any.control().newIndex()).css({ position:"relative" }).appendTo(control);

        o.$element.height(o.$control.height());

        any.ready(function() {
            resizeAll();
        });

        jQuery(window).resize(function() {
            resizeAll();
        });

        o.$control.resize(function() {
            resizeAll();
        });

        o.sizing = {
            activityGroupWidth: 300,
            statusGroupDistance: 200,
            statusGroupWidth: 180,
            forkConditionPolygonScaleY: 0.25
        };

        o.currentActivityPositionX = 0;

        initStage();

        o.$control.defineMethod("element", element);
        o.$control.defineMethod("init", init);
        o.$control.defineMethod("resizeAll", resizeAll);
        o.$control.defineMethod("addActivity", addActivity);
        o.$control.defineMethod("addStatus", addStatus);
        o.$control.defineMethod("addAction", addAction);
        o.$control.defineMethod("addForkCondition", addForkCondition);
        o.$control.defineMethod("addLink", addLink);
        o.$control.defineMethod("saveCurrentHilightGroupId", saveCurrentHilightGroupId);
        o.$control.defineMethod("saveRedrawAttributes", saveRedrawAttributes);
        o.$control.defineMethod("loadRedrawAttributes", loadRedrawAttributes);

        o.$control.defineProperty("stage", { get:getStage });

        any.control(control).initialize();
    })();

    function element()
    {
        return o.$element;
    }

    function init()
    {
        if (o.layer != null) {
            o.layer.destroy();
        }

        o.currentActivityPositionX = 0;

        o.stage.setWidth(o.$element.width());
        o.stage.setHeight(o.$element.height());

        o.layer = new Konva.Layer({
            draggable: false
        });

        o.layer.dragBoundFunc(function(pos) {
            return { x: Math.min(0, pos.x), y: Math.min(0, pos.y) };
        });

        o.stage.add(o.layer);

        o.activityAddButton = addRectText(o.layer, { strokeWidth: 2, fill: "#0000ff", width: 30, height: 30 }, { text: "+", fill: "#ffffff", fontSize: 20, fontStyle: "bold" });

        o.activityAddButton.addEventAction("click", function () {
            o.$control.fire("onActivityAddClick");
        });

        o.layer.add(o.activityAddButton);

        delete(o.activityMap);
        delete(o.statusMap);
        delete(o.actionMap);
        delete(o.forkConditionMap);

        delete(o.currentHilightGroupId);
        delete(o.currentHilightShape);
        delete(o.currentHilightArrow);
        delete(o.forkCondValues);
    }

    function initStage()
    {
        o.stage = new Konva.Stage({
            container: o.$element.attr("id"),
            width: o.$element.width(),
            height: o.$element.height(),
            draggable: false
        });

        return o.stage;
    }

    function getStage()
    {
        return o.stage;
    }

    function resizeStageHeight(group)
    {
        var activityRects = o.layer.find(".activityRect");

        for (var i = 0; i < activityRects.length; i++) {
            activityRects[i].setHeight(Math.max(activityRects[i].getHeight(), group.getAbsolutePosition().y + o.sizing.statusGroupDistance));
        }

        o.stage.setHeight(Math.max(o.stage.getHeight(), group.getAbsolutePosition().y + o.sizing.statusGroupDistance));
    }

    function resizeAll()
    {
        o.$element.height(o.$control.height());
    }

    function addActivity(rowData, activityId, activityName, otherStep, disabled)
    {
        if (o.activityMap == null) {
            o.activityMap = {};
        }

        if (o.activityMap[activityId] != null) {
            return;
        }

        o.activityMap[activityId] = {};

        var group = new Konva.Group({
            name: "activityGroup",
            x: o.currentActivityPositionX,
            y: 0,
            width: o.sizing.activityGroupWidth,
            draggable: false
        });

        o.layer.add(group);

        group.add(new Konva.Rect({
            name: "activityRect",
            x: 0,
            y: 0,
            width: group.width(),
            height: o.$element.height(),
            stroke: "#0000ff",
            strokeWidth: 2,
            draggable: false
        }));

        var shapeTextGroup = addRectText(group, { strokeWidth: 2, fill: otherStep == true ? "#555555" : "#0000ff", height: 30 }, { text: activityName, fill: "#ffffff", fontSize: 13, fontStyle: "bold" }, null, disabled);
        shapeTextGroup.rowData = rowData;

        shapeTextGroup.addEventAction("click", function () {
            o.$control.fire("onActivityClick", [this.rowData]);
        });

        o.activityMap[activityId].group = group;
        o.activityMap[activityId].currentStatusPositionY = 100;

        o.activityMap[activityId].actionAddButton = addRectText(group, { strokeWidth: 1, fill: "#eeeeee", width: 18, height: 18 }, { text: "+", fontSize: 18 });
        o.activityMap[activityId].actionAddButton.rowData = rowData;

        if (o.actionAddButtonPositionY == null) {
            o.actionAddButtonPositionY = shapeTextGroup.elements.shape.height() + (o.activityMap[activityId].currentStatusPositionY - shapeTextGroup.elements.shape.height() - o.activityMap[activityId].actionAddButton.elements.shape.height()) / 2;
        }

        o.activityMap[activityId].actionAddButton.position({ x: (o.sizing.activityGroupWidth - o.sizing.statusGroupWidth) / 2, y: o.actionAddButtonPositionY });

        o.activityMap[activityId].actionAddButton.addEventAction("click", function () {
            o.$control.fire("onActionAddClick", [this.rowData]);
        });

        o.currentActivityPositionX += o.sizing.activityGroupWidth;

        o.activityAddButton.position({ x: o.currentActivityPositionX, y: 0 });

        o.stage.setWidth(Math.max(o.stage.getWidth(), group.getAbsolutePosition().x + group.width() + o.activityAddButton.width()));

        return shapeTextGroup;
    }

    function getActivity(activityId)
    {
        if (o.activityMap == null) {
            return null;
        }

        return o.activityMap[activityId];
    }

    function addStatus(rowData, statusId, activityId, statusName, disabled)
    {
        var activity = getActivity(activityId);

        if (activity == null) {
            return;
        }

        if (o.statusMap == null) {
            o.statusMap = {};
        }

        if (o.statusMap[statusId] != null) {
            return;
        }

        o.statusMap[statusId] = {};

        var group = new Konva.Group({
            x: 0,
            y: activity.currentStatusPositionY,
            width: o.sizing.statusGroupWidth,
            draggable: false
        });

        group.position({ x: (activity.group.width() - group.width()) / 2, y: group.position().y });

        activity.group.add(group);

        var shapeTextGroup = addRectText(group, { fill: "yellow" }, { text: statusName }, null, disabled);
        shapeTextGroup.id("statusGroup_" + statusId);

        shapeTextGroup.addEventAction("click", function() {
            hilightEventGroup(this);
        });

        o.statusMap[statusId].activityId = activityId;
        o.statusMap[statusId].group = group;
        o.statusMap[statusId].currentActionPositionY = shapeTextGroup.elements.shape.height();

        o.statusMap[statusId].actionAddButton = addRectText(group, { strokeWidth: 1, fill: "#eeeeee", width: 18, height: 18 }, { text: "+", fontSize: 18 });
        o.statusMap[statusId].actionAddButton.rowData = rowData;

        o.statusMap[statusId].actionAddButton.addEventAction("click", function () {
            o.$control.fire("onActionAddClick", [this.rowData]);
        });

        moveActionAddButton(statusId);

        activity.currentStatusPositionY += o.sizing.statusGroupDistance;

        resizeStageHeight(group);

        return shapeTextGroup;
    }

    function getStatus(statusId)
    {
        if (o.statusMap == null) {
            return null;
        }

        return o.statusMap[statusId];
    }

    function addAction(rowData, actionId, statusId, actionName, disabled)
    {
        if (any.text.isEmpty(actionId) == true) {
            return;
        }

        var status = getStatus(statusId);

        if (status == null) {
            return;
        }

        if (o.actionMap == null) {
            o.actionMap = {};
        }

        if (o.actionMap[actionId] != null) {
            return;
        }

        o.actionMap[actionId] = {};

        var shapeTextGroup = addRectText(status.group, { fill: "#eeeeee" }, { text: actionName }, { y: status.currentActionPositionY }, disabled);
        shapeTextGroup.id("actionGroup_" + actionId);
        shapeTextGroup.rowData = rowData;

        shapeTextGroup.addEventAction("click", function() {
            hilightEventGroup(this);
        });

        shapeTextGroup.addEventAction("dblclick", function () {
            o.$control.fire("onActionDblClick", [this.rowData]);
            hilightEventGroup(this, true);
        });

        o.actionMap[actionId].statusId = statusId;

        status.currentActionPositionY += shapeTextGroup.elements.shape.height();

        moveActionAddButton(statusId);

        return shapeTextGroup;
    }

    function getAction(actionId)
    {
        if (o.actionMap == null) {
            return null;
        }

        return o.actionMap[actionId];
    }

    function moveActionAddButton(statusId)
    {
        var status = o.statusMap[statusId];

        if (status != null) {
            status.actionAddButton.position({ x: 0, y: status.currentActionPositionY });
        }
    }

    function addForkCondition(rowData, forkCondQryId, actionId, forkCondQrySubject)
    {
        var action = getAction(actionId);

        if (action == null) {
            return;
        }

        var status = getStatus(action.statusId);

        if (status == null) {
            return;
        }

        var activityId = status.activityId;
        var activity = getActivity(activityId);

        if (activity == null) {
            return;
        }

        if (o.forkConditionMap == null) {
            o.forkConditionMap = {};
        }

        if (o.forkConditionMap[forkCondQryId] != null) {
            return;
        }

        var actionGroups = activity.group.find("#actionGroup_" + actionId);
        var groupPosY;

        if (actionGroups.length == 1) {
            var actionAncestorGroup = actionGroups[0].findAncestor("Group");
            var childGroups = activity.group.find("Group");

            groupPosY = actionAncestorGroup.position().y + o.sizing.statusGroupDistance;

            for (var i = 0; i < childGroups.length; i++) {
                if (any.text.startsWith(childGroups[i].id(), "forkConditionGroup_") == true && childGroups[i].position().y == groupPosY) {
                    groupPosY += o.sizing.statusGroupDistance;
                } else if (childGroups[i].position().y >= groupPosY) {
                    childGroups[i].position({ x: childGroups[i].position().x, y: childGroups[i].position().y + o.sizing.statusGroupDistance });
                    resizeStageHeight(childGroups[i]);
                }
            }
        }

        o.forkConditionMap[forkCondQryId] = {};

        var shapeTextGroup = new Konva.Group({
            id: "forkConditionGroup_" + forkCondQryId,
            x: 0,
            y: groupPosY || activity.currentStatusPositionY,
            width: o.sizing.statusGroupWidth,
            draggable: false
        });

        shapeTextGroup.position({ x: (activity.group.width() - shapeTextGroup.width()) / 2, y: shapeTextGroup.position().y });

        activity.group.add(shapeTextGroup);

        shapeTextGroup.elements = {};

        shapeTextGroup.elements.shape = new Konva.RegularPolygon({
            id: "forkConditionPolygon_" + forkCondQryId,
            x: shapeTextGroup.width() / 2,
            y: shapeTextGroup.width() / 2 * o.sizing.forkConditionPolygonScaleY,
            sides: 4,
            radius: shapeTextGroup.width() / 2,
            fill: "#eeeeee",
            stroke: "#000000",
            strokeWidth: 1,
            scaleY: o.sizing.forkConditionPolygonScaleY
        });

        shapeTextGroup.elements.text = new Konva.Text({
            fontSize: 12,
            align: "center",
            width: shapeTextGroup.width(),
            text: forkCondQrySubject
        });

        shapeTextGroup.elements.text.position({
            x: shapeTextGroup.elements.text.position().x,
            y: shapeTextGroup.elements.shape.position().y - shapeTextGroup.elements.shape.height() / 2 + (shapeTextGroup.elements.shape.height() - shapeTextGroup.elements.text.height()) / 2
        });

        shapeTextGroup.add(shapeTextGroup.elements.shape);
        shapeTextGroup.add(shapeTextGroup.elements.text);

        shapeTextGroup.addEventAction = addEventAction;

        shapeTextGroup.addEventAction("click", function() {
            hilightEventGroup(this);
        });

        activity.currentStatusPositionY += o.sizing.statusGroupDistance;

        resizeStageHeight(shapeTextGroup);

        return shapeTextGroup;
    }

    function addLink(rowData, actionId, forkCondQryId, forkCondValue, statusId)
    {
        var actionGroups = o.layer.find("#actionGroup_" + actionId);

        if (actionGroups.length == 0) {
            return;
        }

        var actionRect = actionGroups[0].elements.shape;
        var statusGroups = o.layer.find("#statusGroup_" + statusId);
        var statusRect = (statusGroups.length == 0 ? null : statusGroups[0].elements.shape);

        if (any.text.isEmpty(forkCondQryId) == true) {
            if (statusRect != null) {
                var points = getPoints(actionRect, statusRect);

                var arrow = new Konva.Arrow({
                    x: 0,
                    y: 0,
                    points: points,
                    pointerLength: 10,
                    pointerWidth: 8,
                    fill: "#ff0000",
                    stroke: "#ff0000",
                    strokeWidth: 2,
                    opacity: 0.25
                });

                addArrowLinks(actionRect, arrow);
                addArrowLinks(statusRect, arrow);

                o.layer.add(arrow);

                arrow.on("click", function() {
                    hilightLinkArrow(this);
                });
            }
        } else {
            var forkConditionPolygon = o.layer.find("#forkConditionPolygon_" + forkCondQryId)[0];

            if (o.layer.find("#actionRectToForkConditionPolygonLine_" + actionId + "_" + forkCondQryId).length == 0) {
                var line = new Konva.Line({
                    id: "actionRectToForkConditionPolygonLine_" + actionId + "_" + forkCondQryId,
                    x: 0,
                    y: 0,
                    points: getPoints(actionRect, forkConditionPolygon),
                    stroke: "#ff0000",
                    strokeWidth: 2,
                    opacity: 0.25
                });

                addArrowLinks(actionRect, line);
                addArrowLinks(forkConditionPolygon, line);

                o.layer.add(line);
            }

            if (statusRect != null) {
                var points = getPoints(forkConditionPolygon, statusRect);

                var arrow = new Konva.Arrow({
                    x: 0,
                    y: 0,
                    points: points,
                    pointerLength: 10,
                    pointerWidth: 8,
                    fill: "#ff0000",
                    stroke: "#ff0000",
                    strokeWidth: 2,
                    opacity: 0.25
                });

                addArrowLinks(forkConditionPolygon, arrow);
                addArrowLinks(statusRect, arrow);

                o.layer.add(arrow);

                arrow.on("click", function() {
                    hilightLinkArrow(this);
                });

                var text = new Konva.Text({
                    x: 0,
                    y: 0,
                    fontSize: 12,
                    align: "center",
                    stroke: "#ff0000",
                    strokeWidth: 0.5,
                    text: forkCondValue
                });

                arrow.elements = {};
                arrow.elements.text = text;

                text.elements = {};
                text.elements.arrow = arrow;

                var textPosition = { x: 0, y: 0 };

                if (points.length == 4) {
                    if (o.$control.attr("straightLineLink") == "1") {
                        textPosition.x = points[0] + (points[2] - points[0]) / 2 - text.width() / 2;
                        textPosition.y = points[1] + (points[3] - points[1]) / 2 - text.height() / 2;
                    } else {
                        textPosition.x = points[0] - text.width() / 2;
                        textPosition.y = points[1] + (points[3] - points[1]) / 2 - text.height() / 2;
                    }
                } else if (points.length == 8) {
                    if (points[0] < points[2]) {
                        textPosition.x = points[4] + 5;
                    } else {
                        textPosition.x = points[4] - text.width() - 5;
                    }
                    textPosition.y = points[3] + (points[5] - points[3]) / 2 - text.height() / 2;
                } else {
                    textPosition.x = points[0];
                    textPosition.y = points[1];
                }

                if (o.forkCondValues == null) {
                    o.forkCondValues = {};
                }

                if (o.forkCondValues[textPosition.x + ":" + textPosition.y] != null) {
                    textPosition.y += text.height();
                }

                o.forkCondValues[textPosition.x + ":" + textPosition.y] = text;

                text.setAbsolutePosition(textPosition);

                o.layer.add(text);

                text.on("click", function() {
                    hilightLinkArrow(this.elements.arrow);
                });
            }
        }

        function getPoints(fromShape, toShape)
        {
            var fromActivityChildrenGroup = getActivityChildrenGroup(fromShape);
            var fromSpec = getShapeSpec(fromShape);
            var toActivityChildrenGroup = getActivityChildrenGroup(toShape);
            var toSpec = getShapeSpec(toShape);
            var points = [];

            if (fromSpec.centerX < toSpec.centerX) {
                points.push(fromSpec.centerX + fromSpec.realWidth / 2, fromSpec.centerY);
                if (o.$control.attr("straightLineLink") != "1") {
                    points.push(toSpec.centerX - toSpec.realWidth / 2 - 40, fromSpec.centerY);
                    points.push(toSpec.centerX - toSpec.realWidth / 2 - 40, toSpec.centerY);
                }
                points.push(toSpec.centerX - toSpec.realWidth / 2, toSpec.centerY);
            } else if (fromSpec.centerX > toSpec.centerX) {
                points.push(fromSpec.centerX - fromSpec.realWidth / 2, fromSpec.centerY);
                if (o.$control.attr("straightLineLink") != "1") {
                    points.push(fromSpec.centerX - fromSpec.realWidth / 2 - 20, fromSpec.centerY);
                    points.push(fromSpec.centerX - fromSpec.realWidth / 2 - 20, toSpec.centerY);
                }
                points.push(toSpec.centerX + toSpec.realWidth / 2, toSpec.centerY);
            } else if (fromActivityChildrenGroup.getAbsolutePosition().y + o.sizing.statusGroupDistance == toActivityChildrenGroup.getAbsolutePosition().y) {
                points.push(fromSpec.centerX, fromSpec.centerY + fromSpec.realHeight / 2);
                points.push(toSpec.centerX, toSpec.centerY - toSpec.realHeight / 2);
            } else {
                points.push(fromSpec.centerX - fromSpec.realWidth / 2, fromSpec.centerY);
                points.push(fromSpec.centerX - fromSpec.realWidth / 2 - 20, fromSpec.centerY);
                points.push(fromSpec.centerX - fromSpec.realWidth / 2 - 20, toSpec.centerY);
                points.push(toSpec.centerX - fromSpec.realWidth / 2, toSpec.centerY);
            }

            return points;

            function getActivityChildrenGroup(node)
            {
                if (node == null) {
                    return null;
                }

                var ancestor = node.findAncestor("Group");

                if (ancestor == null) {
                    return null;
                }

                if (ancestor.name() != "activityGroup") {
                    return getActivityChildrenGroup(ancestor);
                }

                return node;
            }

            function getShapeSpec(shape)
            {
                var spec = {};

                if (shape.getClassName() == "RegularPolygon") {
                    spec.centerX = shape.getAbsolutePosition().x;
                    spec.centerY = shape.getAbsolutePosition().y;
                    spec.realWidth = shape.width();
                    spec.realHeight = shape.height() * o.sizing.forkConditionPolygonScaleY;
                } else {
                    spec.centerX = shape.getAbsolutePosition().x + shape.width() / 2;
                    spec.centerY = shape.getAbsolutePosition().y + shape.height() / 2;
                    spec.realWidth = shape.width();
                    spec.realHeight = shape.height();
                }

                return spec;
            }
        }

        function addArrowLinks(target, arrow)
        {
            if (target.arrowLinks == null) {
                target.arrowLinks = [];
            }

            target.arrowLinks.push(arrow);
        }
    }

    function hilightLinkArrow(arrow)
    {
        if (o.currentHilightShape != null && o.currentHilightShape.arrowLinks != null) {
            for (var i = 0; i < o.currentHilightShape.arrowLinks.length; i++) {
                if (o.currentHilightShape.arrowLinks[i] == arrow) {
                    return;
                }
            }
        }

        if (o.currentHilightArrow == arrow) {
            unhilightLinkArrow();
            return;
        }

        unhilightLinkArrow();

        o.currentHilightArrow = arrow;
        o.currentHilightArrow.originalConfig = { strokeWidth: arrow.strokeWidth() };

        arrow.strokeWidth(10);

        if (arrow.elements != null && arrow.elements.text != null) {
            o.currentHilightArrow.originalConfig.text = { strokeWidth: arrow.elements.text.strokeWidth() };
            arrow.elements.text.strokeWidth(2);
        }

        o.layer.draw();
    }

    function unhilightLinkArrow()
    {
        if (o.currentHilightArrow == null) {
            return;
        }

        o.currentHilightArrow.strokeWidth(o.currentHilightArrow.originalConfig.strokeWidth);

        if (o.currentHilightArrow.elements != null && o.currentHilightArrow.elements.text != null) {
            o.currentHilightArrow.elements.text.strokeWidth(o.currentHilightArrow.originalConfig.text.strokeWidth);
        }

        o.layer.draw();

        delete(o.currentHilightArrow);
    }

    function addRectText(target, rectConfig, textConfig, groupConfig, disabled)
    {
        if (groupConfig == null) {
            groupConfig = {};
        }

        groupConfig.y = groupConfig.y || 0;
        groupConfig.width = groupConfig.width || rectConfig.width || target.width();

        var shapeTextGroup = new Konva.Group(groupConfig);
        shapeTextGroup.elements = {};
        target.add(shapeTextGroup);

        if (disabled === true) {
            textConfig.textDecoration = "line-through";
            textConfig.fontStyle = "italic";
        }

        textConfig.fontSize = textConfig.fontSize || 12;
        textConfig.align = textConfig.align || "center";
        textConfig.width = textConfig.width || shapeTextGroup.width();
        shapeTextGroup.elements.text = new Konva.Text(textConfig);

        rectConfig.x = rectConfig.x || 0;
        rectConfig.stroke = rectConfig.stroke || "#000000";
        rectConfig.strokeWidth = rectConfig.strokeWidth || 1;
        rectConfig.width = rectConfig.width || shapeTextGroup.width();
        rectConfig.height = rectConfig.height || shapeTextGroup.elements.text.height() + 8;
        shapeTextGroup.elements.shape = new Konva.Rect(rectConfig);

        shapeTextGroup.elements.text.position({
            x: shapeTextGroup.elements.text.position().x,
            y: shapeTextGroup.elements.shape.position().y + (shapeTextGroup.elements.shape.height() - shapeTextGroup.elements.text.height()) / 2
        });

        shapeTextGroup.add(shapeTextGroup.elements.shape);
        shapeTextGroup.add(shapeTextGroup.elements.text);

        shapeTextGroup.addEventAction = addEventAction;

        return shapeTextGroup;
    }

    function addEventAction(eventName, func)
    {
        this.elements.shape.on(eventName, function(event) {
            if (event.evt.which == 1) {
                func.apply(this.findAncestor("Group"), arguments);
            }
        });

        this.elements.text.on(eventName, function(event) {
            if (event.evt.which == 1) {
                func.apply(this.findAncestor("Group"), arguments);
            }
        });

        if (eventName != "click") {
            return;
        }

        this.elements.shape.on("mouseenter", function () {
            o.stage.container().style.cursor = "pointer";
        });
        this.elements.shape.on("mouseleave", function () {
            o.stage.container().style.cursor = "default";
        });

        this.elements.text.on("mouseenter", function () {
            o.stage.container().style.cursor = "pointer";
        });
        this.elements.text.on("mouseleave", function () {
            o.stage.container().style.cursor = "default";
        });
    }

    function hilightEventGroup(group, force)
    {
        if (o.currentHilightShape != null) {
            o.currentHilightShape.stroke(o.currentHilightShape.originalConfig.stroke);
            o.currentHilightShape.strokeWidth(o.currentHilightShape.originalConfig.strokeWidth);

            if (o.currentHilightShape.arrowLinks != null) {
                for (var i = 0; i < o.currentHilightShape.arrowLinks.length; i++) {
                    var arrowLink = o.currentHilightShape.arrowLinks[i];

                    arrowLink.stroke(arrowLink.originalConfig.stroke);
                    arrowLink.strokeWidth(arrowLink.originalConfig.strokeWidth);
                    arrowLink.opacity(arrowLink.originalConfig.opacity);
                }
            }

            if (force != true && o.currentHilightGroupId == group.id()) {
                delete(o.currentHilightGroupId);
                delete(o.currentHilightShape);
                o.layer.draw();
                return;
            }
        }

        unhilightLinkArrow();

        o.currentHilightGroupId = group.id();

        o.currentHilightShape = group.elements.shape;
        o.currentHilightShape.originalConfig = { stroke: o.currentHilightShape.stroke(), strokeWidth: o.currentHilightShape.strokeWidth() };
        o.currentHilightShape.stroke("#0000ff");
        o.currentHilightShape.strokeWidth(5);

        if (o.currentHilightShape.arrowLinks != null) {
            for (var i = 0; i < o.currentHilightShape.arrowLinks.length; i++) {
                var arrowLink = o.currentHilightShape.arrowLinks[i];

                arrowLink.originalConfig = { stroke: arrowLink.stroke(), strokeWidth: arrowLink.strokeWidth(), opacity: arrowLink.opacity() };
                arrowLink.stroke("#0000ff");
                arrowLink.strokeWidth(10);
                arrowLink.opacity(1);
            }
        }

        group.moveToTop();

        o.layer.draw();
    }

    function saveCurrentHilightGroupId(groupId)
    {
        o.redrawAttributes = {};

        o.redrawAttributes.currentHilightGroupId = (groupId || o.currentHilightGroupId);
    }

    function saveRedrawAttributes()
    {
        o.redrawAttributes = {};

        o.redrawAttributes.top = o.$control.scrollTop();
        o.redrawAttributes.left = o.$control.scrollLeft();

        o.redrawAttributes.currentHilightGroupId = o.currentHilightGroupId;
    }

    function loadRedrawAttributes()
    {
        if (o.redrawAttributes == null) {
            return;
        }

        if (o.redrawAttributes.top != null) {
            o.$control.scrollTop(o.redrawAttributes.top);
        }

        if (o.redrawAttributes.left != null) {
            o.$control.scrollLeft(o.redrawAttributes.left);
        }

        if (o.redrawAttributes.currentHilightGroupId != null) {
            var groups = o.layer.find("#" + o.redrawAttributes.currentHilightGroupId);

            for (var i = 0; i < groups.length; i++) {
                hilightEventGroup(groups[i]);
            }
        }

        delete(o.redrawAttributes);
    }
});
