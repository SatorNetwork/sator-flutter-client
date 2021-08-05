import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class WalletDetailContainer extends StatelessWidget {
  WalletDetailContainer(this.walletDetail,
      {this.height = _defaultHeight, this.margin});

  static const double _defaultHeight = 200.0;

  final WalletDetail walletDetail;
  final double height;
  final EdgeInsetsGeometry? margin;

  double get _fraction {
    return height / _defaultHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20 * _fraction),
        color: SatorioColor.darkAccent,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20 * _fraction),
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
              padding:
                  EdgeInsets.only(top: 22 * _fraction, left: 24 * _fraction),
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
                        fontSize: 32.0 * _fraction,
                        fontWeight: FontWeight.w700,
                        backgroundColor: Colors.transparent,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.0 * _fraction,
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
                            fontSize: 20.0 * _fraction,
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
                        fontSize: 16.0 * _fraction,
                        fontWeight: FontWeight.w500,
                        backgroundColor: Colors.transparent,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16.0 * _fraction,
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
                            fontSize: 12.0 * _fraction,
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
                padding: EdgeInsets.only(
                  bottom: 30 * _fraction,
                  left: 24 * _fraction,
                ),
                child: Container(
                  height: 30 * _fraction,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.25),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12 * _fraction,
                    vertical: 7 * _fraction,
                  ),
                  child: Text(
                    '${walletDetail.balance[2].amount.toStringAsFixed(2)} ${walletDetail.balance[2].currency}',
                    style: textTheme.subtitle2!.copyWith(
                      color: Colors.white,
                      fontSize: 12 * _fraction,
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
