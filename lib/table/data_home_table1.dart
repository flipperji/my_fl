import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'scroll_shadow_model.dart';

///
/// For sorting issue, will based on the header fixed widget for flexible handling, suggest using [FlatButton] to control the data sorting
///
///
class HorizontalDataTable1 extends StatefulWidget {
  final double leftHandSideColumnWidth;
  final double rightHandSideColumnWidth;

  ///if headerWidgets==true,
  ///HorizontalDataTable.headerWidgets[0] as the left hand side header
  ///
  /// if headerWidgets==false
  /// header handling will handle by the itembuilder or the first child -> index == 0
  ///
  /// if no header needed, just ignore this, start data from index ==0
  ///
  final bool isFixedHeader;
  final List<Widget> headerWidgets;

  ///Direct create children
  final List<Widget> leftSideChildren;
  final List<Widget> rightSideChildren;

  ///Suggest use builder for easier manage, like data update
  final int itemCount;
  final IndexedWidgetBuilder leftSideItemBuilder;
  final IndexedWidgetBuilder rightSideItemBuilder;

  ///Row Divider
  ///This is apply to all remaining data row of the list view
  final Widget rowSeparatorWidget;

  ///Elevation for the shadow of header row and first column after scroll
  ///If don't want to show the shadow, please set it to 0.0
  final double elevation;
  final Color elevationColor;

  final Color leftHandSideColBackgroundColor;
  final Color rightHandSideColBackgroundColor;

  const HorizontalDataTable1({
    @required this.leftHandSideColumnWidth,
    @required this.rightHandSideColumnWidth,
    this.isFixedHeader = false,
    this.headerWidgets,
    this.leftSideItemBuilder,
    this.rightSideItemBuilder,
    this.itemCount = 0,
    this.leftSideChildren,
    this.rightSideChildren,
    this.rowSeparatorWidget = const Divider(
      color: Colors.transparent,
      height: 0.0,
      thickness: 0.0,
    ),
    this.elevation = 3.0,
    this.elevationColor = Colors.black54,
    this.leftHandSideColBackgroundColor = Colors.white,
    this.rightHandSideColBackgroundColor = Colors.white,
  })
      : assert(
  (leftSideChildren == null && leftSideItemBuilder != null) ||
      (leftSideChildren == null),
  'Either using itemBuilder or children to assign left side widgets'),
        assert(
        (rightSideChildren == null && rightSideItemBuilder != null) ||
            (rightSideChildren == null),
        'Either using itemBuilder or children to assign right side widgets'),
        assert((isFixedHeader && headerWidgets != null) || !isFixedHeader,
        'If use fixed top row header, isFixedHeader==true, headerWidgets must not be null'),
        assert(itemCount >= 0, 'itemCount must >= 0'),
        assert(elevation >= 0.0, 'elevation must >= 0.0'),
        assert(elevationColor != null, 'elevationColor must not be null');

  @override
  State<StatefulWidget> createState() {
    return _HorizontalDataTable1State();
  }
}

class _HorizontalDataTable1State extends State<HorizontalDataTable1> {
  ScrollController _leftHandSideListViewScrollController = ScrollController();
  ScrollController _rightHandSideListViewScrollController = ScrollController();
  ScrollController _rightHorizontalScrollController = ScrollController();
  _SyncScrollControllerManager _syncScroller = _SyncScrollControllerManager();
  ScrollShadowModel _scrollShadowModel = ScrollShadowModel();

  @override
  void initState() {
    super.initState();
    _syncScroller
        .registerScrollController(_leftHandSideListViewScrollController);
    _syncScroller
        .registerScrollController(_rightHandSideListViewScrollController);
    _leftHandSideListViewScrollController.addListener(() {
      _scrollShadowModel.verticalOffset =
          _leftHandSideListViewScrollController.offset;
      setState(() {});
    });
    _rightHorizontalScrollController.addListener(() {
      _scrollShadowModel.horizontalOffset =
          _rightHorizontalScrollController.offset;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _syncScroller
        .unregisterScrollController(_leftHandSideListViewScrollController);
    _syncScroller
        .unregisterScrollController(_rightHandSideListViewScrollController);
    _leftHandSideListViewScrollController.dispose();
    _rightHandSideListViewScrollController.dispose();
    _rightHorizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScrollShadowModel>(
        create: (context) => _scrollShadowModel,
        child: SafeArea(child: LayoutBuilder(
          builder: (context, boxConstraint) {
            return _getParallelListView(
                boxConstraint.maxWidth, boxConstraint.maxHeight);
          },
        )));
  }

  Widget _getParallelListView(double width, double height) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: widget.leftHandSideColumnWidth,
          height: height,
          width: width - widget.leftHandSideColumnWidth,
          child: SingleChildScrollView(
            controller: _rightHorizontalScrollController,
            child: Container(
              color: widget.rightHandSideColBackgroundColor,
              child: _getRightSideHeaderScrollColumn(),
              width: widget.rightHandSideColumnWidth,
            ),
            scrollDirection: Axis.horizontal,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          height: height,
          width: widget.leftHandSideColumnWidth,
          child: Container(
            width: widget.leftHandSideColumnWidth,
            child: _getLeftSideFixedHeaderScrollColumn(),
          ),
        ),
      ],
    );
  }

  Widget _getLeftSideFixedHeaderScrollColumn() {
    return _getScrollColumn(_getLeftHandSideListView(),
        this._leftHandSideListViewScrollController);
  }

  Widget _getRightSideHeaderScrollColumn() {
    return _getScrollColumn(_getRightHandSideListView(),
        this._rightHandSideListViewScrollController);
  }

  Widget _getScrollColumn(Widget child, ScrollController scrollController) {
    return NotificationListener<ScrollNotification>(
      child: child,
      onNotification: (ScrollNotification scrollInfo) {
        _syncScroller.processNotification(scrollInfo, scrollController);
        return false;
      },
    );
  }

  Widget _getRightHandSideListView() {
    return _getListView(
        _rightHandSideListViewScrollController,
        widget.rightSideItemBuilder,
        widget.itemCount,
        widget.rightSideChildren);
  }

  Widget _getLeftHandSideListView() {
    return _getListView(_leftHandSideListViewScrollController,
        widget.leftSideItemBuilder, widget.itemCount, widget.leftSideChildren);
  }

  Widget _getListView(ScrollController scrollController,
      IndexedWidgetBuilder indexedWidgetBuilder, int itemCount,
      [List<Widget> children]) {
    if (indexedWidgetBuilder != null) {
      return ListView.separated(
        controller: scrollController,
        itemBuilder: indexedWidgetBuilder,
        itemCount: itemCount,
        separatorBuilder: (context, index) {
          return widget.rowSeparatorWidget;
        },
      );
    } else {
      return ListView(
        controller: scrollController,
        children: children,
      );
    }
  }

  double _getElevation(double offset) {
    if (offset != null) {
      double elevation = offset > widget.elevation ? widget.elevation : offset;
      if (elevation >= 0) {
        return elevation;
      }
    }
    return 0.0;
  }
}

class _SyncScrollControllerManager {
  List<ScrollController> _registeredScrollControllers =
  new List<ScrollController>();

  ScrollController _scrollingController;
  bool _scrollingActive = false;

  void registerScrollController(ScrollController controller) {
    _registeredScrollControllers.add(controller);
  }

  void unregisterScrollController(ScrollController controller) {
    _registeredScrollControllers.remove(controller);
  }

  void processNotification(
      ScrollNotification notification, ScrollController sender) {
    if (notification is ScrollStartNotification && !_scrollingActive) {
      _scrollingController = sender;
      _scrollingActive = true;
      return;
    }

    if (identical(sender, _scrollingController) && _scrollingActive) {
      if (notification is ScrollEndNotification) {
        _scrollingController = null;
        _scrollingActive = false;
        return;
      }

      if (notification is ScrollUpdateNotification) {
        _registeredScrollControllers.forEach((controller) {
          if (!identical(_scrollingController, controller)) {
            if (controller.hasClients) {
              controller.jumpTo(_scrollingController.offset);
            } else {}
          }
        });
        return;
      }
    }
  }
}