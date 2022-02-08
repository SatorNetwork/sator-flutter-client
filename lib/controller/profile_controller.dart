import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/active_realms_binding.dart';
import 'package:satorio/binding/nft_item_binding.dart';
import 'package:satorio/binding/nft_list_binding.dart';
import 'package:satorio/binding/reviews_binding.dart';
import 'package:satorio/binding/select_avatar_binding.dart';
import 'package:satorio/binding/show_episodes_realm_binding.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/nft_item_controller.dart';
import 'package:satorio/controller/nft_list_controller.dart';
import 'package:satorio/controller/reviews_controller.dart';
import 'package:satorio/controller/select_avatar_controller.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';
import 'package:satorio/domain/entities/activated_realm.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/review.dart';
import 'package:satorio/domain/entities/select_avatar_type.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/dialog_widget/send_invite_dialog.dart';
import 'package:satorio/ui/page_widget/active_realms_page.dart';
import 'package:satorio/ui/page_widget/nft_item_page.dart';
import 'package:satorio/ui/page_widget/nft_list_page.dart';
import 'package:satorio/ui/page_widget/reviews_page.dart';
import 'package:satorio/ui/page_widget/select_avatar_page.dart';
import 'package:satorio/ui/page_widget/show_episodes_realm_page.dart';

class ProfileController extends GetxController with NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final int _itemsPerPage = 10;
  final int _itemsPerPageNft = 4;
  static const int _initialPage = 1;

  final Rx<Profile?> profileRx = Rx(null);
  final Rx<List<Review?>> reviewsRx = Rx([]);
  final Rx<List<ActivatedRealm?>> activatedRealmsRx = Rx([]);
  final Rx<List<NftItem>> nftItemsRx = Rx([]);

  late final ValueListenable<Box<Profile>> profileListenable;

  ProfileController() {
    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;
  }

  @override
  void onInit() {
    super.onInit();

    _profileListener();
    profileListenable.addListener(_profileListener);

    _loadUserReviews();
    _loadActivatedRealms();
    _loadNfts();
  }

  @override
  void onClose() {
    profileListenable.removeListener(_profileListener);
    super.onClose();
  }

  void refreshPage() {
    _satorioRepository.updateProfile();
    _loadUserReviews();
    _loadActivatedRealms();
    _loadNfts();
  }

  void toReviewsPage() {
    Get.to(
      () => ReviewsPage(),
      binding: ReviewsBinding(),
      arguments: ReviewsArgument('', '', false),
    );
  }

  void toActiveRealmsPage() {
    Get.to(
      () => ActiveRealmsPage(),
      binding: ActiveRealmsBinding(),
    );
  }

  Future toEpisodeDetail(ActivatedRealm realm) async {
    ShowDetail showDetail = await _satorioRepository.showDetail(realm.showId);
    ShowEpisode showEpisode =
        await _satorioRepository.showEpisode(realm.showId, realm.id);

    Get.to(
      () => ShowEpisodesRealmPage(),
      binding: ShowEpisodesRealmBinding(),
      arguments: ShowEpisodeRealmArgument(
          showDetail,
          ShowSeason(realm.showId, realm.seasonNumber, realm.showTitle, []),
          showEpisode,
          true),
    );
  }

  void _loadUserReviews() {
    _satorioRepository
        .getUserReviews(page: _initialPage, itemsPerPage: _itemsPerPage)
        .then((List<Review> reviews) {
      reviewsRx.value = reviews;
    });
  }

  void _loadActivatedRealms() {
    _satorioRepository
        .getActivatedRealms(page: _initialPage, itemsPerPage: _itemsPerPage)
        .then((List<ActivatedRealm> episodes) {
      activatedRealmsRx.value = episodes;
    });
  }

  Future<void> getReferralCode() async {
    _satorioRepository.getReferralCode().then((value) {
      _createDynamicLink(value.referralCode);
      print(value.referralCode);
    });
  }

  Future<void> _createDynamicLink(String referralCode) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://satorio.page.link',
      link: Uri.parse('https://satorio.page.link/referal?code=$referralCode'),
      androidParameters: AndroidParameters(
        packageName: 'com.satorio.app',
        minimumVersion: 0,
      ),
      // iosParameters: IosParameters(
      //   bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
      //   minimumVersion: '0',
      // ),
    );

    parameters.buildShortLink().then((value) {
      print(value.shortUrl);
      Get.dialog(
        SendInviteDialog(value.shortUrl.toString()),
      );
    });
  }

  void toSelectAvatar() {
    Get.to(
      () => SelectAvatarPage(),
      binding: SelectAvatarBinding(),
      arguments: SelectAvatarArgument(SelectAvatarType.settings, null),
    );
  }

  void toLogoutDialog() {
    Get.dialog(
      DefaultDialog(
        'txt_log_out'.tr,
        'txt_log_out_message'.tr,
        'txt_yes'.tr,
        icon: Icons.logout,
        onButtonPressed: () {
          _satorioRepository.logout();
        },
        secondaryButtonText: 'txt_no'.tr,
      ),
    );
  }

  void toNftsMarketplace() {
    if (Get.isRegistered<MainController>()) {
      MainController mainController = Get.find();
      mainController.selectedBottomTabIndex.value = MainController.TabNfts;
    }
  }

  void toMyNfts() {
    if (profileRx.value != null) {
      Get.to(
        () => NftListPage(),
        binding: NftListBinding(),
        arguments: NftListArgument(NftFilterType.User, profileRx.value!.id),
      );
    }
  }

  void toNftItem(final NftItem nftItem) {
    Get.to(
      () => NftItemPage(),
      binding: NftItemBinding(),
      arguments: NftItemArgument(nftItem),
    );
  }

  void _profileListener() {
    if (profileListenable.value.length > 0)
      profileRx.value = profileListenable.value.getAt(0);
  }

  void _loadNfts() {
    if (profileRx.value != null) {
      _satorioRepository
          .nftItems(
        NftFilterType.User,
        profileRx.value!.id,
        page: _initialPage,
        itemsPerPage: _itemsPerPageNft,
      )
          .then((List<NftItem> nftItems) {
        nftItemsRx.value = nftItems;
      });
    }
  }
}
