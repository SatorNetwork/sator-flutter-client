import 'package:webfeed/webfeed.dart';

abstract class FeedDataSource {
  Future<List<RssItem>> rssItems();
}
