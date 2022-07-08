import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_result_controller.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/avatar_image.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class QuizResultPage extends GetView<QuizResultController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backgroundImage('images/bg/gradient.svg'),
          SingleChildScrollView(
            child: Container(
              child: Obx(() {
                final PayloadChallengeResult? result =
                    controller.resultRx.value;
                if (result == null)
                  return SizedBox(
                    height: 0,
                  );
                else if (result.isRewardsDisabled) {
                  return _tablesWithPoints(result);
                } else {
                  return _tablesWithRewards(result);
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tablesWithPoints(PayloadChallengeResult result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _topOffset(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() => Text(
                controller.isWinnerScoresEnabledRx.value
                    ? 'txt_scores'.tr
                    : 'txt_players'.tr,
                style: textTheme.headline4!.copyWith(
                  color: SatorioColor.darkAccent,
                  fontSize: 24.0 * coefficient,
                  fontWeight: FontWeight.w700,
                ),
              )),
        ),
        SizedBox(
          height: 21 * coefficient,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
            color: Colors.white,
          ),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 4,
            ),
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(
              color: Colors.black.withOpacity(0.10),
              height: 1,
            ),
            itemCount: result.players.length,
            itemBuilder: (context, index) {
              final player = result.players[index];
              return _playerWithPrize(
                player.avatar,
                player.username,
                player.pts.toStringAsFixed(2),
              );
            },
          ),
        ),
        ..._buttons()
      ],
    );
  }

  Widget _tablesWithRewards(PayloadChallengeResult result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _topOffset(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'txt_prize_pool'.tr,
                style: textTheme.bodyText1!.copyWith(
                  color: SatorioColor.darkAccent,
                  fontSize: 18.0 * coefficient,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: Text(
                  result.currentPrizePool,
                  textAlign: TextAlign.end,
                  style: textTheme.bodyText1!.copyWith(
                    color: SatorioColor.darkAccent,
                    fontSize: 18.0 * coefficient,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 21 * coefficient,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'txt_top_scores'.tr,
            style: textTheme.headline4!.copyWith(
              color: SatorioColor.darkAccent,
              fontSize: 24.0 * coefficient,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 21 * coefficient,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
            color: Colors.white,
          ),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 4,
            ),
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(
              color: Colors.black.withOpacity(0.10),
              height: 1,
            ),
            itemCount: result.winners.length,
            itemBuilder: (context, index) {
              final player = result.winners[index];
              return _playerWithPrize(
                  player.avatar, player.username, player.prize);
            },
          ),
        ),
        if (result.losers.isNotEmpty) ...[
          SizedBox(
            height: 21 * coefficient,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'txt_other_players'.tr,
              style: textTheme.headline4!.copyWith(
                color: SatorioColor.darkAccent,
                fontSize: 24.0 * coefficient,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 21 * coefficient,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
              color: Colors.white,
            ),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 4,
              ),
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(
                color: Colors.black.withOpacity(0.10),
                height: 1,
              ),
              itemCount: result.losers.length,
              itemBuilder: (context, index) {
                final player = result.losers[index];
                return _otherPlayer(player.avatar, player.username);
              },
            ),
          )
        ],
        ..._buttons(),
      ],
    );
  }

  Widget _topOffset() {
    return SizedBox(
      height: Get.mediaQuery.padding.top + 22 * coefficient,
    );
  }

  List<Widget> _buttons() {
    return [
      SizedBox(
        height: 25 * coefficient,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedGradientButton(
          text: 'txt_play_next_challenge'.tr,
          onPressed: () {
            controller.quizController.toChallenges();
          },
        ),
      ),
      SizedBox(
        height: 13 * coefficient,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BorderedButton(
          text: 'txt_back_realm'.tr,
          textColor: SatorioColor.darkAccent,
          borderColor: SatorioColor.smalt.withOpacity(0.24),
          onPressed: () {
            controller.quizController.backToEpisode();
          },
        ),
      ),
      SizedBox(
        height: 38 * coefficient,
      )
    ];
  }

  Widget _playerWithPrize(String avatar, String username, String prize) {
    return Container(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: AvatarImage(
              avatar,
              width: 34,
              height: 34,
            ),
          ),
          SizedBox(
            width: 20 * coefficient,
          ),
          Expanded(
            child: Text(
              username,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyText1!.copyWith(
                color: SatorioColor.textBlack,
                fontSize: 17.0 * coefficient,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Obx(
            () => controller.isWinnerScoresEnabledRx.value
                ? Container(
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      color: SatorioColor.interactive,
                    ),
                    child: Center(
                      child: Text(
                        prize,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 15.0 * coefficient,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 0,
                  ),
          )
        ],
      ),
    );
  }

  Widget _otherPlayer(String avatar, String username) {
    return Container(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: AvatarImage(
              avatar,
              width: 34,
              height: 34,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              username,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: SatorioColor.darkAccent,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
