import 'package:get/get.dart';
import 'services/api_service.dart';
import 'controllers/user_controller.dart';
import 'controllers/repo_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    final api = ApiService();
    Get.put<ApiService>(api, permanent: true);
    Get.put<UserController>(UserController(apiService: api));
    Get.put<RepoController>(RepoController(apiService: api));
  }
}
