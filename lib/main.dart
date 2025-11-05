import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_repos/app_bindings.dart';
import 'package:github_repos/routes.dart';
import 'package:github_repos/services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = ThemeService();
    return GetMaterialApp(
      title: 'GitHub Repos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: themeService.theme,
      initialRoute: Routes.login,
      getPages: AppPages.pages,
    );
  }
}
