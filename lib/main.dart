import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:family/controller/stting_controller.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/utilities/functions/api_function.dart';
import 'package:family/utilities/services/app_services.dart';
import 'package:family/view/screens/splash_screen.dart';
void main() async {
 WidgetsFlutterBinding.ensureInitialized();//familyService$1
  await Future.wait([AppService.mainInit()]);
  Get.put(SettingController(),permanent: true);
  Get.lazyPut(()=>Crud(),fenix: true);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title:"الأسر المنتجة",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar'), Locale('en')],
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          fontFamily: ArabicFont.changa),
      locale: const Locale('ar', 'YE'),
      home: const SplashScreen(),
    );
  }
}
