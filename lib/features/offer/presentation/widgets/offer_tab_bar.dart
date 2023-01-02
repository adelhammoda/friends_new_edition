import 'package:flutter/material.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/string_manager.dart';


class OfferTabBar extends StatelessWidget {
  final int index ;
  final void Function(int index) onTap;
  const OfferTabBar({Key? key,this.index = 0,required this.onTap}): super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
             TextButton(
                 style: TextButton.styleFrom(
                     padding: EdgeInsets.zero
                 ),
                 onPressed: (){
               onTap(0);
             },
                 child:
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               child: Text(StringManager.home(context),style: Theme.of(context).textTheme.titleMedium!.copyWith(
                   color:index==0? ColorManager.black:ColorManager.black.withOpacity(0.4)
               ),),
             )),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero
                ),
                  onPressed: (){
                onTap(1);
              }, child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(StringManager.favorite(context),style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: index==1? ColorManager.black:ColorManager.black.withOpacity(0.4)
                )),
              ))
            ],
          ),
          const Divider(
            thickness: 1.5,
            color: ColorManager.darkGrey,
          ),
        ],
      ),
    );
  }
}
