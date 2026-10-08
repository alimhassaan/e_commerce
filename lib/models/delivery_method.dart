class DeliveryMethod {
  final String id;
  final String name;
  final String days;
  final String imgUrl;
  final double price;

  DeliveryMethod({
    required this.id,
    required this.name,
    required this.days,
    required this.imgUrl,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'days': days,
      'imgUrl': imgUrl,
      'price': price,
    };
  }

  factory DeliveryMethod.fromMap(Map<String, dynamic> map, String documentId) {
    return DeliveryMethod(
      id: documentId,
      name: map['name'] ?? '',
      days: map['days'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }
}
