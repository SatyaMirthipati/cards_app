import 'package:cards_app/ui/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bloc/user_bloc.dart';
import '../../../data/local/shared_prefs.dart';
import '../../widgets/progress_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static Future open(BuildContext context) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (_) => false,
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final loginIdCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 100),
            const SizedBox(height: 50),
            Text(
              'Login to your account',
              style: textTheme.headlineMedium!.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextFormField(
              cursorWidth: 1,
              controller: loginIdCtrl,
              style: textTheme.titleMedium,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Username'),
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: passwordCtrl,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                  ),
                  onPressed: () => setState(() => showPassword = !showPassword),
                ),
              ),
              obscureText: !showPassword,
              keyboardType: TextInputType.visiblePassword,
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            ProgressButton(
              onPressed: () async {
                if (!(formKey.currentState?.validate() ?? true)) return;
                formKey.currentState?.save();
                final navigator = Navigator.of(context);

                Map<String, String> body = {
                  'username': loginIdCtrl.text,
                  'password': passwordCtrl.text,
                };
                var response = await userBloc.login(body: body);

                var token = response['access_token'];
                await Prefs.setToken(token);
                MainScreen.open(context);
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
