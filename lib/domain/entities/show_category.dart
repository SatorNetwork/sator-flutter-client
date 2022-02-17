import 'package:satorio/domain/entities/show.dart';

class ShowCategory {
  final String id;
  final String title;
  final bool disabled;
  final int sort;
  final List<Show> shows;

  const ShowCategory(this.id, this.title, this.disabled, this.sort, this.shows);
}