import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/show_detail_with_episodes_controller.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class ShowDetailWithEpisodesPage
    extends GetView<ShowDetailWithEpisodesController> {
  get appBarHeight => 411 * coefficient;

  get tabsBlockHeight => _tabBarHeight() + 32 + 16 + 36 * coefficient;

  get episodesBlockHeight =>
      Get.height -
      Get.mediaQuery.padding.top -
      kToolbarHeight -
      tabsBlockHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => controller.showDetailRx.value == null
                ? Container(
                    width: Get.width,
                    height: Get.mediaQuery.padding.top + appBarHeight + 32,
                    color: SatorioColor.darkAccent,
                  )
                : CachedNetworkImage(
                    imageUrl: controller.showDetailRx.value!.cover,
                    cacheKey: controller.showDetailRx.value!.cover,
                    width: Get.width,
                    height: Get.mediaQuery.padding.top + appBarHeight + 32,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Container(
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
          RefreshIndicator(
            color: SatorioColor.brand,
            onRefresh: () async {
              controller.refreshShowData();
            },
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: appBarHeight,
                  collapsedHeight: kToolbarHeight,
                  floating: true,
                  pinned: true,
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
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    collapseMode: CollapseMode.none,
                    title: Obx(
                      () => Text(
                        controller.showDetailRx.value?.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyText2!.copyWith(
                          color: Colors.white
                              .withOpacity(controller.titleAlphaRx.value),
                          fontSize: 17.0 * coefficient,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    background: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 214 * coefficient),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    controller.clap();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'images/show/claps.svg',
                                        width: 22.0 * coefficient,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 6.0 * coefficient,
                                      ),
                                      Obx(
                                        () => Text(
                                          controller.showDetailRx.value?.claps
                                                  .toString() ??
                                              '',
                                          style: textTheme.subtitle2!.copyWith(
                                            color: Colors.white,
                                            fontSize: 15.0 * coefficient,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 23.0 * coefficient,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ImageIcon(
                                        AssetImage("images/show/nft.png"),
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
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 23.0 * coefficient,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.toNetflixDialog();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'images/show/watch.svg',
                                        width: 22.0 * coefficient,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 6.0 * coefficient,
                                      ),
                                      Text(
                                        'Watch',
                                        style: textTheme.subtitle2!.copyWith(
                                          color: Colors.white,
                                          fontSize: 15.0 * coefficient,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                        controller,
                        _tabBarHeight(),
                        _isSingleZeroSeason()
                            ? 'txt_realms'.tr
                            : 'txt_episodes'.tr),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Obx(
                    () => Container(
                      height: episodesBlockHeight,
                      child: controller.seasonsRx.value.length > 0
                          ? TabBarView(
                              controller: controller.tabController,
                              children: controller.seasonsRx.value
                                  .map(
                                    (showSeason) => _episodesList(showSeason),
                                  )
                                  .toList(),
                            )
                          : Container(
                              color: Colors.white,
                              height: episodesBlockHeight,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _episodesList(ShowSeason showSeason) {
    return Container(
      color: Colors.white,
      height: episodesBlockHeight,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        separatorBuilder: (context, index) => SizedBox(
          height: 17 * coefficient,
        ),
        itemCount: showSeason.episodes.length,
        itemBuilder: (context, index) {
          final ShowEpisode showEpisode = showSeason.episodes[index];
          return _episode(showSeason, showEpisode);
        },
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
                child: CachedNetworkImage(
                  imageUrl: showEpisode.cover,
                  cacheKey: showEpisode.cover,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
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
                      // Text(
                      //   'WATCHED',
                      //   style: textTheme.headline6!.copyWith(
                      //     color: Colors.white,
                      //     fontSize: 12 * coefficient,
                      //     fontWeight: FontWeight.w700,
                      //   ),
                      // ),
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
    return _isSingleZeroSeason() ? 0.0 : kTextTabBarHeight;
  }

  bool _isSingleZeroSeason() {
    return controller.seasonsRx.value.length == 1 &&
        controller.seasonsRx.value[0].seasonNumber == 0;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.controller, this.tabBarHeight, this.title);

  final ShowDetailWithEpisodesController controller;
  final double tabBarHeight;
  final String title;

  @override
  double get minExtent => tabBarHeight + 32 + 16 + 36 * coefficient;

  @override
  double get maxExtent => tabBarHeight + 32 + 16 + 36 * coefficient;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              controller.toggleBottomSheet();
            },
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 32,
                bottom: 16,
              ),
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: textTheme.headline3!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 28 * coefficient,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Obx(
            () => Container(
              height: tabBarHeight,
              child: Center(
                child: TabBar(
                  indicatorColor: tabBarHeight > 0
                      ? SatorioColor.interactive
                      : Colors.transparent,
                  automaticIndicatorColorAdjustment: false,
                  labelColor: SatorioColor.interactive,
                  isScrollable: true,
                  unselectedLabelColor: SatorioColor.darkAccent,
                  controller: controller.tabController,
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 16.0 * coefficient),
                  labelStyle: textTheme.bodyText2!.copyWith(
                    color: SatorioColor.darkAccent,
                    fontSize: 17 * coefficient,
                    fontWeight: FontWeight.w500,
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
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return oldDelegate.tabBarHeight != tabBarHeight;
  }
}
