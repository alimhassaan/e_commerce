import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/delivery_method.dart';
import 'package:e_commerce/utilities/app_assets.dart';
import 'package:e_commerce/utilities/context_extension.dart';
import 'package:e_commerce/views/widgets/checkout/checkout_order_details.dart';
import 'package:e_commerce/views/widgets/checkout/delivery_method_item.dart';
import 'package:e_commerce/views/widgets/checkout/payment_component.dart';
import 'package:e_commerce/views/widgets/checkout/shipping_address_component.dart';
import 'package:e_commerce/views/widgets/main_buttom.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping Address',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              ShippingAddressComponent(),
              const Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment Method',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Change',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              PaymentComponent(),
              const Gap(30),
              Text(
                'Delivery Method',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(8),

              StreamBuilder<List<DeliveryMethod>>(
                stream: database.deliveryMethodsStream(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState == ConnectionState.active) {
                    final deliveryMethods = asyncSnapshot.data;
                    if (deliveryMethods.isNullOrEmpty()) {
                      return const Center(
                        child: Text('No delivery methods available!'),
                      );
                    }
                    return SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: deliveryMethods?.length,

                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DeliveryMethodItem(
                            deliveryMethod: deliveryMethods![index],
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator.adaptive());
                },
              ),
              const Gap(32),
              CheckoutOrderDetails(),
              const Gap(90),
              MainButton(
                text: 'Submit Order',
                hasCircularBorder: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
