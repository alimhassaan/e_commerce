class ApiPath {
  static String product() => 'products/';
  static String user(String uid) => 'users/$uid';
  static String addToCart(String uid,String addToCardId) => 'users/$uid/cart/$addToCardId';
    static String myProductsCart(String uid) =>
      'users/$uid/cart/';

}
