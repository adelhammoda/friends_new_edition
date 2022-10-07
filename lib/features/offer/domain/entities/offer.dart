class OfferEntity {
  String id, name, offerOwnerId;
  String? description;
  double value, discount;
  List<Map>? info;
  DateTime startDate;
  DateTime endDate;
  int? totalCapacity;
  List<String> imagesUrl;

  OfferEntity({
    required this.id,
    required this.name,
    required this.startDate,
    required this.description,
    required this.discount,
    required this.offerOwnerId,
    required this.value,
    required this.imagesUrl,
    required this.endDate,
    this.totalCapacity,
    this.info,
  });
}
