import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/home_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          'images/logo_name.svg',
          height: kToolbarHeight * 0.5,
          color: SatorioColor.darkAccent,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
            child: Obx(() => controller.walletBalanceRx.value == null
                ? Container()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        controller.walletBalanceRx.value.sao.displayedValue,
                        style: TextStyle(
                          color: SatorioColor.darkAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        controller.walletBalanceRx.value.usd.displayedValue,
                        style: TextStyle(
                          color: SatorioColor.darkAccent,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )),
          ),
        ],
        bottom: TabBar(
          controller: controller.tabController,
          labelPadding: const EdgeInsets.symmetric(vertical: 10),
          indicatorColor: Colors.transparent,
          unselectedLabelColor: SatorioColor.darkAccent,
          unselectedLabelStyle: TextStyle(
            color: SatorioColor.darkAccent,
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
          ),
          labelColor: SatorioColor.darkAccent,
          labelStyle: TextStyle(
            color: SatorioColor.darkAccent,
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
          ),
          tabs: [
            Text('txt_profile'.tr),
            Text('txt_wallet'.tr),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          _profileTabContent(),
          _walletTabContent(),
        ],
      ),
    );
  }

  Widget _profileTabContent() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 27, right: 24),
          child: Obx(() => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    foregroundColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    foregroundImage:
                        NetworkImage('https://picsum.photos/60/60'),
                    child: SvgPicture.asset(
                      'images/profile_placeholder.svg',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      controller.profileRx.value != null
                          ? controller.profileRx.value.fullName
                          : 'Empty Name',
                      style: TextStyle(
                        color: SatorioColor.textBlack,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                      color: SatorioColor.inputGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'super fun'.toUpperCase(),
                      style: TextStyle(
                        color: SatorioColor.textBlack,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 24),
          child: Text(
            'txt_badges'.tr,
            style: TextStyle(
              color: SatorioColor.textBlack,
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            height: 70,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: 24,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) => SvgPicture.asset(
                'images/badge.svg',
                height: 46,
                width: 46,
              ),
            ),
          ),
        ),
        ListView.builder(
          itemCount: 3,
          padding: const EdgeInsets.only(bottom: 24),
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) => _category(),
        ),
      ],
    );
  }

  Widget _walletTabContent() {
    return Container(
      child: Center(
        child: Text('Wallet Tab Content'),
      ),
    );
  }

  Widget _category() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 24, right: 20),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'txt_challenges'.tr,
                  style: TextStyle(
                    color: SatorioColor.textBlack,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.chevron_right,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Container(
            height: 168,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: 16,
              ),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: 6,
              itemBuilder: (context, index) => _categoryItem(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _categoryItem() {
    return Stack(
      children: [
        Container(
          width: 201,
          height: 168,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image(
              image: NetworkImage('https://picsum.photos/201/168'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Peaky Blinders'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 9),
                Text(
                  'Ranked 12,024',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
