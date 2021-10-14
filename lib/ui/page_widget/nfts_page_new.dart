import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/nfts_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class NFTsPageNew extends GetView<NFTsController> {
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
                    child: TabBar(
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
                      tabs: controller.tabTitles
                          .map(
                            (title) => Tab(
                              text: title,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: controller.tabTitles
                        .map((e) => _nftsListWidget())
                        .toList(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _nftsListWidget() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15 * coefficient,
        mainAxisSpacing: 20 * coefficient,
        childAspectRatio: 0.6,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      itemCount: 9,
      itemBuilder: (context, index) {
        return _nftItemWidget();
      },
    );
  }

  Widget _nftItemWidget() {
    return InkWell(
      onTap: () {
        controller.toItemDetail();
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Image.asset(
                'images/tmp_nft_item.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 12 * coefficient,
          ),
          Container(
            height: 2 * (12 + 4),
            child: Text(
              'An Electric Storm (1/1 NFT + AR physical, 2021)',
              maxLines: 2,
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
              text: '32,284 sao',
              style: TextStyle(
                color: SatorioColor.textBlack,
                fontSize: 12.0 * coefficient,
                fontWeight: FontWeight.w500,
                backgroundColor: Colors.transparent,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '/ \$1,300',
                  style: TextStyle(
                    color: SatorioColor.comet,
                    fontSize: 12.0 * coefficient,
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
