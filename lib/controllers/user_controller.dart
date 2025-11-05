import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserController extends GetxController {
  final ApiService apiService;
  UserController({required this.apiService});

  var user = Rxn<UserModel>();
  var isLoading = false.obs;
  var error = RxnString();

  Future<void> fetchUser(String username) async {
    try {
      isLoading.value = true;
      error.value = null;
      final json = await apiService.getUser(username);
      user.value = UserModel.fromJson(json);
      print(user.value.toString());
    } catch (e) {
      error.value = 'User not found or network error';
    } finally {
      isLoading.value = false;
    }
  }
}
