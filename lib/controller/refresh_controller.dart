import 'dart:async';

class RefreshController {
  StreamController _refreshController = new StreamController.broadcast();

  Stream get refreshStream => _refreshController.stream;

  /*void onClose() {
    _refreshController.close();
  }*/

  void refresh() {
    _refreshController.sink.add('Refresh');
  }
}

final refreshController = RefreshController();
