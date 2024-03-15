import 'package:flutter/material.dart';

import '../../../../model/user.dart';

class SelectUserWidget extends StatelessWidget {
  final User user;
  final Set<String> ids;
  final ValueChanged onChange;

  const SelectUserWidget({
    super.key,
    required this.user,
    required this.onChange,
    required this.ids,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        '${user.name}',
        style: textTheme.bodyLarge!.copyWith(height: 0.5),
      ),
      trailing: Checkbox(value: ids.contains(user.id), onChanged: onChange),
    );
  }
}
