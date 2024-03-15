import 'package:cards_app/model/game_details.dart';
import 'package:cards_app/resources/images.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_card.dart';
import '../../../widgets/details_tile.dart';

class GameDetailsCard extends StatelessWidget {
  final Show show;

  const GameDetailsCard({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      radius: 8,
      margin: const EdgeInsets.all(7.5),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < show.points!.length; i++) ...[
              Row(
                children: [
                  show.points![i].isWinner == true
                      ? Image.asset(Images.crown, width: 20, height: 20)
                      : Image.asset(Images.loose, width: 20, height: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DetailsTile(
                      title: Text('Player ${i + 1}'),
                      value: Text(show.points![i].user?.name ?? 'NA'),
                    ),
                  ),
                  Expanded(
                    child: DetailsTile(
                      title: const Text('Player Score'),
                      value: Text('${show.points![i].score ?? 0}'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ]
          ],
        ),
      ),
    );
  }
}
