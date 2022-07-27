class Videos {
  final String pageURL;
  final String tags;

  Videos({
    required this.pageURL,
    required this.tags,
  });

  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(
      pageURL: json['pageURL'] as String,
      tags: json['tags'] as String,
    );
  }
}
