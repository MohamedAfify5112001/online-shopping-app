import 'package:flutter/material.dart';

import '../model/cart.dart';

extension HexColor on String {
  Color toColor() {
    String hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    // Define a regular expression pattern for email validation
    final regexPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Use the pattern to match the email address
    return regexPattern.hasMatch(this);
  }
}

extension NameValidator on String {
  bool isValidName() {
    return length >= 10;
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    final passwordRegExp =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$');
    return passwordRegExp.hasMatch(this);
  }
}

extension MaskCardNumber on String {
  String get maskCardNumber {
    List<String> numbersSplitting = split(' ');
    final String firstString =
        numbersSplitting[0].replaceAll(numbersSplitting[0], '****');
    final String secondString =
        numbersSplitting[1].replaceAll(numbersSplitting[1], '****');
    final String thirdString =
        numbersSplitting[2].replaceAll(numbersSplitting[2], '****');

    List<String> cardNumberDigits = [
      firstString,
      secondString,
      thirdString,
      numbersSplitting[3]
    ];
    return cardNumberDigits.join(' ');
  }
}

extension CartMethods on Cart {
  double get subtotal =>
      products.fold(0, (total, current) => total + current.discountPrice);

  Map productQuantity(products) {
    Map quantity = {};

    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product]++;
      }
    });

    return quantity;
  }
}
