import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:responsive_framework/responsive_framework.dart';


import 'init_all.dart';
import 'init_main.dart';
import 'wallpaper_app/core/styles/colors.dart';
import 'wallpaper_app/core/styles/theme.dart';
import 'wallpaper_app/features/presentation/pages/wallpaper_home_page.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  //Assign publishable key to flutter_stripe
  // Stripe.publishableKey =
  //     "pk_test_51LJESJINsLzJqHMhqtE67EcJtmY2sLrg8EQFj9QfU6Qfvn8rBcr1ZoUKCv16eaW0mASMnim60zajvWmHQ15SzVif00VbdD1Ym6";

  //Load our .env file that contains our Stripe Secret key
  // await dotenv.load(fileName: "assets/.env");
  await initMain();
  await initAll();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme(context),
      color: AppColors.primaryColor,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: WallpaperHomePage(),
    );
  }
}
