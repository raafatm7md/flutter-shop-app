import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/views/search/search_cubit.dart';
import 'package:shop_app/views/widgets/build_item.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter text to search";
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        SearchCubit.get(context).search(searchController.text);
                      },
                      decoration: const InputDecoration(
                          label: Text("Search"),
                          prefixIcon: Icon(Icons.search)),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoading) const LinearProgressIndicator(),
                    if (state is SearchSuccess)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildItem(
                                SearchCubit.get(context)
                                    .model!
                                    .data!
                                    .data![index],
                                context, isSearch: true),
                            separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 20),
                                  child: Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: Colors.grey[300],
                                  ),
                                ),
                            itemCount: SearchCubit.get(context)
                                .model!
                                .data!
                                .data!
                                .length),
                      )
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
