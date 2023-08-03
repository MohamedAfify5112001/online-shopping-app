import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:online_shopping/presentation/views/bag/bag_screen.dart';
import 'package:online_shopping/presentation/views/favorite/favorite_screen.dart';
import 'package:online_shopping/presentation/views/home/home_screen.dart';
import 'package:online_shopping/presentation/views/profile/profile_screen.dart';
import 'package:online_shopping/presentation/views/shop/shop_screen.dart';

part 'layout_event.dart';

part 'layout_state.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  final List<Widget> screens = [
    const HomeScreen(),
    const ShopScreen(),
    const BagScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  int currentIndex = 0;

  LayoutBloc() : super(LayoutInitial()) {
    on<NavigatorScreenEvent>(_onNavigationScreens);
  }

  Future<void> _onNavigationScreens(NavigatorScreenEvent navigatorScreenEvent,
      Emitter<LayoutState> emit) async {
    currentIndex = navigatorScreenEvent.index;
    emit(NavigationState());
  }
}
