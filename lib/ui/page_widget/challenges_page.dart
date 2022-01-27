import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/challenges_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class ChallengesPage extends GetView<ChallengesController> {
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
              padding: const EdgeInsets.only(top: 20),
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
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: 10,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(
                              height: 16,
                            ),
                        itemBuilder: (context, index) {
                          return _challengeItem(index);
                        }),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: 1,
                        width: Get.width,
                        color: SatorioColor.alice_blue2,
                      ),
                    ),
                    ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: 3,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(
                              height: 16,
                            ),
                        itemBuilder: (context, index) {
                          return _lockChallengeItem(index);
                        }),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _challengeItem(int index) {
    final double itemHeight = 74.0 * coefficient;
    final double imageHeight = 52.0 * coefficient;
    final double imageWidth = 52.0 * coefficient;
    return Container(
      padding: EdgeInsets.all(12.0),
      height: itemHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: SatorioColor.alice_blue,
      ),
      child: Row(
        children: [
          Container(
            height: imageHeight,
            width: imageWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: SatorioColor.alice_blue2,
            ),
            child: Center(
              child: SvgPicture.asset('images/locked_icon.svg'),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dummy challenge $index',
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
                  RichText(
                    text: TextSpan(
                      text: '5 / ',
                      style: textTheme.bodyText1!.copyWith(
                        fontSize: 14 * coefficient,
                        fontWeight: FontWeight.w500,
                        color: SatorioColor.darkAccent,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '10',
                          style: textTheme.bodyText1!.copyWith(
                              fontSize: 14 * coefficient,
                              fontWeight: FontWeight.w500,
                              color: SatorioColor.darkAccent),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SvgPicture.asset('images/prize_icon.svg'),
                  SizedBox(
                    width: 6,
                  ),
                  RichText(
                    text: TextSpan(
                      text: '2,550',
                      style: textTheme.bodyText1!.copyWith(
                        fontSize: 14 * coefficient,
                        fontWeight: FontWeight.w500,
                        color: SatorioColor.darkAccent,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' SAO',
                          style: textTheme.bodyText1!.copyWith(
                              fontSize: 14 * coefficient,
                              fontWeight: FontWeight.w500,
                              color: SatorioColor.darkAccent),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _lockChallengeItem(int index) {
    final double itemHeight = 74.0 * coefficient;
    return Container(
      padding: EdgeInsets.all(12.0),
      height: itemHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: SatorioColor.alice_blue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Locked dummy challenge $index',
                style: textTheme.bodyText2!.copyWith(
                    color: SatorioColor.darkAccent,
                    fontSize: 18.0 * coefficient,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'txt_coming_soon'.tr,
                style: textTheme.bodyText1!.copyWith(
                  fontSize: 14 * coefficient,
                  fontWeight: FontWeight.w500,
                  color: SatorioColor.darkAccent,
                ),
              )
            ],
          ),
          SvgPicture.asset('images/locked_icon.svg', color: SatorioColor.darkAccent,)
        ],
      ),
    );
  }
}
