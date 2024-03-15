import 'package:cards_app/data/network/api_client.dart';
import 'package:cards_app/data/network/api_endpoints.dart';
import 'package:cards_app/model/game_details.dart';

import '../model/game.dart';

class GameRepo {
  Future<List<Game>> getAllGames() async {
    var response = await apiClient.get(Api.games);
    var list = response['data'] as List;
    return list.map((e) => Game.fromMap(e)).toList();
  }

  Future createGame({required body}) async {
    var response = await apiClient.post(Api.games, body);
    return response;
  }

  Future<GameDetails> getOneGame({required String id}) async {
    var response = await apiClient.get('${Api.games}/$id');
    return GameDetails.fromMap(response);
  }

  Future addPointsToGame({required String gameId, required body}) async {
    var response = await apiClient.patch(
      '${Api.games}/$gameId/${Api.addPoints}',
      body,
    );
    return response;
  }

  Future finishGame({required String gameId}) async {
    var response = await apiClient.patch(
      '${Api.games}/$gameId/${Api.finish}',
      {},
    );
    return response;
  }
}
