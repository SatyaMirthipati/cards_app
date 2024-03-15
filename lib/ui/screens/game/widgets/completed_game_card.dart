import 'package:cards_app/model/game_details.dart';
import 'package:flutter/material.dart';

import '../../../../resources/images.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/details_tile.dart';

class CompletedGameCard extends StatelessWidget {
  final List<TotalCount> totalCount;

  const CompletedGameCard({super.key, required this.totalCount});

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
            for (var i in totalCount) ...[
              Row(
                children: [
                  i.isWinner == true
                      ? Image.asset(Images.crown, width: 20, height: 20)
                      : Image.asset(Images.loose, width: 20, height: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DetailsTile(
                      title: const Text('Player'),
                      value: Text(i.user?.name ?? 'NA'),
                    ),
                  ),
                  Expanded(
                    child: DetailsTile(
                      title: const Text('Player Score'),
                      value: Text('${i.total ?? 0}'),
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
