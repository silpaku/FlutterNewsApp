import 'package:hive/hive.dart';

part 'bookmark_model.g.dart';

@HiveType(typeId: 1)
class Bookmark extends HiveObject {
  @HiveField(0)
  late String url;

  Bookmark(this.url);
}
