import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:satorio/controller/activity_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/util/avatar_list.dart';

class ActivityPage extends GetView<ActivityController> {
  ActivityPage() {
    this._activities = _generateData(Random());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        child: GroupedListView<ActivityTmp, DateTime>(
          padding: const EdgeInsets.only(bottom: 16),
          elements: _activities,
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          stickyHeaderBackgroundColor: Colors.white,
          itemComparator: (element1, element2) {
            return element1.date.compareTo(element2.date);
          },
          groupBy: (ActivityTmp activity) {
            return DateTime(
              activity.date.year,
              activity.date.month,
              activity.date.day,
            );
          },
          groupHeaderBuilder: (ActivityTmp activity) {
            return _dateItem(activity.date);
          },
          indexedItemBuilder: (context, activity, index) {
            return _activityItem(activity);
          },
          separator: SizedBox(
            height: 12 * coefficient,
          ),
        ),
      ),
    );
  }

  Widget _dateItem(DateTime dateTime) {
    return Container(
      padding: EdgeInsets.only(
          top: 28 * coefficient, bottom: 12 * coefficient, left: 20, right: 20),
      color: Colors.transparent,
      child: Text(
        '${DateFormat('MMMM d, yyyy').format(dateTime)}',
        style: textTheme.bodyText2!.copyWith(
          color: SatorioColor.textBlack,
          fontSize: 15.0 * coefficient,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _activityItem(ActivityTmp activity) {
    final EdgeInsets padding =
        EdgeInsets.only(left: 16 * coefficient, right: 16 * coefficient);

    return Container(
      height: 131 * coefficient,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(17 * coefficient)),
        color: SatorioColor.alice_blue,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 110 * coefficient,
                  padding: EdgeInsets.symmetric(horizontal: 13 * coefficient),
                  child: Center(
                    child: Image.asset(
                      activity.asset,
                    ),
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  color: Colors.black.withOpacity(0.08),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16 * coefficient),
                    child: Text(
                      activity.text,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.darkAccent,
                        fontSize: 15.0 * coefficient,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 56 * coefficient,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(17 * coefficient),
              ),
              // color: Colors.red
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [SatorioColor.alice_blue2, SatorioColor.alice_blue],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipOval(
                  child: SvgPicture.asset(
                    activity.avatarAsset,
                    width: 22 * coefficient,
                    height: 22 * coefficient,
                  ),
                ),
                SizedBox(
                  width: 8 * coefficient,
                ),
                Expanded(
                  child: Text(
                    activity.username,
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 15.0 * coefficient,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8 * coefficient,
                ),
                Text(
                  activity.amount,
                  style: textTheme.bodyText2!.copyWith(
                    color: SatorioColor.interactive,
                    fontSize: 14.0 * coefficient,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  ' ${activity.currency}',
                  style: textTheme.bodyText2!.copyWith(
                    color: SatorioColor.interactive,
                    fontSize: 14.0 * coefficient,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  late final List<ActivityTmp> _activities;

  List<ActivityTmp> _generateData(Random random) {
    return [
      ActivityTmp(
        'images/tmp_stranger_things.png',
        'Beat @jerry in 1-1 super challenge.',
        avatars[random.nextInt(avatars.length)],
        'roberto21',
        '+4.42',
        'SAO',
        DateTime(2021, 7, 7, 12, 25),
      ),
      ActivityTmp(
        'images/tmp_breaking_bad.png',
        'Finished all of 2nd season.',
        avatars[random.nextInt(avatars.length)],
        'billyBOB!i',
        '+4.42',
        'SAO',
        DateTime(2021, 7, 7, 10, 45),
      ),
      ActivityTmp(
        'images/tmp_breaking_bad.png',
        'Scored top 50 in S1.E4 realm.',
        avatars[random.nextInt(avatars.length)],
        'Dorgan5',
        '+4.42',
        'SAO',
        DateTime(2021, 7, 7, 5, 11),
      ),
      ActivityTmp(
        'images/tmp_stranger_things.png',
        'Beat @jerry in 1-1 super challenge.',
        avatars[random.nextInt(avatars.length)],
        'Nightmare_boi',
        '+4.42',
        'SAO',
        DateTime(2021, 7, 4, 18, 13),
      ),
      ActivityTmp(
        'images/tmp_stranger_things.png',
        'Beat @jerry in 1-1 super challenge.',
        avatars[random.nextInt(avatars.length)],
        '369damngoodtyme',
        '+4.42',
        'SAO',
        DateTime(2021, 7, 4, 10, 38),
      ),
      ActivityTmp(
        'images/tmp_stranger_things.png',
        'Beat @jerry in 1-1 super challenge.',
        avatars[random.nextInt(avatars.length)],
        '369damngoodtyme',
        '+4.42',
        'SAO',
        DateTime(2021, 7, 3, 20, 21),
      ),
      ActivityTmp(
        'images/tmp_stranger_things.png',
        'Beat @jerry in 1-1 super challenge.',
        avatars[random.nextInt(avatars.length)],
        '369damngoodtyme',
        '+4.42',
        'SAO',
        DateTime(2021, 7, 3, 11, 12),
      ),
    ];
  }
}

class ActivityTmp {
  const ActivityTmp(
    this.asset,
    this.text,
    this.avatarAsset,
    this.username,
    this.amount,
    this.currency,
    this.date,
  );

  final String asset;
  final String text;
  final String avatarAsset;
  final String username;
  final String amount;
  final String currency;
  final DateTime date;
}
