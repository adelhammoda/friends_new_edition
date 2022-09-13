



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_s/responsive_s.dart';

import '../../../../core/common_widget/another_login_option.dart';
import '../../../../core/common_widget/loader.dart';
import '../../../../core/common_widget/snackbar_widget.dart';
import '../manager/login_bloc.dart';

Widget buildLoginOptionButton({
  required Responsive responsive,
  required void Function() onTap,
  required String image,
  required String content,
  required String loadingStatus,
  required LoginEvent event,

}){
  return  Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if(state is ErrorState){
          print(state.failure.message);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
                MessageSnackBar(context,
              responsive: responsive,errorMessage: state.failure.message,success: false,));
          });

        }
        final loginOption =AnotherLoginOption(
          onTap:(){
            BlocProvider.of<LoginBloc>(context)
                      .add(event);
          },
          image: image,
          content: content,
        );
        switch(state.runtimeType){

          case LoadingState:
            {
              if((state as LoadingState).loadingIn==loadingStatus){
                return const Loader();
              }else{
                return loginOption;
              }
            }
          case ErrorState:
            {
              return loginOption;
            }
          case LoginInitial:case LoadedState:default:
          return loginOption;
        }

      },
    ),
  );
}