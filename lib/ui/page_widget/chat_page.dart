import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/chat_controller.dart';
import 'package:satorio/data/model/message_model.dart';
import 'package:satorio/domain/entities/message.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/util/extension.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ChatPage extends GetView<ChatController> {
  final double bodyHeight = max(0.3 * Get.height, 220);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: InkWell(
          onTap: () {
            controller.saveTimestamp();
            controller.back();
          },
          child: Container(
            width: Get.width,
            child: Column(
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
                    controller.showSeasonRx.value.seasonNumber == 0
                        ? controller.showEpisodeRx.value.title
                        : 'txt_episode_naming'.tr.format(
                            [
                              controller.showSeasonRx.value.seasonNumber,
                              controller.showEpisodeRx.value.episodeNumber,
                              controller.showEpisodeRx.value.title,
                            ],
                          ),
                    style: textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        leading: null,
        actions: [
          Container(
            height: kToolbarHeight,
            width: kToolbarHeight,
            child: InkWell(
              onTap: () {
                controller.saveTimestamp();
                controller.back();
              },
              child: Icon(
                Icons.close,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: InkWell(
        onTap: () {
          controller.saveTimestamp();
          controller.back();
        },
        child: Container(
          child: Stack(
            children: [
              Obx(
                () => CachedNetworkImage(
                  imageUrl: controller.showEpisodeRx.value.cover,
                  cacheKey: controller.showEpisodeRx.value.cover,
                  width: Get.width,
                  height: bodyHeight + 24,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
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
            ],
          ),
        ),
      ),
      bottomSheet: _chatContent(),
    );
  }

  Widget _chatContent() {
    final double minSize = (Get.height - 180 * coefficient) / Get.height;
    final double maxSize =
        (Get.height - Get.mediaQuery.padding.top - 1) / Get.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        color: Color(0xFF131B37),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: minSize,
        minChildSize: minSize,
        maxChildSize: maxSize,
        expand: false,
        builder: (context, scrollController) => LayoutBuilder(
          builder: (context, constraints) => Column(
            children: [
              Container(
                height: 60,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.question_answer_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Realm chat',
                        style: textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                    controller: controller.autoScrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    reverse: true,
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: constraints.maxWidth,
                            minHeight: constraints.maxHeight - 120),
                        child: Column(
                          children: [
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: controller.isMessagesRx.value
                                    ? _getMessageList()
                                    : _emptyState(),
                              ),
                            ),
                          ],
                        ))),
              ),
              Container(
                height: 60,
                color: Color(0xFF767E9B),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: TextField(
                          autofocus: false,
                          style: textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                            fontSize: 12 * coefficient,
                            fontWeight: FontWeight.w400,
                          ),
                          keyboardType: TextInputType.text,
                          controller: controller.messageController,
                          onChanged: (text) {},
                          onSubmitted: (input) {
                            controller.sendMessage();
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Join in the conversation',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 12 * coefficient,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.sendMessage();
                        controller.autoScrollController.scrollToIndex(0,
                            duration: Duration(milliseconds: 150),
                            preferPosition: AutoScrollPosition.begin);
                      },
                      child: Container(
                        height: 60,
                        width: 80,
                        child: Center(
                          child: Text(
                            "Send",
                            style: textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
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

  Widget _getMessageList() {
    ScrollController _controller = ScrollController();

    return FirebaseAnimatedList(
      controller: _controller,
      physics: NeverScrollableScrollPhysics(),
      reverse: false,
      shrinkWrap: true,
      query: controller.getMessageQuery(),
      itemBuilder: (context, snapshot, animation, index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final message = MessageModel.fromJson(json);
        Color color = _colors[index % _colors.length];

        return AutoScrollTag(
          index: index,
          key: ValueKey(index),
          controller: controller.autoScrollController,
          child: VisibilityDetector(
              key: Key('${message.createdAt}'),
              onVisibilityChanged: (VisibilityInfo info) {
                final bool shouldCheck = info.visibleFraction == 1.0 &&
                    controller.lastSeen.timestamp!.microsecondsSinceEpoch <
                        message.createdAt!.microsecondsSinceEpoch &&
                    controller.scrollIndex != 0;

                if (shouldCheck) {
                  controller.scrollIndex--;
                  controller.saveMessageSeen(message.createdAt!);
                }
              },
              child: _showMessage(message, color)),
        );
      },
    );
  }

  final List<Color> _colors = [
    SatorioColor.lavender_rose,
    SatorioColor.mona_lisa,
    SatorioColor.light_sky_blue
  ];

  Widget _emptyState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('images/hand_shake.png'),
        SizedBox(
          height: 20,
        ),
        Text(
          'txt_no_messages'.tr,
          style: textTheme.bodyText2!.copyWith(
            color: Colors.white,
            fontSize: 18 * coefficient,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'txt_say_hello'.tr,
          style: textTheme.bodyText2!.copyWith(
            color: Colors.white,
            fontSize: 15 * coefficient,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _showMessage(Message message, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: '${message.fromUserName}: ',
                      style: textTheme.bodyText2!.copyWith(
                        color: color,
                        fontSize: 12 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: message.text,
                          style: textTheme.bodyText2!.copyWith(
                            color: Colors.white,
                            fontSize: 12 * coefficient,
                            fontWeight: FontWeight.w400,
                          ),
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
    );
  }
}
