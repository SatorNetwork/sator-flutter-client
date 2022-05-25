import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:satorio/data/datasource/feed_data_source.dart';
import 'package:webfeed/webfeed.dart';

class FeedDataSourceImpl implements FeedDataSource {
  static const String _feedHost = 'https://satortoken.medium.com/';
  static const String _feedPath = 'feed';

  @override
  Future<List<RssItem>> rssItems() async {
    final getConnect = GetConnect();

    getConnect.timeout = Duration(seconds: 30);
    getConnect.baseUrl = _feedHost;

    final response = await getConnect.get(_feedPath);
    final feed = await compute(parseResponse, response.bodyString!);

    return feed.items ?? [];
  }
}

RssFeed parseResponse(String xmlString) {
  return RssFeed.parse(xmlString);
}
