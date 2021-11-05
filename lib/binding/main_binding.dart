import 'package:get/get.dart';
import 'package:satorio/controller/activity_controller.dart';
import 'package:satorio/controller/home_controller.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/nft_categories_controller.dart';
import 'package:satorio/controller/personal_profile_controller.dart';
import 'package:satorio/controller/profile_controller.dart';
import 'package:satorio/controller/wallet_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());

    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<NftCategoriesController>(() => NftCategoriesController());
    Get.lazyPut<WalletController>(() => WalletController());
    Get.lazyPut<PersonalProfileController>(() => PersonalProfileController());

    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ActivityController>(() => ActivityController());
  }
}
