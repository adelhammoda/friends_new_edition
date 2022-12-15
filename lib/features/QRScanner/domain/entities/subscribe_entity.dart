class SubscribeEntity {
  final String id, userId, subscriptionTypeId;
  final DateTime date;
  String? centerId;

  SubscribeEntity(
      {required this.id,
      required this.userId,
      required this.subscriptionTypeId,
      required this.date,
      required this.centerId});
}
