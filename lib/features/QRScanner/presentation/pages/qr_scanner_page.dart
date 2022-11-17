import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_widget/friends_button.dart';
import 'package:friends/core/common_widget/loader.dart';
import 'package:friends/core/common_widget/snackbar_widget.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/QRScanner/presentation/manager/camera_manager/camera_bloc.dart';
import 'package:friends/features/QRScanner/presentation/manager/subscription_manager/subscription_bloc.dart';
import 'package:friends/features/QRScanner/presentation/manager/user_details_manager/user_details_bloc.dart';
import 'package:friends/features/home_page/presentation/widgets/qr_scan_text.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:responsive_s/responsive_s.dart';


class QrScannerPage extends StatefulWidget {
  const QrScannerPage({Key? key}) : super(key: key);

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      BlocProvider
          .of<CameraBloc>(context)
          .getController!
          .resumeCamera();
    } else if (Platform.isIOS) {
      BlocProvider
          .of<CameraBloc>(context)
          .getController!
          .resumeCamera();
    }
  }


  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    final qrView= QRView(
      key: _qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderRadius: 30,
        borderColor: ColorManager.lightGreen,
        borderLength: 50,
      ),
      formatsAllowed: const [BarcodeFormat.qrcode],
    );
    return BlocConsumer<CameraBloc, CameraState>(
        listener: (context, state) {
          if (state is CameraErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(MessageSnackBar(
                context, responsive: responsive,
                errorMessage: state.failure.message));
          }
        },
        builder: (context, state) {
          if (state is CameraLoadingState) {
            return const Center(child: Loader(),);
          } else {
            return AnimatedCrossFade(
                firstChild: Column(
                  children: <Widget>[
                    //static text
                    const QrScanText(),
                    SizedBox(
                      height:
                      responsive.responsiveHeight(forUnInitialDevices: 40),
                      width: responsive.responsiveHeight(
                          forUnInitialDevices: 40),
                      child: Lottie.asset(
                        AssetsManager.scanQrAnimation,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: responsive.responsiveHeight(
                              forUnInitialDevices: 10)),
                      child: FriendsButton(
                        width: 30,
                        height: 5,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            StringManager.openCamera,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall,
                          ),
                        ),
                        onPressed: () {
                          if (BlocProvider
                              .of<CameraBloc>(context)
                              .getController != null) {
                            BlocProvider.of<CameraBloc>(context).add(
                                const OpenCameraEvent());
                          }
                        },
                      ),
                    )
                  ],
                ),
                secondChild: SizedBox(
                  height: responsive.responsiveHeight(forUnInitialDevices: 90),
                  child: Stack(
                    children: <Widget>[
                      qrView,
                      Align(
                        alignment: Alignment.topLeft,
                        child: CloseButton(
                          color: ColorManager.darkGreen,
                          onPressed: () {
                            BlocProvider.of<CameraBloc>(context).add(
                                const CloseCameraEvent());
                          },
                        ),
                      )
                    ],
                  ),
                ),
                crossFadeState: state is CameraOpened
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 1000));
          }
        }
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    BlocProvider
        .of<CameraBloc>(context)
        .setController = controller;
    controller.scannedDataStream.listen((scanData) {
      BlocProvider.of<CameraBloc>(context).add(const CloseCameraEvent());
      BlocProvider.of<CameraBloc>(context).add(
          NavigateToUserDetailsEvent(context: context, userId: scanData.code));
      BlocProvider.of<SubscriptionQrScannerBloc>(context).add(
          LoadUserSubscriptionsEvent(userId: scanData.code));
      BlocProvider.of<UserDetailsBloc>(context).add(
          LoadUserDetailsEvent(userId: scanData.code));
    });
  }
}


