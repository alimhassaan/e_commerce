import 'package:e_commerce/views/pages/cart_page.dart';
import 'package:e_commerce/views/pages/favorites_page.dart';
import 'package:e_commerce/views/pages/home_page.dart';
import 'package:e_commerce/views/pages/profile_page.dart';
import 'package:e_commerce/views/pages/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final _bottomNavbarController = PersistentTabController();

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const ShopPage(),
      const CartPage(),
      const FavoritesPage(),
      const ProfilePage(),
    ];
  }

  List<ItemConfig> _navBarsItems() {
    return [
      ItemConfig(
        icon: const Icon(Icons.home),
        title: 'Home',
        activeForegroundColor: Colors.red,
      ),
      ItemConfig(
        icon: const Icon(Icons.shopping_bag),
        title: 'Shop',
        activeForegroundColor: Colors.red,
      ),
      ItemConfig(
        icon: const Icon(Icons.shopping_cart),
        title: 'Cart',
        activeForegroundColor: Colors.red,
      ),
      ItemConfig(
        icon: const Icon(Icons.favorite_border),
        title: 'Favorites',
        activeForegroundColor: Colors.red,
      ),
      ItemConfig(
        icon: const Icon(Icons.person_outline),
        title: 'Profile',
        activeForegroundColor: Colors.red,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screens = _buildScreens();
    final items = _navBarsItems();

    return PersistentTabView(
      controller: _bottomNavbarController,
      tabs: List.generate(
        screens.length,
        (index) =>
            PersistentTabConfig(screen: screens[index], item: items[index]),
      ),
      backgroundColor: Colors.white,

      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),

      selectedTabPressConfig: const SelectedTabPressConfig(
        popAction: PopActionType.all,
      ),
      navBarBuilder: (navBarConfig) => Style2BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
      ),
    );
  }
}
