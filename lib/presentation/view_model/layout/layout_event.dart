part of 'layout_bloc.dart';

@immutable
sealed class LayoutEvent extends Equatable {
  const LayoutEvent();
}

final class NavigatorScreenEvent extends LayoutEvent {
  final int index;
  const NavigatorScreenEvent({required this.index});

  @override
  List<Object> get props => [index];
}
