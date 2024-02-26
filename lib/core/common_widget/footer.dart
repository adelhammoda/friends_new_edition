import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  final String facebookUrl;
  final String instagramUrl;
  final String emailUrl;
  final String facebookUrlNatively;
  final String instagramUrlNatively;
  final String emailUrlNatively;

  const Footer(
      {Key? key,
      required this.facebookUrl,
      required this.instagramUrl,
      required this.emailUrl,
      required this.facebookUrlNatively,
      required this.instagramUrlNatively,
      required this.emailUrlNatively})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildLinkImageButton(AssetsManager.facebook, facebookUrlNatively,facebookUrl),
        buildLinkImageButton(AssetsManager.instagram, instagramUrlNatively,instagramUrl),
        buildLinkImageButton(AssetsManager.email, emailUrlNatively,emailUrl),
      ],
    );
  }

  Widget buildLinkImageButton(String asset, String urlNatively, String url) {
    return InkWell(
      onTap: () async {
        bool canLaunch = await canLaunchUrl(Uri.parse(url));

        try {
          // if (canLaunch) {
          //   await launchUrl(Uri.parse(urlNatively),
          //       mode: LaunchMode.platformDefault);
          // } else {
            await launchUrl(Uri.parse(url));
            debugPrint('can not launch this url');
          // }
        } on Exception catch (e) {
          //TODO:display error message.
          debugPrint(e.toString());
        }
      },
      splashColor: null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            SvgPicture.asset(asset, color: ColorManager.black.withOpacity(0.4)),
      ),
    );
  }
}
