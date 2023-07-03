import 'package:flutter/material.dart';

import '../config/palette.dart';

simpleDialog({
  BuildContext? context,
  String? title,
  content,
}) {
  return showDialog<String>(
    context: context!,
    builder: (context) => AlertDialog(
      title: Text(title!),
      content: Text(content),
      actions: [
        FilledButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Palette.primaryColor)),
          child: const Text('Fermer'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
