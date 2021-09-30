import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:satorio/controller/select_avatar_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/util/avatar_list.dart';
import '../../util/avatar_list.dart';
import '../theme/light_theme.dart';
import '../theme/sator_color.dart';
import '../theme/text_theme.dart';

class SelectAvatarPage extends GetView<SelectAvatarController> {
  @override
  Widget build(BuildContext context) {
    const double topPanelHeight = 240.0;
    const double bottomPanelHeight = 114.0;
    return Scaffold(
      backgroundColor: SatorioColor.alice_blue,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: _bottomButton(),
          ),
          _topPanel(),
          Container(
              padding: EdgeInsets.only(
                  top: topPanelHeight * coefficient,
                  bottom: bottomPanelHeight * coefficient),
              child: SingleChildScrollView(child: _avatarsList()))
        ],
      ),
    );
  }

  Widget _bottomButton() {
    const double bottomPanelHeight = 114.0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      height: bottomPanelHeight * coefficient,
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

  Widget _avatarsList() {
    ScrollController _controller = ScrollController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        controller: _controller,
        scrollDirection: Axis.vertical,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
        shrinkWrap: true,
        itemCount: avatars.length,
        itemBuilder: (_, index) => _avatar(index),
      ),
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
          Text(
            'txt_select_avatar'.tr,
            style: textTheme.headline1!.copyWith(
                color: Colors.black,
                fontSize: 34.0 * coefficient,
                fontWeight: FontWeight.w700),
          ),
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
                          ? SvgPicture.asset(
                              controller.avatarRx.value!,
                              height: 64 * coefficient,
                              width: 64 * coefficient,
                            )
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
                () => Text(
                  controller.profileRx.value?.displayedName ?? '',
                  style: textTheme.bodyText1!.copyWith(
                      color: Colors.black,
                      fontSize: 18.0 * coefficient,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
