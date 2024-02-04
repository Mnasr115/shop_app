import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/modules/Auth/login_screen/cubit/login_cubit.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/constant.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<ShopCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Shoppe',
              style: TextStyle(
                color: kPrimaryColor,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 32,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            onTap: (int index) {
              cubit.changeBottemNavi(index);
            },
            currentIndex: cubit.currentIndex,
            items: cubit.items,
          ),
        );
      },
    );
  }
}
