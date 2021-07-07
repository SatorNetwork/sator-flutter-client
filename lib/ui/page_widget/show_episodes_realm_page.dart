import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/realm_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class ShowEpisodesRealmPage extends GetView<RealmController> {
  final double kHeight = 220;
  final double bottomSheetMinHeight = Get.mediaQuery.size.height - 320;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: _bodyContent(),
      bottomSheet: _bottomSheetContent(context),
    );
  }

  Widget _bodyContent() {
    // const double kHeight = 220;
    return Stack(
      children: [
        SvgPicture.asset(
          'images/bg/gradient_challenge_splash_reversed.svg',
          height: Get.height,
          fit: BoxFit.cover,
        ),
        //TODO: replace
        // Obx(
        //       () => Image.network(
        //     '',
        //     height: Get.height - bottomSheetMinHeight + 24,
        //     fit: BoxFit.cover,
        //     errorBuilder: (context, error, stackTrace) => Container(
        //       color: SatorioColor.darkAccent,
        //     ),
        //   ),
        // ),
        Container(
          height: kHeight,
          child: Stack(
            children: [
              Positioned(
                top: kHeight / 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
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
              Container(
                margin: EdgeInsets.only(top: kHeight / 3.2),
                width: Get.mediaQuery.size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Breaking Bad',
                      style: textTheme.bodyText2!.copyWith(
                        color: Colors.white,
                        fontSize: 12.0 * coefficient,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'S1.E3 Cat’s in the bag',
                      style: textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: kHeight / 3,
                right: 0,
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  width: 50,
                  height: 44,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: () => controller.back(),
                            child: SvgPicture.asset('images/chat_icon.svg')),
                      ),
                      Positioned(
                        right: 15,
                        bottom: 24,
                        child: ClipOval(
                          child: Container(
                            height: 20,
                            width: 20,
                            color: SatorioColor.brand,
                            child: Center(
                              child: Text(
                                '55',
                                style: textTheme.bodyText2!.copyWith(
                                  color: Colors.white,
                                  fontSize: 9 * coefficient,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: kHeight / 1.6),
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    width: 16,
                  ),
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white.withOpacity(0.6),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Row(
                          children: [
                            SvgPicture.asset('images/locked_icon.svg'),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '24hrs',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 15 * coefficient,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Status',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 12 * coefficient,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bottomSheetContent(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.1,
      maxChildSize: 0.8,
      // height: bottomSheetMinHeight,
      builder: (context, ScrollController scrollController) =>
          SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 32, left: 20, right: 20, bottom: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Obx(
              //       () => Text(
              //     controller.showDetailRx.value?.title ?? '',
              //     style: textTheme.headline3!.copyWith(
              //       color: Colors.black,
              //       fontSize: 24.0 * coefficient,
              //       fontWeight: FontWeight.w700,
              //     ),
              //   ),
              // ),
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final String _descr =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse interdum lectus semper neque pellentesque, nec molestie elit maximus. Nulla et diam at ante pellentesque ornare. Suspendisse dapibus, erat at ullamcorper dignissim, purus justo blandit diam, id eleifend mi lacus venenatis turpis. Nullam id lacus non odio egestas vehicula. Aliquam vitae vulputate nisl. Sed quis sodales quam, et semper turpis. Etiam iaculis elit a mauris pretium, in suscipit velit auctor. Fusce eu iaculis augue.\nIn hac habitasse platea dictumst. Suspendisse porta fringilla erat eu consequat. Etiam malesuada odio non augue ultricies euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec vel rhoncus eros. Nullam eu nisl eu ex finibus consectetur. Cras sit amet eros posuere, mollis mi ut, malesuada ante. Aliquam hendrerit eleifend ante.\nMorbi tempus ante id ornare feugiat. Nullam eget orci ac mauris lobortis tristique in vitae quam. Nulla et nunc rhoncus, venenatis massa sit amet, lacinia velit. Donec facilisis tortor eu urna pharetra, non scelerisque leo auctor. Mauris feugiat, metus id congue ornare, velit augue iaculis elit, vel aliquam nunc tortor quis tortor. Donec vel tincidunt magna. Vivamus eget purus mi. Maecenas purus lectus, scelerisque sed ante pulvinar, varius posuere mauris. Morbi mi sapien, aliquet id dolor et, accumsan commodo nunc. In hac habitasse platea dictumst. Morbi lacinia tincidunt velit, et blandit velit tincidunt eget. Mauris non lectus et sem pulvinar convallis a non tortor.';
}
