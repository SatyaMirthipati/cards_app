import 'package:cards_app/resources/theme.dart';
import 'package:cards_app/ui/screens/splash/splash_screen.dart';
import 'package:cards_app/ui/widgets/progress_block_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:provider/provider.dart';

import 'bloc/game_bloc.dart';
import 'bloc/main_bloc.dart';
import 'bloc/progress_bloc.dart';
import 'bloc/user_bloc.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProgressBloc()),
          ChangeNotifierProvider(create: (_) => MainBloc()),
          ChangeNotifierProvider(create: (_) => UserBloc()),
          ChangeNotifierProvider(create: (_) => GameBloc()),
        ],
        child: ProgressBlockWidget(
          child: MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Shuffle Squad',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme,
            home: const SplashScreen(),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
          ),
        ),
      ),
    );
  }
}
