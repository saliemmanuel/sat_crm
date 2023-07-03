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

Future simpleDialogueCardSansTitle(
    {String? msg, BuildContext? context, bool? barrierDismissible = false}) {
  return showDialog(
      context: context!,
      barrierDismissible: barrierDismissible!,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(color: Palette.primaryColor),
              const SizedBox(width: 15.0),
              Text(msg!)
            ],
          ),
        );
      });
}
