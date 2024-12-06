import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:api_news/model/news_article.dart';
import 'package:api_news/network/net_client.dart';
import 'package:api_news/presentation/home_page/widget/list_news_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexBar = 0;
  List<NewsArticle> _articles = [];
  List<NewsArticle> _filteredArticles = [];
  bool _isLoading = true;
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();
  String _source = 'cnn'; // Default source is CNN

  @override
  void initState() {
    super.initState();
    _fetchNewsArticles();
  }

  Future<void> _fetchNewsArticles() async {
    final category = _source == 'cnn'
        ? (indexBar == 0 ? 'olahraga' : 'teknologi')
        : (indexBar == 0 ? 'lifestyle' : 'syariah');

    try {
      setState(() {
        _isLoading = true;
      });
      _articles = await NetClient().fetchNewsArticles(category, _source);
      _filteredArticles = _articles;
    } catch (e) {
      print("Error fetching articles: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterArticles(String query) {
    final filtered = _articles.where((article) {
      final titleLower = article.title?.toLowerCase() ?? '';
      final dateLower = article.isoDate?.toLowerCase() ?? '';
      final queryLower = query.toLowerCase();
      return titleLower.contains(queryLower) || dateLower.contains(queryLower);
    }).toList();

    setState(() {
      _filteredArticles = filtered;
    });
  }

  void _changeSource(String source) {
    setState(() {
      _source = source;
      _fetchNewsArticles();
    });
  }

  void _showSourceDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [const Color(0xFFFF4081), Colors.pink.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title of the Dialog
              const Text(
                "Select News Source",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // CNN Option
              ListTile(
                leading: const Icon(
                  Icons.campaign,
                  color: Colors.white,
                  size: 30,
                ),
                title: const Text(
                  'CNN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  _changeSource('cnn');
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.white),
              
              // CNBC Option
              ListTile(
                leading: const Icon(
                  Icons.business,
                  color: Colors.white,
                  size: 30,
                ),
                title: const Text(
                  'CNBC',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  _changeSource('cnbc');
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.white70),

              // Cancel Button
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


  List<BottomNavigationBarItem> _bottomNavigationBarItems() {
    return _source == 'cnn'
        ? const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.futbol),
              label: "Olahraga",
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.desktop),
              label: "Teknologi",
            ),
          ]
        : const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.tshirt),
              label: "Lifestyle",
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.mosque),
              label: "Syariah",
            ),
          ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                onChanged: _filterArticles,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search by title or date",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              )
            : Text(
                _source == 'cnn' ? 'CNN News' : 'CNBC News', // Menampilkan CNN atau CNBC di title
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        elevation: 6,
        toolbarHeight: 70,
        shadowColor: Colors.pink.withOpacity(0.2),
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.cancel : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchController.clear();
                  _filteredArticles = _articles;
                }
                _isSearching = !_isSearching;
              });
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: _showSourceDialog,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.pinkAccent,
                ),
              )
            : _filteredArticles.isEmpty
                ? const Center(
                    child: Text(
                      "No news articles found",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : NewsList(articles: _filteredArticles),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBar,
        onTap: (index) {
          setState(() {
            indexBar = index;
            _fetchNewsArticles();
          });
        },
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: _bottomNavigationBarItems(),
      ),
    );
  }
}
