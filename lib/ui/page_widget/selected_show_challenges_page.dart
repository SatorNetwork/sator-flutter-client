import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/selected_show_challenges_controller.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class SelectedShowChallengesPage
    extends GetView<SelectedShowChallengesController> {
  SelectedShowChallengesPage(Show show) : super() {
    controller.loadChallenges(show);
  }

  @override
  Widget build(BuildContext context) {
    const double kHeight = 142;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SvgPicture.asset(
            'images/gradient.svg',
            fit: BoxFit.fill,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                          Icons.chevron_left,
                          size: 32,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: kHeight / 1.8),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.showTitle == null
                                ? ""
                                : controller.showTitle.value,
                            style: TextStyle(
                              color: SatorioColor.darkAccent,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - kHeight),
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
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(24),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 16,
                          ),
                      itemCount:
                          controller.selectedShowChallengesRx.value.length,
                      itemBuilder: (context, index) {
                        ChallengeSimple challengeSimple =
                            controller.selectedShowChallengesRx.value[index];
                        return _challengeItem(context, challengeSimple, index);
                      }
                      // _challengeItem(context, index),
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
    final List<Color> colors = [
      SatorioColor.lavender_rose,
      SatorioColor.mona_lisa,
      SatorioColor.light_sky_blue
    ];

    return InkWell(
      onTap: () => {print("tap")},
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
                  color: colors[index % colors.length],
                ),
                child: Center(
                    child: Container(
                        height: 23,
                        width: 23,
                        child: Image.asset("images/logo.png",
                            color: Colors.white)))),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  challengeSimple.title == null ? "" : challengeSimple.title,
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
                  style: TextStyle(
                    color: SatorioColor.darkAccent,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
