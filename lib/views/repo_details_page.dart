import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/repo_model.dart';

class RepoDetailPage extends StatelessWidget {
  const RepoDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final RepoModel repo = args!['repo'] as RepoModel;

    String formatDate(String date) {
      try {
        final parsed = DateTime.parse(date);
        return DateFormat('MMM dd, yyyy').format(parsed);
      } catch (_) {
        return date;
      }
    }

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
            Text('Updated: ${formatDate(repo.updatedAt.toLocal().toString())}'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                final uri = Uri.parse(repo.htmlUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  Get.snackbar('Error', 'Could not launch ${repo.htmlUrl}');
                }
              },
              child: const Text('Open on GitHub'),
            ),
          ],
        ),
      ),
    );
  }
}
