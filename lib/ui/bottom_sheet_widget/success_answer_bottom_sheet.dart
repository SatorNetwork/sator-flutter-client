import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/payload/payload_question_result.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/util/extension.dart';

class SuccessAnswerBottomSheet extends StatelessWidget {
  const SuccessAnswerBottomSheet(this.data);

  final PayloadQuestionResult data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.stars_rounded,
                size: 32,
                color: data.rate > 0
                    ? SatorioColor.interactive
                    : SatorioColor.grey,
              ),
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.stars_rounded,
                size: 48,
                color: data.rate > 1
                    ? SatorioColor.interactive
                    : SatorioColor.grey,
              ),
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.stars_rounded,
                size: 32,
                color: data.rate > 2
                    ? SatorioColor.interactive
                    : SatorioColor.grey,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'txt_keep_going'.tr,
            style: TextStyle(
              color: SatorioColor.darkAccent,
              fontSize: 28.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            'txt_questions_left'.tr.format([data.questionsLeft]),
            style: TextStyle(
              color: SatorioColor.darkAccent,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'txt_wait_time_runs_out'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: SatorioColor.textBlack,
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 44,
          ),
          RichText(
            text: TextSpan(
              text: 'txt_fastest_answer'.tr,
              style: TextStyle(
                color: SatorioColor.textBlack,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: data.additionalPts > 0
                      ? 'txt_add_pts'.tr.format([data.additionalPts])
                      : '',
                  style: TextStyle(
                    color: SatorioColor.textBlack,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
