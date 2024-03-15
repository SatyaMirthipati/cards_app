import 'package:cards_app/bloc/game_bloc.dart';
import 'package:cards_app/model/game_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/empty_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import 'widgets/completed_game_card.dart';

class CompletedGameScreen extends StatelessWidget {
  final String id;

  const CompletedGameScreen({super.key, required this.id});

  static Future open(BuildContext context, {required String id}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CompletedGameScreen(id: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var gameBloc = Provider.of<GameBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Completed Screen')),
      body: FutureBuilder<GameDetails>(
        future: gameBloc.getOneGame(id: id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CustomErrorWidget(error: snapshot.error);
          }
          if (!snapshot.hasData) return const LoadingWidget();
          var gameDetails = snapshot.data;
          var data = gameDetails?.totalCount ?? [];
          if (data.isEmpty) return const EmptyWidget();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CompletedGameCard(totalCount: data),
              ),
            ],
          );
        },
      ),
    );
  }
}
