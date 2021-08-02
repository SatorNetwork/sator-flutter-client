import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class WalletDetailContainer extends StatelessWidget {
  const WalletDetailContainer(this.walletDetail, {this.height, this.margin});

  final WalletDetail walletDetail;
  final double? height;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: SatorioColor.darkAccent,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SvgPicture.asset(
                'images/sator_wallet.svg',
                height: height,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 22, left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      text: walletDetail.balance.length > 0
                          ? walletDetail.balance[0].amount.toStringAsFixed(2)
                          : '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w700,
                        backgroundColor: Colors.transparent,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.0,
                            fontWeight: FontWeight.w600,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        TextSpan(
                          text: walletDetail.balance.length > 0
                              ? walletDetail.balance[0].currency
                              : '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  RichText(
                    text: TextSpan(
                      text: walletDetail.balance.length > 1
                          ? walletDetail.balance[1].amount.toStringAsFixed(2)
                          : '',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        backgroundColor: Colors.transparent,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        TextSpan(
                          text: walletDetail.balance.length > 1
                              ? walletDetail.balance[1].currency
                              : '',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (walletDetail.balance.length > 2)
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 30,
                  left: 24,
                ),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.25),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  child: Text(
                    '${walletDetail.balance[2].amount.toStringAsFixed(2)} ${walletDetail.balance[2].currency}',
                    style: textTheme.subtitle2!.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
