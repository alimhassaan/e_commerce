class ApiPath {
  static String product() => 'products/';
  static String deliveryMethods() => 'deliveryMethods/';
  static String user(String uid) => 'users/$uid';
  static String addToCart(String uid, String addToCardId) =>
      'users/$uid/cart/$addToCardId';
  static String myProductsCart(String uid) => 'users/$uid/cart/';
  static String userShippingAddress(String uid) =>
      'users/$uid/shippingAddresses/';
  static String newAddress(String uid,String addressId) =>
      'users/$uid/shippingAddresses/$addressId';
}
