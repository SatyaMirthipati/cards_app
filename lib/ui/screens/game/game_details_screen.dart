import 'package:cards_app/bloc/game_bloc.dart';
import 'package:cards_app/model/game_details.dart';
import 'package:cards_app/ui/screens/main/main_screen.dart';
import 'package:cards_app/ui/screens/success_screen.dart';
import 'package:cards_app/ui/widgets/empty_widget.dart';
import 'package:cards_app/ui/widgets/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import 'add_points_screen.dart';
import 'widgets/game_details_card.dart';

class GameDetailsScreen extends StatelessWidget {
  final String id;

  const GameDetailsScreen({super.key, required this.id});

  static Future open(BuildContext context, {required String id}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GameDetailsScreen(id: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var gameBloc = Provider.of<GameBloc>(context, listen: false);
    return FutureBuilder<GameDetails>(
      future: gameBloc.getOneGame(id: id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CustomErrorWidget.scaffold(error: snapshot.error);
        }
        if (!snapshot.hasData) return const LoadingWidget.scaffold();
        var gameDetails = snapshot.data!;
        var shows = gameDetails.shows ?? [];
        if (shows.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: const Text('Game Details')),
            body: const EmptyWidget(message: 'No Sub Games'),
            extendBody: true,
            bottomNavigationBar: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: ProgressButton(
                      onPressed: () async {
                        AddPointsScreen.open(
                          context,
                          users: gameDetails.users ?? [],
                          gameId: '${gameDetails.id}',
                        );
                      },
                      child: const Text('Add Points'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        await gameBloc.finishGame(gameId: '${gameDetails.id}');
                        SuccessScreen.open(
                          context,
                          onProcess: () => MainScreen.open(context),
                          title: 'Game completed successfully',
                          description: '',
                        );
                      },
                      child: const Text('End Game'),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Game Details')),
          body: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: shows.length,
            itemBuilder: (context, index) {
              return GameDetailsCard(show: shows[index]);
            },
          ),
          extendBody: true,
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: ProgressButton(
                    onPressed: () async {
                      AddPointsScreen.open(
                        context,
                        users: gameDetails.users ?? [],
                        gameId: '${gameDetails.id}',
                      );
                    },
                    child: const Text('Add Points'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      await gameBloc.finishGame(gameId: '${gameDetails.id}');
                      SuccessScreen.open(
                        context,
                        onProcess: () => MainScreen.open(context),
                        title: 'Game completed successfully',
                        description: '',
                      );
                    },
                    child: const Text('End Game'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
