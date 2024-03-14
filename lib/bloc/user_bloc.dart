import 'package:flutter/material.dart';

import '../repository/user_repo.dart';

class UserBloc with ChangeNotifier{
  final _userRepo = UserRepo();

  Future login({required Map<String, String> body}) async {
    var response = await _userRepo.login(body: body);
    return response;
  }
}