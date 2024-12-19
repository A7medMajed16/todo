import 'package:flutter/material.dart';

mixin TabControllerManager {
  TabController? _tabController;

  void initTabController(TickerProvider vsync) {
    _tabController?.dispose();
    _tabController = TabController(length: 4, vsync: vsync);
  }

  TabController? get tabController => _tabController;

  void disposeTabController() {
    _tabController?.dispose();
    _tabController = null;
  }
}
