import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/models/model_mate_k.dart';
import 'package:smate/screens/common/about_date.dart';
import 'package:smate/screens/mating/widgets/mate_card_header_join.dart';
import 'package:smate/screens/mating/widgets/mate_card_header_mine.dart';
import 'package:smate/screens/mating/widgets/mate_join_member_in_card.dart';

enum MatingCardType { mine, join, like, none }

class MatingCard extends StatelessWidget {
  final MateModel mateModel;
  final MatingCardType type;

  const MatingCard({
    Key? key,
    required this.mateModel,
    required this.type,
  }) : super(key: key);

  Widget header() {
    switch (type) {
      case MatingCardType.mine:
        return MateCardHeaderMine(
          mateInfo: mateModel,
        );
      case MatingCardType.join:
        return MateCardHeaderJoin(
          mateInfo: mateModel,
        );
      default:
        return MateCardHeaderJoin(
          mateInfo: mateModel,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    logError('MatingCardType  Build!!!! ${MatingCardType.join}');

    return Card(
      elevation: 2,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SizedBox(
          height: 153,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: CachedNetworkImage(
                  imageUrl: mateModel.images![0],
                  fit: BoxFit.cover,
                ),
              ),
              Flexible(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Constants.sapceGap * 2,
                      horizontal: Constants.sapceGap * 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header(),
                      const SizedBox(
                        height: Constants.sapceGap * 3,
                      ),
                      Text(
                        mateModel.title ?? "none",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(
                        height: Constants.sapceGap * 2,
                      ),
                      Text(
                        "${mateModel.locationStr} · ${AboutDate.dateForMate.format(
                          (mateModel.mateDate ?? DateTime.now()),
                        )}",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .apply(color: ColorStore.color65),
                      ),
                      const SizedBox(
                        height: Constants.sapceGap * 3,
                      ),
                      CardJoinMember(
                          limitCount: mateModel.memberLimit!,
                          userList: mateModel.member?.joinMember),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
