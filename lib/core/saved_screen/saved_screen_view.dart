import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:webview_demo_app/core/news_screen/news_screen_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  int? currentIndex = 0;
  bool isStoryLoading = true;

  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Saved screen");
    final newsScreenProvider = Provider.of<NewsScreenProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Saved',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: false,
          elevation: 1.0,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            newsScreenProvider.savedURLs.isEmpty
                ? const Center(
                    child: Text('No Saved Stories'),
                  )
                : PageView.builder(
                    controller: controller,
                    itemCount: newsScreenProvider.savedURLs.length,
                    dragStartBehavior: DragStartBehavior.down,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value) {
                      print(value);
                      print(controller.page!.toInt());
                      print("==============");
                      currentIndex = value;
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10.0.sp),
                        child: WebView(
                          initialUrl: newsScreenProvider.savedURLs[index],
                          onPageStarted: (value) {
                            print(controller.page!.toInt());
                            print(index);
                            if (controller.page!.toInt() == index ||
                                controller.page!.toInt() + 1 == index) {
                              setState(() {
                                isStoryLoading = true;
                              });
                            } else {
                              setState(() {
                                isStoryLoading = false;
                              });
                            }
                          },
                          onPageFinished: (value) {
                            setState(() {
                              isStoryLoading = false;
                            });
                          },
                          javascriptMode: JavascriptMode.unrestricted,
                        ),
                      );
                    }),
            newsScreenProvider.savedURLs.isEmpty
                ? Container()
                : isStoryLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
          ],
        ));
  }
}
