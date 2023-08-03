part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class FetchNewProductEvent extends ProductEvent {
  const FetchNewProductEvent();
}

final class FetchShoesProductEvent extends ProductEvent {
  const FetchShoesProductEvent();
}

final class FetchAccessoriesProductEvent extends ProductEvent {
  const FetchAccessoriesProductEvent();
}

final class AddProductInFavEvent extends ProductEvent {
  final Product product;
  const AddProductInFavEvent(this.product);
}

final class DeleteProductInFavEvent extends ProductEvent {
  final Product product;
  const DeleteProductInFavEvent(this.product);
}
