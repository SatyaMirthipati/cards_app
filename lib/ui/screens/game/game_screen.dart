import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bloc/game_bloc.dart';
import '../../../model/game.dart';
import '../../../resources/colors.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import 'widgets/add_game_sheet.dart';
import 'widgets/game_card.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    var gameBloc = Provider.of<GameBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: const Text('Games'),
        actions: [
          TextButton.icon(
            onPressed: () async {
              var res = await AddGameSheet.open(context);
              if (res != true) return;
              setState(() {});
            },
            label: const Text('Create Game'),
            icon: const Icon(
              Icons.add_box_rounded,
              color: MyColors.primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: FutureBuilder<List<Game>>(
        future: gameBloc.getAllGames(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CustomErrorWidget(error: snapshot.error);
          }
          if (!snapshot.hasData) return const LoadingWidget();
          var list = snapshot.data ?? [];
          if (list.isEmpty) return const EmptyWidget();
          return ListView(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return GameCard(game: list[index]);
                },
              ),
              const SizedBox(height: 100),
            ],
          );
        },
      ),
    );
  }
}
