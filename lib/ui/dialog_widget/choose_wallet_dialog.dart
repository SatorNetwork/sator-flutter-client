import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/wallet_detail_container.dart';

typedef SelectWalletDetailCallback = void Function(WalletDetail walletDetail);

class ChooseWalletDialog extends StatelessWidget {
  ChooseWalletDialog(this.title, this.walletDetails, this.onSelected);

  final String title;
  final List<WalletDetail> walletDetails;
  final SelectWalletDetailCallback onSelected;

  final PageController _pageController = PageController(
    keepPage: true,
    viewportFraction: 0.85,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: textTheme.headline1!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 21.0 * coefficient,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 150,
              child: PageView.builder(
                controller: _pageController,
                itemCount: walletDetails.length,
                itemBuilder: (context, index) {
                  WalletDetail walletDetail = walletDetails[index];
                  return InkWell(
                    onTap: () {
                      Get.back();
                      onSelected(walletDetail);
                    },
                    child: WalletDetailContainer(
                      walletDetail,
                      height: 150,
                      margin: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                    ),
                  );
                  // return _walletItem(walletDetail);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
