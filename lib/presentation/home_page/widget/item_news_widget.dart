import 'package:flutter/material.dart';
import 'package:api_news/model/news_article.dart';
import 'package:api_news/presentation/detail_page/detail_page.dart';

class NewsItem extends StatelessWidget {
  final NewsArticle article;

  const NewsItem({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Aksi untuk masuk ke halaman DetailPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(article: article), // Mengirimkan artikel ke halaman detail
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar thumbnail di sebelah kanan
            article.imageUrl != null
                ? Container(
                    width: 170, // Gambar tidak terlalu besar
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                      image: DecorationImage(
                        image: NetworkImage(article.imageUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    width: 120,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                    ),
                  ),
            const SizedBox(width: 10),
            
            // Judul dan informasi lainnya di sebelah kiri
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      article.title ?? "No Title",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    
                    // Date
                    Text(
                      article.isoDate ?? "No Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
