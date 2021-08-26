import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';
import 'package:satorio/data/model/message_model.dart';
import 'package:satorio/domain/entities/message.dart';
import 'package:satorio/domain/entities/review.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/util/extension.dart';

class ShowEpisodesRealmPage extends GetView<ShowEpisodeRealmController> {
  final double bodyHeight = 220;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Text(
                controller.showDetailRx.value.title,
                style: textTheme.bodyText2!.copyWith(
                  color: Colors.white,
                  fontSize: 12.0 * coefficient,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Obx(
              () => Text(
                'txt_episode_naming'.tr.format([
                  controller.showSeasonRx.value.seasonNumber,
                  controller.showEpisodeRx.value.episodeNumber,
                  controller.showEpisodeRx.value.title,
                ]),
                style: textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        leading: InkWell(
          onTap: () => controller.back(),
          child: Icon(
            Icons.chevron_left_rounded,
            size: 32,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            // margin: const EdgeInsets.only(right: 20),
            width: kToolbarHeight,
            height: kToolbarHeight,
            child: Stack(
              children: [
                Center(
                  child: Obx(
                    () => IconButton(
                      onPressed: controller.isRealmActivatedRx.value
                          ? () => controller.toChatPage()
                          : null,
                      icon: Icon(
                        Icons.question_answer_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 5,
                  child: ClipOval(
                    child: Container(
                      height: 20,
                      width: 20,
                      color: SatorioColor.brand,
                      child: Center(
                        child: Text(
                          '55',
                          style: textTheme.bodyText2!.copyWith(
                            color: Colors.white,
                            fontSize: 9 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: _bodyContent(),
      bottomSheet: _bottomSheetContent(),
    );
  }

  Widget _bodyContent() {
    return Stack(
      children: [
        Obx(
          () => Image.network(
            controller.showEpisodeRx.value.cover,
            height: bodyHeight + 24,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: SatorioColor.darkAccent,
            ),
          ),
        ),
        Container(
          height: Get.mediaQuery.padding.top + kToolbarHeight + 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0.5),
              ],
            ),
          ),
        ),
        Container(
          height: bodyHeight,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: Get.mediaQuery.padding.top + kToolbarHeight + 20),
                width: Get.mediaQuery.size.width,
                height: 71 * coefficient,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  children: [
                    Obx(
                      () => InkWell(
                        onTap: controller.isRealmActivatedRx.value
                            ? () {
                                controller.toRealmExpiringBottomSheet();
                              }
                            : null,
                        child: Container(
                          margin: EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: Colors.white.withOpacity(0.6),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  controller.isRealmActivatedRx.value
                                      ? 'images/unlocked_icon.svg'
                                      : 'images/locked_icon.svg',
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      controller.isRealmActivatedRx.value
                                          ? 'txt_2h_left'.tr
                                          : 'txt_locked'.tr,
                                      style: textTheme.bodyText2!.copyWith(
                                        color: SatorioColor.textBlack,
                                        fontSize: 15 * coefficient,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Text(
                                      'txt_status'.tr,
                                      style: textTheme.bodyText2!.copyWith(
                                        color: SatorioColor.textBlack,
                                        fontSize: 12 * coefficient,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: Colors.white.withOpacity(0.6),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'images/sator_logo.svg',
                              color: SatorioColor.textBlack,
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '0',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 15 * coefficient,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  'txt_you'.tr.toLowerCase(),
                                  style: textTheme.bodyText2!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 12 * coefficient,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '3,414.42',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 15 * coefficient,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  'txt_realmers'.tr.toLowerCase(),
                                  style: textTheme.bodyText2!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 12 * coefficient,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: Colors.white.withOpacity(0.6),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'images/active.svg',
                              color: SatorioColor.textBlack,
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '152',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 15 * coefficient,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  'txt_active'.tr.toLowerCase(),
                                  style: textTheme.bodyText2!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 12 * coefficient,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: Colors.white.withOpacity(0.6),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'images/profile.svg',
                              color: SatorioColor.textBlack,
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '152',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 15 * coefficient,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  'txt_ranking'.tr.toLowerCase(),
                                  style: textTheme.bodyText2!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 12 * coefficient,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bottomSheetContent() {
    final double minSize = (Get.height - bodyHeight) / Get.height;
    final double maxSize =
        (Get.height - Get.mediaQuery.padding.top - 1) / Get.height;

    return DraggableScrollableSheet(
      initialChildSize: minSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      expand: false,
      builder: (context, scrollController) => LayoutBuilder(
        builder: (context, constraints) => Obx(
          () => Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: controller.isRealmActivatedRx.value
                      ? ScrollPhysics()
                      : NeverScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                        minHeight: constraints.maxHeight),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 48 * coefficient,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'txt_realm_chat'.tr,
                                style: textTheme.headline4!.copyWith(
                                  color: SatorioColor.textBlack,
                                  fontSize: 24 * coefficient,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              InkWell(
                                onTap: () => controller.toChatPage(),
                                child: Icon(
                                  Icons.chevron_right_rounded,
                                  size: 32 * coefficient,
                                  color: SatorioColor.textBlack,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 148,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(13),
                              ),
                              color: SatorioColor.alice_blue,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(13),
                              ),
                              child: FirebaseAnimatedList(
                                padding: EdgeInsets.all(17),
                                physics: AlwaysScrollableScrollPhysics(),
                                controller: controller.scrollController,
                                query: controller.getMessageQuery(),
                                itemBuilder:
                                    (context, snapshot, animation, index) {
                                  final json =
                                      snapshot.value as Map<dynamic, dynamic>;
                                  final message = MessageModel.fromJson(json);
                                  Color color = _colors[index % _colors.length];
                                  return _showMessage(message, color);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            'txt_overall_rating'.tr,
                            style: textTheme.headline4!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 24 * coefficient,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(13),
                              ),
                              color: SatorioColor.alice_blue,
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'images/smile/smile_10.svg',
                                  width: 30 * coefficient,
                                ),
                                SizedBox(
                                  width: 10 * coefficient,
                                ),
                                Text(
                                  '90%',
                                  style: textTheme.headline5!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 20 * coefficient,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  '5,120 ratings',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 15 * coefficient,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.toRateBottomSheet();
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(13),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    SatorioColor.alice_blue2,
                                    SatorioColor.alice_blue,
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'txt_rate_episode'.tr,
                                  style: textTheme.bodyText2!.copyWith(
                                    color: SatorioColor.interactive,
                                    fontSize: 14 * coefficient,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            'txt_challenges'.tr,
                            style: textTheme.headline4!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 24 * coefficient,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onTap: () {
                              controller.toChallenge();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(13),
                                ),
                                color: SatorioColor.interactive,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 16),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 52,
                                          width: 52,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            color:
                                                SatorioColor.free_speech_blue,
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              'images/sator_logo.svg',
                                              color: Colors.white,
                                              height: 23,
                                              width: 23,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'txt_head'.tr,
                                              style:
                                                  textTheme.bodyText1!.copyWith(
                                                color: Colors.white,
                                                fontSize: 18 * coefficient,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              'txt_head_text'.tr,
                                              style:
                                                  textTheme.bodyText2!.copyWith(
                                                color: Colors.white,
                                                fontSize: 14 * coefficient,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          size: 32,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 45,
                                        right: 45,
                                        top: 21,
                                        bottom: 5),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          SatorioColor.medium_slate_blue,
                                          SatorioColor.medium_slate_blue_2
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '291',
                                              style:
                                                  textTheme.bodyText2!.copyWith(
                                                color: Colors.white,
                                                fontSize: 14 * coefficient,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              'txt_players'.tr.toLowerCase(),
                                              style:
                                                  textTheme.bodyText2!.copyWith(
                                                color: Colors.white,
                                                fontSize: 14 * coefficient,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '2,130.00 SAO',
                                              style:
                                                  textTheme.bodyText2!.copyWith(
                                                color: Colors.white,
                                                fontSize: 14 * coefficient,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              'txt_remains'.tr.toLowerCase(),
                                              style:
                                                  textTheme.bodyText2!.copyWith(
                                                color: Colors.white,
                                                fontSize: 14 * coefficient,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            'txt_nfts'.tr,
                            style: textTheme.headline4!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 24 * coefficient,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 366,
                            child: ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                width: 16,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                String img;
                                String name;
                                switch (index) {
                                  case 0:
                                    img = 'nfts_1';
                                    name = "Game of Thrones";
                                    break;
                                  case 1:
                                    img = 'nfts_4';
                                    name = "Sopranos";
                                    break;
                                  case 2:
                                    img = 'nfts_5';
                                    name = "Simpsons";
                                    break;
                                  case 3:
                                    img = 'nfts_2';
                                    name = "Breaking Bad";
                                    break;
                                  case 4:
                                    img = 'nfts_3';
                                    name = "Batman and Robin";
                                    break;
                                  default:
                                    img = 'nfts_5';
                                    name = "Simpsons";
                                    break;
                                }
                                return _nftsItem(img, name);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'txt_reviews'.tr,
                                style: textTheme.headline4!.copyWith(
                                  color: SatorioColor.textBlack,
                                  fontSize: 24 * coefficient,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              InkWell(
                                onTap: () => controller.back(),
                                child: Icon(
                                  Icons.chevron_right_rounded,
                                  size: 32 * coefficient,
                                  color: SatorioColor.textBlack,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 226 * coefficient,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                separatorBuilder: (context, index) => SizedBox(
                                      width: 16,
                                    ),
                                itemBuilder: (context, index) {
                                  return _reviewItem(review);
                                }),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          BorderedButton(
                            text: 'txt_write_review'.tr,
                            borderColor: SatorioColor.interactive,
                            textColor: SatorioColor.interactive,
                            borderWidth: 3,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: Text(
                              'txt_earn_sao_upvoted'.tr,
                              style: textTheme.bodyText1!.copyWith(
                                color: SatorioColor.interactive,
                                fontSize: 14 * coefficient,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (!controller.isRealmActivatedRx.value)
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.25),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'txt_start_watching_earn_sao'.tr,
                        style: textTheme.bodyText2!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 13 * coefficient,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ElevatedGradientButton(
                        text: 'txt_unlock_realm'.tr,
                        onPressed: () {
                          controller.toEpisodeRealmDialog();
                        },
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nftsItem(String assetName, String name) {
    double width = Get.width - 80;
    double height = 192.0 * coefficient;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: width,
        child: Stack(
          children: [
            Image.asset(
              "images/new/$assetName.png",
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 85 * coefficient),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: textTheme.headline4!.copyWith(
                          color: Colors.white,
                          fontSize: 20.0 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
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
                          color: SatorioColor.textBlack,
                          fontSize: 12.0 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: SatorioColor.alice_blue,
              padding: EdgeInsets.symmetric(vertical: 16),
              margin: EdgeInsets.only(top: 140 * coefficient),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'An Electric Storm (1/1 NFT + AR physical, 2021)',
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 18 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7 * coefficient,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  SatorioColor.yellow_orange,
                                  SatorioColor.tomato,
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          review.userName,
                          style: textTheme.bodyText2!.copyWith(
                            color: SatorioColor.textBlack,
                            fontSize: 15 * coefficient,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: Get.mediaQuery.size.width,
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          SatorioColor.alice_blue2,
                          SatorioColor.alice_blue
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'txt_reserve_price'.tr,
                          style: textTheme.bodyText2!.copyWith(
                            color: SatorioColor.comet,
                            fontSize: 15 * coefficient,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          '15.00 SAO',
                          style: textTheme.bodyText2!.copyWith(
                            color: SatorioColor.textBlack,
                            fontSize: 15 * coefficient,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<Color> _colors = [
    SatorioColor.lavender_rose,
    SatorioColor.mona_lisa,
    SatorioColor.light_sky_blue
  ];

  Widget _showMessage(Message message, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.fromUserName,
            style: textTheme.bodyText2!.copyWith(
              color: color,
              fontSize: 12 * coefficient,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    message.text,
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 14 * coefficient,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewItem(Review review) {
    return Container(
      padding: EdgeInsets.only(bottom: 16, top: 30),
      width: Get.mediaQuery.size.width - 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(13),
        ),
        color: SatorioColor.alice_blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SvgPicture.asset(
                  'images/smile/smile_1.svg',
                  width: 24 * coefficient,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    review.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText1!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 18 * coefficient,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                review.text,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyText2!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 15 * coefficient,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.only(top: 16, left: 20, right: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  SatorioColor.alice_blue2,
                  SatorioColor.alice_blue,
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            SatorioColor.yellow_orange,
                            SatorioColor.tomato,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      review.userName,
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 15 * coefficient,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'images/like_icon.svg',
                      color: SatorioColor.textBlack,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      review.likes,
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 14 * coefficient,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: SatorioColor.interactive,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'images/sator_logo.svg',
                          width: 12,
                          height: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'txt_tip'.tr,
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.interactive,
                        fontSize: 14 * coefficient,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  final Review review = Review(
      'id',
      '7 / 10',
      '06 June 2021',
      'Something nice to watch',
      'A high school chemistry teacher dying of cancer teams with a former student to secure his family\'s future by manufacturing and selling crystal ...',
      'roberto21',
      '2.5M',
      '234');
}
