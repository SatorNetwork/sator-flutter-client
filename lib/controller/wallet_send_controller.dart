import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/qr_scanner_binding.dart';
import 'package:satorio/binding/transaction_preview_binding.dart';
import 'package:satorio/controller/qr_scanner_controller.dart';
import 'package:satorio/controller/transaction_preview_controller.dart';
import 'package:satorio/domain/entities/qr/qr_data.dart';
import 'package:satorio/domain/entities/transfer.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/transacting_tips_bottom_sheet.dart';
import 'package:satorio/ui/dialog_widget/choose_wallet_dialog.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/page_widget/qr_scanner_page.dart';
import 'package:satorio/ui/page_widget/transaction_preview_page.dart';

class WalletSendController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final TextEditingController amountController = TextEditingController();
  late final TextEditingController toAddressController;
  final TextEditingController noteController = TextEditingController();

  late final Rx<WalletDetail?> fromWalletDetailRx;
  late final RxString toAddressRx;
  late final RxDouble amountRx = 0.0.obs;

  late final RxBool toAddressVisibility;

  WalletSendController() {
    WalletSendArgument argument = Get.arguments as WalletSendArgument;

    fromWalletDetailRx = Rx(argument.fromWalletDetail);

    toAddressRx = (argument.toAddress == null ? '' : argument.toAddress!).obs;
    toAddressController = TextEditingController(text: argument.toAddress);

    toAddressVisibility =
        (argument.toAddress != null && argument.toAddress!.isNotEmpty).obs;
  }

  @override
  void onInit() {
    super.onInit();
    toAddressController.addListener(_toAddressListener);
    amountController.addListener(_amountListener);
  }

  @override
  void onReady() {
    super.onReady();
    if (fromWalletDetailRx.value == null) {
      _showSelectSource();
    }
  }

  @override
  void onClose() {
    amountController.removeListener(_amountListener);
    toAddressController.removeListener(_toAddressListener);
    super.onClose();
  }

  void back() {
    Get.back();
  }

  void showTransactingTips() {
    Get.bottomSheet(
      TransactingTipsBottomSheet(),
    );
  }

  void createTransfer() {
    if (fromWalletDetailRx.value != null) {
      _satorioRepository
          .createTransfer(
        fromWalletDetailRx.value!.id,
        toAddressRx.value,
        amountRx.value,
      )
          .then(
        (Transfer transfer) {
          Get.to(
            () => TransactionPreviewPage(),
            binding: TransactionPreviewBinding(),
            arguments: TransactionPreviewArgument(transfer),
          );
        },
      );
    }
  }

  void clearDestinationAddress() {
    toAddressController.clear();
  }

  void selectDestinationFromOwnWallets() {
    String? id = fromWalletDetailRx.value?.id;

    List<WalletDetail> walletDetails =
        (_satorioRepository.walletDetailsListenable(null)
                as ValueListenable<Box<WalletDetail>>)
            .value
            .values
            .where((element) => element.id != id)
            .toList();

    if (walletDetails.length > 0) {
      Get.dialog(
        ChooseWalletDialog(
          'txt_choose_your_destination_wallet'.tr,
          walletDetails,
          (walletDetail) {
            _setToAddress(walletDetail.solanaAccountAddress);
          },
        ),
      );
    }
  }

  void selectDestinationFromContacts() {
    Get.dialog(
      DefaultDialog(
        'txt_oops'.tr,
        'txt_coming_soon'.tr,
        'txt_ok'.tr,
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  void enterDestinationAddress() {
    toAddressVisibility.value = true;
  }

  void scanDestinationQr() async {
    final result = await Get.to(
      () => QrScannerPage(),
      binding: QrScannerBinding(),
      arguments: QrScannerArgument(
        true,
        expectedQrTypes: [QrType.walletSend],
      ),
    );

    if (result != null && (result is String) && result.isNotEmpty)
      _setToAddress(result);
  }

  void _setToAddress(String toAddress) {
    toAddressController.value = TextEditingValue(
      text: toAddress,
      selection: TextSelection.fromPosition(
        TextPosition(offset: toAddress.length),
      ),
    );

    toAddressVisibility.value = true;
  }

  void _showSelectSource() {
    List<WalletDetail> walletDetails =
        (_satorioRepository.walletDetailsListenable(null)
                as ValueListenable<Box<WalletDetail>>)
            .value
            .values
            .toList();
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          Get.back(closeOverlays: true);
          return true;
        },
        child: ChooseWalletDialog(
          'txt_choose_your_source_wallet'.tr,
          walletDetails,
          (walletDetail) {
            fromWalletDetailRx.value = walletDetail;
          },
          closeOverlays: true,
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _toAddressListener() {
    toAddressRx.value = toAddressController.text;
  }

  void _amountListener() {
    double? amountValue = double.tryParse(amountController.text);
    if (amountValue != null) {
      amountRx.value = amountValue;
    }
  }
}

class WalletSendArgument {
  final WalletDetail? fromWalletDetail;
  final String? toAddress;

  const WalletSendArgument(this.fromWalletDetail, this.toAddress);
}
