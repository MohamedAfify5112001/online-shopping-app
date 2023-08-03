part of 'layout_bloc.dart';

@immutable
sealed class LayoutState {}

class LayoutInitial extends LayoutState {}

class NavigationState extends LayoutState {}
