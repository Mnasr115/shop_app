import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/models/favorites_model/favorites_model.dart';
import 'package:shop_app/modules/search/cubit/search_cubit.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Search'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      textEditingController: searchController,
                      type: TextInputType.text,
                      label: 'Search',
                      prefix: Icons.search,
                      validate: (value) {
                        if (value.isEmpyt) {
                          return 'Enter a text to search';
                        }
                      },
                      onFieldSubmitted: (String text) {
                        SearchCubit.get(context).searchProduct(text);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is LoadingSearchState)
                      const LinearProgressIndicator(),
                    if (state is! SuccessSearchState)
                      const SizedBox(height: 10,),



                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
