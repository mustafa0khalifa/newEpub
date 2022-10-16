// @dart=2.9

import 'package:t1t1/view_model/home_view_model.dart';
import 'package:t1t1/view/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';

void main() {
  final app = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeViewModel()),
    ],
    child: const MyApp(),
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // convert app to english to fit with folioreader not work with arabic device
    // go to vocsy_epub_viewer plugin in android folder to set config channel add this code below to fit with arabic devices
    // to epubViewerplugin.java in java folder in line 128
    //###//

    // Resources res = context.getResources();
    // DisplayMetrics dm = res.getDisplayMetrics();
    // android.content.res.Configuration conf = res.getConfiguration();
    // conf.setLocale(new Locale("en")); // API 17+ only.
    // res.updateConfiguration(conf, dm);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('en'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      supportedLocales: [const Locale('en')],
      home: const HomeView(),
    );
  }
}
