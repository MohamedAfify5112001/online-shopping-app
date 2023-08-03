part of 'product_bloc.dart';

enum ProductStatus {
  initial,
  loading,
  success,
  failure;
}

final class ProductState extends Equatable {
  final List<Product> newProducts;
  final ProductStatus newProductStatus;
  final String newProductErrorMessage;

  final List<Product> shoesProducts;
  final ProductStatus shoesProductStatus;
  final String shoesErrorMessage;

  final List<Product> accessoriesProducts;
  final ProductStatus accessoriesProductStatus;
  final String accessoriesErrorMessage;

  final ProductStatus addProductInFavStatus;
  final String addProductInFavErrorMessage;

  final ProductStatus deleteProductInFavStatus;
  final String deleteProductInFavErrorMessage;

  const ProductState({
    this.newProductStatus = ProductStatus.initial,
    this.newProducts = const <Product>[],
    this.newProductErrorMessage = "",
    this.shoesProductStatus = ProductStatus.initial,
    this.shoesProducts = const <Product>[],
    this.shoesErrorMessage = "",
    this.accessoriesProductStatus = ProductStatus.initial,
    this.accessoriesProducts = const <Product>[],
    this.accessoriesErrorMessage = "",
    this.addProductInFavStatus = ProductStatus.initial,
    this.addProductInFavErrorMessage = "",
    this.deleteProductInFavStatus = ProductStatus.initial,
    this.deleteProductInFavErrorMessage = "",
  });

  ProductState copyWith({
    ProductStatus? newProductStatus,
    List<Product>? newProducts,
    String? newProductErrorMessage,
    ProductStatus? shoesProductStatus,
    List<Product>? shoesProducts,
    String? shoesErrorMessage,
    ProductStatus? accessoriesProductStatus,
    List<Product>? accessoriesProducts,
    String? accessoriesErrorMessage,
    ProductStatus? addProductInFavStatus,
    String? addProductInFavErrorMessage,
    ProductStatus? deleteProductInFavStatus,
    String? deleteProductInFavErrorMessage,
  }) {
    return ProductState(
      newProductStatus: newProductStatus ?? this.newProductStatus,
      newProducts: newProducts ?? this.newProducts,
      newProductErrorMessage:
          newProductErrorMessage ?? this.newProductErrorMessage,
      shoesProductStatus: shoesProductStatus ?? this.shoesProductStatus,
      shoesProducts: shoesProducts ?? this.shoesProducts,
      shoesErrorMessage: shoesErrorMessage ?? this.shoesErrorMessage,
      accessoriesProductStatus:
          accessoriesProductStatus ?? this.accessoriesProductStatus,
      accessoriesProducts: accessoriesProducts ?? this.accessoriesProducts,
      accessoriesErrorMessage:
          accessoriesErrorMessage ?? this.accessoriesErrorMessage,
      addProductInFavStatus:
          addProductInFavStatus ?? this.addProductInFavStatus,
      addProductInFavErrorMessage:
          addProductInFavErrorMessage ?? this.addProductInFavErrorMessage,
      deleteProductInFavStatus:
          deleteProductInFavStatus ?? this.deleteProductInFavStatus,
      deleteProductInFavErrorMessage:
          deleteProductInFavErrorMessage ?? this.deleteProductInFavErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        newProductStatus,
        newProducts,
        newProductErrorMessage,
        shoesProducts,
        shoesProductStatus,
        shoesErrorMessage,
        accessoriesProductStatus,
        accessoriesProducts,
        accessoriesErrorMessage,
        addProductInFavStatus,
        addProductInFavErrorMessage,
        deleteProductInFavErrorMessage,
        deleteProductInFavStatus
      ];
}
