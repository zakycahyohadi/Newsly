import 'package:flutter/material.dart';
import 'package:api_news/model/news_article.dart';

class DetailPage extends StatelessWidget {
  final NewsArticle article;

  const DetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title ?? "Detail",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[200],
        elevation: 8,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Article Image with Rounded Corners
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: article.imageUrl != null
                      ? Image.network(
                          article.imageUrl!,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image, size: 80),
                ),
              ),
              const SizedBox(height: 20),

              // Article Title
              Text(
                article.title ?? "No title",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
              const SizedBox(height: 10),

              // Article Date
              Text(
                article.isoDate ?? "No date",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const Divider(height: 30, color: Colors.grey),

              // Article Content Snippet
              Text(
                article.contentSnippet ?? "No content available.",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),

              // "Add to Favorites" Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to favorites!')),
                    );
                  },
                  icon: const Icon(Icons.favorite),
                  label: const Text('Add to Favorites'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[200],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
