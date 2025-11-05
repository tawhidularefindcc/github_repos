class RepoModel {
  final int id;
  final String name;
  final String fullName;
  final String description;
  final String language;
  final int stargazersCount;
  final int forksCount;
  final DateTime updatedAt;
  final String htmlUrl;

  RepoModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.language,
    required this.stargazersCount,
    required this.forksCount,
    required this.updatedAt,
    required this.htmlUrl,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) => RepoModel(
    id: json['id'],
    name: json['name'] ?? '',
    fullName: json['full_name'] ?? '',
    description: json['description'] ?? '',
    language: json['language'] ?? 'Unknown',
    stargazersCount: json['stargazers_count'] ?? 0,
    forksCount: json['forks_count'] ?? 0,
    updatedAt: DateTime.parse(json['updated_at']),
    htmlUrl: json['html_url'] ?? '',
  );
}
