import 'package:e_commerce/controllers/Checkout/checkout_cubit.dart';
import 'package:e_commerce/utilities/context_extension.dart';
import 'package:e_commerce/views/widgets/checkout/add_card_bottom_sheet.dart';
import 'package:e_commerce/views/widgets/main_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit()..fetchCards(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Payment Methods',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CheckoutCubit, CheckoutState>(
          buildWhen: (previous, current) =>
              current is FetchingCards ||
              current is CardsFetched ||
              current is CardsFetchingFailed,
          builder: (context, state) {
            if (state is FetchingCards) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is CardsFetchingFailed) {
              return Center(
                child: Text('Failed to fetch cards: ${state.error}'),
              );
            } else if (state is CardsFetched) {
              final checkoutCubit = context.read<CheckoutCubit>();
              final paymentMethods = state.paymentMethods;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Your payment cards',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: paymentMethods.length,
                        itemBuilder: (context, index) {
                          final paymentMethod = paymentMethods[index];
                          return InkWell(
                            onTap: () async {
                              final selected = await checkoutCubit
                                  .selectedPaymentMethod(paymentMethod);
                              if (!context.mounted) return;
                              if (selected) {
                                context.pop(rootNavigator: true);
                              }
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 8.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Tooltip(
                                          message: paymentMethod.isPreferred
                                              ? 'Default card'
                                              : 'Payment card',
                                          child: Icon(
                                            paymentMethod.isPreferred
                                                ? Icons.check_circle
                                                : Icons.credit_card,
                                            color: paymentMethod.isPreferred
                                                ? Colors.green
                                                : null,
                                          ),
                                        ),
                                        const Gap(8),
                                        Text(' ${paymentMethod.name}'),
                                        const Gap(8),
                                        Text(
                                          '**** **** **** ${paymentMethod.cardNumber.substring(paymentMethod.cardNumber.length - 4)}',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () async {
                                            await showModalBottomSheet<void>(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor: Colors.white,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                          top: Radius.circular(
                                                            30,
                                                          ),
                                                        ),
                                                  ),
                                              builder: (context) =>
                                                  BlocProvider.value(
                                                    value: checkoutCubit,
                                                    child: AddCardBottomSheet(
                                                      paymentMethod:
                                                          paymentMethod,
                                                    ),
                                                  ),
                                            );
                                            if (!context.mounted) return;
                                            await checkoutCubit.fetchCards();
                                          },
                                        ),

                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () async {
                                            await checkoutCubit.deleteCard(
                                              paymentMethod,
                                            );
                                            if (!context.mounted) return;
                                            await checkoutCubit.fetchCards();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const Gap(16),
                      Builder(
                        builder: (context) => MainButton(
                          onTap: () async {
                            await showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30),
                                ),
                              ),
                              builder: (context) => BlocProvider.value(
                                value: checkoutCubit,
                                child: const AddCardBottomSheet(),
                              ),
                            );
                            if (!context.mounted) return;
                            await checkoutCubit.fetchCards();
                          },
                          child: const Text('Add New Card'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
