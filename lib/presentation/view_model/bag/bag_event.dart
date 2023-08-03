part of '../../view_model/bag/bag_bloc.dart';

sealed class BagEvent extends Equatable {
  const BagEvent();

  @override
  List<Object> get props => [];
}

final class AddItemInBagEvent extends BagEvent {
  final Product product;
  const AddItemInBagEvent({required this.product});
}

final class AddItemInBagWithQuantityEvent extends BagEvent {
  final Product product;
  const AddItemInBagWithQuantityEvent({required this.product});
}

final class RemoveItemInBagWithQuantityEvent extends BagEvent {
  final Product product;
  const RemoveItemInBagWithQuantityEvent({required this.product});
}

final class FetchBagItemsEvent extends BagEvent {}

final class IncrementBagItemEvent extends BagEvent {
  final int count;
  IncrementBagItemEvent(this.count);
}

final class DeleteItemFromBagList extends BagEvent {
  final Product product;

  const DeleteItemFromBagList(this.product);
}
