import 'package:cards_app/ui/screens/game/game_screen.dart';
import 'package:cards_app/ui/screens/users/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bloc/main_bloc.dart';
import '../../../resources/colors.dart';
import '../../../resources/images.dart';
import '../../widgets/dialog_confirm.dart';
import '../home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static Future open(BuildContext context) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
      (_) => false,
    );
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var mainBloc = Provider.of<MainBloc>(context, listen: true);
    return WillPopScope(
      onWillPop: () async {
        var res = await ConfirmDialog.show(
          context,
          message: 'Are you sure you want to exit',
          title: 'Exit App ?',
        );
        if (res != true) return false;
        return true;
      },
      child: Scaffold(
        extendBody: true,
        body: Builder(
          builder: (context) {
            switch (mainBloc.index) {
              case 0:
                return HomeScreen();
              case 1:
                return GameScreen();
              case 2:
                return const UsersScreen();
              default:
                return Container();
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Colors.white,
          unselectedItemColor: const Color(0xFF000000),
          type: BottomNavigationBarType.fixed,
          currentIndex: mainBloc.index,
          onTap: mainBloc.updateIndex,
          elevation: 15,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(4.0),
                child: ImageIcon(AssetImage(Images.home)),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.all(4.0),
                child: ImageIcon(AssetImage(Images.home)),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(4.0),
                child: ImageIcon(AssetImage(Images.game)),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.all(4.0),
                child: ImageIcon(AssetImage(Images.game)),
              ),
              label: 'Games',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(4.0),
                child: ImageIcon(AssetImage(Images.users)),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.all(4.0),
                child: ImageIcon(AssetImage(Images.users)),
              ),
              label: 'Players',
            ),
          ],
        ),
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  final String image;
  final bool selected;
  final VoidCallback onTap;
  final String text;

  const IconWidget({
    Key? key,
    required this.image,
    required this.selected,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: selected
                  ? MyColors.primaryColor
                  : MyColors.primaryColor.withOpacity(0.3),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                    image,
                    height: 22,
                    width: 25,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  text,
                  style: textTheme.labelSmall!.copyWith(fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
