import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/activity_controller.dart';
import 'package:satorio/util/avatar_list.dart';

class ActivityPage extends GetView<ActivityController> {
  ActivityPage() {
    this._dateActivities = _generateData(Random());
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
        // child: ,
      ),
    );
  }

  late final List<DateActivity> _dateActivities;

  List<DateActivity> _generateData(Random random) {
    return [
      DateActivity(
        DateTime.now(),
        [
          ActivityTmp(
            'images/tmp_stranger_things.png',
            'Beat @jerry in 1-1 super challenge.',
            avatars[random.nextInt(avatars.length)],
            'roberto21',
            '+4.42 SAO',
          ),
          ActivityTmp(
            'images/tmp_breaking_bad.png',
            'Finished all of 2nd season.',
            avatars[random.nextInt(avatars.length)],
            'billyBOB!i',
            '+4.42 SAO',
          ),
          ActivityTmp(
            'images/tmp_breaking_bad.png',
            'Scored top 50 in S1.E4 realm.',
            avatars[random.nextInt(avatars.length)],
            'Dorgan5',
            '+4.42 SAO',
          ),
        ],
      ),
      DateActivity(
        DateTime.now().subtract(Duration(days: 1)),
        [
          ActivityTmp(
            'images/tmp_stranger_things.png',
            'Beat @jerry in 1-1 super challenge.',
            avatars[random.nextInt(avatars.length)],
            'Nightmare_boi',
            '+4.42 SAO',
          ),
          ActivityTmp(
            'images/tmp_stranger_things.png',
            'Beat @jerry in 1-1 super challenge.',
            avatars[random.nextInt(avatars.length)],
            '369damngoodtyme',
            '+4.42 SAO',
          ),
        ],
      ),
      DateActivity(
        DateTime.now().subtract(Duration(days: 1)),
        [
          ActivityTmp(
            'images/tmp_stranger_things.png',
            'Beat @jerry in 1-1 super challenge.',
            avatars[random.nextInt(avatars.length)],
            '369damngoodtyme',
            '+4.42 SAO',
          ),
          ActivityTmp(
            'images/tmp_stranger_things.png',
            'Beat @jerry in 1-1 super challenge.',
            avatars[random.nextInt(avatars.length)],
            '369damngoodtyme',
            '+4.42 SAO',
          ),
        ],
      ),
    ];
  }
}

class ActivityTmp {
  const ActivityTmp(
      this.asset, this.text, this.avatarAsset, this.username, this.amount);

  final String asset;
  final String text;
  final String avatarAsset;
  final String username;
  final String amount;
}

class DateActivity {
  const DateActivity(this.date, this.activities);

  final DateTime date;
  final List<ActivityTmp> activities;
}
