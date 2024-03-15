import 'package:flutter/material.dart';

import '../model/game.dart';
import '../model/game_details.dart';
import '../repository/game_repo.dart';

class UserScore {
  String? userId;
  String? score;

  UserScore({
    this.userId,
    this.score,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'score': score,
    };
  }
}

class GameBloc with ChangeNotifier {
  final _gameRepo = GameRepo();

  List<UserScore> userScores = [];

  Future<List<Game>> getAllGames() async {
    return await _gameRepo.getAllGames();
  }

  Future createGame({required body}) async {
    return await _gameRepo.createGame(body: body);
  }

  Future<GameDetails> getOneGame({required String id}) async {
    return await _gameRepo.getOneGame(id: id);
  }

  Future addPointsToGame({required String gameId, required body}) async {
    return await _gameRepo.addPointsToGame(gameId: gameId, body: body);
  }

  Future finishGame({required String gameId}) async {
    return await _gameRepo.finishGame(gameId: gameId);
  }
}
