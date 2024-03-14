import 'package:cards_app/model/user.dart';

import '../data/network/api_client.dart';
import '../data/network/api_endpoints.dart';

class UserRepo {
  Future login({required Map<String, String> body}) async {
    var response = await apiClient.post(Api.login, body);
    return response;
  }

  Future<List<User>> getAllUsers() async {
    var response = await apiClient.get(Api.users);
    var list = response['data'] as List;
    return list.map((e) => User.fromMap(e)).toList();
  }

  Future createUser({required body}) async {
    var response = await apiClient.post(Api.users, body);
    return response;
  }

  Future<User> getOneUser({required String id}) async {
    var response = await apiClient.get('${Api.users}/$id');
    return User.fromMap(response);
  }

  Future updateOneUser({required String id, required body}) async {
    var response = await apiClient.patch('${Api.users}/$id', body);
    return response;
  }
}
