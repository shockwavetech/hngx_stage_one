import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final backgroundColor = Colors.grey.withOpacity(0.6);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreenUtilInit(
          designSize: const Size(800, 1280),
          builder: (context, child){
            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: backgroundColor,
                    child: ClipPath(
                      clipper: SemiCircleClipper(),
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/dp.jpeg'),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: backgroundColor,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Row(),
                        Text('Marshal Moses', style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w900),),
                        Text('Flutter Developer', style: TextStyle( fontSize: 30.sp, color: Colors.blueGrey, fontWeight: FontWeight.w900),),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blueGrey, // Change this color to the desired text color
                            ),
                            onPressed: ()async{
                              String url = 'https://github.com/shockwavetech';
                              final finalUrl = Uri.parse(url);
                              Future.delayed(const Duration(seconds: 0), ()async{
                                if(await canLaunchUrl(finalUrl)){
                                  await launchUrl(finalUrl, mode: LaunchMode.inAppWebView);
                                }
                              });
                            },
                            child: const Text('Open Github'))
                      ],
                    ),
                  ),
                ),


                // Container(
                //   height: 200.0,
                //   color: Colors.green,
                // ),
              ],
            );
          },
        )
      ),
    );
  }
}


class SemiCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    final path = Path();
    path.lineTo(0, height * 0.8);
   path.quadraticBezierTo(
       width * 0.5,
       height,
       width,
       height * 0.8); //// point two

    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


