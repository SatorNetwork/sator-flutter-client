import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/selected_show_challenges_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'dart:math' as math;

class SelectedShowChallengesPage extends GetView<SelectedShowChallengesController> {
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
                    child: InkWell(child: Icon(Icons.chevron_left)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: kHeight / 2),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Lorem ipsum",
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
            margin: EdgeInsets.only(top: 142),
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
                    itemCount: 10,
                    itemBuilder: (context, index) => _challengeItem(context),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _challengeItem(BuildContext context) {
    return InkWell(
      onTap: () => {
        print("tap")
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
                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(0.8)),
              // child: SvgPicture.asset(
              //   'images/logo.svg',
              //   height: 20,
              //   alignment: Alignment.center,
              // ),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Challenge name",
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
                  "History of Westoros",
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
