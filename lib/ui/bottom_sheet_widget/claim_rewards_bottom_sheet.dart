import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:satorio/data/model/payload/payload_winner_model.dart';
// import 'package:satorio/domain/entities/payload/payload_winner.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class ClaimRewardsBottomSheet extends StatelessWidget {
  const ClaimRewardsBottomSheet(this.data);
  //TODO: replace
  final PayloadWinnerModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
      ),
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
                data.prize,
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
    );
  }
}
