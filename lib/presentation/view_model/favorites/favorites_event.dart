part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

final class FetchFavoritesProductEvent extends FavoritesEvent {
  const FetchFavoritesProductEvent();
}
