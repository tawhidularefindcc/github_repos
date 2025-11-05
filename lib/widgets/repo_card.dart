import 'package:flutter/material.dart';
import '../models/repo_model.dart';
import 'package:intl/intl.dart';

class RepoCard extends StatelessWidget {
  final RepoModel repo;
  const RepoCard({required this.repo, super.key});

  @override
  Widget build(BuildContext context) {
    final updated = DateFormat.yMMMd().format(repo.updatedAt);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: ListTile(
        title: Text(repo.name),
        subtitle: Text(
          repo.description.isEmpty ? 'No description' : repo.description,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('\u2605 ${repo.stargazersCount}'), Text(updated)],
        ),
      ),
    );
  }
}
