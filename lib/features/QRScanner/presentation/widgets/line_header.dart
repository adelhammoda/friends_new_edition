import 'package:flutter/material.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:friends/core/manager/string_manager.dart';

class LineHeader extends StatelessWidget {
  const LineHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Padding(
        padding: EdgeInsets.only(
          left: responsive.responsiveWidth(forUnInitialDevices: 15),
        ),
        child: Row(
          children: <Widget>[
            Text(
              StringManager.ownedPackages(context),
              style: Theme.of(context).textTheme.button,
            ),
            const Icon(Icons.arrow_downward)
          ],
        ));
  }
}
