'=================================================================================================
'VSFlexGrid7.0의 기본 상수 정의
'=================================================================================================
Const flexcpText=0	'Returns or sets the cell's text (or clip string for selections).
Const flexcpTextStyle=1	'Returns or sets the cell's text style (see CellTextStyle).
Const flexcpAlignment=2	'Returns or sets the cell's text alignment (see CellAlignment).
Const flexcpPicture=3	'Returns or sets the cell's picture (see CellPicture).
Const flexcpPictureAlignment=4	'Returns or sets the cell's picture alignment (see CellPictureAlignment).
Const flexcpChecked=5	'Returns or sets the state of the cell's check box (see CellChecked).
Const flexcpBackColor=6	'Returns or sets the cell's back color (see CellBackColor).
Const flexcpForeColor=7	'Returns or sets the cell's fore color (see CellForeColor).
Const flexcpFloodPercent=8	'Returns or sets the cell's flood percent (see CellFloodPercent).
Const flexcpFloodColor=9	'Returns or sets the cell's flood color (see CellFloodColor).
Const flexcpFont=10	'Returns or sets the cell's font.
Const flexcpFontSize=12
Const flexcpFontBold=13	'Returns or sets the cell's font.
'Const flexcpFont*	11-17	Returns or sets properties of the cell's font (see CellFontName etc).
Const flexcpFontUnderline=15
Const flexcpValue=18	'Returns the value of the cell's text (read-only).
Const flexcpTextDisplay=19	'Returns the cell's formatted text (read only).
Const flexcpData=20	'Returns or sets a Variant attached to the cell.
Const flexcpCustomFormat=21	'Returns True if the cell has custom formatting (set to False to remove all custom formatting).
Const flexcpLeft=22	'Returns a cell's left coordinate, in twips, taking merging into account (read-only).
Const flexcpTop=23	'Returns a cell's top coordinate, in twips, taking merging into account (read-only).
Const flexcpWidth=24	'Returns a cell's width, in twips, taking merging into account (read-only).
Const flexcpHeight=25	'Returns a cell's height, in twips, taking merging into account (read-only).
Const flexcpVariantValue=26	'Returns a double if the cell contains a numeric value or a string otherwise (read-only).
Const flexcpRefresh=27	'Set to True to force a cell or range to be

Const flexTextFlat=0	'Draw text normally.
Const flexTextRaised=1	'Draw text with a strong raised 3-D effect.
Const flexTextInset=2	'Draw text with a strong inset 3-D effect.
Const flexTextRaisedLight=3	'Draw text with a light raised 3-D effect.
Const flexTextInsetLight=4	'Draw text with a light inset 3-D effect.

Const flexAlignLeftTop=0
Const flexAlignLeftCenter=1
Const flexAlignLeftBottom=2
Const flexAlignCenterTop=3
Const flexAlignCenterCenter=4
Const flexAlignCenterBottom=5
Const flexAlignRightTop=6
Const flexAlignRightCenter=7
Const flexAlignRightBottom=8
Const flexAlignGeneral=9

Const flexPicAlignLeftTop=0
Const flexPicAlignLeftCenter=1
Const flexPicAlignLeftBottom=2
Const flexPicAlignCenterTop=3
Const flexPicAlignCenterCenter=4
Const flexPicAlignCenterBottom=5
Const flexPicAlignRightTop=6
Const flexPicAlignRightCenter=7
Const flexPicAlignRightBottom=8
Const flexPicAlignStretch=9
Const flexPicAlignTile=10

Const flexNoCheckbox=0	'The cell has no check box. This is the default setting.
Const flexChecked=1	'The cell has a check box that is checked.
Const flexUnchecked=2	'The cell has a check box that is not checked.

Const flexFillSingle=0	'Setting the Text property or any of the cell formatting properties affects the current cell only.
Const flexFillRepeat=1	'Setting the Text property or any of the cell formatting properties affects the entire selected range.

Const flexSTNone=0	'Outline only, no aggregate values
Const flexSTClear=1	'Clear all subtotals
Const flexSTSum=2	'Returns the sum of all numeric entries in the given range.
Const flexSTPercent=3	'Percent of total sum
Const flexSTCount=4	'Returns the number of numeric entries in the given range.
Const flexSTAverage=5	'Returns the average of all numeric entries in the given range.
Const flexSTMax=6	'Returns the maximum of all numeric entries in the given range.
Const flexSTMin=7	'Returns the minimum of all numeric entries in the given range.
Const flexSTStd=8	'Returns the standard deviation of all numeric entries in the given range.
Const flexSTVar=9	'Returns the variance of all numeric entries in the given range.

Const flexFreezeNone=0	'The user cannot change the number of frozen rows or columns.
Const flexFreezeColumns=1	'The user can change the number of frozen columns.
Const flexFreezeRows=2	'The user can change the number of frozen rows.
Const flexFreezeBoth=3	'The user can change the number of frozen rows and columns.

Const flexResizeNone=0	'The user may not resize rows or columns.
Const flexResizeColumns=1	'The user may resize column widths.
Const flexResizeRows=2	'The user may resize row heights.
Const flexResizeBoth=3	'The user may resize column widths and row heights.
Const flexResizeBothUniform=4	'The user may resize column widths and row heights. When a row height is resized, the new height is applied to all rows.

Const flexDTEmpty=0
Const flexDTNull=1
Const flexDTShort=2
Const flexDTLong=3
Const flexDTSingle=4
Const flexDTDouble=5
Const flexDTCurrency=6
Const flexDTDate=7
Const flexDTString=8
Const flexDTDispatch=9
Const flexDTError=10
Const flexDTBoolean=11
Const flexDTVariant=12
Const flexDTUnknown=13
Const flexDTDecimal=14
Const flexDTLong8=20
Const flexDTStringC=30
Const flexDTStringW=1

Const flexNoEllipsis=0	'Long strings are truncated, no ellipsis characters are displayed.
Const flexEllipsisEnd=1	'Ellipsis characters are displayed at the end of long strings.
Const flexEllipsisPath=2	'Ellipsis characters are displayed in the middle of long strings.

Const flexExNone=0	'No ExplorerBar. Fixed rows behave as usual.
Const flexExSort=1	'Users may sort columns by clicking on their headings.
Const flexExMove=2	'Users may move columns by dragging their headings.
Const flexExSortAndMove=3	'Users may sort and move columns.
Const flexExSortShow=5	'Users may sort columns by clicking on their headings. The control will show the current sorting order by drawing an arrow on the heading.
Const flexExSortShowAndMove=7	'Users may sort and move columns.  The control will show the current sorting order by drawing an arrow on the heading.
Const flexExMoveRows=8	'Allows movement of rows by dragging them by the fixed cells on the row. *

Const flexFocusNone=0	'Do not show a focus rectangle.
Const flexFocusLight=1	'Show a one-pixel wide focus rectangle.
Const flexFocusHeavy=2	'Show a two-pixel wide focus rectangle.
Const flexFocusSolid=3	'Show focus rectangle as a flat frame (the color is determined by the BackColorSel property).
Const flexFocusRaised=4	'Show focus rectangle as a raised frame.
Const flexFocusInset=5	'Show focus rectangle as an inset frame.

Const flexMergeNever=0	'Do not merge cells.
Const flexMergeFree=1	'Merge any adjacent cells with same contents (if they are on a row with RowMerge set to True or a column with MergeCol set to True).
Const flexMergeRestrictRows=2	'Merge rows only if cells above are also merged.
Const flexMergeRestrictColumns=3	'Merge columns only if cells to the left are also merged.
Const flexMergeRestrictAll=4	'Merge cells only if cells above or to the left are also merged.
Const flexMergeFixedOnly=5	'Merge only fixed cells. This setting is useful for setting up complex headers for the data and preventing the data itself from being merged.
Const flexMergeSpill=6	'Allow long entries to spill into empty adjacent cells.
Const flexMergeOutline=7	'Makes entries in subtotal rows spill to fill adjacent empty cells.  This setting is useful when you want to display only a node name on the outline nodes and data on the regular (non-node) rows.

Const flexOutlineBarNone=0	'No outline bar.
Const flexOutlineBarComplete=1	'Complete outline tree plus button row on top. (Buttons are only displayed if the OutlineBar is on a fixed column).
Const flexOutlineBarSimple=2	'Complete outline tree, no buttons across the top.
Const flexOutlineBarSymbols=3	'Outline symbols but no connecting lines.
Const flexOutlineBarCompleteLeaf=4	'Similar to flexOutlineBarComplete, but empty nodes are displayed without symbols.
Const flexOutlineBarSimpleLeaf=5	'Similar to flexOutlineBarSimple, but empty nodes are displayed without symbols.
Const flexOutlineBarSymbolsLeaf=6	'Similar to flexOutlineBarSymbols, but empty nodes are displayed without symbols.

Const flexScrollBarNone=0	'Do not display any scrollbars.
Const flexScrollBarHorizontal=1'Display a horizontal scrollbar.
Const flexScrollBarVertical=2	'Display a vertical scrollbar.
Const flexScrollBarBoth=3	'Display horizontal and vertical scrollbars.

Const flexSelectionFree=0	'Allows selections to be made as usual, spreadsheet-style.
Const flexSelectionByRow=1	'Forces selections to span entire rows. Useful for implementing record-based displays.
Const flexSelectionByColumn=2	'Forces selections to span entire columns. Useful for selecting ranges for a chart or fields for sorting.
Const flexSelectionListBox=3	'Similar to flexSelectionByRow, but allows non-continuous selections.CTRL-clicking with the mouse toggles the selection for an individual row. Dragging the mouse over a group of rows toggles their selected state.

Const flexSortNone=0	'Ignore this column when sorting. This setting is useful when you assign it to a column's Cols property, then set Sort to flexSortUseColSort.
Const flexSortGenericAscending=1	'Sort strings and numbers in ascending order.
Const flexSortGenericDescending=2	'Sort strings and numbers in descending order.
Const flexSortNumericAscending=3	'Sort numbers in ascending order.
Const flexSortNumericDescending=4	'Sort numbers in descending order.
Const flexSortStringNoCaseAscending=5	'Sort strings in ascending order, ignoring capitalization.
Const flexSortStringNoCaseDescending=6	'Sort strings in descending order, ignoring capitalization.
Const flexSortStringAscending=7	'Sort strings in ascending order.
Const flexSortStringDescending=8	'Sort strings in descending order.
Const flexSortCustom=9	'Fire a Compare event and use the return value to sort the columns.
Const flexSortUseColSort=10	'This setting allows you to use different settings for each column, as determined by the ColSort property. Using this setting, you may sort some columns in ascending and others in descending order.

Const flexSTBelow=0	'Subtotals are inserted below the data. This setting creates grids that look like reports.
Const flexSTAbove=1	'Subtotals are inserted above the data. This setting creates grids that look like outline trees (this is the default value).

Const flexGridNone=0	'Do not draw grid lines between cells.
Const flexGridFlat=1	'Draw flat lines with color and width determined by the GridColor and GridLineWidth properties.
Const flexGridInset=2	'Draw inset lines between cells.
Const flexGridRaised=3	'Draw raised lines between cells.
Const flexGridFlatHorz=4	'Draw flat lines between rows, no lines between columns.
Const flexGridInsetHorz=5	'Draw inset lines between rows, no lines between columns.
Const flexGridRaisedHorz=6	'Draw raised lines between rows, no lines between columns.
Const flexGridSkipHorz=7	'Draw an inset effect around every other row.
Const flexGridFlatVert=8	'Draw flat lines between columns, no lines between rows.
Const flexGridInsetVert=9	'Draw inset lines between columns, no lines between rows.
Const flexGridRaisedVert=10	'Draw raised lines between columns, no lines between rows.
Const flexGridSkipVert=11	'Draw an inset effect around every other column.
Const flexGridExplorer=12	'Draw button-like frames around each cell.
Const flexGridExcel=13	'Draw button-like frames around each cell, highlighting the headings for the current selection. This setting should only be applied to the GridLinesFixed property.

Const flexOleDropNone =0	'The control does not accept OLE drops and displays the No Drop cursor.
Const flexOleDropManual=1	'The target component triggers the OLE drop events, allowing the programmer to handle the OLE drop operation in code.
Const flexOleDropAutomatic=2	'The control automatically accepts OLE drops if the DataObject object contains data in string or file formats.

Const flexOLEDragManual=0	'When OLEDragMode is set to flexOleDragManual, you must call the OleDrag method to start dragging, which then triggers the OLEStartDrag event. A good place to call the OLEDrag method is in response to the BeforeMouseDown event.
Const flexOLEDragAutomatic=1	'When OLEDragMode is set to flexOleDragAutomatic, the control fills a DataObject object with the data it contains and sets the effects parameter before initiating the OLEStartDrag event when the user attempts to drag out of the control. This gives you control over the drag/drop operation and allows you to intercede by adding or modifying the data that is being dragged.

Const flexNTRoot=0	'Returns the index of the node's top level ancestor.
Const flexNTParent=1	'Returns the index of the node's immediate parent.
Const flexNTFirstChild=2	'Returns the index of the node's first child node.
Const flexNTLastChild=3	'Returns the index of the node's last child node.
Const flexNTFirstSibling=4	'Returns the index of the node's first sibling node (may be same row)
Const flexNTLastSibling=5	'Returns the index of the node's last sibling node (may be same row)
Const flexNTPreviousSibling=6	'Returns the index of the node's previous sibling node (-1 if this is the first sibling)
Const flexNTNextSibling=7	'Returns the index of the node's next sibling node (-1 if this is the last sibling)

Const flexOutlineExpanded=0	'The node is expanded: all subordinate nodes are visible.
Const flexOutlineSubtotals=1	'The node is partially expanded: subordinates nodes are visible but collapsed.
Const flexOutlineCollapsed=2	'The node is collapsed: all subordinate nodes are hidden.

Const vbDropEffectNone=0	'Drop operation was cancelled.
Const vbDropEffectCopy=1	'Drop results in a copy from the source to the target. The original data remains.
Const vbDropEffectMove=2	'Drop moves the data from the source to the target. The original data should be deleted.

Const flexFlat=0
Const flex3D=1

Const flexBorderNone=0
Const flexBorderFlat=1

Const flexAutoSizeColWidth=0	'Adjust column widths to accommodate the widest entry in each column.
Const flexAutoSizeRowHeight=1	'Adjust row heights to accommodate the longest entry in each row.

Const flexHighlightNever=0	'Never highlight the selected range. Selected ranges will not be visible to the user.
Const flexHighlightAlways=1	'Always highlight the selected range.
Const flexHighlightWithFocus=2	'Highlight the selected range only when the control has the

Const flexFileAll=0	'Save all data and formatting information.
Const flexFileData=1	'Save only the data, ignoring formatting information.
Const flexFileFormat=2	'Save only the global formatting, ignoring the data.
Const flexFileCommaText=3	'Save data to a comma-delimited text file.
Const flexFileTabText=4	'Save data to a tab-delimited text file.
Const flexFileCustomText=5	'Save data to a text file using the delimiters specified by the ClipSeparators property.
Const flexFileExcel=6	'Load a sheet from an Excel97 file (you can specify which sheet to load using the Options parameter).

Const flexODNone=0	'The control performs all drawing itself. The DrawCell event does not get fired at all. (This is the default setting.)
Const flexODOver=1	'The control draws the cell, then fires the DrawCell event so the application can add text or graphics over the default cell contents.
Const flexODContent=2	'The control draws the cell background, including any pictures, but no text. It fires the DrawCell event so the application can draw the text.
Const flexODComplete=3	'The control draws nothing at all in the cell. It fires the DrawCell event and the application is responsible for drawing the entire cell.
Const flexODOverFixed=4	'Similar to flexODOver, except only fixed cells are owner-drawn.
Const flexODContentFixed=5	'Similar to flexODContent, except only fixed cells are owner-drawn.
Const flexODCompleteFixed=6	'Similar to flexODComplete, except only fixed cells are owner-drawn.

Const flexEDNone=0
Const flexEDKbd=1
Const flexEDKbdMouse=2