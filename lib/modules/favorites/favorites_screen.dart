import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/constant.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            CachedNetworkImage(
              imageUrl: 'model.image!',
              width: 100,
              height: 100,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(height: 1.0),
              ),
              Row(
                children: [
                  Text(
                   '{model.price?.round()}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: kPrimaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                 /* if (model.discount != 0)
                    Text(
                      '${model.oldPrice?.round()}' '\$',
                      style: const TextStyle(
                        fontSize: 10,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),*/
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      //ShopCubit.get(context).changeFavorites(model.id!);
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      //backgroundColor: ShopCubit.get(context).favorites[model.id!]! ? kPrimaryColor : Colors.grey,
                      child: const Icon(
                        Icons.favorite_outline,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
