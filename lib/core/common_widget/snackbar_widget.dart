import 'package:flutter/material.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_s/responsive_s.dart';

class MessageSnackBar extends SnackBar {
  final Responsive responsive;
  final String errorMessage;
  final Color borderColor;
  final Color textHeaderColor;
  final String textHeader;
   MessageSnackBar(BuildContext context,
       {Key? key,required this.responsive,
         this.borderColor =ColorManager.error ,
         this.textHeaderColor =ColorManager.error ,
         this.textHeader =ConstantManager.error,
         required this.errorMessage,
          String animationString= AssetsManager.wrongAnimation})
      : super(key: key,
     content: SingleChildScrollView(
       child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           Row(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(right: 8.0),
                     child: SizedBox(
                       width: responsive.responsiveWidth(forUnInitialDevices: 15),
                       child: Lottie.asset(animationString,fit: BoxFit.fill),
                     ),
                   ),
                 ],
               ),
               SizedBox(
                 width: responsive.responsiveWidth(forUnInitialDevices: 50),
                 child:Column(
                   mainAxisSize: MainAxisSize.min,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Text(textHeader,
                       style: Theme.of(context).textTheme.labelLarge?.copyWith(color: textHeaderColor),),
                     Text(errorMessage,
                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
                         color: ColorManager.black
                       ),),
                   ],
                 ) ,
               ),
               const Spacer(),
               IconButton(
                 icon:  Icon(Icons.close,color: ColorManager.black,),
                 onPressed: (){
                   ScaffoldMessenger.of(context).clearSnackBars();
                 },
               )
             ],
           ),
         ],
       ),
     ),
    width:responsive.responsiveWidth(forUnInitialDevices: 90) ,
    backgroundColor: ColorManager.white.withOpacity(0.95),
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(15),
       side: BorderSide(
         color: borderColor,
         width: 2
       )
     ),
     elevation: 10,
     behavior: SnackBarBehavior.floating,
     padding: const EdgeInsets.all(5),
    duration: Duration(milliseconds: errorMessage.length*100)

  );
}
