import 'package:flutter/material.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:responsive_s/responsive_s.dart';

class QrScanText extends StatelessWidget {
  const QrScanText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Padding(
      padding: EdgeInsets.only(
        top: responsive.responsiveHeight(forUnInitialDevices: 5),
      ),
      child: SizedBox(
        width: responsive.responsiveWidth(forUnInitialDevices: 92),
        child: Text(StringManager.placeYourDeviceOnQrCode,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center),
      ),
    );
  }
}
