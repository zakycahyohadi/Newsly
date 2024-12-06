import 'dart:convert';
import 'package:api_news/model/news_article.dart';
import 'package:http/http.dart' as http;

class NetClient {
  // Function to fetch news articles from the API
  Future<List<NewsArticle>> fetchNewsArticles(String category, String source) async {
    String baseUrl;

    // Tentukan URL berdasarkan sumber dan kategori
    if (source == 'cnn') {
      baseUrl = "https://berita-indo-api-next.vercel.app/api/cnn-news/$category";
    } else {
      baseUrl = "https://berita-indo-api-next.vercel.app/api/cnbc-news/$category";
    }

    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((json) => NewsArticle.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load news articles: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}
