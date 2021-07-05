import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/show_episodes_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class ShowEpisodesPage extends GetView<ShowEpisodesController> {
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
          'Show Title',
          style: textTheme.bodyText1!.copyWith(
            color: SatorioColor.darkAccent,
            fontSize: 17,
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
        bottom: TabBar(
          indicatorColor: SatorioColor.interactive,
          labelColor: SatorioColor.interactive,
          isScrollable: true,
          unselectedLabelColor: SatorioColor.darkAccent,
          controller: controller.tabController,
          labelPadding: EdgeInsets.symmetric(horizontal: 16.0 * coefficient),
          labelStyle: textTheme.headline4!.copyWith(
            color: SatorioColor.darkAccent,
            fontSize: 20 * coefficient,
            fontWeight: FontWeight.w700,
          ),
          tabs: [
            Tab(
              text: 'Season 1',
            ),
            Tab(
              text: 'Season 2',
            ),
          ],
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
            margin: EdgeInsets.only(
              top: Get.mediaQuery.padding.top +
                  kToolbarHeight +
                  kTextTabBarHeight +
                  24 * coefficient,
            ),
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _episodesList(),
                _episodesList(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _episodesList() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        color: Colors.white,
      ),
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        separatorBuilder: (context, index) => SizedBox(
          height: 17 * coefficient,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return _episode();
        },
      ),
    );
  }

  Widget _episode() {
    final int h = (180 * coefficient).round();
    final int w = (Get.width - 2 * 20).round();

    return InkWell(
      child: Container(
        height: 180 * coefficient,
        child: Stack(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  image: NetworkImage('https://picsum.photos/$w/$h'),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: SatorioColor.grey,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        '1. Pilot',
                        style: textTheme.headline5!.copyWith(
                          color: Colors.white,
                          fontSize: 18 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      'WATCHED',
                      style: textTheme.headline6!.copyWith(
                        color: Colors.white,
                        fontSize: 12 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
