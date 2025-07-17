import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motel/presentation/helpers/glassmorphic_container.dart';
import 'package:motel/presentation/helpers/adaptive_text.dart';

class LinenChangeTile extends StatelessWidget {
  final VoidCallback onTap;
  const LinenChangeTile({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassmorphicContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.refresh_thick,
                color: Colors.white, size: scaleText(context, 40)),
            SizedBox(height: scaleText(context, 12)),
            Text(
              "Замена белья",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: scaleText(context, 16),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}