import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/models/category_model/category_Model.dart';
import 'package:shop_app/models/category_model/datum.dart';
import 'package:shop_app/models/home_model/HomeModel.dart';
import 'package:shop_app/models/home_model/Products.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constant.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavState) {
          if (!state.changeFavoritesModel.status!) {
            showToast(
                text: state.changeFavoritesModel.message!,
                state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoryModel != null,
          builder: (context) => productBuilder(
              ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoryModel!,
              context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget productBuilder(HomeModel model, CategoryModel categoryModel, context) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        CarouselSlider(
          items: model.data?.banners
              ?.map(
                (e) => CachedNetworkImage(
                  imageUrl: e.image!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 250,
            initialPage: 0,
            reverse: false,
            enableInfiniteScroll: true,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(
              seconds: 3,
            ),
            autoPlayAnimationDuration: const Duration(
              seconds: 1,
            ),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  print('Done');
                },
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) =>
                        buildCategoryItems(categoryModel.data!.data![index]),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 10,
                    ),
                    itemCount: categoryModel.data!.data!.length,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'New Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1 / 1.12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            model.data!.products!.length,
            (index) =>
                buildGridViewProducts(model.data!.products![index], context),
          ),
        ),
      ],
    ),
  );
}

Widget buildCategoryItems(Datum data) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      CachedNetworkImage(
        imageUrl: data.image!,
        width: 100,
        height: 100,
      ),
      Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
        ),
        child: Text(
          data.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

Widget buildGridViewProducts(Products model, context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: model.image!,
                width: 100,
                height: 100,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_shopping_cart_rounded,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
          if (model.discount != 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: Colors.red,
              child: const Text(
                'DISCOUNT',
                style: TextStyle(fontSize: 8, color: Colors.white),
              ),
            ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${model.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(height: 1.0),
            ),
            Row(
              children: [
                Text(
                  '${model.price?.round()}' '\$',
                  style: const TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                if (model.discount != 0)
                  Text(
                    '${model.oldPrice?.round()}' '\$',
                    style: const TextStyle(
                      fontSize: 10,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    ShopCubit.get(context).changeFavorites(model.id);
                  },
                  icon: CircleAvatar(
                    radius: 15,
                    backgroundColor:
                        ShopCubit.get(context).favorites[model.id]!
                            ? kPrimaryColor
                            : Colors.grey,
                    child: const Icon(
                      Icons.favorite_outline,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
