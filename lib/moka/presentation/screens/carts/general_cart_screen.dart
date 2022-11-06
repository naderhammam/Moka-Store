import 'package:flutter/material.dart';
import 'package:moka_store/core/utils/strings_manager.dart';

import 'carts_screen.dart';

class GeneralCartScreen extends StatelessWidget {
  const GeneralCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        AppStrings.cart,
      )),
      body: const CartsScreen(),
    );
  }
}
