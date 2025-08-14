import 'package:flutter/material.dart';

class AppBarExample extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final Color appBarBackgroundColor;
  final Color appBarForegroundColor;
  final Color appBarShadowColor;
  final Color appBarIconColor;
  final Color appBarTitleColor;

  final bool? isFavorited;
  final VoidCallback? onFavoritePressed;

  const AppBarExample({
    super.key,
    required this.appBarTitle,
    this.isFavorited,
    this.onFavoritePressed,
    this.appBarBackgroundColor = const Color.fromRGBO(39, 39, 87, 1),
    this.appBarForegroundColor = Colors.white,
    this.appBarShadowColor = const Color.fromRGBO(255, 255, 255, 0.3),
    this.appBarIconColor = Colors.white,
    this.appBarTitleColor = Colors.white,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarBackgroundColor,
      foregroundColor: appBarForegroundColor,
      elevation: 6,
      shadowColor: appBarShadowColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      title: Text(
        appBarTitle,
        style: TextStyle(
          color: appBarTitleColor,
          fontWeight: FontWeight.bold,
          fontSize: 26,
          letterSpacing: 1.2,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: appBarIconColor),
          tooltip: 'Szukaj',
          onPressed: () {},
        ),
        if (isFavorited != null && onFavoritePressed != null)
          IconButton(
            icon: isFavorited!
                ? const Icon(Icons.favorite, color: Colors.red)
                : Icon(Icons.favorite_border, color: appBarIconColor),
            tooltip: 'Ulubione',
            onPressed: onFavoritePressed,
          ),
      ],
    );
  }
}
