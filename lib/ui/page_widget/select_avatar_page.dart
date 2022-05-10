import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/select_avatar_controller.dart';
import 'package:satorio/domain/entities/select_avatar_type.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/avatar_image.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/util/avatar_list.dart';
import 'package:satorio/util/links.dart';

class SelectAvatarPage extends GetView<SelectAvatarController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SatorioColor.alice_blue,
      extendBodyBehindAppBar: true,
      appBar: controller.type == SelectAvatarType.settings
          ? AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Container(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'txt_select_avatar'.tr,
                      style: textTheme.bodyText2!.copyWith(
                        color: Colors.black,
                        fontSize: 17.0 * coefficient,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              leading: Container(
                height: kToolbarHeight,
                width: kToolbarHeight,
                child: InkWell(
                  onTap: () {
                    controller.back();
                  },
                  child: Icon(
                    Icons.chevron_left,
                    size: 32,
                    color: Colors.black,
                  ),
                ),
              ),
              actions: [
                Container(
                  height: kToolbarHeight,
                  width: kToolbarHeight,
                ),
              ],
            )
          : AppBar(
              toolbarHeight: 0,
              backgroundColor: Colors.transparent,
            ),
      body: Column(
        children: [
          _topPanel(),
          Expanded(
            child: _avatars(),
          ),
          _bottomButton()
        ],
      ),
    );
  }

  Widget _avatarsContent(AvatarsListType avatarsListType) {
    switch (avatarsListType) {
      case AvatarsListType.local:
        return _avatarsList();
      case AvatarsListType.nfts:
        return _nftsList();
    }
  }

  Widget _avatars() {
    return Obx(() => _avatarsContent(controller.avatarsListType.value));
  }

  Widget _bottomButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          color: Colors.white),
      child: Center(
        child: Obx(
          () => ElevatedGradientButton(
            text: 'txt_looks_good_simple'.tr,
            isEnabled: controller.avatarRx.value != null,
            onPressed: () {
              controller.saveAvatar();
            },
          ),
        ),
      ),
    );
  }

  Widget _nftsList() {
    ScrollController _controller = ScrollController();
    return controller.nftItemsRx.value.length != 0
        ? GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            controller: _controller,
            scrollDirection: Axis.vertical,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
            shrinkWrap: true,
            itemCount: controller.nftItemsRx.value.length,
            itemBuilder: (_, index) => _nftAvatar(index),
          )
        : _emptyNftsState();
  }

  Widget _emptyNftsState() {
    const double bottomPanelHeight = 114.0;
    const double topPanelHeight = 240.0;

    return InkWell(
      onTap: () {
        controller.backToMain();
        controller.toNfts();
      },
      child: Container(
        height: (Get.height - bottomPanelHeight - topPanelHeight) * coefficient,
        child: Center(
            child: Text(
          'txt_buy_nfts'.tr,
          style: textTheme.bodyText2!.copyWith(
            color: SatorioColor.interactive,
            fontSize: 17.0 * coefficient,
            fontWeight: FontWeight.w600,
          ),
        )),
      ),
    );
  }

  Widget _avatarsList() {
    ScrollController _controller = ScrollController();
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      controller: _controller,
      scrollDirection: Axis.vertical,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
      shrinkWrap: true,
      itemCount: avatars.length,
      itemBuilder: (_, index) => _avatar(index),
    );
  }

  Widget _avatar(int index) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
          onTap: () {
            controller.setAvatar(index);
          },
          child: Container(
              height: 51,
              width: 51,
              child: SvgPicture.asset(avatars[index], fit: BoxFit.cover))),
    );
  }

  Widget _nftAvatar(int index) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
            onTap: () {
              controller.setAvatar(index);
            },
            child: Container(
                height: 51,
                width: 51,
                child: Image.network(
                  controller.nftItemsRx.value[index].nftPreview.isNotEmpty
                      ? controller.nftItemsRx.value[index].nftPreview
                      : controller.nftItemsRx.value[index].nftLink,
                ))));
  }

  Widget _topPanel() {
    const double height = 240.0;
    return Container(
      height: height * coefficient,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70 * coefficient,
          ),
          controller.type == SelectAvatarType.registration
              ? Text(
                  'txt_select_avatar'.tr,
                  style: textTheme.headline1!.copyWith(
                      color: Colors.black,
                      fontSize: 34.0 * coefficient,
                      fontWeight: FontWeight.w700),
                )
              : Container(),
          SizedBox(
            height: 24 * coefficient,
          ),
          Row(
            children: [
              Obx(
                () => ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Center(
                      child: controller.avatarRx.value != null
                          ? _avatarImage()
                          : controller.type == SelectAvatarType.settings
                              ? AvatarImage(
                                  controller.profileRx.value?.avatarPath,
                                  width: 64,
                                  height: 64)
                              : Image.asset(
                                  'images/null_avatar.png',
                                  height: 64 * coefficient,
                                  width: 64 * coefficient,
                                ),
                    )),
              ),
              SizedBox(
                width: 24 * coefficient,
              ),
              Obx(
                () => Expanded(
                  child: Text(
                    controller.profileRx.value?.displayedName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText1!.copyWith(
                        color: Colors.black,
                        fontSize: 18.0 * coefficient,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: controller.type == SelectAvatarType.settings ? 32 : 0,
          ),
          controller.type == SelectAvatarType.settings
              ? Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _radioButton('txt_bitys'.tr, AvatarsListType.local),
                      _radioButton('txt_nfts'.tr, AvatarsListType.nfts),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _radioButton(String title, AvatarsListType avatarsListType) {
    return InkWell(
      onTap: () {
        controller.avatarRx.value = null;
        controller.toggle(avatarsListType);
      },
      child: Row(
        children: [
          ClipOval(
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: SatorioColor.alice_blue,
                border: Border(
                    bottom: BorderSide(
                  color: SatorioColor.alice_blue2,
                  width: 1 * coefficient,
                )),
              ),
              child: Center(
                child: ClipOval(
                  child: Container(
                    height: 12,
                    width: 12,
                    color: controller.avatarsListType.value == avatarsListType
                        ? SatorioColor.brand
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: textTheme.bodyText1!.copyWith(
                color: Colors.black,
                fontSize: 15.0 * coefficient,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget _avatarImage() {
    RegExpMatch? match = new RegExp(urlPattern, caseSensitive: false)
        .firstMatch(controller.avatarRx.value!);

    switch (controller.avatarsListType.value) {
      case AvatarsListType.local:
        return controller.avatarRx.value != null && match == null
            ? SvgPicture.asset(
                controller.avatarRx.value!,
                height: 64 * coefficient,
                width: 64 * coefficient,
              )
            : SvgPicture.asset(
                controller.profileRx.value?.avatarPath ?? '',
                height: 64 * coefficient,
                width: 64 * coefficient,
              );
      case AvatarsListType.nfts:
        return controller.avatarRx.value != null && match != null
            ? Image.network(
                controller.avatarRx.value!,
                height: 64 * coefficient,
                width: 64 * coefficient,
              )
            : SvgPicture.asset(
                controller.profileRx.value?.avatarPath ?? '',
                height: 64 * coefficient,
                width: 64 * coefficient,
              );
    }
  }
}
