import 'package:cards_app/bloc/user_bloc.dart';
import 'package:cards_app/ui/screens/main/main_screen.dart';
import 'package:cards_app/ui/screens/success_screen.dart';
import 'package:cards_app/ui/widgets/navbar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../utils/helper.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  static Future open(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateUserScreen(),
      ),
    );
  }

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Create Player')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Enter the following details to proceed',
              style: textTheme.labelSmall!.copyWith(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: nameCtrl,
              autofocus: true,
              keyboardType: TextInputType.text,
              style: textTheme.bodyLarge,
              inputFormatters: <TextInputFormatter>[
                CapitalizeEachWordFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              style: textTheme.bodyLarge,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: mobileCtrl,
              keyboardType: TextInputType.number,
              style: textTheme.bodyLarge,
              decoration: const InputDecoration(labelText: 'Mobile'),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(10),
              ],
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: NavbarButton(
        onPressed: () async {
          if (!(formKey.currentState?.validate() ?? true)) return;
          formKey.currentState?.save();
          var userBloc = Provider.of<UserBloc>(context, listen: false);

          var body = {
            'name': nameCtrl.text,
            'email': emailCtrl.text,
            'mobile': mobileCtrl.text,
          };
          await userBloc.createUser(body: body);

          SuccessScreen.open(
            context,
            onProcess: () => MainScreen.open(context),
            title: 'User Created Successfully',
            description: '',
          );
        },
        child: const Text('Submit'),
      ),
    );
  }
}
