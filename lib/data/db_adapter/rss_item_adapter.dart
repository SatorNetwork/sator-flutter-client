import 'package:hive/hive.dart';
import 'package:satorio/data/db_adapter/adapter_type_ids.dart';
import 'package:webfeed/domain/rss_content.dart';
import 'package:webfeed/webfeed.dart';

class RssItemAdapter extends TypeAdapter<RssItem> {
  @override
  int get typeId => RssItemTypeId;

  @override
  RssItem read(BinaryReader reader) {
    final title = reader.readString();
    final description = reader.readString();
    final author = reader.readString();
    final link = reader.readString();
    final guid = reader.readString();
    final pubDate = DateTime.tryParse(reader.readString());
    final contentValue = reader.readString();
    final contentImages = reader.readStringList();

    return RssItem(
      title: title,
      description: description,
      author: author,
      link: link,
      guid: guid,
      pubDate: pubDate,
      content: RssContent(
        contentValue,
        contentImages,
      ),
    );
  }

  @override
  void write(BinaryWriter writer, RssItem rssItem) {
    final String author = rssItem.author ?? (rssItem.dc?.creator ?? '');

    writer.writeString(rssItem.title ?? '');
    writer.writeString(rssItem.description ?? '');
    writer.writeString(author);
    writer.writeString(rssItem.link ?? '');
    writer.writeString(rssItem.guid ?? '');
    writer.writeString(rssItem.pubDate?.toIso8601String() ?? '');
    writer.writeString(rssItem.content?.value ?? '');
    writer.writeStringList(rssItem.content?.images.toList() ?? []);
  }
}
