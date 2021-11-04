import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/show_challenges_controller.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class ShowChallengesPage extends GetView<ShowChallengesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Obx(
          () => Text(
            controller.showRx.value.title,
            style: textTheme.bodyText1!.copyWith(
              color: SatorioColor.darkAccent,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
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
      body: Stack(
        children: [
          backgroundImage('images/bg/gradient.svg'),
          Container(
            constraints: BoxConstraints(
                minHeight: Get.mediaQuery.size.height -
                    (Get.mediaQuery.padding.top + kToolbarHeight)),
            margin: EdgeInsets.only(
                top: Get.mediaQuery.padding.top + kToolbarHeight),
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
                          Color color = _colors[index % _colors.length];
                          return _challengeItem(challengeSimple, color);
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

  Widget _challengeItem(ChallengeSimple challengeSimple, Color color) {
    return InkWell(
      onTap: () {
        controller.toChallenge(challengeSimple);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            color: SatorioColor.alice_blue),
        height: 84 * coefficient,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 52 * coefficient,
              width: 52 * coefficient,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: color,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'images/sator_logo.svg',
                  color: Colors.white,
                  width: 23 * coefficient,
                  height: 23 * coefficient,
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
                    challengeSimple.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText1!.copyWith(
                      color: SatorioColor.darkAccent,
                      fontSize: 18.0 * coefficient,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    challengeSimple.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.darkAccent,
                      fontSize: 14.0 * coefficient,
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
