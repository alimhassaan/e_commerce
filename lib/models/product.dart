import 'package:e_commerce/utilities/app_assets.dart';

class Product {
  final String id;
  final String title;
  final String imageUrl;
  final int price;
  final int? discountValue;
  final String category;
  final double? rate;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.discountValue = 0,
    this.category = 'Other',
    this.rate,
  });
}

List<Product> dummyProducts = [
  Product(
    id: '1',
    title: "T-shirt",
    imageUrl: AppAssets.tmpProductImage,
    price: 300,
    category: 'Clothes',
    discountValue: 20,
  ),
  Product(
    id: '1',
    title: "T-shirt",
    imageUrl: AppAssets.tmpProductImage,
    price: 300,
    category: 'Clothes',
  ),
  Product(
    id: '1',
    title: "T-shirt",
    imageUrl: AppAssets.tmpProductImage,
    price: 300,
    category: 'Clothes',
    discountValue: 20,
  ),
  Product(
    id: '1',
    title: "T-shirt",
    imageUrl: AppAssets.tmpProductImage,
    price: 300,
    category: 'Clothes',
    discountValue: 20,
  ),
  Product(
    id: '1',
    title: "T-shirt",
    imageUrl: AppAssets.tmpProductImage,
    price: 300,
    category: 'Clothes',
    discountValue: 20,
  ),
  Product(
    id: '1',
    title: "T-shirt",
    imageUrl: AppAssets.tmpProductImage,
    price: 300,
    category: 'Clothes',
    discountValue: 20,
  ),
  Product(
    id: '1',
    title: "T-shirt",
    imageUrl: AppAssets.tmpProductImage,
    price: 300,
    category: 'Clothes',
    discountValue: 20,
  ),
];
