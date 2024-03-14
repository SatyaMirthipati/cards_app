import 'package:flutter/material.dart';

import '../model/user.dart';
import '../repository/user_repo.dart';

class UserBloc with ChangeNotifier {
  final _userRepo = UserRepo();

  Future login({required Map<String, String> body}) async {
    var response = await _userRepo.login(body: body);
    return response;
  }

  Future<List<User>> getAllUsers() async {
    return await _userRepo.getAllUsers();
  }

  Future createUser({required body}) async {
    return await _userRepo.createUser(body: body);
  }

  Future<User> getOneUser({required String id}) async {
    return await _userRepo.getOneUser(id: id);
  }

  Future updateOneUser({required String id, required body}) async {
    return await _userRepo.updateOneUser(id: id, body: body);
  }
}
