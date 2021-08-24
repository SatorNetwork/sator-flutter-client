import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/shows_category_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class ShowsCategoryPage extends GetView<ShowsCategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Obx(
          () => Text(
            controller.titleRx.value,
            style: textTheme.bodyText1!.copyWith(
              color: SatorioColor.darkAccent,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
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
          SvgPicture.asset(
            'images/bg/gradient.svg',
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Container(
            constraints: BoxConstraints(
                minHeight: Get.mediaQuery.size.height -
                    (Get.mediaQuery.padding.top + kToolbarHeight)),
            margin: EdgeInsets.only(
                top: Get.mediaQuery.padding.top + kToolbarHeight),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _showsList(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _showsList() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        color: Colors.white,
      ),
      child: Obx(
        () => ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(
            height: 17 * coefficient,
          ),
          itemCount: controller.showsRx.value.length,
          itemBuilder: (context, index) {
            final Show show = controller.showsRx.value[index];
            return _showItem(show);
          },
        ),
      ),
    );
  }

  Widget _showItem(Show show) {
    final width = Get.width - 20 - 20;
    final height = 168.0 * coefficient;
    return InkWell(
      onTap: () {
        controller.toShowDetail(show);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: width,
          height: height,
          child: Stack(
            children: [
              Image(
                width: width,
                height: height,
                fit: BoxFit.cover,
                image: NetworkImage(show.cover),
                errorBuilder: (context, error, stackTrace) => Container(
                  color: SatorioColor.grey,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          show.title,
                          style: textTheme.headline4!.copyWith(
                            color: Colors.white,
                            fontSize: 20.0 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 7,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: SatorioColor.lavender_rose,
                        ),
                        child: Text(
                          'NFT',
                          style: textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            fontSize: 12.0 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
