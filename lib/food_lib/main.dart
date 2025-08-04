// lib/main.dart
import 'package:flutter/material.dart';
import 'burger_kio/screens/first_page.dart';
import 'burger_kio/screens/second_page.dart';
import 'burger_kio/screens/third_page.dart';
import 'burger_kio/screens/fourth_page.dart';
import 'burger_kio/screens/fifth_page.dart';
import 'burger_kio/screens/sixth_page.dart'; // SixthPage 임포트 추가
import 'burger_kio/utils.dart';

class FoodMain extends StatelessWidget {
  const FoodMain({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double deviceWidth = constraints.maxWidth;
        final double deviceHeight = constraints.maxHeight;

        const double aspectRatio = baseScreenWidth / baseScreenHeight;

        final double maxAppWidth = baseScreenWidth * 2;
        final double maxAppHeight = baseScreenHeight * 2;

        double appWidth = deviceWidth;
        double appHeight = deviceHeight;

        if (appWidth > maxAppWidth) appWidth = maxAppWidth;
        if (appHeight > maxAppHeight) appHeight = maxAppHeight;

        if (appWidth / appHeight > aspectRatio) {
          appWidth = appHeight * aspectRatio;
        } else {
          appHeight = appWidth / aspectRatio;
        }

        SizeConfig().init(context, actualAppSize: Size(appWidth, appHeight));

        return Center(
          child: SizedBox(
            width: appWidth,
            height: appHeight,
            child: MaterialApp(
              title: 'Kiosk App',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: '/',
              routes: {
                '/': (context) => const FirstPage(),
                '/second': (context) => const SecondPage(),
                '/third': (context) => const ThirdPage(),
                '/fourth': (context) => const FourthPage(orderList: [], totalAmount: 0),
                '/fifth': (context) {
                  final int totalAmountFromFourthPage = ModalRoute.of(context)!.settings.arguments as int? ?? 0;
                  return FifthPage(finalTotalAmount: totalAmountFromFourthPage);
                },
                '/sixth': (context) => const SixthPage(), // SixthPage 라우트 추가
              },
            ),
          ),
        );
      },
    );
  }
}