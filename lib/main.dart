import 'package:admin/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Routes/pages.dart';
import 'firebase_options.dart';

void main() async {
  await GetStorage.init();
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // initMeeduPlayer(logLevel: MPVLogLevel.error);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Investor Admin Panel',
      getPages: AppPages.routes,
      initialRoute: AppPages.INITIAL,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: bgColor,
        // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
        //     // .apply(bodyColor: Colors.white),
        //     .apply(bodyColor: textColor),
        canvasColor: secondaryColor,
      ),
      builder: EasyLoading.init(),
    );
  }
}
