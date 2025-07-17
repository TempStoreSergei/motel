import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motel/presentation/helpers/glassmorphic_container.dart';
import 'package:motel/presentation/helpers/adaptive_text.dart';

class LaundryTile extends StatelessWidget {
  final VoidCallback onTap;
  const LaundryTile({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassmorphicContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.drop_fill,
                color: Colors.blue.shade300, size: scaleText(context, 40)),
            SizedBox(height: scaleText(context, 12)),
            Text(
              "Стирка",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: scaleText(context, 18),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}