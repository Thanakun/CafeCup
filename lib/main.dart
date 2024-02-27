import 'package:coffee_application/data/network/cookie-manager.dart';
import 'package:coffee_application/hive/boxes.dart';
import 'package:coffee_application/hive/users.dart';
import 'package:coffee_application/provider/customer-provider.dart';
import 'package:coffee_application/provider/shop_provider.dart';
import 'package:coffee_application/screen/customer_register_second_view.dart';
import 'package:coffee_application/screen/customer_register_third_view.dart';
import 'package:coffee_application/screen/customer_register_view.dart';
import 'package:coffee_application/screen/customer_home_view.dart';
import 'package:coffee_application/screen/garph_shop/bar_chart.dart';
import 'package:coffee_application/screen/login.dart';
import 'package:coffee_application/screen/my_component/graph_shop.dart';
import 'package:coffee_application/screen/register.dart';
import 'package:coffee_application/screen/shop_register/shop_register_second_view.dart';
import 'package:coffee_application/screen/shop_register/shop_register_third_view.dart';
import 'package:coffee_application/screen/splash-screen.dart';
import "package:flutter/material.dart";
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UsersAdapter());
  boxUsers = await Hive.openBox<Users>('users');
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
          title: "CAFE CUP",
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
              fontFamily: 'Open Sans',
              visualDensity: VisualDensity.adaptivePlatformDensity),
          home: SplashScreen()),
    );
  }
}
