import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:webview_demo_app/core/news_screen/news_screen_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';


class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with AutomaticKeepAliveClientMixin<NewsScreen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller.addListener(() {
    //   print(controller.page);
    // });
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView() ;
    }
  }



  final Completer<WebViewController> _controller = Completer<WebViewController>();

  List<String> webURLS = [
    "https://www.inshorts.com/en/news/rbi-extends-ontap-liquidity-scheme-for-contact-intensive-sectors-till-june-30-1644476324089",
    "https://www.inshorts.com/en/news/cant-believe-kohli-was-caught-behind-in-whiteball-cricket-kaif-1644477191695",
    "https://www.inshorts.com/en/news/what-are-the-key-takeaways-from-rbis-monetary-policy-announcement-1644474219193",
    "https://www.inshorts.com/en/news/raj-up-haryana-industries-must-shift-to-clean-fuels-by-sept-30-caqm-1644473806673",
    "https://www.inshorts.com/en/news/adani-wilmar-now-among-top-100-mostvaluable-publicly-listed-indian-firms-1644476127223",
    "https://www.inshorts.com/en/news/10780-seats-remained-vacant-in-iits-in-last-2-academic-sessions-govt-1644475139997",
    "https://www.inshorts.com/en/news/rishabh-pant-is-better-off-as-finisher-rahul-as-opener-gavaskar-1644474685860",
    "https://www.inshorts.com/en/news/felt-like-a-chess-game-labuschagne-on-facing-ashwin-in-202021-1644474385425",
    "https://www.inshorts.com/en/news/some-players-will-be-hard-to-get-back-rcbs-mike-hesson-on-ipl-auction-1644477151143",
    "https://www.inshorts.com/en/news/rbi-governor-das-quotes-lata-mangeshkars-song-aaj-phir-jeene-ki-tamanna-hai-in-speech-1644473723368",
  ];

  int? currentIndex = 0;
  bool isStoryLoading = true;

  PageController controller = PageController(viewportFraction: 1, keepPage: true);



  @override
  Widget build(BuildContext context) {
    print("News screen");
    final newsScreenProvider = Provider.of<NewsScreenProvider>(context);
    return Scaffold(
              body: Stack(
                children: [
                   PageView.builder(
                     controller: controller,
                    itemCount: webURLS.length,
                    dragStartBehavior: DragStartBehavior.down,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                      onPageChanged: (value){
                          print(value);
                          print(controller.page!.toInt());
                          print("==============");
                          currentIndex = value;
                      },
                      itemBuilder: (context,index){
                        return Container(
                          margin: EdgeInsets.all(10.0.sp),

                          child: WebView(
                              initialUrl: webURLS[index],
                              onPageStarted: (value){
                                print(controller.page!.toInt());
                                print(index);
                                if(controller.page!.toInt() == index || controller.page!.toInt()+1 == index) {
                                  setState(() {
                                    isStoryLoading = true;
                                  });
                                }else{
                                  setState(() {
                                    isStoryLoading = false;
                                  });
                                }
                              },
                              onPageFinished: (value){
                                setState(() {
                                  isStoryLoading = false;
                                });
                              },
                            // navigationDelegate: (navigationRequest){
                            //     return navigationRequest
                            // },
                              javascriptMode: JavascriptMode.unrestricted,
                            ),
                        );
                      }
                  ),
                  isStoryLoading ? const Center(child: CircularProgressIndicator(),) : Container(),
                  Positioned(
                    bottom: 10.0,
                    right: 10.0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.0,color: Color.fromRGBO(18, 82, 255, 1.0).withOpacity(0.2)),
                        shape: BoxShape.circle,
                      ),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: (){
                          if(!newsScreenProvider.savedURLs.contains(webURLS[currentIndex!])) {
                            newsScreenProvider.saveNews(webURLS[currentIndex!]);
                            print(newsScreenProvider.savedURLs.length);
                            Fluttertoast.showToast(
                                msg: "Story saved ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black.withOpacity(0.8),
                                textColor: Colors.white,
                                fontSize: 16.0.sp,
                            );
                          }else{
                            Fluttertoast.showToast(
                              msg: "Already saved",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black.withOpacity(0.8),
                              textColor: Colors.white,
                              fontSize: 16.0.sp,
                            );
                          }
                        },
                        elevation: 10.0,
                        child: Icon(Icons.bookmark,color: const Color.fromRGBO(18, 82, 255, 1.0),),
                      ),
                    ),
                  ),
                ],
              ),

    );
  }

  @override
  bool get wantKeepAlive => true;
}

