import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/nfts_controller.dart';
import 'package:satorio/domain/entities/nft_preview.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/title_button.dart';

class NFTsPage extends GetView<NFTsController> {
  @override
  Widget build(BuildContext context) {
    final double topMargin = 160 * coefficient;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.7),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: null,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(
                color: SatorioColor.darkAccent,
                fontSize: 14.0 * coefficient,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Image.asset('images/search.png'),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: RefreshIndicator(
        color: SatorioColor.brand,
        onRefresh: () async {},
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: SatorioColor.darkAccent,
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'images/bg/gradient.svg',
                      height: Get.height + topMargin,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              _content(),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 20),
              //   child: ,
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget _content() {
    final double topMargin = 140 * coefficient;
    return InkWell(
      onTap: () {
        controller.toNonWorkingFeatureDialog();
      },
      child: Container(
        margin: EdgeInsets.only(top: topMargin),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TitleWithButton(
                onTap: () {},
                textCode: 'Popular NFTs',
                fontSize: 24.0 * coefficient,
                fontWeight: FontWeight.w700,
                buttonText: 'View',
                color: Colors.black,
                iconColor: SatorioColor.darkAccent,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(17 * coefficient),
                              ),
                              child: Image.asset(
                                'images/tmp_nft_5.png',
                                width: Get.width,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 8 * coefficient,
                            ),
                            Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: '1,784',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0 * coefficient,
                                      fontWeight: FontWeight.w500,
                                      backgroundColor: Colors.transparent,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: ' '),
                                      TextSpan(
                                        text: 'sao',
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
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15 * coefficient,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(17 * coefficient),
                              ),
                              child: Image.asset(
                                'images/tmp_nft_6.png',
                                height: 200,
                                width: Get.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 8 * coefficient,
                            ),
                            RichText(
                              text: TextSpan(
                                text: '32,284',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0 * coefficient,
                                  fontWeight: FontWeight.w500,
                                  backgroundColor: Colors.transparent,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: ' '),
                                  TextSpan(
                                    text: 'sao',
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15 * coefficient,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(17 * coefficient),
                              ),
                              child: Image.asset(
                                'images/tmp_nft_7.png',
                                height: 200,
                                width: Get.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 8 * coefficient,
                            ),
                            RichText(
                              text: TextSpan(
                                text: '3,284',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0 * coefficient,
                                  fontWeight: FontWeight.w500,
                                  backgroundColor: Colors.transparent,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: ' '),
                                  TextSpan(
                                    text: 'sao',
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
            _allShows(),
            SizedBox(
              height: 15 * coefficient,
            ),
          ],
        ),
      ),
    );
  }

  Widget _allShows() {
    return Container(
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
          return _showItem(nftPreview);
        },
      ),
    );
  }

  Widget _showItem(NFTPreview nftPreview) {
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
