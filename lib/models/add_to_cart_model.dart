class AddToCartModel {
  final String id;
  final String productId;
  final String title;
  final String imgUrl;
  final int price;
  final int discountValue;
  final String category;
  final int quantity;
  final String size;
  final String color;
  AddToCartModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.imgUrl,
    required this.price,
    this.discountValue = 0,
    required this.category,
    this.quantity = 1,
    required this.size,
    this.color = 'Black',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'imgUrl': imgUrl,
      'price': price,
      'discountValue': discountValue,
      'category': category,
      'quantity': quantity,
      'size': size,
      'color': color,
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map,String documentId) {
    return AddToCartModel(
      id: documentId,
      productId: map['productId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      imgUrl: map['imgUrl'] as String? ?? '',
      price: (map['price'] as num?)?.toInt() ?? 0,
      discountValue: (map['discountValue'] as num?)?.toInt() ?? 0,
      category: map['category'] as String? ?? 'Other',
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      size: map['size'] as String? ?? '',
      color: map['color'] as String? ?? 'Black',
    );
  }

}
