import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/nft_categories_controller.dart';
import 'package:satorio/domain/entities/nft_category.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/nft_preview.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/title_button.dart';

class NftCategoriesPage extends GetView<NftCategoriesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            child: SvgPicture.asset(
              'images/bg/gradient.svg',
              height: Get.height,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
                color: Colors.white,
                child: Center(
                  child: Obx(
                    () => TabBar(
                      controller: controller.tabController,
                      indicatorColor: SatorioColor.interactive,
                      labelColor: SatorioColor.interactive,
                      isScrollable: true,
                      unselectedLabelColor: SatorioColor.darkAccent,
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: 16.0 * coefficient),
                      labelStyle: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.darkAccent,
                        fontSize: 17 * coefficient,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: _generateTab(controller.categoriesRx.value),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => TabBarView(
                    controller: controller.tabController,
                    children:
                        _generateTabContent(controller.categoriesRx.value),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _generateTab(List<NftCategory> value) {
    List<Widget> result = [];
    result.add(
      Tab(
        text: 'txt_home'.tr,
      ),
    );
    result.addAll(
      controller.categoriesRx.value
          .map(
            (category) => Tab(
              text: category.title,
            ),
          )
          .toList(),
    );

    return result;
  }

  List<Widget> _generateTabContent(List<NftCategory> value) {
    List<Widget> result = [];
    result.add(_home());
    result.addAll(
      controller.categoriesRx.value
          .map(
            (category) => _nftItemListWidget(category),
          )
          .toList(),
    );

    return result;
  }

  Widget _nftItemListWidget(final NftCategory nftCategory) {
    return RefreshIndicator(
      color: SatorioColor.brand,
      onRefresh: () async {
        controller.refreshData();
      },
      child: Obx(
        () => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15 * coefficient,
            mainAxisSpacing: 20 * coefficient,
            childAspectRatio: 0.6,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          itemCount: controller.itemsRx.value[nftCategory.id]?.length ?? 0,
          itemBuilder: (context, index) {
            final NftItem nftItem =
                controller.itemsRx.value[nftCategory.id]![index];
            return _nftItemWidget(nftItem);
          },
        ),
      ),
    );
  }

  Widget _nftItemWidget(final NftItem nftItem) {
    return InkWell(
      onTap: () {
        controller.toNftItem(nftItem);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Image.network(
                nftItem.imageLink,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 12 * coefficient,
          ),
          Container(
            child: Text(
              nftItem.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyText2!.copyWith(
                color: SatorioColor.textBlack,
                fontSize: 12.0 * coefficient,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 8 * coefficient,
          ),
          RichText(
            text: TextSpan(
              text: '${nftItem.buyNowPrice.toStringAsFixed(2)} SAO',
              style: TextStyle(
                color: SatorioColor.textBlack,
                fontSize: 12.0 * coefficient,
                fontWeight: FontWeight.w500,
                backgroundColor: Colors.transparent,
              ),
              // children: <TextSpan>[
              //   TextSpan(
              //     text: '/ \$1,300',
              //     style: TextStyle(
              //       color: SatorioColor.comet,
              //       fontSize: 12.0 * coefficient,
              //       fontWeight: FontWeight.w500,
              //       backgroundColor: Colors.transparent,
              //     ),
              //   ),
              // ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _home() {
    return RefreshIndicator(
      color: SatorioColor.brand,
      onRefresh: () async {
        controller.refreshData();
      },
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => TitleWithButton(
                    onTap: controller.nftHomeRx.value == null
                        ? () {}
                        : () {
                            controller.toNftCategory(
                              controller.nftHomeRx.value!.id,
                            );
                          },
                    textCode: controller.nftHomeRx.value?.title ?? '',
                    fontSize: 24.0 * coefficient,
                    fontWeight: FontWeight.w700,
                    buttonText: 'txt_view'.tr,
                    color: Colors.black,
                    iconColor: SatorioColor.darkAccent,
                  ),
                ),
              ),
              SizedBox(
                height: 20 * coefficient,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () {
                              NftItem? item = controller.nftHomeRx.value !=
                                          null &&
                                      controller.nftHomeRx.value!.items.length >
                                          0
                                  ? controller.nftHomeRx.value!.items[0]
                                  : null;
                              return _homeNftItem(item);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15 * coefficient,
                        ),
                        Expanded(
                          child: Obx(
                            () {
                              NftItem? item = controller.nftHomeRx.value !=
                                          null &&
                                      controller.nftHomeRx.value!.items.length >
                                          1
                                  ? controller.nftHomeRx.value!.items[1]
                                  : null;
                              return _homeNftItem(item);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15 * coefficient,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () {
                              NftItem? item = controller.nftHomeRx.value !=
                                          null &&
                                      controller.nftHomeRx.value!.items.length >
                                          2
                                  ? controller.nftHomeRx.value!.items[2]
                                  : null;
                              return _homeNftItem(item);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 34 * coefficient,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TitleWithButton(
                  onTap: () {
                    controller.toNonWorkingFeatureDialog();
                  },
                  textCode: 'txt_all_shows'.tr,
                  fontSize: 24.0 * coefficient,
                  fontWeight: FontWeight.w700,
                  buttonText: 'View',
                  color: Colors.black,
                  iconColor: SatorioColor.darkAccent,
                ),
              ),
              SizedBox(
                height: 10 * coefficient,
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                height: 168 * coefficient,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 16,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: nftsList.length,
                  itemBuilder: (context, index) {
                    NFTPreview nftPreview = nftsList[index];
                    return _homeShowItem(nftPreview);
                  },
                ),
              ),
              SizedBox(
                height: 15 * coefficient,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeNftItem(NftItem? nftItem) {
    return InkWell(
      onTap: nftItem == null
          ? null
          : () {
              controller.toNftItem(nftItem);
            },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(17 * coefficient),
            ),
            child: nftItem != null
                ? Image.network(
                    nftItem.imageLink,
                    height: 200,
                    width: Get.width,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 200,
                    width: Get.width,
                  ),
          ),
          SizedBox(
            height: 8 * coefficient,
          ),
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: nftItem?.buyNowPrice.toStringAsFixed(2) ?? '',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0 * coefficient,
                fontWeight: FontWeight.w500,
                backgroundColor: Colors.transparent,
              ),
              children: <TextSpan>[
                TextSpan(text: ' '),
                TextSpan(
                  text: nftItem != null ? 'SAO' : '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0 * coefficient,
                    fontWeight: FontWeight.w500,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeShowItem(NFTPreview nftPreview) {
    final double width = 125.0;
    return InkWell(
      onTap: () {
        controller.toNonWorkingFeatureDialog();
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                  color: Colors.white,
                  child: Image.asset(
                    nftPreview.cover,
                    width: width,
                    height: width,
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              height: 2 * coefficient,
            ),
            Expanded(
              child: Text(
                nftPreview.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: textTheme.headline4!.copyWith(
                  color: Colors.black,
                  fontSize: 15.0 * coefficient,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<NFTPreview> nftsList = [
    NFTPreview('Ballers', 'images/tmp_nft_show_1.jpg'),
    NFTPreview('Breaking Bad', 'images/tmp_nft_show_2.jpg'),
    NFTPreview('Entourage', 'images/tmp_nft_show_3.jpg'),
    NFTPreview('Friends', 'images/tmp_nft_show_4.jpg'),
    NFTPreview('Grace and Frankie', 'images/tmp_nft_show_5.jpg'),
    NFTPreview('HODL', 'images/tmp_nft_show_6.jpg'),
    NFTPreview('How To Make It In America', 'images/tmp_nft_show_7.jpg'),
    NFTPreview('Loki', 'images/tmp_nft_show_8.jpg'),
    NFTPreview('Nine Perfect Strangers', 'images/tmp_nft_show_9.jpg'),
    NFTPreview(
        'The Falcon and the Winter Soldier', 'images/tmp_nft_show_10.jpg'),
  ];
}
