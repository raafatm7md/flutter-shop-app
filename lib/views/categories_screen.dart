import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/views/shop/shop_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var categoriesModel = ShopCubit.get(context).categoriesModel;
        return categoriesModel == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
            itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data!.data![index]),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
            itemCount: categoriesModel.data!.data!.length);
      },
    );
  }

  Widget buildCategoryItem(Datum category) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(category.image!),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 20),
            Text(
              category.name!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
