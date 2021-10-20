import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/nft_categories_controller.dart';
import 'package:satorio/domain/entities/nft_category.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

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
          Container(
            margin: EdgeInsets.only(top: Get.mediaQuery.padding.top),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  child: Center(
                    child: Obx(
                      () => TabBar(
                        controller: controller.tabController,
                        indicatorColor: SatorioColor.interactive,
                        labelColor: SatorioColor.interactive,
                        isScrollable: true,
                        unselectedLabelColor: SatorioColor.darkAccent,
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: 16.0 * coefficient),
                        labelStyle: textTheme.bodyText2!.copyWith(
                          color: SatorioColor.darkAccent,
                          fontSize: 17 * coefficient,
                          fontWeight: FontWeight.w500,
                        ),
                        tabs: controller.categoriesRx.value
                            .map(
                              (category) => Tab(
                                text: category.title,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => TabBarView(
                      controller: controller.tabController,
                      children: controller.categoriesRx.value
                          .map(
                            (category) => _nftItemListWidget(category),
                          )
                          .toList(),
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
}
