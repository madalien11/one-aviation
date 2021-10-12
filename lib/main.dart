import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'src/common/dependencies/injection_container.dart';
import 'src/constants/material_theme.dart';
import 'src/routes/routes.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('tokens');

  initGetIt();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static Routes router = Routes();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        ],
        background: Container(color: Color(0xFFF5F5F5)),
      ),
      onGenerateRoute: router.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'ONE Aviation',
      theme: appThemeData,
    );
  }
}
