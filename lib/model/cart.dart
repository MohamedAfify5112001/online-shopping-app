import 'package:equatable/equatable.dart';
import 'package:online_shopping/model/product_model.dart';
import 'package:online_shopping/token/extensions.dart';

final class Cart extends Equatable {
  final List<Product> products;
  final List<dynamic>? productQuantityAllProducts;
  const Cart({
    this.products = const <Product>[],
    this.productQuantityAllProducts,
  });

  factory Cart.fromMap($JsonMap json) => Cart(
      products: (json['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
      productQuantityAllProducts: json['productQuantityAllProducts']);
  $JsonMap get toMap => {
        'products': productQuantity(products)
            .keys
            .map((product) => product.toMap)
            .toList(),
        'productQuantityAllProducts': productQuantity(products).values.toList(),
      };
  @override
  List<Object> get props => [products];
}

typedef $JsonMap = Map<String, dynamic>;
