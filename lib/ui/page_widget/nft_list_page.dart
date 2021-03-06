import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/nft_list_controller.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class NftListPage extends GetView<NftListController> {
  static const double _threshHold = 50.0;

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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
          backgroundImage('images/bg/gradient.svg'),
          Container(
            margin: EdgeInsets.only(
                top: Get.mediaQuery.padding.top + kToolbarHeight),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              color: Colors.white,
            ),
            height: Get.mediaQuery.size.height -
                (Get.mediaQuery.padding.top + kToolbarHeight),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent - _threshHold)
                    if (controller.filterType != NftFilterType.User) {
                      controller.loadNfts();
                    }
                  return true;
                },
                child: _nftList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _nftList() {
    return Obx(
      () => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15 * coefficient,
          mainAxisSpacing: 20 * coefficient,
          childAspectRatio: 0.6,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        itemCount: controller.nftItemsRx.value.length,
        itemBuilder: (context, index) {
          final NftItem nftItem = controller.nftItemsRx.value[index];
          return _nftItemWidget(nftItem);
        },
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
                nftItem.nftPreview.isNotEmpty
                    ? nftItem.nftPreview
                    : nftItem.nftLink,
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
          nftItem.onSale
              ? RichText(
                  text: TextSpan(
                    text: isAndroid
                        ? '${nftItem.buyNowPrice.toStringAsFixed(2)} SAO'
                        : '${nftItem.priceInUsd.toStringAsFixed(2)} USD',
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
                )
              : Container(),
        ],
      ),
    );
  }
}
