import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/nfts_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/title_button.dart';

class NFTsPage extends GetView<NFTsController> {
  @override
  Widget build(BuildContext context) {
    final double topMargin = 140;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.3),
        centerTitle: true,
        title: Container(
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(
                color: SatorioColor.darkAccent,
                fontSize: 15.0,
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
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: _content(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _content() {
    final double topMargin = 140;
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Column(
        children: [
          TitleWithButton(
            onTap: () {},
            textCode: 'Popular',
            fontSize: 34.0,
            fontWeight: FontWeight.w700,
            buttonText: 'View',
            color: Colors.black,
            iconColor: SatorioColor.darkAccent,
          ),
          SizedBox(
            height: 20,
          ),
          Column(
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
                            'images/tmp_nft_2.png',
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'images/nft_logo.png',
                              height: 14,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                text: '3,284',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  backgroundColor: Colors.transparent,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: ' '),
                                  TextSpan(
                                    text: 'sao',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
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
                    width: 15,
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
                            'images/tmp_nft_2.png',
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        RichText(
                          text: TextSpan(
                            text: '32,284',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              backgroundColor: Colors.transparent,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: ' '),
                              TextSpan(
                                text: 'sao',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              TextSpan(text: ' / '),
                              TextSpan(
                                text: '\$1,300',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 12.0,
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
                height: 15,
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
                            'images/tmp_nft_2.png',
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        RichText(
                          text: TextSpan(
                            text: '3,284',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              backgroundColor: Colors.transparent,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: ' '),
                              TextSpan(
                                text: 'sao',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              TextSpan(text: ' / '),
                              TextSpan(
                                text: '\$1,30',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 12.0,
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
          SizedBox(
            height: 34,
          ),
          TitleWithButton(
            onTap: () {},
            textCode: 'All Shows',
            fontSize: 34.0,
            fontWeight: FontWeight.w700,
            buttonText: 'View',
            color: Colors.black,
            iconColor: SatorioColor.darkAccent,
          ),
          SizedBox(
            height: 20,
          ),
          _allShows(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _allShows() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 168 * coefficient,
      child: Obx(
        () => ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            width: 16,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: controller.allShowsRx.value.length,
          itemBuilder: (context, index) {
            Show show = controller.allShowsRx.value[index];
            return _showItem(show);
          },
        ),
      ),
    );
  }

  Widget _showItem(Show show) {
    final double width = 125.0;
    return InkWell(
      onTap: () {},
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                color: Colors.white,
                child: Image(
                  width: width,
                  height: width,
                  fit: BoxFit.cover,
                  image: NetworkImage(show.cover),
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: SatorioColor.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Text(
                show.title,
                textAlign: TextAlign.center,
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
}
