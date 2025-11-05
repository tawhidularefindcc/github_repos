import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/repo_model.dart';

class RepoDetailPage extends StatelessWidget {
  const RepoDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final RepoModel repo = args!['repo'] as RepoModel;

    return Scaffold(
      appBar: AppBar(title: Text(repo.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(repo.fullName, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              repo.description.isEmpty ? 'No description' : repo.description,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: [
                Chip(label: Text('Language: ${repo.language}')),
                Chip(label: Text('Stars: ${repo.stargazersCount}')),
                Chip(label: Text('Forks: ${repo.forksCount}')),
              ],
            ),
            const SizedBox(height: 12),
            Text('Updated: ${repo.updatedAt.toLocal()}'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                // open in browser
                // Use url_launcher package if desired; for now we show a snackbar
                Get.snackbar(
                  'Open',
                  'Open repository in browser: \${repo.htmlUrl}',
                );
              },
              child: const Text('Open on GitHub'),
            ),
          ],
        ),
      ),
    );
  }
}
