import 'package:flutter/material.dart';
import 'package:sat_crm/config/palette.dart';

class CardHome extends StatelessWidget {
  final String label;
  final String imagePath;
  final void Function()? onTap;
  const CardHome(
      {super.key, required this.label, this.onTap, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.black.withOpacity(0.1)),
        child: Column(children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imagePath), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(25.0),
              color: Palette.primaryColor.withOpacity(0.1),
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              label,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ]),
      ),
    );
  }
}
