import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/select_avatar_type.dart';
import 'package:satorio/domain/entities/wallet.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/main_page.dart';
import 'package:satorio/util/avatar_list.dart';

class SelectAvatarController extends GetxController with BackToMainMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<String?> avatarRx = Rx(null);
  final Rx<Profile?> profileRx = Rx(null);
  final Rx<List<NftItem>> nftItemsRx = Rx([]);
  final Rx<AvatarsListType> avatarsListType = Rx(AvatarsListType.local);

  Map<String, Wallet> wallets = {};
  Rx<List<WalletDetail>> walletDetailsRx = Rx([]);
  RxString solanaAddressRx = ''.obs;

  late final ValueListenable<Box<Profile>> profileListenable;
  late ValueListenable<Box<Wallet>> _walletsListenable;
  ValueListenable<Box<WalletDetail>>? _walletDetailsListenable;

  final int _itemsPerPageNft = 4;
  static const int _initialPage = 1;

  late final SelectAvatarType type;
  late final Uri? deepLink;

  SelectAvatarController() {
    SelectAvatarArgument argument = Get.arguments as SelectAvatarArgument;
    type = argument.selectAvatarType;
    deepLink = argument.deepLink;
    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;

    _walletsListenable =
        _satorioRepository.walletsListenable() as ValueListenable<Box<Wallet>>;
  }

  void toggle(AvatarsListType value) {
    avatarsListType.value = value;
  }

  void setAvatar(int index) {
    if (avatarsListType.value == AvatarsListType.local) {
      avatarRx.value = avatars[index];
    } else {
      avatarRx.value = nftItemsRx.value[index].nftPreview;
    }
  }

  void saveAvatar() {
    _satorioRepository.selectAvatar(avatarRx.value!).then((isSuccess) {
      if (isSuccess) {
        //TODO: for future, when settings page created
        switch (type) {
          case SelectAvatarType.registration:
            Get.offAll(
              () => MainPage(),
              binding: MainBinding(),
              arguments: MainArgument(deepLink),
            );
            break;
          case SelectAvatarType.settings:
            avatarRx.value = null;
            back();
            break;
        }
        _satorioRepository.updateProfile();
      } else {
        avatarRx.value = null;
      }
    }).catchError((value) {
      avatarRx.value = null;
    });
  }

  void back() {
    Get.back();
  }

  void toNfts() {
    if (Get.isRegistered<MainController>()) {
      MainController mainController = Get.find();
      mainController.selectedBottomTabIndex.value = MainController.TabNfts;
    }
  }

  @override
  void onInit() {
    super.onInit();

    _profileListener();
    profileListenable.addListener(_profileListener);
    _walletsListenable.addListener(_walletsListener);
    _refreshAllWallets();
  }

  @override
  void onClose() {
    profileListenable.removeListener(_profileListener);
    _walletsListenable.removeListener(_walletsListener);
    _walletDetailsListenable?.removeListener(_walletDetailsListener);
    super.onClose();
  }

  void _walletsListener() {
    // Update wallets map
    Map<String, Wallet> walletsNew = {};
    _walletsListenable.value.values.forEach((wallet) {
      walletsNew[wallet.id] = wallet;
    });
    wallets = walletsNew;

    // Ids of wallets
    List<String> ids = wallets.values.map((wallet) => wallet.id).toList();

    // Re-subscribe to new actual ids
    _walletDetailsListenable?.removeListener(_walletDetailsListener);
    _walletDetailsListenable = _satorioRepository.walletDetailsListenable(ids)
        as ValueListenable<Box<WalletDetail>>;
    _walletDetailsListenable?.addListener(_walletDetailsListener);
  }

  void _walletDetailsListener() {
    List<WalletDetail> walletDetails =
        _walletDetailsListenable!.value.values.toList();
    walletDetails.sort((a, b) => a.order.compareTo(b.order));
    walletDetailsRx.value = walletDetails;
    _solanaAddress();
  }

  void _profileListener() {
    if (profileListenable.value.length > 0)
      profileRx.value = profileListenable.value.getAt(0);
  }

  void _refreshAllWallets() {
    _satorioRepository.updateWallets().then((List<Wallet> wallets) {
      wallets.forEach((wallet) {
        _updateWalletDetail(wallet);
      });
    });
  }

  void _updateWalletDetail(Wallet? wallet) {
    if (wallet != null) {
      _satorioRepository.updateWalletDetail(wallet.detailsUrl);
    }
  }

  void _solanaAddress() {
    walletDetailsRx.value.forEach((element) {
      solanaAddressRx.update((val) {
        if (element.solanaAccountAddress.isNotEmpty) {
          solanaAddressRx.value = element.solanaAccountAddress;
          _loadNfts();
        }
      });
    });
  }

  void _loadNfts() {
    if (profileRx.value != null) {
      _satorioRepository
          .userNfts(solanaAddressRx.value)
          .then((List<NftItem> nftItems) {
        nftItemsRx.value = nftItems;
      });
    }
  }
}

class SelectAvatarArgument {
  final SelectAvatarType selectAvatarType;
  final Uri? deepLink;

  const SelectAvatarArgument(this.selectAvatarType, this.deepLink);
}

enum AvatarsListType {
  local,
  nfts,
}
