import 'package:get/get.dart';
import '../models/repo_model.dart';
import '../services/api_service.dart';

enum ViewType { list, grid }

class RepoController extends GetxController {
  final ApiService apiService;
  RepoController({required this.apiService});

  var repos = <RepoModel>[].obs;
  var filtered = <RepoModel>[].obs;
  var isLoading = false.obs;
  var error = RxnString();
  var viewType = ViewType.list.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchRepos(String username) async {
    try {
      isLoading.value = true;
      error.value = null;
      final list = await apiService.getUserRepos(username);
      repos.value = list.map((e) => RepoModel.fromJson(e)).toList();
      filtered.value = List.of(repos);
    } catch (e) {
      error.value = 'Failed to load repositories';
    } finally {
      isLoading.value = false;
    }
  }

  void toggleView() => viewType.value = viewType.value == ViewType.list
      ? ViewType.grid
      : ViewType.list;

  void sortByName({bool ascending = true}) {
    filtered.sort(
      (a, b) => ascending
          ? a.name.toLowerCase().compareTo(b.name.toLowerCase())
          : b.name.toLowerCase().compareTo(a.name.toLowerCase()),
    );
  }

  void sortByDate({bool newestFirst = true}) {
    filtered.sort(
      (a, b) => newestFirst
          ? b.updatedAt.compareTo(a.updatedAt)
          : a.updatedAt.compareTo(b.updatedAt),
    );
  }

  void filterByLanguage(String lang) {
    if (lang.isEmpty)
      filtered.value = List.of(repos);
    else
      filtered.value = repos.where((r) => r.language == lang).toList();
  }

  void searchByName(String query) {
    if (query.isEmpty)
      filtered.value = List.of(repos);
    else
      filtered.value = repos
          .where((r) => r.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
  }
}
