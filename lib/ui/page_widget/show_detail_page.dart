import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/show_detail_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class ShowDetailPage extends GetView<ShowDetailController> {
  final bottomSheetMinHeight = 250 * coefficient;

  ShowDetailPage(Show show) : super() {
    controller.loadShowDetail(show);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: InkWell(
            onTap: () => controller.back(),
            child: Icon(
              Icons.chevron_left_rounded,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: _bodyContent(),
      bottomSheet: _bottomSheetContent(),
    );
  }

  Widget _bodyContent() {
    return Stack(
      children: [
        Obx(
          () => Image.network(
            controller.showDetailRx.value?.cover ?? '',
            height: Get.height - bottomSheetMinHeight + 24,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: SatorioColor.darkAccent,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: Get.height,
            width: 100 * coefficient,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0)
              ]),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: Get.height,
            width: 100 * coefficient,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0.5)
              ]),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(top: 214, left: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_outline_rounded,
                  size: 22.0 * coefficient,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 6.0 * coefficient,
                ),
                Text(
                  '32',
                  style: textTheme.subtitle2!.copyWith(
                    color: Colors.white,
                    fontSize: 15.0 * coefficient,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 23.0 * coefficient,
                ),
                Icon(
                  Icons.photo_outlined,
                  size: 22.0 * coefficient,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 6.0 * coefficient,
                ),
                Text(
                  '325',
                  style: textTheme.subtitle2!.copyWith(
                    color: Colors.white,
                    fontSize: 15.0 * coefficient,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 23.0 * coefficient,
                ),
                Icon(
                  Icons.mode_comment_outlined,
                  size: 22.0 * coefficient,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 6.0 * coefficient,
                ),
                Text(
                  '35',
                  style: textTheme.subtitle2!.copyWith(
                    color: Colors.white,
                    fontSize: 15.0 * coefficient,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomSheetContent() {
    return Container(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 32, left: 20, right: 20, bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                controller.showDetailRx.value?.title ?? '',
                style: textTheme.headline3!.copyWith(
                  color: Colors.black,
                  fontSize: 24.0 * coefficient,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 4.0 * coefficient,
            ),
            Obx(
              () => Text(
                controller.showDetailRx.value?.description ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.justify,
                style: textTheme.bodyText2!.copyWith(
                  color: Colors.black,
                  fontSize: 15.0 * coefficient,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 20.0 * coefficient,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'txt_challenges_available'.tr,
                  style: textTheme.bodyText2!.copyWith(
                    color: Colors.black,
                    fontSize: 15.0 * coefficient,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 4.0 * coefficient,
                ),
                Expanded(
                  child: Text(
                    '12',
                    textAlign: TextAlign.end,
                    style: textTheme.bodyText2!.copyWith(
                      color: Colors.black,
                      fontSize: 15.0 * coefficient,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0 * coefficient,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'txt_rewards_earned'.tr,
                  style: textTheme.bodyText2!.copyWith(
                    color: Colors.black,
                    fontSize: 15.0 * coefficient,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 4.0 * coefficient,
                ),
                Expanded(
                  child: Text(
                    12.55555555.toStringAsFixed(2),
                    textAlign: TextAlign.end,
                    style: textTheme.bodyText2!.copyWith(
                      color: Colors.black,
                      fontSize: 15.0 * coefficient,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0 * coefficient,
            ),
            SizedBox(
              height: 48.0,
              child: ElevatedGradientButton(
                text: 'txt_episodes'.tr,
                onPressed: () {
                  controller.toEpisodes();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
