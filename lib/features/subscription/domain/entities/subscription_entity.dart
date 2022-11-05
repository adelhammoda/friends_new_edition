import 'package:flutter/widgets.dart';

class SubscriptionEntity {
  final String id;
  String name;
  double price;
  String currency;
  DateTime startDate;
  DateTime endDate;
  String imageUrl;
  Color backGroundColor, borderColor;
  String? description;

  SubscriptionEntity(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.borderColor,
      required this.endDate,
      required this.startDate,
      required this.backGroundColor,
      required this.currency,
      required this.price,
      this.description});
}
