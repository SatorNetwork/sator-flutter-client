import 'package:get/get.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class QuizController extends GetxController {
  Challenge challenge;
  GetSocket socket;

  Rx<String> childPageWidget = Rx('');

  final SatorioRepository _satorioRepository = Get.find();

  @override
  void onClose() {
    if (socket != null) {
      socket.dispose();
      socket.close();
      socket = null;
    }
  }

  void setChallenge(Challenge challenge) {
    this.challenge = challenge;

    _initSocket(challenge.play);
  }

  void _initSocket(String url) async {
    socket = await _satorioRepository.socket(url);

    socket.onOpen(() {
      print('Socket onOpen ${socket.url}');
    });
    socket.onClose((close) {
      print('Socket onClose ${close.message}');
    });
    socket.onError((e) {
      print('Socket onError ${e.message}');
    });
    socket.onMessage((data) {
      print('Socket onMessage: $data');
    });
    socket.connect();
  }
}
