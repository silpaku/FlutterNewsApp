import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Bookmark extends HiveObject {
  @HiveField(0)
  late String url;

  Bookmark(this.url);
}

class BookmarkService {
  static Future<void> addBookmark(String url) async {
    final box = await Hive.openBox<Bookmark>('bookmarks');
    final bookmark = Bookmark(url);
    box.add(bookmark);
  }

  static Future<void> removeBookmark(String url) async {
    final box = await Hive.openBox<Bookmark>('bookmarks');
    final bookmark = box.values.firstWhere((bookmark) => bookmark.url == url);
    bookmark.delete();
  }

  static Future<bool> isBookmarked(String url) async {
    final box = await Hive.openBox<Bookmark>('bookmarks');
    return box.values.any((bookmark) => bookmark.url == url);
  }
}

class DetailViewScreen extends StatefulWidget {
  final String newsUrl;

  DetailViewScreen({Key? key, required this.newsUrl}) : super(key: key);

  @override
  _DetailViewScreenState createState() => _DetailViewScreenState();
}

class _DetailViewScreenState extends State<DetailViewScreen> {
  late WebViewController _webViewController;
  int _currentIndex = 0;
  late String _modifiedNewsUrl;

  @override
  void initState() {
    super.initState();
    _modifiedNewsUrl = widget.newsUrl.startsWith("http:")
        ? widget.newsUrl.replaceFirst("http:", "https:")
        : widget.newsUrl;
  }

  Future<void> toggleBookmark() async {
    final isBookmarked = await BookmarkService.isBookmarked(_modifiedNewsUrl);

    if (isBookmarked) {
      await BookmarkService.removeBookmark(_modifiedNewsUrl);
    } else {
      await BookmarkService.addBookmark(_modifiedNewsUrl);
    }

    setState(() {
      _currentIndex = 1; // Ensure bookmark icon is updated
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Snack")),
      body: WebView(
        initialUrl: _modifiedNewsUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            toggleBookmark();
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FutureBuilder<bool>(
              future: BookmarkService.isBookmarked(_modifiedNewsUrl),
              builder: (context, snapshot) {
                final isBookmarked = snapshot.data ?? false;
                return Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.blue,
                );
              },
            ),
            label: 'Bookmark',
          ),
        ],
      ),
    );
  }
}
