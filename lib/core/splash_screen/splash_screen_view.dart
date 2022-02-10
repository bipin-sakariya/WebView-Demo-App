import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:webview_demo_app/core/home_screen/home_screen_view.dart';
import 'package:webview_demo_app/core/news_screen/news_screen_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_)async{
      await Future.delayed(const Duration(seconds: 1,milliseconds: 500),(){
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => ScreenUtilInit(
              designSize: const Size(360, 690),
              builder: () {
                return MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                          create: (context) => NewsScreenProvider()),
                    ],
                    child: HomeScreen()
                );
              }),
              transitionDuration: Duration.zero,
            ),
            );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flow news',
              style: TextStyle(
                fontFamily: 'DancingScript-Regular',
                fontSize: 40.0.sp,
                color: const Color.fromRGBO(18, 82, 255, 1.0),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0.h,),
            Text(
              'Consume News in Seconds',
              style: TextStyle(
                fontSize: 22.0.sp,
                letterSpacing: 1.25
              ),
            ),
          ],
        ),
      ),
    );
  }
}
