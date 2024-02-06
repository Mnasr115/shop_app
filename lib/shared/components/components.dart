import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/category_model/Data.dart';
import 'package:shop_app/models/category_model/category_Model.dart';
import 'package:shop_app/models/category_model/datum.dart';
import 'package:shop_app/models/home_model/HomeModel.dart';
import 'package:shop_app/models/home_model/Products.dart';
import 'package:shop_app/shared/components/constant.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.textEditingController,
    required this.type,
    required this.label,
    this.onTap,
    this.onChange,
    this.onFieldSubmitted,
    this.validate,
    this.prefix,
    this.suffix,
    this.suffixPressed,
    this.isPassword = false,
  });

  final TextEditingController textEditingController;
  final TextInputType type;
  final String label;
  final void Function()? onTap;
  final void Function(String)? onChange;
  final void Function(String)? onFieldSubmitted;
  final dynamic validate;
  final dynamic prefix;
  final dynamic suffix;
  final dynamic suffixPressed;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onTap: onTap,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)),
        border: const OutlineInputBorder(),
        suffixIcon: GestureDetector(
          onTap: suffixPressed,
          child: Icon(suffix),
        ),
        prefixIcon: Icon(prefix),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING, }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget builderWidget(HomeModel model, CategoryModel categoryModel) {
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
                'Category Section',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              buildCategories(categoryModel),
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
                buildGridViewProductItems(model.data!.products![index]),
          ),
        ),
      ],
    ),
  );
}

Widget buildCategories(CategoryModel categoryModel) {
  return GestureDetector(
    onTap: (){
      print('Done');
    },
    child: SizedBox(
      height: 100,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) =>  CategoryItems(categoryModel.data!.data![index]),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 10,
        ),
        itemCount: categoryModel.data!.data!.length,
      ),
    ),
  );
}

Widget CategoryItems(Datum data) {
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
            child:  Text(
              data.name!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
              ),),
          ),
        ],
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
                onPressed: () {},
                icon: const Icon(
                  Icons.add_shopping_cart_rounded,
                  size: 28,
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