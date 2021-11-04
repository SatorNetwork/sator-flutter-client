import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/reviews_controller.dart';
import 'package:satorio/domain/entities/review.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/util/smile_list.dart';

class ReviewsPage extends GetView<ReviewsController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'txt_reviews'.tr,
          style: textTheme.bodyText1!.copyWith(
            color: SatorioColor.darkAccent,
            fontSize: 24,
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
      body: Stack(
        children: [
          Container(
            color: SatorioColor.darkAccent,
            child: Column(
              children: [
                backgroundImage('images/bg/gradient.svg'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              color: Colors.white,
            ),
            child: ClipRRect(
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(32)),
                child: Stack(children: [
                  NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification.metrics.pixels >=
                          notification.metrics.maxScrollExtent - 100)
                        controller.loadReviews();
                      return true;
                    },
                    child: _reviews(),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 40,
                      width: Get.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(1),
                            Colors.white.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ])),
          )
        ],
      ),
    );
  }

  Widget _reviews() {
    return Obx(
    () => ListView.separated(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          itemCount: controller.reviewsRx.value.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(
            height: 16,
          ),
          itemBuilder: (context, index) {
            return _reviewItem(controller.reviewsRx.value[index]);
          }),
    );
  }


  Widget _reviewItem(Review review) {
    Rx<bool> isExpandedRx = Rx(false);
    final int minStringLength = 45;

    return Obx(
        () => InkWell(
        onTap: () {
          if (review.review.length < 70) return;
          isExpandedRx.value = !isExpandedRx.value;
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 16, top: 16),
          width: Get.mediaQuery.size.width - 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(13),
            ),
            color: SatorioColor.alice_blue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      smile[review.rating] ?? '',
                      width: 24 * coefficient,
                      height: 24 * coefficient,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      child: Text(
                        review.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyText1!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 18 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Text(
                  review.review,
                  maxLines: isExpandedRx.value ? 1000 : review.review.length < minStringLength ? 1 : 4,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyText2!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 15 * coefficient,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16, left: 20, right: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      SatorioColor.alice_blue2,
                      SatorioColor.alice_blue,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  SatorioColor.yellow_orange,
                                  SatorioColor.tomato,
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            review.userName,
                            style: textTheme.bodyText2!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 15 * coefficient,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     SvgPicture.asset(
                    //       'images/like_icon.svg',
                    //       color: SatorioColor.textBlack,
                    //     ),
                    //     SizedBox(
                    //       width: 8,
                    //     ),
                    //     Text(
                    //       review.likes.toString(),
                    //       style: textTheme.bodyText2!.copyWith(
                    //         color: SatorioColor.textBlack,
                    //         fontSize: 14 * coefficient,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 15,
                    //     ),
                    //     Container(
                    //       height: 24,
                    //       width: 24,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: SatorioColor.interactive,
                    //       ),
                    //       child: Center(
                    //         child: SvgPicture.asset(
                    //           'images/sator_logo.svg',
                    //           width: 12,
                    //           height: 12,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 4,
                    //     ),
                    //     Text(
                    //       'txt_tip'.tr,
                    //       style: textTheme.bodyText2!.copyWith(
                    //         color: SatorioColor.interactive,
                    //         fontSize: 14 * coefficient,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
