import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/show_challenges_controller.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class ShowChallengesPage extends GetView<ShowChallengesController> {
  ShowChallengesPage(Show show) : super() {
    controller.loadChallenges(show);
  }

  @override
  Widget build(BuildContext context) {
    const double kHeight = 120;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SvgPicture.asset(
            'images/bg/gradient.svg',
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Container(
            height: kHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 33),
              child: Stack(
                children: [
                  Positioned(
                    top: kHeight / 2,
                    child: InkWell(
                      onTap: () => controller.back(),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        size: 32,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: kHeight / 1.8),
                    width: Get.mediaQuery.size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.show.title,
                          style: TextStyle(
                            color: SatorioColor.darkAccent,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            constraints:
                BoxConstraints(minHeight: Get.mediaQuery.size.height - kHeight),
            margin: EdgeInsets.only(top: kHeight),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(
                    () => ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(24),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 16,
                            ),
                        itemCount: controller.showChallengesRx.value.length,
                        itemBuilder: (context, index) {
                          ChallengeSimple challengeSimple =
                              controller.showChallengesRx.value[index];
                          return _challengeItem(
                              context, challengeSimple, index);
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _challengeItem(
      BuildContext context, ChallengeSimple challengeSimple, int index) {
    return InkWell(
      onTap: () {
        controller.toChallenge(challengeSimple);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            color: SatorioColor.alice_blue),
        height: 84,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: _colors[index % _colors.length],
              ),
              child: Center(
                child: SvgPicture.asset(
                  'images/logo.svg',
                  width: 23,
                  height: 23,
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    challengeSimple.title == null ? "" : challengeSimple.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: SatorioColor.darkAccent,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    challengeSimple.description == null
                        ? ""
                        : challengeSimple.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: SatorioColor.darkAccent,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<Color> _colors = [
    SatorioColor.lavender_rose,
    SatorioColor.mona_lisa,
    SatorioColor.light_sky_blue
  ];
}
