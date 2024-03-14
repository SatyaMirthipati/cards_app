import 'package:cards_app/bloc/user_bloc.dart';
import 'package:cards_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../utils/helper.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/navbar_button.dart';
import '../main/main_screen.dart';
import '../success_screen.dart';

class UpdateUserScreen extends StatelessWidget {
  final String id;

  const UpdateUserScreen({super.key, required this.id});

  static Future open(BuildContext context, {required String id}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdateUserScreen(id: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    return FutureBuilder<User>(
      future: userBloc.getOneUser(id: id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CustomErrorWidget.scaffold(error: snapshot.error);
        }
        if (!snapshot.hasData) return const LoadingWidget.scaffold();
        var user = snapshot.data!;
        return UpdateUserScreenBody(user: user, id: id);
      },
    );
  }
}

class UpdateUserScreenBody extends StatefulWidget {
  final String id;
  final User user;

  const UpdateUserScreenBody({super.key, required this.id, required this.user});

  @override
  State<UpdateUserScreenBody> createState() => _UpdateUserScreenBodyState();
}

class _UpdateUserScreenBodyState extends State<UpdateUserScreenBody> {
  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameCtrl.text = widget.user.name ?? '';
    emailCtrl.text = widget.user.email ?? '';
    mobileCtrl.text = widget.user.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit A User')),
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
          await userBloc.updateOneUser(id: widget.id, body: body);

          SuccessScreen.open(
            context,
            onProcess: () => MainScreen.open(context),
            title: 'User Updated Successfully',
            description: '',
          );
        },
        child: const Text('Submit'),
      ),
    );
  }
}
