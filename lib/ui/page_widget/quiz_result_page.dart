import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_result_controller.dart';
import 'package:satorio/domain/entities/payload/payload_winner.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class QuizResultPage extends GetView<QuizResultController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          children: [
            SvgPicture.asset(
              'images/bg/gradient.svg',
              height: Get.height,
              fit: BoxFit.cover,
            ),
            Container(
              width: Get.width,
              margin: EdgeInsets.only(top: 76),
              child: Column(
                children: [
                  Text(
                    "txt_winners".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: SatorioColor.darkAccent,
                      fontSize: 34.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("txt_prize_pool".tr,
                            style: TextStyle(
                              color: SatorioColor.darkAccent,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            )),
                        Obx(
                          () => Text(
                              controller.resultRx.value == null
                                  ? ""
                                  : "${controller.resultRx.value.prizePool} SAO",
                              style: TextStyle(
                                color: SatorioColor.darkAccent,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Colors.white),
                      child:
                          // Obx(
                          //   () =>
                          ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                              separatorBuilder: (context, index) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 6),
                                    child: Divider(
                                      color: Colors.black.withOpacity(0.11),
                                    ),
                                  ),
                              itemCount: 3,
                              // controller.resultRx.value.winners.length,
                              itemBuilder: (context, index) {
                                // PayloadWinner payloadWinner =
                                //     controller.resultRx.value.winners[index];
                                return _winnerItem();
                              }),
                      // ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedGradientButton(
                      text: 'txt_claim_rewards'.tr,
                      onPressed: () {
                        _congratsBottomSheet(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedGradientButton(
                      text: 'txt_back_home'.tr,
                      onPressed: () {
                        controller.back();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _winnerItem() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "@fffff",
          // payloadWinner.username,
          style: TextStyle(
            color: SatorioColor.textBlack,
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          height: 33,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(56)),
              color: SatorioColor.interactive),
          child: Center(
            child: Text(
              "333 SAO",
              // payloadWinner.prize,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    );
  }

  void _congratsBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        clipBehavior: Clip.hardEdge,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        builder: (context) {
          return Container(
              height: 390.0,
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'images/congrats_icon.svg',
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          "txt_congrats".tr,
                          style: TextStyle(
                            color: SatorioColor.textBlack,
                            fontSize: 34.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "txt_congrats_msg".tr,
                          style: TextStyle(
                            color: SatorioColor.textBlack,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "83.33 SAO",
                          style: TextStyle(
                            color: SatorioColor.textBlack,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedGradientButton(
                          text: 'txt_awesome'.tr,
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.11),
                                  width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "txt_solana_link".tr,
                                  style: TextStyle(
                                    color: SatorioColor.darkAccent,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                SvgPicture.asset(
                                  'images/link_icon.svg',
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
