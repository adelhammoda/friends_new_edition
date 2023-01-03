import 'package:flutter/material.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';
import 'package:responsive_s/responsive_s.dart';

class SubscribeChecker extends StatelessWidget {
  final SubscriptionEntity subscriptionEntity;

  const SubscribeChecker({Key? key, required this.subscriptionEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSubscribed = (subscriptionEntity.endDate.isAfter(DateTime.now()) &&
            subscriptionEntity.startDate.isBefore(DateTime.now())) ||
        subscriptionEntity.endDate.isAtSameMomentAs(DateTime.now());
    final Responsive responsive = Responsive(context);
    return Container(
      width: double.infinity,
      height: responsive.responsiveHeight(forUnInitialDevices: 8),
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
            color: isSubscribed ? ColorManager.lightGreen : ColorManager.red,
            width: 2),
        bottom: BorderSide(
            color: isSubscribed ? ColorManager.lightGreen : ColorManager.red,
            width: 2),
      )),
      child: Center(
        child: Text(
          isSubscribed ? StringManager.subscribed(context) : StringManager.unsubscribed(context),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isSubscribed ? ColorManager.lightGreen : ColorManager.red),
        ),
      ),
    );
  }
}
