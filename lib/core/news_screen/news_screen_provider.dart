import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsScreenProvider with ChangeNotifier{
   WebViewController? wvController;

   List<String> savedURLs = [];

   saveNews(String value) {
    savedURLs.add(value);
    notifyListeners();
  }
}