import 'package:online_shopping/data/network/services/crud_data/crud_services.dart';
import 'package:online_shopping/model/card_model.dart';

import '../../model/order_model.dart';
import '../../model/shipping_address_model.dart';

abstract interface class PaymentRepository {
  Future<void> addPaymentMethod(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName,
      required CardModel cardModel});

  Future<List<CardModel>> getPaymentMethod({
    required String firebaseUserId,
    required String collectionName,
    required String subCollectionName,
  });

  Future<void> addShippingAddress(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName,
      required ShippingAddressModel shippingAddressModel});

  Future<List<ShippingAddressModel>> getShippingAddress({
    required String firebaseUserId,
    required String collectionName,
    required String subCollectionName,
  });

  Future<void> addOrder(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName,
      required OrderModel orderModel});

  Future<List<OrderModel>> getOrders({
    required String firebaseUserId,
    required String collectionName,
    required String subCollectionName,
  });
}

final class PaymentRepositoryImplemntation implements PaymentRepository {
  final CrudServices crudServices;
  PaymentRepositoryImplemntation({required this.crudServices});
  @override
  Future<void> addPaymentMethod(
          {required String firebaseUserId,
          required String collectionName,
          required String subCollectionName,
          required CardModel cardModel}) async =>
      await crudServices.addPaymentMethod(
          firebaseUserId: firebaseUserId,
          collectionName: collectionName,
          subCollectionName: subCollectionName,
          cardModel: cardModel);

  @override
  Future<List<CardModel>> getPaymentMethod(
          {required String firebaseUserId,
          required String collectionName,
          required String subCollectionName}) async =>
      await crudServices.getPaymentMethod(
          firebaseUserId: firebaseUserId,
          collectionName: collectionName,
          subCollectionName: subCollectionName);

  @override
  Future<void> addShippingAddress(
          {required String firebaseUserId,
          required String collectionName,
          required String subCollectionName,
          required ShippingAddressModel shippingAddressModel}) async =>
      await crudServices.addShippingAddress(
          firebaseUserId: firebaseUserId,
          collectionName: collectionName,
          subCollectionName: subCollectionName,
          shippingAddressModel: shippingAddressModel);

  @override
  Future<List<ShippingAddressModel>> getShippingAddress(
          {required String firebaseUserId,
          required String collectionName,
          required String subCollectionName}) async =>
      await crudServices.getShippingAddress(
        firebaseUserId: firebaseUserId,
        collectionName: collectionName,
        subCollectionName: subCollectionName,
      );

  @override
  Future<void> addOrder(
          {required String firebaseUserId,
          required String collectionName,
          required String subCollectionName,
          required OrderModel orderModel}) async =>
      await crudServices.addOrder(
          firebaseUserId: firebaseUserId,
          collectionName: collectionName,
          subCollectionName: subCollectionName,
          orderModel: orderModel);

  @override
  Future<List<OrderModel>> getOrders(
          {required String firebaseUserId,
          required String collectionName,
          required String subCollectionName}) async =>
      await crudServices.getOrders(
        firebaseUserId: firebaseUserId,
        collectionName: collectionName,
        subCollectionName: subCollectionName,
      );
}
