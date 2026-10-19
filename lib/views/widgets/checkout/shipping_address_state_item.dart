import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/shipping_address.dart';
import 'package:e_commerce/utilities/app_routes.dart';
import 'package:e_commerce/utilities/args_model/add_shipping_address_args.dart';
import 'package:e_commerce/utilities/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ShippingAddressStateItem extends StatefulWidget {
  final ShippingAddress shippingAddress;
  const ShippingAddressStateItem({super.key, required this.shippingAddress});

  @override
  State<ShippingAddressStateItem> createState() =>
      _ShippingAddressStateItemState();
}

class _ShippingAddressStateItemState extends State<ShippingAddressStateItem> {
  late bool checkValue;
  @override
  void initState() {
    checkValue = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.shippingAddress.fullName,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () => context.pushNamed(
                    AppRoutes.addShippingAddressRoute,
                    arguments: AddShippingAddressArgs(database: database,shippingAddress: widget.shippingAddress,
                    )
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Text(
              widget.shippingAddress.address,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '${widget.shippingAddress.city}, ${widget.shippingAddress.state}, ${widget.shippingAddress.country}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const Gap(8),
            CheckboxListTile(
              title: const Text('Default shipping address'),

              value: checkValue,
              onChanged: (newValue) {
                setState(() {
                  checkValue = newValue!;
                });
              },
              activeColor: Colors.red,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }
}
