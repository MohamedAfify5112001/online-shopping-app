import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/model/shipping_address_model.dart';

import '../token/constants.dart';
import 'cart.dart';

final class OrderModel extends Equatable {
  final String orderNumber;
  final String date;
  final String trackingNumber;
  final Cart cart;
  final ShippingAddressModel shippingAddress;
  final PaymentCard paymentCard;
  final DeliveryMethods deliveryMethod;
  final PromoCodeModel discountPromoCode;
  final int totalAmount;

  const OrderModel({
    required this.orderNumber,
    required this.date,
    required this.trackingNumber,
    required this.cart,
    required this.shippingAddress,
    required this.paymentCard,
    required this.deliveryMethod,
    required this.discountPromoCode,
    required this.totalAmount,
  });

  factory OrderModel.fromMap($JsonMap json) => OrderModel(
        orderNumber: json['orderNumber'],
        date: json['date'],
        trackingNumber: json['trackingNumber'],
        cart: Cart.fromMap(json['cart']),
        shippingAddress: ShippingAddressModel.fromMap(json['shippingAddress']),
        paymentCard: PaymentCard.fromMap(json['paymentCard']),
        deliveryMethod: DeliveryMethods.fromMap(json['deliveryMethod']),
        discountPromoCode: PromoCodeModel.fromMap(json['discountPromoCode']),
        totalAmount: json['totalAmount'],
      );

  $JsonMap get toMap => {
        'orderNumber': orderNumber,
        'trackingNumber': trackingNumber,
        'date': date,
        'cart': cart.toMap,
        'shippingAddress': shippingAddress.toMap,
        'paymentCard': paymentCard.toMap,
        'deliveryMethod': deliveryMethod.toMap,
        'discountPromoCode': discountPromoCode.toMap,
        'totalAmount': totalAmount,
      };

  @override
  List<Object> get props => [orderNumber, trackingNumber];
}

final class PaymentCard extends Equatable {
  final String cardNumber;
  final bool isMasterOrVisa;

  const PaymentCard({
    required this.cardNumber,
    required this.isMasterOrVisa,
  });

  factory PaymentCard.fromMap($JsonMap json) => PaymentCard(
        cardNumber: json['cardNumber'],
        isMasterOrVisa: json['isMasterOrVisa'],
      );

  $JsonMap get toMap => {
        'cardNumber': cardNumber,
        'isMasterOrVisa': isMasterOrVisa,
      };

  @override
  List<Object> get props => [cardNumber, isMasterOrVisa];
}

final class DeliveryMethods extends Equatable {
  final String image;
  final int salary;
  final String methodDelivery;
  final String date;
  const DeliveryMethods({
    required this.image,
    required this.salary,
    required this.methodDelivery,
    required this.date,
  });

  factory DeliveryMethods.fromMap($JsonMap json) => DeliveryMethods(
        image: json['image'],
        salary: json['salary'],
        methodDelivery: json['methodDelivery'],
        date: json['date'],
      );
  $JsonMap get toMap => {
        'image': image,
        'salary': salary,
        'methodDelivery': methodDelivery,
        'date': date,
      };

  @override
  List<Object> get props => [salary, methodDelivery, date];
}

final class PromoCodeModel extends Equatable {
  final String image;
  final String promoName;
  final String promoDesc;
  final String time;
  final String discountRate;
  final String color;
  final bool isGradient;
  final Color isGradientColor;
  const PromoCodeModel(
      {this.image = '',
      required this.promoName,
      required this.promoDesc,
      required this.time,
      required this.discountRate,
      this.isGradient = false,
      this.isGradientColor = Colors.transparent,
      this.color = ''});
  factory PromoCodeModel.fromMap($JsonMap json) => PromoCodeModel(
        promoDesc: json['promoDesc'],
        discountRate: json['discountRate'],
        promoName: '',
        time: '',
      );
  $JsonMap get toMap => {
        'promoDesc': promoDesc,
        'discountRate': discountRate,
      };
  @override
  List<Object> get props => [image, promoName, promoDesc];
}

typedef $JsonMap = Map<String, dynamic>;
