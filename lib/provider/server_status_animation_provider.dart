import 'package:flutter/material.dart';

class ServerStatusAnimationProvider extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  bool showOnAppBar = false;

  ServerStatusAnimationProvider() {
    scrollControler.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollControler.offset > 60.0 && !showOnAppBar) {
      showOnAppBar = true;
      notifyListeners();
    } else if (scrollControler.offset <= 60.0 && showOnAppBar) {
      showOnAppBar = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollControler.dispose();
    super.dispose();
  }

  ScrollController get scrollControler => _scrollController;
}
