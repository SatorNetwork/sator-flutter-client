import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/shows_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class ShowsPage extends GetView<ShowsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          children: [
            SvgPicture.asset(
              'images/bg/splash.svg',
              height: Get.height,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 64),
                      child: Center(
                        child: Text(
                          'txt_challenges'.tr,
                          style: TextStyle(
                              color: SatorioColor.darkAccent,
                              fontSize: 28.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                        color: Colors.white,
                      ),
                      child: Obx(
                        () => ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(24),
                          physics: ScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 24,
                          ),
                          itemCount: controller.showsRx.value.length + 10,
                          itemBuilder: (context, index) {
                            // Show show = controller.showsRx.value[index];
                            return _showItem();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _showItem() {
    return Container(
      height: 168,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image(
                image: NetworkImage('https://picsum.photos/400/168'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      'Hold on for dear life',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: SatorioColor.lavender_rose,
                    ),
                    child: Text(
                      'New'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
