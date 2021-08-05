import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satorio/controller/chat_controller.dart';
import 'package:satorio/data/model/message_model.dart';
import 'package:satorio/domain/entities/message.dart';

class ChatPage extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   centerTitle: true,
      //   title: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       // Obx(
      //       //       () => Text(
      //       //     controller.showDetailRx.value?.title ?? '',
      //       //     style: textTheme.bodyText2!.copyWith(
      //       //       color: Colors.white,
      //       //       fontSize: 12.0 * coefficient,
      //       //       fontWeight: FontWeight.w400,
      //       //     ),
      //       //   ),
      //       // ),
      //       SizedBox(
      //         height: 2,
      //       ),
      //       Obx(
      //             () => Text(
      //           'txt_episode_naming'.tr.format([
      //             controller.showSeasonRx.value?.seasonNumber ?? 0,
      //             controller.showEpisodeRx.value?.episodeNumber ?? 0,
      //             controller.showEpisodeRx.value?.title ?? '',
      //           ]),
      //           style: textTheme.bodyText1!.copyWith(
      //             color: Colors.white,
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      //   leading: InkWell(
      //     onTap: () => controller.back(),
      //     child: Icon(
      //       Icons.chevron_left_rounded,
      //       size: 32,
      //       color: Colors.white,
      //     ),
      //   ),
      //   actions: [
      //     Container(
      //       // margin: const EdgeInsets.only(right: 20),
      //       width: kToolbarHeight,
      //       height: kToolbarHeight,
      //       child: Stack(
      //         children: [
      //           Center(
      //             child: InkWell(
      //               onTap: () => controller.back(),
      //               child: Icon(
      //                 Icons.question_answer_rounded,
      //                 color: Colors.white,
      //                 size: 24,
      //               ),
      //             ),
      //           ),
      //           Positioned(
      //             left: 5,
      //             top: 5,
      //             child: ClipOval(
      //               child: Container(
      //                 height: 20,
      //                 width: 20,
      //                 color: SatorioColor.brand,
      //                 child: Center(
      //                   child: Text(
      //                     '55',
      //                     style: textTheme.bodyText2!.copyWith(
      //                       color: Colors.white,
      //                       fontSize: 9 * coefficient,
      //                       fontWeight: FontWeight.w700,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
      body: Container(
        child: Stack(
          children: [
            SvgPicture.asset(
              'images/bg/gradient.svg',
              height: Get.height,
              fit: BoxFit.cover,
            ),
            Container(
                margin: EdgeInsets.only(top: 100), child: _getMessageList()),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: controller.messageController,
                        onChanged: (text) {},
                        onSubmitted: (input) {
                          controller.sendMessage();
                        },
                        decoration: const InputDecoration(
                            hintText: 'Enter new message'),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(controller.canSendMessage()
                          ? CupertinoIcons.arrow_right_circle_fill
                          : CupertinoIcons.arrow_right_circle),
                      onPressed: () {
                        controller.sendMessage();
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMessageList() {
    return FirebaseAnimatedList(
      physics: AlwaysScrollableScrollPhysics(),
      controller: controller.scrollController,
      query: controller.getMessageQuery(),
      itemBuilder: (context, snapshot, animation, index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final message = MessageModel.fromJson(json);
        return _showMessage(message);
      },
    );
  }

  Widget _showMessage(Message message) {
    return Padding(
        padding: const EdgeInsets.only(left: 1, top: 5, right: 1, bottom: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.fromUserName),
            SizedBox(
              height: 6,
            ),
            Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[350]!,
                          blurRadius: 2.0,
                          offset: Offset(0, 1.0))
                    ],
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.white),
                child: MaterialButton(
                    disabledTextColor: Colors.black87,
                    padding: EdgeInsets.only(left: 18),
                    onPressed: null,
                    child: Wrap(
                      children: [
                        Container(
                            child: Row(
                          children: [
                            Text(message.text),
                          ],
                        )),
                      ],
                    ))),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    DateFormat('yyyy-MM-dd hh.mm')
                        .format(message.createdAt)
                        .toString(),
                    style: TextStyle(color: Colors.grey),
                  )),
            ),
          ],
        ));
  }
}
