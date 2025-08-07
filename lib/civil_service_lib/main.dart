import 'package:flutter/material.dart';
import 'widgets.dart';
import 'outline.dart';

class CivilServiceMain extends StatelessWidget {
  const CivilServiceMain({super.key});

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
            child: CivilServiceMachine()
          ),
        );
      },
    );
  }
}