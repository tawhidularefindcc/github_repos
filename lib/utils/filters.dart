List<String> extractLanguages(List repos) {
  final langs = <String>{};
  for (var r in repos) {
    final l = r.language ?? 'Unknown';
    langs.add(l);
  }
  return langs.toList();
}
