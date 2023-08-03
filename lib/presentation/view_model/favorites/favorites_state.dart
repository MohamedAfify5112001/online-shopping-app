part of 'favorites_bloc.dart';

enum FavoritesStatus {
  initial,
  loading,
  success,
  failure;
}

final class FavoritesState extends Equatable {
  final List<Product> favProducts;
  final FavoritesStatus favProductStatus;
  final String favProductsErrorMessage;
  const FavoritesState({
    this.favProductStatus = FavoritesStatus.initial,
    this.favProducts = const <Product>[],
    this.favProductsErrorMessage = "",
  });

  @override
  List<Object> get props =>
      [favProducts, favProductStatus, favProductsErrorMessage];
  FavoritesState copyWith({
    FavoritesStatus? favProductStatus,
    List<Product>? favProducts,
    String? favProductsErrorMessage,
  }) =>
      FavoritesState(
        favProductStatus: favProductStatus ?? this.favProductStatus,
        favProducts: favProducts ?? this.favProducts,
        favProductsErrorMessage:
            favProductsErrorMessage ?? this.favProductsErrorMessage,
      );
}
