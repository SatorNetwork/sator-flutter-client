import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/profile_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/sator_icons.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/util/avatar_list.dart';

class ProfilePage extends GetView<ProfileController> {
  final int avatarIndex = Random().nextInt(avatars.length);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
          width: Get.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100 * coefficient,
                height: 72 * coefficient,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16 * coefficient),
                        child: SvgPicture.asset(
                          avatars[avatarIndex],
                          width: 72 * coefficient,
                          height: 72 * coefficient,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 40 * coefficient,
                        height: 40 * coefficient,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: SatorioColor.magic_mint,
                              width: 3 * coefficient),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Image.asset(
                            'images/tmp_shuriken.png',
                            height: 24 * coefficient,
                            width: 24 * coefficient,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          controller.profileRx.value?.displayedName ?? '',
                          style: textTheme.headline6!.copyWith(
                            color: SatorioColor.textBlack,
                            fontSize: 18.0 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.showInvite();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(24, 24),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          primary: SatorioColor.brand,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'txt_invite_friends'.tr.toUpperCase(),
                          style: textTheme.bodyText2!.copyWith(
                            color: Colors.white,
                            fontSize: 12.0 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  SatorIcons.exit,
                  size: 24,
                ),
                onPressed: () {
                  controller.logout();
                },
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 28, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'txt_badges'.tr,
                              style: textTheme.headline3!.copyWith(
                                color: SatorioColor.textBlack,
                                fontSize: 24.0 * coefficient,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 32 * coefficient,
                              color: SatorioColor.textBlack,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 121 * coefficient,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 12 * coefficient,
                          ),
                          itemCount: _badges.length,
                          itemBuilder: (context, index) {
                            BadgeTmp badge = _badges[index];
                            return _badgeItem(badge);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 32,
                          bottom: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'txt_your_activity'.tr,
                              style: textTheme.headline3!.copyWith(
                                color: SatorioColor.textBlack,
                                fontSize: 24.0 * coefficient,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 32 * coefficient,
                              color: SatorioColor.textBlack,
                            )
                          ],
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8 * coefficient,
                        ),
                        itemCount: _activities.length,
                        itemBuilder: (context, index) {
                          ActivityTmp activity = _activities[index];
                          return _activityItem(activity);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 28, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'txt_realms_open'.tr,
                              style: textTheme.headline3!.copyWith(
                                color: SatorioColor.textBlack,
                                fontSize: 24.0 * coefficient,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 32 * coefficient,
                              color: SatorioColor.textBlack,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 180 * coefficient,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 16 * coefficient,
                          ),
                          itemCount: _realms.length,
                          itemBuilder: (context, index) {
                            RealmTmp realm = _realms[index];
                            return _realmItem(realm);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 28, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'txt_nfts'.tr,
                              style: textTheme.headline3!.copyWith(
                                color: SatorioColor.textBlack,
                                fontSize: 24.0 * coefficient,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 32 * coefficient,
                              color: SatorioColor.textBlack,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 181 * coefficient,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 28, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'txt_reviews'.tr,
                              style: textTheme.headline3!.copyWith(
                                color: SatorioColor.textBlack,
                                fontSize: 24.0 * coefficient,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 32 * coefficient,
                              color: SatorioColor.textBlack,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 230 * coefficient,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 16 * coefficient,
                          ),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return _reviewItem();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _badgeItem(BadgeTmp badge) {
    return Container(
      height: 121 * coefficient,
      width: 100 * coefficient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100 * coefficient,
            height: 100 * coefficient,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(17 * coefficient)),
              color: SatorioColor.alice_blue,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    badge.asset,
                    width: 60 * coefficient,
                    height: 60 * coefficient,
                    fit: BoxFit.cover,
                  ),
                ),
                if (badge.count > 0)
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 6 * coefficient,
                          horizontal: 8 * coefficient),
                      child: Text(
                        badge.count.toString(),
                        style: textTheme.headline6!.copyWith(
                          color: SatorioColor.interactive,
                          fontSize: 18.0 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Text(
            badge.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyText2!.copyWith(
              color: SatorioColor.interactive,
              fontSize: 14.0 * coefficient,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityItem(ActivityTmp activity) {
    return Container(
      height: 74 * coefficient,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(17 * coefficient)),
        color: SatorioColor.alice_blue,
      ),
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
    );
  }

  Widget _realmItem(RealmTmp realm) {
    final double itemWidth = Get.width - 2 * 20 - 16 * coefficient;
    final double borderWidth = 5 * coefficient;

    return Container(
      width: itemWidth,
      height: 180 * coefficient,
      decoration: BoxDecoration(
        border: Border.all(
          color: SatorioColor.interactive,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16 * coefficient)),
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(16 * coefficient - borderWidth)),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Image.network(
              realm.imageUrl,
              height: 180 * coefficient,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: itemWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16 * coefficient - borderWidth,
                  vertical: 20 * coefficient - borderWidth,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      realm.showTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontSize: 18.0 * coefficient,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      realm.episodeTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headline6!.copyWith(
                        color: Colors.white,
                        fontSize: 18.0 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _reviewItem() {
    final double itemWidth = Get.width - 20 - 2 * 16 * coefficient;
    final EdgeInsets padding =
        EdgeInsets.only(left: 16 * coefficient, right: 16 * coefficient);
    return Container(
      height: 230 * coefficient,
      width: itemWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(17 * coefficient)),
        color: SatorioColor.alice_blue,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 44 * coefficient,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(0.08),
                  width: 1 * coefficient,
                ),
              ),
            ),
            child: Padding(
              padding: padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 22 * coefficient,
                    color: SatorioColor.interactive,
                  ),
                  SizedBox(
                    width: 4 * coefficient,
                  ),
                  Text(
                    '9 / 10',
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 12.0 * coefficient,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '06 June 2021',
                      textAlign: TextAlign.end,
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 12.0 * coefficient,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: padding,
            child: Text(
              'Something nice to watch',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.headline6!.copyWith(
                color: SatorioColor.textBlack,
                fontSize: 18.0 * coefficient,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: padding,
            child: Text(
              'A high school chemistry teacher dying of cancer teams with a former student to secure his family\'s future...',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyText2!.copyWith(
                color: SatorioColor.textBlack,
                fontSize: 15.0 * coefficient,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            height: 60 * coefficient,
            width: itemWidth,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(17 * coefficient),
              ),
              // color: Colors.red
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.05),
                  Colors.black.withOpacity(0.01),
                ],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 20 * coefficient,
                  height: 20 * coefficient,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        SatorioColor.yellow_orange,
                        SatorioColor.tomato,
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 6 * coefficient,
                ),
                Expanded(
                  child: Text(
                    'username',
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 15.0 * coefficient,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.thumb_up_rounded,
                  size: 20 * coefficient,
                  color: SatorioColor.interactive,
                ),
                SizedBox(
                  width: 8 * coefficient,
                ),
                Text(
                  '2.5k',
                  style: textTheme.bodyText2!.copyWith(
                    color: SatorioColor.interactive,
                    fontSize: 14.0 * coefficient,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 24 * coefficient,
                ),
                Icon(
                  Icons.thumb_down_rounded,
                  size: 20 * coefficient,
                  color: SatorioColor.textBlack,
                ),
                SizedBox(
                  width: 8 * coefficient,
                ),
                Text(
                  '234',
                  style: textTheme.bodyText2!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 14.0 * coefficient,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  final List<BadgeTmp> _badges = [
    BadgeTmp('images/tmp_badge_1.png', 'Genesis', 0),
    BadgeTmp('images/tmp_badge_2.png', 'Big Binger', 2),
    BadgeTmp('images/tmp_badge_3.png', 'Speed Demon', 4),
    BadgeTmp('images/tmp_badge_4.png', 'Collector', 0),
  ];

  final List<ActivityTmp> _activities = [
    ActivityTmp(
      'images/tmp_stranger_things.png',
      'You scored top 50 in S1. E4 realm.',
    ),
    ActivityTmp(
      'images/tmp_breaking_bad.png',
      'Finished all of 2nd season.',
    ),
    ActivityTmp(
      'images/tmp_stranger_things.png',
      'Beat @jerry24 in 1-1 super challenge.',
    ),
    ActivityTmp(
      'images/tmp_stranger_things.png',
      'Beat @jerry in 1-1 super challenge.',
    ),
  ];

  final List<RealmTmp> _realms = [
    RealmTmp(
      'https://upload.wikimedia.org/wikipedia/en/d/d6/Cat%27s_in_the_Bag.jpg',
      'Breaking Bad',
      'Cat\'s in the Bag...',
    ),
    RealmTmp(
      'https://media.npr.org/assets/img/2013/09/20/184ad101-eeb2-bc20-378a-35487bcb135f_bb_rv-and-scenic_004-2802-90c9764ed9e1155c92a1faf560b8b90e9e275335.jpg',
      'Breaking Bad',
      'Pilot',
    ),
  ];
}

class BadgeTmp {
  const BadgeTmp(this.asset, this.name, this.count);

  final String asset;
  final String name;
  final int count;
}

class ActivityTmp {
  const ActivityTmp(this.asset, this.text);

  final String asset;
  final String text;
}

class RealmTmp {
  const RealmTmp(this.imageUrl, this.showTitle, this.episodeTitle);

  final String imageUrl;
  final String showTitle;
  final String episodeTitle;
}
