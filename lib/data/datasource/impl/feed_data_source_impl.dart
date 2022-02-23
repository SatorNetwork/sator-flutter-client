import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:satorio/data/datasource/feed_data_source.dart';
import 'package:webfeed/webfeed.dart';

class FeedDataSourceImpl implements FeedDataSource {
  @override
  Future<RssFeed> feed() async {
    final getConnect = GetConnect();

    getConnect.timeout = Duration(seconds: 30);
    getConnect.baseUrl = 'https://satortoken.medium.com/';

    final response = await getConnect.get('feed');
    final feed = await compute(parseResponse, response.bodyString!);

    // print('${feed.title}');
    // print('${feed.link}');
    // print('${feed.image?.url}');
    // print('${feed.generator}');
    // print('${feed.lastBuildDate}');
    // print('${feed.webMaster}');
    // print('${feed.items?.length}');

    return feed;
  }
}

RssFeed parseResponse(String xmlString) {
  return RssFeed.parse(xmlString);
}
