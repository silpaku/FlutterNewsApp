import 'package:hive/hive.dart';
import 'package:inshorts/model/bookmark_model.dart';

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
