import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_s/responsive_s.dart';

import '../../../../core/common_widget/another_login_option.dart';
import '../../../../core/common_widget/loader.dart';
import '../../../../core/common_widget/snackbar_widget.dart';
import '../manager/login_bloc.dart';
import '../../../register/presentation/manager/register_bloc.dart' as register;

Widget buildAuthOptionButton<bloc extends Bloc<blocEvent, blocState>, blocState,
    blocEvent>({
  required Responsive responsive,
  required String image,
  required String content,
  required String loadingStatus,
  required blocEvent event,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: BlocBuilder<bloc, blocState>(
      builder: (context, state) {
        if (state is ErrorState ) {
          debugPrint(state.failure.message);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(MessageSnackBar(
              context,
              responsive: responsive,
              errorMessage: state.failure.message,
              success: false,
            ));
          });
          }

        if( state is register.ErrorState){
          debugPrint(state.failure.message);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(MessageSnackBar(
              context,
              responsive: responsive,
              errorMessage: state.failure.message,
              success: false,
            ));
          });
        }


        final loginOption = AnotherLoginOption(
          onTap: () {
            BlocProvider.of<bloc>(context).add(event);
          },
          image: image,
          content: content,
        );
        switch (state.runtimeType) {
          case register.LoadingState:
            {
              if ((state as register.LoadingState).loadingIn == loadingStatus) {
                return const Loader();
              } else {
                return loginOption;
              }
            }
          case LoadingState:
            {
              if ((state as LoadingState).loadingIn == loadingStatus) {
                return const Loader();
              } else {
                return loginOption;
              }
            }
          case ErrorState:
          case register.ErrorState:
            {
              return loginOption;
            }
          case LoginInitial:
          case LoadedState:
          case register.LoadedState:
          case register.RegisterInitial:
          default:
            return loginOption;
        }
      },
    ),
  );
}
