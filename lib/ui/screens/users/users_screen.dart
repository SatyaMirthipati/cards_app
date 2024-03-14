import 'package:cards_app/bloc/user_bloc.dart';
import 'package:cards_app/model/user.dart';
import 'package:cards_app/resources/colors.dart';
import 'package:cards_app/ui/screens/users/create_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/empty_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import 'widgets/user_card.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: const Text('Players'),
        actions: [
          TextButton.icon(
            onPressed: () {
              CreateUserScreen.open(context);
            },
            label: const Text('Add Player'),
            icon: const Icon(
              Icons.add_box_rounded,
              color: MyColors.primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: userBloc.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CustomErrorWidget(error: snapshot.error);
          }
          if (!snapshot.hasData) return const LoadingWidget();
          var list = snapshot.data ?? [];
          if (list.isEmpty) return const EmptyWidget();
          return ListView.builder(
            itemCount: list.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return UserCard(user: list[index]);
            },
          );
        },
      ),
    );
  }
}
