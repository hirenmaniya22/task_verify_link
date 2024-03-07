import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:task_verify_link/routes/app_routes.dart';
import 'package:task_verify_link/utils/app_color.dart';

import 'local_db/hive_database_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDatabase.initialize();
  // await HiveDatabase.openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task ',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.appRoutes,
    );
  }
}
