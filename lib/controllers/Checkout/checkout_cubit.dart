import 'package:e_commerce/models/payment_method.dart';
import 'package:e_commerce/services/checkout_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final checkoutServices = CheckoutServicesImpl();

  Future<void> addCard(PaymentMethod paymentMethods) async {
    emit(AddingCards());

    try {
      await checkoutServices.setPaymentMethod(paymentMethods);
      emit(CardsAdded());
    } catch (e) {
      emit(CardsAddingFailed(error: e.toString()));
    }
  }

  Future<void> fetchCards() async {
    emit(FetchingCards());

    try {
      final paymentMethods = await checkoutServices.getPaymentMethods();
      emit(CardsFetched(paymentMethods: paymentMethods));
    } catch (e) {
      emit(CardsFetchingFailed(error: e.toString()));
    }
  }

  Future<void> deleteCard(PaymentMethod paymentMethods) async {
    emit(DeletingCards());

    try {
      await checkoutServices.deletePaymentMethod(paymentMethods);
      emit(CardsDeleted());
    } catch (e) {
      emit(CardsDeletingFailed(error: e.toString()));
    }
  }

  Future<bool> selectedPaymentMethod(PaymentMethod paymentMethods) async {
    emit(FetchingCards());
    try {
      await checkoutServices.selectPaymentMethod(paymentMethods);
      final refreshedPaymentMethods = await checkoutServices
          .getPaymentMethods();
      emit(CardsFetched(paymentMethods: refreshedPaymentMethods));
      return true;
    } catch (e) {
      emit(CardsFetchingFailed(error: e.toString()));
      return false;
    }
  }
}
