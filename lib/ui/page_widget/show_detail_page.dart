import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/show_detail_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class ShowDetailPage extends GetView<ShowDetailController> {
  final bottomSheetMinHeight = 300 * coefficient;

  ShowDetailPage(Show show) : super() {
    controller.loadShowDetail(show);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: _bodyContent(),
      bottomSheet: _bottomSheetContent(),
    );
  }

  Widget _bodyContent() {
    const double kHeight = 120;
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
        Container(
          height: kHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Positioned(
                  top: kHeight / 2,
                  child: InkWell(
                    onTap: () => controller.back(),
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
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
      // height: bottomSheetMinHeight,
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
            Text(
              _descr,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.justify,
              style: textTheme.bodyText2!.copyWith(
                color: Colors.black,
                fontSize: 15.0 * coefficient,
                fontWeight: FontWeight.w400,
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

  final String _descr =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse interdum lectus semper neque pellentesque, nec molestie elit maximus. Nulla et diam at ante pellentesque ornare. Suspendisse dapibus, erat at ullamcorper dignissim, purus justo blandit diam, id eleifend mi lacus venenatis turpis. Nullam id lacus non odio egestas vehicula. Aliquam vitae vulputate nisl. Sed quis sodales quam, et semper turpis. Etiam iaculis elit a mauris pretium, in suscipit velit auctor. Fusce eu iaculis augue.\nIn hac habitasse platea dictumst. Suspendisse porta fringilla erat eu consequat. Etiam malesuada odio non augue ultricies euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec vel rhoncus eros. Nullam eu nisl eu ex finibus consectetur. Cras sit amet eros posuere, mollis mi ut, malesuada ante. Aliquam hendrerit eleifend ante.\nMorbi tempus ante id ornare feugiat. Nullam eget orci ac mauris lobortis tristique in vitae quam. Nulla et nunc rhoncus, venenatis massa sit amet, lacinia velit. Donec facilisis tortor eu urna pharetra, non scelerisque leo auctor. Mauris feugiat, metus id congue ornare, velit augue iaculis elit, vel aliquam nunc tortor quis tortor. Donec vel tincidunt magna. Vivamus eget purus mi. Maecenas purus lectus, scelerisque sed ante pulvinar, varius posuere mauris. Morbi mi sapien, aliquet id dolor et, accumsan commodo nunc. In hac habitasse platea dictumst. Morbi lacinia tincidunt velit, et blandit velit tincidunt eget. Mauris non lectus et sem pulvinar convallis a non tortor.';
}
