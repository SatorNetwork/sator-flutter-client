import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/challenges_controller.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class ChallengesPage extends GetView<ChallengesController> {
  static const double _threshHold = 150.0;

  final List<Color> _colors = [
    SatorioColor.lavender_rose,
    SatorioColor.mona_lisa,
    SatorioColor.light_sky_blue
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'txt_challenges'.tr,
          style: textTheme.bodyText1!.copyWith(
            color: SatorioColor.darkAccent,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: InkWell(
            onTap: () => controller.back(),
            child: Icon(
              Icons.chevron_left_rounded,
              color: SatorioColor.darkAccent,
              size: 32,
            ),
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            backgroundImage('images/bg/gradient.svg'),
            Container(
              width: Get.width,
              margin: EdgeInsets.only(
                  top: Get.mediaQuery.padding.top + kToolbarHeight),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent - _threshHold)
                      controller.loadChallenges();
                    return true;
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.refreshData();
                    },
                    child: Obx(
                      () => ListView.separated(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                        itemCount: controller.challengesRx.value.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 12,
                        ),
                        itemBuilder: (context, index) {
                          final ChallengeSimple challenge =
                              controller.challengesRx.value[index];
                          final Color color = _colors[index % _colors.length];
                          return _challengeItem(challenge, color);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _challengeItem(ChallengeSimple challenge, Color color) {
    final double itemHeight = 74.0 * coefficient;
    final double imageHeight = 52.0 * coefficient;
    final double imageWidth = 52.0 * coefficient;
    return InkWell(
      onTap: () {
        controller.toChallenge(challenge);
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        height: itemHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: SatorioColor.alice_blue,
        ),
        child: Row(
          children: [
            challenge.cover.isEmpty
                ? Container(
                    height: imageHeight,
                    width: imageWidth,
                    padding: EdgeInsets.all(8 * coefficient),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: color,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'images/sator_logo.svg',
                        color: Colors.white,
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Image.network(
                      challenge.cover,
                      height: imageHeight,
                      width: imageWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    challenge.title,
                    style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.darkAccent,
                        fontSize: 18.0 * coefficient,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('images/player_icon.svg'),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        '${challenge.playersCount}/${challenge.playersToStart}',
                        style: textTheme.bodyText1!.copyWith(
                          fontSize: 14 * coefficient,
                          fontWeight: FontWeight.w500,
                          color: SatorioColor.darkAccent,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SvgPicture.asset('images/prize_icon.svg'),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        challenge.prizePool,
                        style: textTheme.bodyText1!.copyWith(
                          fontSize: 14 * coefficient,
                          fontWeight: FontWeight.w500,
                          color: SatorioColor.darkAccent,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            challenge.isRealmActivated
                ? SizedBox(
                    width: 0,
                  )
                : SvgPicture.asset(
                    'images/locked_icon.svg',
                    color: SatorioColor.darkAccent,
                  ),
          ],
        ),
      ),
    );
  }
}
