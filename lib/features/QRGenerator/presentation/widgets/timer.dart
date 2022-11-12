

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/features/QRGenerator/presentation/manager/qr_generator_bloc.dart';



class TimerForQr extends StatefulWidget {
  const TimerForQr({Key? key}) : super(key: key);

  @override
  State<TimerForQr> createState() => _TimerForQrState();
}

class _TimerForQrState extends State<TimerForQr> {
  int timeInSecond =0;
  int timeInMinute = 0;
  @override
  initState(){
    super.initState();
    Timer.periodic(const Duration(seconds: 1),(time){
      setState(
          (){
            timeInMinute =time.tick~/60.floor();
            timeInSecond = time.tick%60;
          }
      );
      if(timeInMinute == 2){
        BlocProvider.of<QrGeneratorBloc>(context).add(HideQrEvent());
        time.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text("${timeInMinute.toString().padLeft(2,"0")}:${timeInSecond.toString().padLeft(2,"0")}",
    style: Theme.of(context).textTheme.labelMedium,);
  }
}

