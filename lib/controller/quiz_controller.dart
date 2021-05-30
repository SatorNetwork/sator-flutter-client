import 'package:get/get.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/entities/quiz_screen_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class QuizController extends GetxController {
  Challenge challenge;
  GetSocket _socket;

  final Rx<QuizScreenType> screenTypeRx = Rx(QuizScreenType.lobby);

  final SatorioRepository _satorioRepository = Get.find();

  @override
  void onClose() {
    if (_socket != null) {
      _socket.dispose();
      _socket.close();
      _socket = null;
    }
  }

  void back() {
    Get.back();
  }

  void setChallenge(Challenge challenge) {
    this.challenge = challenge;

    _initSocket(challenge.play);
  }

  void _initSocket(String url) async {
    _socket = await _satorioRepository.socket(url);

    _socket.onOpen(() {
      print('Socket onOpen ${_socket.url}');
    });
    _socket.onClose((close) {
      print('Socket onClose ${close.message}');
    });
    _socket.onError((e) {
      print('Socket onError ${e.message}');
    });
    _socket.onMessage((data) {
      print('Socket onMessage: $data');
    });
    _socket.connect();
  }
}
