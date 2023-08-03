import 'package:online_shopping/data/network/services/crud_data/crud_services.dart';

import '../../model/cart.dart';
import '../../model/product_model.dart';

abstract interface class ProductRepository {
  Future<List<Product>> getNewProductItems();

  Future<List<Product>> getShoesProductItems();

  Future<List<Product>> getAccessoriesProductItems();

  Future<void> addProductInFav(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName,
      required Product product});

  Future<void> deleteProductInFav(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName,
      required Product product});

  Future<List<Product>> getFavoritesItems(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName});

  Future<void> addProductInBag(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName,
      required Product product});

  Future<Cart> getBagItems(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName});

  Future<void> deleteProductInBag(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName,
      required Product product});
}

final class ProductRepositoryImplementation implements ProductRepository {
  final CrudServices crudServices;
  ProductRepositoryImplementation({required this.crudServices});
  @override
  Future<List<Product>> getNewProductItems() async =>
      await crudServices.getNewProductItems();

  @override
  Future<List<Product>> getShoesProductItems() async =>
      await crudServices.getShoesProductItems();

  @override
  Future<List<Product>> getAccessoriesProductItems() async =>
      await crudServices.getAccessoriesProductItems();

  @override
  Future<void> addProductInFav(
          {required String firebaseUserId,
          required String collectionName,
          required String subCollectionName,
          required Product product}) async =>
      await crudServices.addProductInFav(
          firebaseUserId: firebaseUserId,
          collectionName: collectionName,
          subCollectionName: subCollectionName,
          product: product);

  @override
  Future<void> deleteProductInFav(
          {required String firebaseUserId,
          required String collectionName,
          required String subCollectionName,
          required Product product}) async =>
      await crudServices.deleteProductInFav(
          firebaseUserId: firebaseUserId,
          collectionName: collectionName,
          subCollectionName: subCollectionName,
          product: product);

  @override
  Future<List<Product>> getFavoritesItems(
          {required String firebaseUserId,
          required String collectionName,
          required String subCollectionName}) async =>
      await crudServices.getFavoritesItems(
          firebaseUserId: firebaseUserId,
          collectionName: collectionName,
          subCollectionName: subCollectionName);

  @override
  Future<void> addProductInBag(
          {required String firebaseUserId,
          required String collectionName,
          required String subCollectionName,
          required Product product}) async =>
      await crudServices.addProductInBag(
          firebaseUserId: firebaseUserId,
          collectionName: collectionName,
          subCollectionName: subCollectionName,
          product: product);

  @override
  Future<Cart> getBagItems(
          {required String firebaseUserId,
          required String collectionName,
          required String subCollectionName}) async =>
      await crudServices.getBagItems(
          firebaseUserId: firebaseUserId,
          collectionName: collectionName,
          subCollectionName: subCollectionName);

  @override
  Future<void> deleteProductInBag(
          {required String firebaseUserId,
          required String collectionName,
          required String subCollectionName,
          required Product product}) async =>
      await crudServices.deleteProductInBag(
          firebaseUserId: firebaseUserId,
          collectionName: collectionName,
          subCollectionName: subCollectionName,
          product: product);
}
