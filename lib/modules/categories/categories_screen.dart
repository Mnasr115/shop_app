import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/models/category_model/datum.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            ShopCubit.get(context).getGategories();
          },
          child: ListView.separated(
            itemBuilder: (context, index) => buildCategoryItem(
                ShopCubit.get(context).categoryModel!.data!.data![index]),
            separatorBuilder: (context, index) => Divider(
              thickness: 0.5,
              height: 2,
              indent: 16,
              color: Colors.grey[400],
            ),
            itemCount: ShopCubit.get(context).categoryModel!.data!.data!.length,
          ),
        );
      },
    );
  }

  Widget buildCategoryItem(Datum data) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: data.image!,
              width: 80,
              height: 80,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              data.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );
}
