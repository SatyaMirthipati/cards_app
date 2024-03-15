import 'package:cards_app/bloc/game_bloc.dart';
import 'package:cards_app/bloc/user_bloc.dart';
import 'package:cards_app/model/user.dart';
import 'package:cards_app/ui/screens/game/game_details_screen.dart';
import 'package:cards_app/ui/screens/main/main_screen.dart';
import 'package:cards_app/ui/widgets/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/empty_widget.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/loading_widget.dart';
import 'select_user_widget.dart';

class AddGameSheet extends StatefulWidget {
  const AddGameSheet({super.key});

  static Future open(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return const AddGameSheet();
      },
    );
  }

  @override
  State<AddGameSheet> createState() => _AddGameSheetState();
}

class _AddGameSheetState extends State<AddGameSheet> {
  Set<String> ids = {};

  Future<List>? future;

  @override
  void initState() {
    super.initState();
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    future = Future.wait([userBloc.getAllUsers()]);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return IntrinsicHeight(
      child: Container(
        height: 450,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: FutureBuilder<List>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return CustomErrorWidget(error: snapshot.error);
            }
            if (!snapshot.hasData) return const LoadingWidget();
            var list = snapshot.data?[0] as List<User>;
            if (list.isEmpty) return const EmptyWidget();
            return ListView(
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Select Users',
                    style: textTheme.bodyLarge!.copyWith(fontSize: 18),
                  ),
                ),
                ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    return SelectUserWidget(
                      user: list[index],
                      ids: ids,
                      onChange: (v) {
                        if (!ids.contains(list[index].id)) {
                          ids.add('${list[index].id}');
                        } else if (ids.contains(list[index].id)) {
                          ids.remove(list[index].id);
                        } else {
                          ids.remove('${list[index].id}');
                        }
                        setState(() {});
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ProgressButton(
                    onPressed: () async {
                      var gameBloc = Provider.of<GameBloc>(
                        context,
                        listen: false,
                      );

                      var body = {'userIds': ids.toList()};
                      var res = await gameBloc.createGame(body: body);

                      MainScreen.open(context);
                      GameDetailsScreen.open(context, id: res['_id']);
                    },
                    child: const Text('Continue'),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
