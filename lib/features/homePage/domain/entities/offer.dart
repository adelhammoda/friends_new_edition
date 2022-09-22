class OfferEntity {
  String id, name, offerOwnerId, description;
  double value, discount;
  List<Map> info;
  DateTime date;
  int totalCapacity;
  List<String> imagesUrl;

  OfferEntity(
      {required this.id,
      required this.name,
      required this.date,
      required this.description,
      required this.discount,
      required this.info,
      required this.offerOwnerId,
      required this.totalCapacity,
      required this.value,
      required this.imagesUrl});
}
