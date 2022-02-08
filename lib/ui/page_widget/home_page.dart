import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/home_controller.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/show_category.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/avatar_image.dart';
import 'package:satorio/ui/widget/title_button.dart';
import 'package:satorio/util/avatar_list.dart';

class HomePage extends GetView<HomeController> {
  final int avatarIndex = Random().nextInt(avatars.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: RefreshIndicator(
        color: SatorioColor.brand,
        onRefresh: () async {
          controller.refreshHomePage();
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: SatorioColor.darkAccent,
                child: Stack(
                  children: [
                    backgroundImage('images/bg/gradient.svg'),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 76, right: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller.toProfile();
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Center(
                                            child: Obx(() =>
                                                controller.profileRx.value ==
                                                            null ||
                                                        controller
                                                            .profileRx
                                                            .value!
                                                            .avatarPath
                                                            .isEmpty
                                                    ? Image.asset(
                                                        'images/null_avatar.png',
                                                        width: 50,
                                                        height: 50,
                                                        fit: BoxFit.fitWidth,
                                                      )
                                                    : AvatarImage(
                                                        controller.profileRx
                                                            .value!.avatarPath,
                                                        width: 50,
                                                        height: 50,
                                                      )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => Text(
                                          controller.profileRx.value
                                                  ?.displayedName ??
                                              '',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.headline1!.copyWith(
                                              color: SatorioColor.darkAccent,
                                              fontSize: 14.0 * coefficient,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.toWallet();
                              },
                              child: Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      controller.walletRx.value.length > 0
                                          ? controller
                                              .walletRx.value[0].displayedValue
                                          : '',
                                      style: textTheme.bodyText1!.copyWith(
                                        color: SatorioColor.darkAccent,
                                        fontSize: 18.0 * coefficient,
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
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 160),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  color: Colors.white,
                ),
                child: _contentWithCategories(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentWithCategories() {
    final RxInt _itemsPerPage = 3.obs;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => controller.nftHomeRx.value.length != 0
              ? Padding(
                  padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                  child: TitleWithButton(
                    textCode: 'txt_featured_nfts'.tr,
                    onTap: () {
                      controller.toNfts();
                    },
                  ),
                )
              : Container(),
        ),
        Obx(
          () => controller.nftHomeRx.value.length != 0
              ? Container(
                  margin: const EdgeInsets.only(top: 16),
                  height: 125 * coefficient,
                  child: Obx(
                    () => ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 12,
                      ),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _itemsPerPage.value,
                      itemBuilder: (context, index) {

                        final NftItem nftItem =
                            controller.nftHomeRx.value[index];
                        return _nftItem(nftItem);
                      },
                    ),
                  ),
                )
              : Container(),
        ),
        _categories(),
        Obx(
          () => controller.allShowsRx.value.length != 0
              ? Padding(
                  padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                  child: TitleWithButton(
                    textCode: 'All realms',
                    onTap: () {
                      controller.toAllShows();
                    },
                  ),
                )
              : Container(),
        ),
        Obx(
          () => controller.allShowsRx.value.length != 0
              ? Container(
                  margin: const EdgeInsets.only(top: 16),
                  height: 168 * coefficient,
                  child: Obx(
                    () => ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 16,
                      ),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: controller.allShowsRx.value.length,
                      itemBuilder: (context, index) {
                        Show show = controller.allShowsRx.value[index];
                        return _showItem(show);
                      },
                    ),
                  ),
                )
              : Container(),
        ),
        SizedBox(
          height: 24,
        )
      ],
    );
  }

  Widget _categories() {
    return Obx(
      () => ListView.separated(
        separatorBuilder: (context, categoryIndex) => SizedBox(
          height: controller.categoriesRx.value[categoryIndex].shows.length != 0
              ? 16
              : 0,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.categoriesRx.value.length,
        itemBuilder: (context, categoryIndex) {
          ShowCategory category = controller.categoriesRx.value[categoryIndex];
          return Column(
            children: [
              Obx(
                () =>
                    controller.categoriesRx.value[categoryIndex].shows.length !=
                            0
                        ? Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TitleWithButton(
                              textCode: category.title,
                              onTap: () {
                                controller.toShowsCategory(category);
                              },
                            ),
                          )
                        : Container(),
              ),
              Obx(
                () => controller
                            .categoriesRx.value[categoryIndex].shows.length !=
                        0
                    ? Container(
                        margin: const EdgeInsets.only(top: 16),
                        height: 168 * coefficient,
                        child: Obx(
                          () => ListView.separated(
                            separatorBuilder: (context, showIndex) => SizedBox(
                              width: 16,
                            ),
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: controller
                                .categoriesRx.value[categoryIndex].shows.length,
                            itemBuilder: (context, showIndex) {
                              Show show = controller.categoriesRx
                                  .value[categoryIndex].shows[showIndex];
                              return _showItem(show);
                            },
                          ),
                        ),
                      )
                    : Container(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _showItem(Show show) {
    final width = Get.width - 20 - 32;
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
              CachedNetworkImage(
                imageUrl: show.cover,
                cacheKey: show.cover,
                width: width,
                height: height,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
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
                      show.hasNft
                          ? InkWell(
                              onTap: () {
                                controller.toShowNfts(show.id);
                              },
                              child: Container(
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
                              ),
                            )
                          : Container()
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

  Widget _nftItem(final NftItem nftItem) {
    final width = (Get.width - 12 - 2 * 20 - 8) / 2;
    final height = 125 * coefficient;
    return InkWell(
      onTap: () {
        controller.toNftItem(nftItem);
      },
      child: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                nftItem.nftPreview.isEmpty ? nftItem.nftLink :
                nftItem.nftPreview,
                width: width,
                height: height - 25 * coefficient,
                fit: BoxFit.cover,
              ),
            ),
            // Expanded(
            //   child: Row(
            //     mainAxisSize: MainAxisSize.max,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Container(
            //         width: 18 * coefficient,
            //         height: 18 * coefficient,
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           gradient: LinearGradient(
            //             begin: Alignment.topCenter,
            //             end: Alignment.bottomCenter,
            //             colors: [
            //               SatorioColor.razzle_dazzle_rose,
            //               SatorioColor.dodger_blue
            //             ],
            //           ),
            //         ),
            //         child: Center(
            //           child: SvgPicture.asset(
            //             'images/sator_logo.svg',
            //             width: 9 * coefficient,
            //             height: 9 * coefficient,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         width: 6 * coefficient,
            //       ),
            //       // Expanded(
            //       //   child: Text(
            //       //     '${nftItem.buyNowPrice.toStringAsFixed(2)} SAO',
            //       //     maxLines: 1,
            //       //     overflow: TextOverflow.ellipsis,
            //       //     style: textTheme.bodyText2!.copyWith(
            //       //       color: Colors.black,
            //       //       fontSize: 12.0 * coefficient,
            //       //       fontWeight: FontWeight.w500,
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
