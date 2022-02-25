import 'package:get/get.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class ChallengesController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<Challenge?> challengeRx = Rx(null);
  final RxBool isRequested = false.obs;

  ChallengesController();

  void back() {
    Get.back();
  }
}
