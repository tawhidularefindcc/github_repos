import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/repo_controller.dart';
import '../controllers/user_controller.dart';
import '../widgets/repo_card.dart';
import '../widgets/repo_grid_tile.dart';
import '../routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final repoCtrl = Get.find<RepoController>();
    final userCtrl = Get.find<UserController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Obx(() => Text(userCtrl.user.value?.login ?? 'Repositories')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Obx(
              () => Icon(
                repoCtrl.viewType.value == ViewType.list
                    ? Icons.grid_view
                    : Icons.list,
              ),
            ),
            onPressed: repoCtrl.toggleView,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00BCD4), Color(0xFF3F51B5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    onChanged: repoCtrl.searchByName,
                    decoration: const InputDecoration(
                      hintText: 'Search repositories...',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (repoCtrl.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (repoCtrl.error.value != null) {
                    return Center(child: Text(repoCtrl.error.value!));
                  }

                  final list = repoCtrl.filtered;
                  if (list.isEmpty) {
                    return const Center(child: Text('No repositories found.'));
                  }

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: repoCtrl.viewType.value == ViewType.list
                        ? ListView.builder(
                            key: const ValueKey('list'),
                            itemCount: list.length,
                            itemBuilder: (_, i) => GestureDetector(
                              onTap: () => Get.toNamed(
                                Routes.repo,
                                arguments: {'repo': list[i]},
                              ),
                              child: RepoCard(repo: list[i]),
                            ),
                          )
                        : GridView.builder(
                            key: const ValueKey('grid'),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.2,
                                ),
                            itemCount: list.length,
                            itemBuilder: (_, i) => GestureDetector(
                              onTap: () => Get.toNamed(
                                Routes.repo,
                                arguments: {'repo': list[i]},
                              ),
                              child: RepoGridTile(repo: list[i]),
                            ),
                          ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
