import 'package:e_commerce/utilities/app_assets.dart';

class Product {
  final String id;
  final String title;
  final String imgUrl;
  final int price;
  final int discountValue;
  final String category;
  final double? rate;

  Product({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.price,
    this.discountValue = 0,
    this.category = 'Other',
    this.rate,
  });

  bool get hasDiscount => discountValue > 0;

  double get discountedPrice => price * (1 - discountValue / 100);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imgUrl': imgUrl,
      'discountValue': discountValue,
      'category': category,
      'rate': rate,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map, String documentId) {
    return Product(
      id: documentId,
      title: map['title'] as String? ?? '',
      price: (map['price'] as num?)?.toInt() ?? 0,
      imgUrl: map['imgUrl'] as String? ?? '',
      discountValue: (map['discountValue'] as num?)?.toInt() ?? 0,
      category: map['category'] as String? ?? 'Other',
      rate: map['rate'] is num ? (map['rate'] as num).toDouble() : null,
    );
  }
}

List<Product> dummyProducts = [
  Product(
    id: '1',
    title: "T-shirt",
    imgUrl: AppAssets.tmpProductImage,
    price: 300,
    category: 'Clothes',
    discountValue: 20,
  ),
  Product(
    id: '2',
    title: "T-shirt",
    imgUrl: AppAssets.tmpProductImage,
    price: 300,
    category: 'Clothes',
  ),
  Product(
    id: '3',
    title: "T-shirt",
    imgUrl: AppAssets.tmpProductImage,
    price: 300,
    category: 'Clothes',
    discountValue: 20,
  ),
  Product(
    id: '4',
    title: "T-shirt",
    imgUrl: AppAssets.tmpProductImage,
    price: 300,
    category: 'Clothes',
    discountValue: 20,
  ),
  Product(
    id: '5',
    title: "T-shirt",
    imgUrl: AppAssets.tmpProductImage,
    price: 300,
    category: 'Clothes',
    discountValue: 20,
  ),
  Product(
    id: '6',
    title: "T-shirt",
    imgUrl: AppAssets.tmpProductImage,
    price: 300,
    category: 'Clothes',
    discountValue: 20,
  ),
  Product(
    id: '7',
    title: "T-shirt",
    imgUrl: AppAssets.tmpProductImage,
    price: 300,
    category: 'Clothes',
    discountValue: 20,
  ),
];
