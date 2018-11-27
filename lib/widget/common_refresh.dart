import 'package:flutter/material.dart';
import 'package:flutter_module/widget/common_refresh_header.dart';
import 'package:flutter_module/widget/common_refresh_loading.dart';
import 'package:flutter_module/widget/refresh/refresh_indicator.dart';

typedef RefreshCallback = Future<void> Function();

class CommonRefresh extends StatefulWidget {
  const CommonRefresh({
    Key key,
    @required this.child,
    this.maxRefreshHeight = 100.0,
    @required this.onRefresh,
    @required this.onLoad,
    this.refreshWidget,
    this.loadingWidget,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.onRefreshStatusCallback,
    this.refreshController,
    this.loadingController,
  })  : assert(child != null),
        assert(onRefresh != null),
        assert(notificationPredicate != null),
        super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// The refresh indicator will be stacked on top of this child. The indicator
  /// will appear when child's Scrollable descendant is over-scrolled.
  ///
  /// Typically a [ListView] or [CustomScrollView].
  final Widget child;

  final Widget refreshWidget;

  final Widget loadingWidget;

  final RefreshController refreshController;

  final RefreshController loadingController;

  /// The distance from the child's top or bottom edge to where the refresh
  /// indicator will settle. During the drag that exposes the refresh indicator,
  /// its actual displacement may significantly exceed this value.
  final double maxRefreshHeight;

  final RefreshCallback onRefresh;

  final LoadingCallback onLoad;

  /// A check that specifies whether a [ScrollNotification] should be
  /// handled by this widget.
  ///
  /// By default, checks whether `notification.depth == 0`. Set it to something
  /// else for more complicated layouts.
  final ScrollNotificationPredicate notificationPredicate;

  final OnRefreshStatusCallback onRefreshStatusCallback;

  @override
  CommonRefreshState createState() => CommonRefreshState();
}

class CommonRefreshState extends State<CommonRefresh>
    with TickerProviderStateMixin {
  GlobalKey<RefreshIndicator2State> _key = new GlobalKey();

  double _refreshPercent = 0.0;
  bool _refreshAutoPlay = false;

  RefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = new RefreshController();
    _refreshController.addListener(() {
      setState(() {
        _refreshPercent = _refreshController.percent;
        if (widget.refreshController != null) {
          widget.refreshController.percent = _refreshPercent;
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController.dispose();
  }

  void show() {
    _key.currentState.show();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator2(
        key: _key,
        child: widget.child,
        onRefresh: widget.onRefresh,
        onLoad: widget.onLoad,
        refreshController: _refreshController,
        refreshWidget: CommonRefreshHeader(
          isAutoPlay: _refreshAutoPlay,
          fraction: _refreshPercent,
        ),
        loadingController: widget.loadingController,
        loadingWidget: CommonRefreshLoading(),
        maxRefreshHeight: widget.maxRefreshHeight,
        onRefreshStatusCallback: (mode) {
          if (mode == RefreshIndicatorMode.snap || mode== RefreshIndicatorMode.refresh) {
            setState(() {
              _refreshAutoPlay = true;
            });
          } else {
            setState(() {
              _refreshAutoPlay = false;
            });
          }
          if (widget.onRefreshStatusCallback != null) {
            widget.onRefreshStatusCallback(mode);
          }
        });
  }
}
