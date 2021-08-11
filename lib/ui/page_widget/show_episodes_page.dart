import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/show_episodes_controller.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
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
        title: Obx(
          () => Text(
            controller.showDetailRx.value.title,
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
          Obx(
            () => Container(
              margin: EdgeInsets.only(
                top: Get.mediaQuery.padding.top + kToolbarHeight,
              ),
              height: _tabBarHeight(),
              width: Get.width,
              child: Center(
                child: TabBar(
                  indicatorColor: _isTabBarVisible()
                      ? SatorioColor.interactive
                      : Colors.transparent,
                  automaticIndicatorColorAdjustment: false,
                  labelColor: SatorioColor.interactive,
                  isScrollable: true,
                  unselectedLabelColor: SatorioColor.darkAccent,
                  controller: controller.tabController,
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 16.0 * coefficient),
                  labelStyle: textTheme.headline4!.copyWith(
                    color: SatorioColor.darkAccent,
                    fontSize: 20 * coefficient,
                    fontWeight: FontWeight.w700,
                  ),
                  tabs: controller.seasonsRx.value
                      .map(
                        (showSeason) => Tab(
                          text: showSeason.title,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.only(
                top: Get.mediaQuery.padding.top +
                    kToolbarHeight +
                    _tabBarHeight() +
                    24 * coefficient,
              ),
              child: TabBarView(
                controller: controller.tabController,
                children: controller.seasonsRx.value
                    .map(
                      (showSeason) => _episodesList(showSeason),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _episodesList(ShowSeason showSeason) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        color: Colors.white,
      ),
      child: RefreshIndicator(
        color: SatorioColor.brand,
        onRefresh: () async {
          controller.refreshSeasons();
        },
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          separatorBuilder: (context, index) => SizedBox(
            height: 17 * coefficient,
          ),
          itemCount: showSeason.episodes.length,
          itemBuilder: (context, index) {
            final ShowEpisode showEpisode = showSeason.episodes[index];
            return _episode(showSeason, showEpisode);
          },
        ),
      ),
    );
  }

  Widget _episode(ShowSeason showSeason, ShowEpisode showEpisode) {
    return InkWell(
      onTap: () {
        controller.toEpisodeDetail(showSeason, showEpisode);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 180 * coefficient,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                child: Image(
                  image: NetworkImage(showEpisode.cover),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: SatorioColor.grey,
                  ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          showEpisode.title,
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
      ),
    );
  }

  double _tabBarHeight() {
    return _isTabBarVisible() ? kTextTabBarHeight : 0.0;
  }

  bool _isTabBarVisible() {
    return !(controller.seasonsRx.value.length == 1 &&
        controller.seasonsRx.value[0].seasonNumber == 0);
  }
}
