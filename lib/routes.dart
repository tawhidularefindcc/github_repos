import 'package:get/get.dart';
import 'views/login_page.dart';
import 'views/home_page.dart';
import 'views/repo_details_page.dart';

class Routes {
  static const login = '/';
  static const home = '/home';
  static const repo = '/repo';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.login, page: () => const LoginPage()),
    GetPage(name: Routes.home, page: () => const HomePage()),
    GetPage(name: Routes.repo, page: () => const RepoDetailPage()),
  ];
}
