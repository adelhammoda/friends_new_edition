import 'package:flutter/material.dart';
import 'package:friends/core/extension/string_extension.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/size_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';
import 'package:intl/intl.dart';
import 'package:responsive_s/responsive_s.dart';

class SubscriptionWidget extends StatefulWidget {
  final SubscriptionEntity subscriptionEntity;
  final String? scannedByValue;
  const SubscriptionWidget({Key? key, required this.subscriptionEntity,this.scannedByValue})
      : super(key: key);

  @override
  State<SubscriptionWidget> createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Padding(padding: EdgeInsets.symmetric(
      vertical: 10,horizontal: responsive.responsiveWidth(forUnInitialDevices: 5),
    ),child: Container(
      width: responsive.responsiveWidth(forUnInitialDevices: 90),
      height: responsive.responsiveHeight(forUnInitialDevices: 25),
      padding: EdgeInsets.only(
          top: responsive.responsiveHeight(forUnInitialDevices: 2.5),
          left: 20,
          right: 15),
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(widget.subscriptionEntity.imageUrl),
              fit: BoxFit.fill,
              opacity: 0.7
          ),
          color: ColorManager.darkGrey,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
                color: widget.subscriptionEntity.borderColor,
                blurStyle: BlurStyle.solid,
                spreadRadius: 0,
                offset: const Offset(0, 11)),
            BoxShadow(
              color: widget.subscriptionEntity.backGroundColor,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              offset: const Offset(0, 10),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.subscriptionEntity.name.capitalizeTheFirstCharacter(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ColorManager.darkGreen,
                ),
              ),
              Text(
                  "${widget.subscriptionEntity.price} ${widget.subscriptionEntity.currency}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: ColorManager.darkGreen,
                      fontSize: SizeManager.titleMedium
                  )),
            ],
          ),
          Padding(padding: const EdgeInsets.only(top: 10),
            child: Text("${StringManager.from}: ${DateFormat.yMMMMd().format(widget.subscriptionEntity.startDate)}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorManager.black,
                    fontSize: SizeManager.dateSize
                )),),
          Padding(padding: const EdgeInsets.only(top: 4),
            child: Text("${StringManager.to}: ${DateFormat.yMMMMd().format(widget.subscriptionEntity.endDate)}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorManager.black,
                    fontSize: SizeManager.dateSize
                )),),
          const Spacer(),
          if(!widget.scannedByValue.isNullOrEmpty())Padding(padding: const EdgeInsets.only(top: 10,bottom: 16),
            child: Text("${StringManager.scannedBy}: ${widget.scannedByValue}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorManager.black,
                    fontSize: SizeManager.dateSize
                )),),
        ],
      ),

    ),);
  }
}
