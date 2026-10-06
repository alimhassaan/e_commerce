import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/utilities/constans.dart';
import 'package:e_commerce/views/widgets/drop_down_menu.dart';
import 'package:e_commerce/views/widgets/main_buttom.dart';
import 'package:e_commerce/views/widgets/main_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;
  String? selectedSize;
  String? selectedColor;

  Future<void> addToCart() async {
    final database = Provider.of<Database>(context,listen: false);
    try {
      await database.addToCart(
        AddToCartModel(
          id: documentIdFromLocalDatabase(), // You can implement a function to generate a unique ID for the cart item
          title: widget.product.title,
          imgUrl: widget.product.imgUrl,
          price: widget.product.price,
          discountValue: widget.product.discountValue,
          category: widget.product.category,
          quantity: 1, // You can change this to the desired quantity
          size: selectedSize ?? '',
          color: selectedColor ?? '',
          productId: widget.product.id, // Use the product ID as the product ID
        ),
      );
    } catch (e) {
      if(!mounted) {
        return;
      }
      MainDialog.showCustomDialog(context: context, error: e, title: 'Error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withValues(alpha: 0.01),
      appBar: AppBar(
        title: Text(widget.product.title),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.product.imgUrl, width: double.infinity),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropDownMenu(
                        hint: 'Select Size',
                        values: ['S', 'M', 'L', 'XL', 'XXL'],
                        initialValue: selectedSize,
                        onChanged: (value) {
                          setState(() {
                            selectedSize = value ?? '';
                          });
                        },
                      ),
                      const Gap(2),
                      DropDownMenu(
                        hint: 'Select Color',
                        values: ['Red', 'Blue', 'Green', 'Yellow'],
                        initialValue: selectedColor,
                        onChanged: (value) {
                          setState(() {
                            selectedColor = value ?? '';
                          });
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.title,
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '\$${widget.product.price}',
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const Gap(16),

                  Text(
                    'This is a dummy description for this product! I think we will add it in the future! I need to add more lines, so I add these words just to have more than two lines!',
                  ),
                  const Gap(10),
                  MainButton(
                    text: 'Add To Cart',
                    onTap: addToCart,
                    hasCircularBorder: true,
                  ),
                  const Gap(32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
