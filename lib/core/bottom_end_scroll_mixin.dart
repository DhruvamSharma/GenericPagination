import 'package:flutter/widgets.dart';

mixin BottomEndScrollMixin {

    // you can play around with this number
    double _paginationOffset = 200;

    void onScroll(ScrollNotification notification, {VoidCallback? onEndReached}) {
    if (_isAtBottom(notification)) {
      // you can paginate
      onEndReached?.call();
    }
  }

  set paginationOffset(double value) => _paginationOffset = value;

  bool _isAtBottom(ScrollNotification notification) {
    final maxScrollExtent = notification.metrics.maxScrollExtent;
    final currentScrollExtent = notification.metrics.pixels;
    return currentScrollExtent >= maxScrollExtent - _paginationOffset;
  }
}