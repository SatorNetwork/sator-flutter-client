import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/show_detail_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class ShowDetailPage extends GetView<ShowDetailController> {

  final RxBool expanded = true.obs;

  final bottomSheetMinHeight = 342;

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
                  size: 22,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '32',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 23,
                ),
                Icon(
                  Icons.photo_outlined,
                  size: 22,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '325',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 23,
                ),
                Icon(
                  Icons.mode_comment_outlined,
                  size: 22,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '35',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
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
    final double minSize = bottomSheetMinHeight / Get.height;
    final double maxSize =
        (Get.height - Get.mediaQuery.padding.top - 1) / Get.height;

    return DraggableScrollableSheet(
      initialChildSize: minSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      expand: false,
      builder: (context, scrollController) => LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          controller: scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 32, left: 20, right: 20, bottom: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        controller.showDetailRx.value?.title ?? '',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Expanded(
                      child: Obx(
                          () => Text(
                            '1\n2\n3\n1\n2\n3\n1\n2\n3\n1\n2\n3\n1\n2\n3\n1\n2\n3\n1\n2\n3\n1\n2\n3\n1\n2\n3\n1\n2\n3\n1\n2\n3\n1\n2\n3\n',
                            overflow: TextOverflow.ellipsis,
                            maxLines: expanded.value ? null : 4,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_circle_outline_rounded,
                          size: 20,
                          color: SatorioColor.darkAccent.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'txt_watch_trailer'.tr,
                            style: TextStyle(
                              color: SatorioColor.darkAccent.withOpacity(0.5),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'txt_challenges_available'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            '12',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'txt_rewards_earned'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            12.55555555.toStringAsFixed(2),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 48,
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
            ),
          ),
        ),
      ),
    );
  }
}
