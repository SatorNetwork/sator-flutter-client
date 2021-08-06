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

class ChatPage extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        leading: Container(),
        actions: [
          Container(
            height: kToolbarHeight,
            width: kToolbarHeight,
            child: InkWell(
              onTap: () => controller.back(),
              child: Icon(
                Icons.close,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Obx(
              () => Image.network(
                controller.showEpisodeRx.value.cover,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: SatorioColor.darkAccent,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _chatContent(),
    );
  }

  Widget _chatContent() {
    final double minSize = (Get.height - 120 * coefficient) / Get.height;
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
                    controller: controller.scrollController,
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: constraints.maxWidth,
                            minHeight: constraints.maxHeight),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: _getMessageList(),
                            ),
                          ],
                        ))),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Color(0xFF767E9B),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextField(
                            autofocus: true,
                            style: textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            keyboardType: TextInputType.text,
                            controller: controller.messageController,
                            onChanged: (text) {},
                            onSubmitted: (input) {
                              controller.sendMessage();
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                                hintText: 'Join in the conversation',
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.sendMessage();
                          },
                          child: Text(
                            "Send",
                            style: textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMessageList() {
    ScrollController _controller = ScrollController();
    return FirebaseAnimatedList(
      // physics: NeverScrollableScrollPhysics(),
      controller: _controller,
      shrinkWrap: true,
      query: controller.getMessageQuery(),
      itemBuilder: (context, snapshot, animation, index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final message = MessageModel.fromJson(json);
        Color color = _colors[index % _colors.length];
        return _showMessage(message, color);
      },
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
              Text(
                message.text,
                style: textTheme.bodyText2!.copyWith(
                  color: Colors.white,
                  fontSize: 14 * coefficient,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // Text(
              //   DateFormat('yyyy-MM-dd hh.mm')
              //       .format(message.createdAt)
              //       .toString(),
              //   style: TextStyle(color: Colors.grey),
              // ),
            ],
          )),
        ],
      ),
    );
  }
}
