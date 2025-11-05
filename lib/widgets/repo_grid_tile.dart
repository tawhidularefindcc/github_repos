import 'package:flutter/material.dart';
import '../models/repo_model.dart';
import 'package:intl/intl.dart';

class RepoGridTile extends StatelessWidget {
  final RepoModel repo;
  const RepoGridTile({required this.repo, super.key});

  @override
  Widget build(BuildContext context) {
    final updated = DateFormat.yMMMd().format(repo.updatedAt);
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(repo.name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                repo.description.isEmpty ? 'No description' : repo.description,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(repo.language),
                Text('\u2605 ${repo.stargazersCount}'),
              ],
            ),
            Align(alignment: Alignment.bottomRight, child: Text(updated)),
          ],
        ),
      ),
    );
  }
}
