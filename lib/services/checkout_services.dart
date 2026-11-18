import 'package:e_commerce/models/payment_method.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utilities/api_path.dart';

abstract class CheckoutServices {
  Future<void> setPaymentMethod(PaymentMethod paymentMethod);
  Future<void> deletePaymentMethod(PaymentMethod paymentMethod);
  Future<List<PaymentMethod>> getPaymentMethods();
  Future<void> selectPaymentMethod(PaymentMethod paymentMethod);
}

class CheckoutServicesImpl implements CheckoutServices {
  final _firestoreServices = FirestoreServices.instance;
  final authServices = Auth();

  @override
  Future<void> setPaymentMethod(PaymentMethod paymentMethod) async {
    final uid = authServices.currentUser!.uid;
    if (paymentMethod.isPreferred) {
      final cards = await getPaymentMethods();
      await _savePreferredPaymentMethod(paymentMethod, cards, uid);
      return;
    }
    await _firestoreServices.setData(
      path: ApiPath.addCard(uid, paymentMethod.id),
      data: paymentMethod.toMap(),
    );
  }

  @override
  Future<void> deletePaymentMethod(PaymentMethod paymentMethod) async {
    final uid = authServices.currentUser!.uid;
    await _firestoreServices.deleteData(
      path: ApiPath.addCard(uid, paymentMethod.id),
    );
  }

  @override
  Future<List<PaymentMethod>> getPaymentMethods() async {
    final uid = authServices.currentUser!.uid;
    return await _firestoreServices.getCollection(
      path: ApiPath.cards(uid),
      builder: ((data, documentId) => PaymentMethod.fromMap(data!)),
    );
  }

  @override
  Future<void> selectPaymentMethod(PaymentMethod paymentMethod) async {
    final uid = authServices.currentUser!.uid;
    final cards = await getPaymentMethods();
    final selectedCard = cards.where((card) => card.id == paymentMethod.id);
    if (selectedCard.isEmpty) {
      throw StateError('The selected payment card no longer exists.');
    }
    final card = selectedCard.first;
    await _savePreferredPaymentMethod(
      PaymentMethod(
        id: card.id,
        name: card.name,
        cardNumber: card.cardNumber,
        expiryDate: card.expiryDate,
        cvv: card.cvv,
        isPreferred: true,
      ),
      cards,
      uid,
    );
  }

  Future<void> _savePreferredPaymentMethod(
    PaymentMethod paymentMethod,
    List<PaymentMethod> cards,
    String uid,
  ) async {
    final dataByPath = <String, Map<String, dynamic>>{};
    for (final card in cards) {
      final updatedCard = card.id == paymentMethod.id
          ? paymentMethod
          : PaymentMethod(
              id: card.id,
              name: card.name,
              cardNumber: card.cardNumber,
              expiryDate: card.expiryDate,
              cvv: card.cvv,
            );
      dataByPath[ApiPath.addCard(uid, updatedCard.id)] = updatedCard.toMap();
    }

    dataByPath[ApiPath.addCard(uid, paymentMethod.id)] = paymentMethod.toMap();
    await _firestoreServices.setDataBatch(dataByPath: dataByPath);
  }
}
