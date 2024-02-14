import 'package:coffee_application/data/network/cookie-manager.dart';
import 'package:coffee_application/provider/customer-provider.dart';
import 'package:coffee_application/provider/shop_provider.dart';
import 'package:coffee_application/screen/customer_register_second_view.dart';
import 'package:coffee_application/screen/customer_register_third_view.dart';
import 'package:coffee_application/screen/customer_register_view.dart';
import 'package:coffee_application/screen/customer_shop_view.dart';
import 'package:coffee_application/screen/garph_shop/bar_chart.dart';
import 'package:coffee_application/screen/login.dart';
import 'package:coffee_application/screen/my_component/graph_shop.dart';
import 'package:coffee_application/screen/register.dart';
import 'package:coffee_application/screen/splash-screen.dart';
import "package:flutter/material.dart";
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TokenManager.instance.initToken();
  runApp(EasyLocalization(
    startLocale: const Locale('th', 'TH'),
    path: 'assets/locales',
    fallbackLocale: const Locale('th', 'TH'),
    supportedLocales: const [Locale('en', 'US'), Locale('th', 'TH')],
    saveLocale: true,
    child: const MyApp(),
  ));
}

//สร้าง widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShopProvider>(
          create: (context) => ShopProvider(),
        ),
        ChangeNotifierProvider<CustomerProvider>(
          create: (context) => CustomerProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'APP_TITLE'.tr(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
              fontFamily: 'Open Sans',
              visualDensity: VisualDensity.adaptivePlatformDensity
              // fontFamily: GoogleFonts.kanit().fontFamily
              ),
          // color: Color.fromRGBO(0, 0, 0, 1),
          // theme: ThemeData(
          //     primarySwatch: Color.fromARGB(0, 0, 0, 255)),
          // initialRoute: RoutesName.splash,
          // onGenerateRoute: Routes.generateRoute,
          home: SplashScreen()),
    );
  }
}
