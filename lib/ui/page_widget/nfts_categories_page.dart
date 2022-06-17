import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/nft_categories_controller.dart';
import 'package:satorio/domain/entities/nft_category.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/title_button.dart';

class NftCategoriesPage extends GetView<NftCategoriesController> {
  static const double _threshHold = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          backgroundImage('images/bg/gradient.svg'),
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
    //TODO: uncomment when categories functionality will be added
    // result.addAll(
    //   controller.categoriesRx.value
    //       .map(
    //         (category) => Tab(
    //           text: category.title,
    //         ),
    //       )
    //       .toList(),
    // );

    result.add(
      Tab(
        text: 'txt_all'.tr,
      ),
    );

    return result;
  }

  List<Widget> _generateTabContent(List<NftCategory> value) {
    List<Widget> result = [];
    result.add(_homeTab());
    //TODO: uncomment when categories functionality will be added
    // result.addAll(
    //   controller.categoriesRx.value
    //       .map(
    //         (category) => _nftItemList(category),
    //       )
    //       .toList(),
    // );
    result.add(_allNftsTab());

    return result;
  }

  Widget _nftItemList(final NftCategory nftCategory) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - _threshHold)
          controller.loadItemsByCategory(nftCategory);
        return true;
      },
      child: RefreshIndicator(
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
            itemCount: controller.allNftsRx.value.length,
            itemBuilder: (context, index) {
              final NftItem nftItem = controller.allNftsRx.value[index];
              return _nftItem(nftItem);
            },
          ),
        ),
      ),
    );
  }

  Widget _allNftsTab() {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - _threshHold)
          controller.loadNfts();
        return true;
      },
      child: RefreshIndicator(
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
            itemCount: controller.allNftsRx.value.length,
            itemBuilder: (context, index) {
              final NftItem nftItem = controller.allNftsRx.value[index];
              return _nftItem(nftItem);
            },
          ),
        ),
      ),
    );
  }

  Widget _nftItem(final NftItem nftItem) {
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
                nftItem.nftPreview.isEmpty
                    ? nftItem.nftLink
                    : nftItem.nftPreview,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 12 * coefficient,
          ),
          Container(
            child: Text(
              nftItem.nftMetadata.name,
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
              text: isAndroid
                  ? '${nftItem.buyNowPrice.toStringAsFixed(2)} SAO'
                  : '${controller.setItemPrice(nftItem.priceInUsd)} USD',
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

  Widget _homeTab() {
    return RefreshIndicator(
      color: SatorioColor.brand,
      onRefresh: () async {
        controller.refreshData();
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 16),
          constraints: BoxConstraints(
            minHeight: Get.height -
                kBottomNavigationBarHeight -
                Get.mediaQuery.padding.top -
                kTextTabBarHeight +
                1,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => TitleWithButton(
                    onTap: () => controller.toAllTab(),
                    textCode: controller.nftHomeRx.value?.title ?? 'All',
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
                child: Obx(
                  () {
                    switch (controller.allNftsRx.value.length) {
                      case 0:
                        return Container();
                      case 1:
                        return _homeNft1(
                          controller.allNftsRx.value[0],
                        );
                      case 2:
                        return _homeNft2(
                          controller.allNftsRx.value[0],
                          controller.allNftsRx.value[1],
                        );
                      default:
                        return _homeNft3(
                          controller.allNftsRx.value[0],
                          controller.allNftsRx.value[1],
                          controller.allNftsRx.value[2],
                        );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 34 * coefficient,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeNft1(NftItem nftItem) {
    return Row(
      children: [
        Expanded(
          child: _homeNftItem(nftItem),
        ),
      ],
    );
  }

  Widget _homeNft2(NftItem nftItem1, NftItem nftItem2) {
    return Row(
      children: [
        Expanded(
          child: _homeNftItem(nftItem1),
        ),
        SizedBox(
          width: 15 * coefficient,
        ),
        Expanded(
          child: _homeNftItem(nftItem2),
        ),
      ],
    );
  }

  Widget _homeNft3(NftItem nftItem1, NftItem nftItem2, NftItem nftItem3) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _homeNftItem(nftItem1),
            ),
            SizedBox(
              width: 15 * coefficient,
            ),
            Expanded(
              child: _homeNftItem(nftItem2),
            ),
          ],
        ),
        SizedBox(
          height: 15 * coefficient,
        ),
        Row(
          children: [
            Expanded(
              child: _homeNftItem(nftItem3),
            ),
          ],
        ),
      ],
    );
  }

  Widget _homeNftItem(NftItem nftItem) {
    return InkWell(
      onTap: () {
        controller.toNftItem(nftItem);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(17 * coefficient),
            ),
            child: Image.network(
              nftItem.nftPreview.isEmpty ? nftItem.nftLink : nftItem.nftPreview,
              height: 200,
              width: Get.width,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 8 * coefficient,
          ),
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: isAndroid
                  ? '${nftItem.buyNowPrice.toStringAsFixed(2)}'
                  : '${controller.setItemPrice(nftItem.priceInUsd)}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0 * coefficient,
                fontWeight: FontWeight.w500,
                backgroundColor: Colors.transparent,
              ),
              children: <TextSpan>[
                TextSpan(text: ' '),
                TextSpan(
                  text: isAndroid ? 'SAO' : 'USD',
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
}
