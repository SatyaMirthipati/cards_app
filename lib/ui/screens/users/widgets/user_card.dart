import 'package:cards_app/model/user.dart';
import 'package:cards_app/ui/screens/users/update_user_screen.dart';
import 'package:cards_app/ui/widgets/custom_card.dart';
import 'package:cards_app/ui/widgets/details_tile.dart';
import 'package:cards_app/utils/helper.dart';
import 'package:flutter/material.dart';

import '../../../../resources/colors.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      radius: 8,
      margin: const EdgeInsets.all(7.5),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DetailsTile(
                        title: const Text('Player name'),
                        value: Text((user.name ?? 'NA').toCapitalized()),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: DetailsTile(
                        title: const Text('Mobile'),
                        value: Text(user.mobile ?? 'NA'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                DetailsTile(
                  title: const Text('Email'),
                  value: Text(user.email ?? 'NA'),
                ),
              ],
            ),
            Positioned(
              top: -15,
              right: -15,
              child: IconButton(
                onPressed: () {
                  UpdateUserScreen.open(context, id: '${user.id}');
                },
                icon: const Icon(
                  Icons.edit,
                  color: MyColors.primaryColor,
                  size: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
