import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/utilities/app_routes.dart';
import 'package:e_commerce/utilities/args_model/add_shipping_address_args.dart';
import 'package:e_commerce/views/pages/auth/landing_page.dart';
import 'package:e_commerce/views/pages/bottom_navbar.dart';
import 'package:e_commerce/views/pages/auth/login_page.dart';
import 'package:e_commerce/views/pages/auth/signup_page.dart';
import 'package:e_commerce/views/pages/checkout/add_shipping_address_page.dart';
import 'package:e_commerce/views/pages/checkout/checkout_page.dart';
import 'package:e_commerce/views/pages/checkout/shipping_address_page.dart';
import 'package:e_commerce/views/pages/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.signupPageRoute:
      return CupertinoPageRoute(builder: (_) => const SignupPage());
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(builder: (_) => const LoginPage());
    case AppRoutes.bottomNavBar:
      final database = settings.arguments as Database;
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: const BottomNavbar(),
        ),
      );
    case AppRoutes.landingPageRoute:
      return CupertinoPageRoute(builder: (_) => const LandingPage());
    case AppRoutes.addShippingAddressRoute:
      final args = settings.arguments as AddShippingAddressArgs;
      final database = args.database;
      final shippingAddress = args.shippingAddress;
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: AddShippingAddressPage(shippingAddress: shippingAddress),
        ),
      );
    case AppRoutes.shippingAddressRoute:
      final database = settings.arguments as Database;
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: const ShippingAddressPage(),
        ),
      );
    case AppRoutes.checkoutPageRoute:
      final database = settings.arguments as Database;
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: const CheckoutPage(),
        ),
      );
    case AppRoutes.productDetailsRoute:
      return CupertinoPageRoute(
        builder: (_) {
          final args = settings.arguments as Map<String, dynamic>;
          final product = args['product'] as Product;
          final database = args['database'] as Database;
          return Provider.value(
            value: database,
            child: ProductDetails(product: product),
          );
        },
      );

    default:
      return null;
  }
}
