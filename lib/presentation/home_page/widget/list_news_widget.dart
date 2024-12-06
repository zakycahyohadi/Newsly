import 'package:api_news/model/news_article.dart';
import 'package:api_news/presentation/home_page/widget/item_news_widget.dart';
import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  final List<NewsArticle> articles;

  const NewsList({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];

        return NewsItem(article: article);
      },
    );
  }
}