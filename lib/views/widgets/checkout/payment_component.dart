import 'package:e_commerce/controllers/Checkout/checkout_cubit.dart';
import 'package:e_commerce/utilities/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentComponent extends StatelessWidget {
  const PaymentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      buildWhen: (previous, current) =>
          current is FetchingCards ||
          current is CardsFetched ||
          current is CardsFetchingFailed,
      builder: (context, state) {
        if (state is FetchingCards) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (state is CardsFetchingFailed) {
          return Text('Failed to load payment cards: ${state.error}');
        }
        if (state is CardsFetched) {
          for (final paymentMethod in state.paymentMethods) {
            if (paymentMethod.isPreferred) {
              final digits = paymentMethod.cardNumber.replaceAll(
                RegExp(r'\D'),
                '',
              );
              final lastFour = digits.length > 4
                  ? digits.substring(digits.length - 4)
                  : digits;
              return Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.network(
                        AppAssets.masterCard,
                        fit: BoxFit.cover,
                        height: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${paymentMethod.name} **** **** **** $lastFour',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            }
          }
          return const Text('No default payment card selected');
        }
        return const SizedBox.shrink();
      },
    );
  }
}
