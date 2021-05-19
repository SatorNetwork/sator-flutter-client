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
        backgroundColor: SatorioColor.brand,
        title: SvgPicture.asset(
          'images/logo_name.svg',
          height: kToolbarHeight * 0.5,
          color: SatorioColor.darkAccent,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '302 SAO',
                  style: TextStyle(
                      color: SatorioColor.darkAccent,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '2,456.25 USD',
                  style: TextStyle(
                      color: SatorioColor.darkAccent,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
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
              fontWeight: FontWeight.w400),
          labelColor: SatorioColor.darkAccent,
          labelStyle: TextStyle(
              color: SatorioColor.darkAccent,
              fontSize: 22.0,
              fontWeight: FontWeight.w700),
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
          padding: const EdgeInsets.only(left: 24, top: 27, right: 21),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                foregroundImage: NetworkImage('https://picsum.photos/60/60'),
                child: SvgPicture.asset(
                  'images/profile_placeholder.svg',
                  width: 60,
                  height: 60,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Ivan Sunguroff',
                  style: TextStyle(
                      color: SatorioColor.textBlack,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700),
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
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 24),
          child: Text(
            'txt_badges'.tr,
            style: TextStyle(
                color: SatorioColor.textBlack,
                fontSize: 22.0,
                fontWeight: FontWeight.w500),
          ),
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
}
