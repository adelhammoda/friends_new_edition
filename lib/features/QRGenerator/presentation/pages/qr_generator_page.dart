import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_widget/loader.dart';
import 'package:friends/core/manager/size_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/QRGenerator/presentation/manager/qr_generator_bloc.dart';
import 'package:friends/features/QRGenerator/presentation/widgets/timer.dart';
import 'package:friends/features/home_page/presentation/manager/homepage_bloc.dart';
import 'package:responsive_s/responsive_s.dart';

class QrGeneratorPage extends StatelessWidget {
  const QrGeneratorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      body: BlocConsumer<QrGeneratorBloc, QrGeneratorState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadedQrGeneratorState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top:
                          responsive.responsiveHeight(forUnInitialDevices: 10)),
                  child: Text(
                    StringManager.pleaseScanHere,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const Icon(
                  Icons.arrow_downward,
                  size: SizeManager.bigIcon,
                ),
                SizedBox(
                  width: responsive.responsiveWidth(forUnInitialDevices: 80),
                  height: responsive.responsiveWidth(forUnInitialDevices: 80),
                  child: state.qrImage,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: responsive.responsiveHeight(forUnInitialDevices: 5)),
                  child: Text(
                    StringManager.itWillDisappearIn2Minutes(context),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: responsive.responsiveHeight(forUnInitialDevices: 1)),
                  child: const TimerForQr(),
                ),
              ],
            );
          } else if (state is LoadingQrGeneratorState) {
            return const Center(
              child: Loader(),
            );
          } else {
            return Center(
              child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<QrGeneratorBloc>(context).add(
                        GenerateQREvent(
                            context: context,
                            bloc: BlocProvider.of<HomepageBloc>(context)));
                  },
                  child:  Text(StringManager.generate(context))),
            );
          }
        },
      ),
    );
  }
}
