import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/presentation/view_model/layout/layout_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutBloc, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          body: BlocProvider.of<LayoutBloc>(context)
              .screens[BlocProvider.of<LayoutBloc>(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 30.0.w,
            currentIndex: BlocProvider.of<LayoutBloc>(context).currentIndex,
            onTap: ($Index) => BlocProvider.of<LayoutBloc>(context)
                .add(NavigatorScreenEvent(index: $Index)),
            items: [
              BottomNavigationBarItem(
                icon: BlocProvider.of<LayoutBloc>(context).currentIndex == 0
                    ? const Icon(Icons.home)
                    : const Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: BlocProvider.of<LayoutBloc>(context).currentIndex == 1
                      ? const Icon(Icons.shopping_cart)
                      : const Icon(Icons.shopping_cart_outlined),
                  label: "Shop"),
              BottomNavigationBarItem(
                  icon: BlocProvider.of<LayoutBloc>(context).currentIndex == 2
                      ? const Icon(Icons.shopping_bag)
                      : const Icon(Icons.shopping_bag_outlined),
                  label: "Bag"),
              BottomNavigationBarItem(
                  icon: BlocProvider.of<LayoutBloc>(context).currentIndex == 3
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border_outlined),
                  label: "Favorite"),
              BottomNavigationBarItem(
                  icon: BlocProvider.of<LayoutBloc>(context).currentIndex == 4
                      ? const Icon(Icons.person)
                      : const Icon(Icons.person_outline),
                  label: "Profile"),
            ],
          ),
        );
      },
    );
  }
}
