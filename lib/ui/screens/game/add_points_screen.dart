import 'package:cards_app/bloc/game_bloc.dart';
import 'package:cards_app/ui/screens/main/main_screen.dart';
import 'package:cards_app/ui/screens/success_screen.dart';
import 'package:cards_app/ui/widgets/navbar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../model/user.dart';

class AddPointsScreen extends StatefulWidget {
  final List<User> users;
  final String gameId;

  const AddPointsScreen({super.key, required this.users, required this.gameId});

  static Future open(
    BuildContext context, {
    required List<User> users,
    required String gameId,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddPointsScreen(users: users, gameId: gameId),
      ),
    );
  }

  @override
  State<AddPointsScreen> createState() => _AddPointsScreenState();
}

class _AddPointsScreenState extends State<AddPointsScreen> {
  final formKey = GlobalKey<FormState>();
  late List<String?> enteredScores;

  @override
  void initState() {
    super.initState();
    enteredScores = List.generate(widget.users.length, (index) => null);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var gameBloc = Provider.of<GameBloc>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        gameBloc.userScores.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Points Screen')),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              for (var i = 0; i < widget.users.length; i++) ...[
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: textTheme.bodyLarge,
                  decoration: InputDecoration(
                    labelText: '${widget.users[i].name}',
                  ),
                  onChanged: (v) {
                    enteredScores[i] = v;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(2),
                  ],
                  validator: (text) {
                    if (text?.trim().isEmpty ?? true) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
              ]
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: NavbarButton(
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              for (var i = 0; i < widget.users.length; i++) {
                if (enteredScores[i] != null) {
                  gameBloc.userScores.add(
                    UserScore(
                      userId: widget.users[i].id,
                      score: enteredScores[i],
                    ),
                  );
                }
              }
              enteredScores =
                  List.generate(widget.users.length, (index) => null);
              var body = {
                'points':
                    gameBloc.userScores.map((score) => score.toJson()).toList(),
              };
              await gameBloc.addPointsToGame(gameId: widget.gameId, body: body);

              SuccessScreen.open(
                context,
                onProcess: () => MainScreen.open(context),
                title: 'Game points updated',
                description: '',
              );
            }
          },
          child: const Text('Submit'),
        ),
      ),
    );
  }
}
