import 'package:comindors/Api/ApiAdmin.dart';
import 'package:comindors/Api/ApiPay.dart';
import 'package:comindors/Api/ApiPayAdmin.dart';
import 'package:comindors/Api/ApiPayDetails.dart';
import 'package:comindors/Api/ApiRekening.dart';
import 'package:comindors/Login/LoginScreen.dart';
import 'package:comindors/Page/SplashPage.dart';
import 'package:comindors/Page/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'Api/ApiOutlet.dart';
import 'Ui/Warna.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0.20), //top bar color
      ),
    );

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ApiOutlet>(
          create: (_) => ApiOutlet(),
        ),
        ChangeNotifierProvider<ApiRekening>(
          create: (_) => ApiRekening(),
        ),
        ChangeNotifierProvider<ApiPayment>(
          create: (_) => ApiPayment(),
        ),
        ChangeNotifierProvider<ApiPayAdmin>(
          create: (_) => ApiPayAdmin(),
        ),
        ChangeNotifierProvider<ApiAdmin>(
          create: (_) => ApiAdmin(),
        ),
        ChangeNotifierProvider<ApiPayDetails>(
          create: (_) => ApiPayDetails(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('id', ''), // English, no country code
          Locale('en', ''), // Spanish, no country code
        ],
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Warna.BiruPrimary,
          ),
          fontFamily: 'QuickSand',
          accentColor: Warna.BiruPrimary,
          primaryColor: Warna.BiruPrimary,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Warna.BiruPrimary,
            primary: Warna.BiruPrimary, //<-- SEE HERE
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Warna.BiruPrimary,
        ),
        home: SplashPage(),
      ),
    );
  }
}
