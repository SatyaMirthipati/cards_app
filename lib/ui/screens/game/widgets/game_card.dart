import 'package:cards_app/ui/screens/game/completed_game_screen.dart';
import 'package:cards_app/ui/screens/game/game_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../model/game.dart';
import '../../../../resources/colors.dart';
import '../../../../utils/helper.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/details_tile.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return CustomCard(
      radius: 8,
      margin: const EdgeInsets.all(7.5),
      child: InkWell(
        onTap: () async {
          if (game.status == 'IN_PROGRESS') {
            GameDetailsScreen.open(context, id: '${game.id}');
          } else {
            CompletedGameScreen.open(context, id: '${game.id}');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      if (game.title != null)
                        Expanded(
                          child: DetailsTile(
                            title: const Text('Title'),
                            value: Text(DateFormat('dd MMMM, yyyy')
                                .format(game.title!)),
                          ),
                        ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: DetailsTile(
                          title: const Text('Player Count'),
                          value: Text('${game.usersIds?.length ?? 0} Users'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: DetailsTile(
                          title: const Text('Status'),
                          value: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: game.status == 'IN_PROGRESS'
                                  ? MyColors.pending.withOpacity(0.2)
                                  : MyColors.completed.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              Helper.statuses[game.status] ?? 'NA',
                              style: textTheme.titleMedium!.copyWith(
                                color: game.status == 'IN_PROGRESS'
                                    ? MyColors.pending
                                    : MyColors.completed,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: DetailsTile(
                          title: const Text('Sub-Game Count'),
                          value: Text('${game.shows?.length ?? 0} Sub-Games'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: -15,
                right: -15,
                child: IconButton(
                  onPressed: () {
                    GameDetailsScreen.open(context, id: '${game.id}');
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: MyColors.primaryColor,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
