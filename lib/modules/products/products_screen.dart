import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/models/home_model/HomeModel.dart';
import 'package:shop_app/models/home_model/Products.dart';
import 'package:shop_app/shared/components/constant.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null,
          builder: (context) =>
              productBuilder(ShopCubit.get(context).homeModel!),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productBuilder(HomeModel model) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          CarouselSlider(
            items: model.data?.banners
                ?.map(
                  (e) => CachedNetworkImage(imageUrl:
                  e.image!,
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
                  buildGridViewProductItems(model.data!.products![index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridViewProductItems(Products model) {
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
                IconButton(
                  onPressed: (){},
                  icon: const Icon(
                  Icons.add_shopping_cart_rounded,
                    size: 28,
                ),
                ),
              ],
            ),
            if (model.discount!=0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: Colors.red,
              child: const Text('DISCOUNT',
              style: TextStyle(
                fontSize: 8,
                color: Colors.white
              ),),
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
                 if(model.discount!=0)
                   Text(
                     '${model.oldPrice?.round()}' '\$',
                     style: const TextStyle(
                       fontSize: 10,
                       decoration: TextDecoration.lineThrough,
                     ),
                   ),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_outline,
                        size: 14,
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
