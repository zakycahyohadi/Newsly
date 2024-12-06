class NewsArticle {
  final String? title;
  final String? link;
  final String? isoDate;
  final String? contentSnippet;
  final String? imageUrl;

  NewsArticle({
    this.title,
    this.link,
    this.isoDate,
    this.contentSnippet,
    this.imageUrl,
  });

  // Mengonversi JSON ke objek NewsArticle
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      link: json['link'],
      isoDate: json['isoDate'],
      contentSnippet: json['contentSnippet'],
      imageUrl: json['image']['large'],
    );
  }
}
