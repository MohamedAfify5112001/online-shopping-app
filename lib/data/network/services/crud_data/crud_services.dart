import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/model/banner_model.dart';
import 'package:online_shopping/model/card_model.dart';
import 'package:online_shopping/model/order_model.dart';
import 'package:online_shopping/model/product_model.dart';

import '../../../../model/cart.dart';
import '../../../../model/shipping_address_model.dart';

abstract interface class CrudServices {
  Future<List<BannerModel>> getBanner();

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

final class CrudServicesImplementation implements CrudServices {
  @override
  Future<List<BannerModel>> getBanner() async {
    final getBannersDoc =
        await FirebaseFirestore.instance.collection('banners').get();
    List<JsonMap> bannerJsons =
        getBannersDoc.docs.map((data) => data.data()).toList();
    List<BannerModel> banners =
        bannerJsons.map((banner) => BannerModel.fromMap(banner)).toList();
    return banners;
  }

  @override
  Future<List<Product>> getNewProductItems() async {
    final getNewProductDoc =
        await FirebaseFirestore.instance.collection('new-items').get();
    List<JsonMap> newProductJsons =
        getNewProductDoc.docs.map((data) => data.data()).toList();
    List<String> uIds = getNewProductDoc.docs.map((id) => id.id).toList();
    List<JsonMap> newProductJsonsWithUId = [];
    List<Product> newProducts = [];
    for (int i = 0; i < newProductJsons.length; i++) {
      JsonMap jsonNewProduct = newProductJsons[i];
      jsonNewProduct['uId'] = uIds[i];
      newProductJsonsWithUId.add(jsonNewProduct);
    }
    newProducts = newProductJsonsWithUId
        .map((jsonProduct) => Product.fromJson(jsonProduct))
        .toList();
    return newProducts;
  }

  @override
  Future<List<Product>> getShoesProductItems() async {
    final getShoesProductDoc =
        await FirebaseFirestore.instance.collection('shoes').get();
    List<JsonMap> shoesProductJsons =
        getShoesProductDoc.docs.map((data) => data.data()).toList();
    List<String> uIds = getShoesProductDoc.docs.map((id) => id.id).toList();
    List<JsonMap> shoesProductJsonsWithUId = [];
    List<Product> shoesProducts = [];
    for (int i = 0; i < shoesProductJsons.length; i++) {
      JsonMap jsonNewProduct = shoesProductJsons[i];
      jsonNewProduct['uId'] = uIds[i];
      shoesProductJsonsWithUId.add(jsonNewProduct);
    }
    shoesProducts = shoesProductJsonsWithUId
        .map((jsonProduct) => Product.fromJson(jsonProduct))
        .toList();
    return shoesProducts;
  }

  @override
  Future<List<Product>> getAccessoriesProductItems() async {
    final getAccessoriesProductDoc =
        await FirebaseFirestore.instance.collection('accessories').get();
    List<JsonMap> accessoriesProductJsons =
        getAccessoriesProductDoc.docs.map((data) => data.data()).toList();
    List<String> uIds =
        getAccessoriesProductDoc.docs.map((id) => id.id).toList();
    List<JsonMap> accessoriesProductJsonsWithUId = [];
    List<Product> accessoriesProducts = [];
    for (int i = 0; i < accessoriesProductJsons.length; i++) {
      JsonMap jsonNewProduct = accessoriesProductJsons[i];
      jsonNewProduct['uId'] = uIds[i];
      accessoriesProductJsonsWithUId.add(jsonNewProduct);
    }
    accessoriesProducts = accessoriesProductJsonsWithUId
        .map((jsonProduct) => Product.fromJson(jsonProduct))
        .toList();
    return accessoriesProducts;
  }

  @override
  Future<void> addProductInFav(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName,
      required Product product}) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollectionName)
        .doc(product.name)
        .set(product.toMap);
  }

  @override
  Future<void> deleteProductInFav(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName,
      required Product product}) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollectionName)
        .doc(product.name)
        .delete();
  }

  @override
  Future<List<Product>> getFavoritesItems(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName}) async {
    final getFavJson = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollectionName)
        .get();
    final getAllDocsFav =
        getFavJson.docs.map((favJson) => favJson.data()).toList();

    final List<Product> favProducts =
        getAllDocsFav.map((fav) => Product.fromJson(fav)).toList();
    return favProducts;
  }

  @override
  Future<void> addProductInBag(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName,
      required Product product}) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollectionName)
        .doc(product.name)
        .set(product.toMap);
  }

  @override
  Future<Cart> getBagItems(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName}) async {
    final getBagJson = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollectionName)
        .get();
    final getAllDocsBag =
        getBagJson.docs.map((favJson) => favJson.data()).toList();

    final List<Product> bagProducts =
        getAllDocsBag.map((bag) => Product.fromJson(bag)).toList();
    return Cart(products: bagProducts);
  }

  @override
  Future<void> deleteProductInBag(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName,
      required Product product}) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollectionName)
        .doc(product.name)
        .delete();
  }

  @override
  Future<void> addPaymentMethod(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName,
      required CardModel cardModel}) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollectionName)
        .doc(cardModel.cardNumber)
        .set(cardModel.toMap);
  }

  @override
  Future<List<CardModel>> getPaymentMethod(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName}) async {
    final getPaymentCardMethodsJson = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollectionName)
        .get();
    final getAllDocsPaymentCardMethods = getPaymentCardMethodsJson.docs
        .map((cardJson) => cardJson.data())
        .toList();

    final List<CardModel> cards = getAllDocsPaymentCardMethods
        .map((card) => CardModel.fromMap(card))
        .toList();
    return cards;
  }

  @override
  Future<void> addShippingAddress(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName,
      required ShippingAddressModel shippingAddressModel}) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollectionName)
        .add(shippingAddressModel.toMap);
  }

  @override
  Future<List<ShippingAddressModel>> getShippingAddress(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName}) async {
    final getShippingAddressDoc = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollectionName)
        .get();
    List<JsonMap> shippingAddressJsons =
        getShippingAddressDoc.docs.map((data) => data.data()).toList();
    List<String> uIds = getShippingAddressDoc.docs.map((id) => id.id).toList();
    List<JsonMap> shippingAddressJsonsWithUId = [];
    List<ShippingAddressModel> shippingAddress = [];
    for (int i = 0; i < shippingAddressJsons.length; i++) {
      JsonMap jsonNewProduct = shippingAddressJsons[i];
      jsonNewProduct['uId'] = uIds[i];
      shippingAddressJsonsWithUId.add(jsonNewProduct);
    }
    shippingAddress = shippingAddressJsonsWithUId
        .map((jsonProduct) => ShippingAddressModel.fromMap(jsonProduct))
        .toList();
    return shippingAddress;
  }

  @override
  Future<void> addOrder(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName,
      required OrderModel orderModel}) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollectionName)
        .add(orderModel.toMap);
  }

  @override
  Future<List<OrderModel>> getOrders(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollectionName}) async {
    final getOrdersJson = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollectionName)
        .get();
    final getAllDocsOrders =
        getOrdersJson.docs.map((orderJson) => orderJson.data()).toList();

    final List<OrderModel> orders =
        getAllDocsOrders.map((order) => OrderModel.fromMap(order)).toList();
    return orders;
  }
}

typedef JsonMap = Map<String, dynamic>;
