import 'dart:math';

import 'package:intl/intl.dart';

import '../model/order_model.dart';
import 'app_colors.dart';

final List<DeliveryMethods> _methodsDelivery = [
  const DeliveryMethods(
      salary: 15,
      methodDelivery: 'FedEx',
      date: '2-3 days',
      image: 'assets/images/fedex.png'),
  const DeliveryMethods(
      salary: 22,
      methodDelivery: 'USPCom',
      date: '2-4 days',
      image: 'assets/images/usps.png'),
  const DeliveryMethods(
      salary: 20,
      methodDelivery: 'DHL',
      date: '3-4 days',
      image: 'assets/images/dhl.png'),
];

List<DeliveryMethods> get allDeliveryMethods => _methodsDelivery;
List<PromoCodeModel> promoCodes = [
  PromoCodeModel(
      promoName: 'Personal offer',
      promoDesc: 'mypromocode2023',
      time: '6 days remaining',
      isGradient: true,
      isGradientColor: AppColors.errorColor,
      color: '#DB3022',
      discountRate: '10'),
  const PromoCodeModel(
    promoName: 'Summer Sale',
    promoDesc: 'summer2023',
    image: 'assets/images/promo_code_image.png',
    time: '23 days remaining',
    isGradient: false,
    discountRate: '15',
  ),
  const PromoCodeModel(
    promoName: 'Personal offer',
    promoDesc: 'mypromocode2023',
    time: '6 days remaining',
    isGradient: false,
    discountRate: '22',
    color: "#000000",
  ),
];

String _generateRandomString() {
  final random = Random();
  const alphaNumeric = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  String result = '';

  for (int i = 0; i < 2; i++) {
    result += alphaNumeric[random.nextInt(alphaNumeric.length)];
  }

  for (int i = 0; i < 8; i++) {
    result += random.nextInt(10).toString();
  }

  return result;
}

String get orderAndTrackingNumbers => _generateRandomString();

String formatDate(DateTime date) {
  final formatter = DateFormat('MM-dd-yyyy');
  return formatter.format(date);
}

