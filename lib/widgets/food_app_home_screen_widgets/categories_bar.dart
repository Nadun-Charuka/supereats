import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supereats/models/categories_model.dart';
import 'package:supereats/providers/category_provider.dart';
import 'package:supereats/utils/colors.dart';

class CategoriesBarWidget extends ConsumerStatefulWidget {
  const CategoriesBarWidget({super.key});

  @override
  ConsumerState<CategoriesBarWidget> createState() =>
      _CategoriesBarWidgetState();
}

class _CategoriesBarWidgetState extends ConsumerState<CategoriesBarWidget> {
  String? selectedCategory;
  late Future<List<CategoryModel>> futureCategories = fetchCategories();
  List<CategoryModel> categories = [];
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    try {
      final categories = await futureCategories;
      if (categories.isNotEmpty) {
        setState(() {
          this.categories = categories;
          ref.read(selectedCategoryProvider.notifier).state =
              categories.first.name;
        });
      }
    } catch (e) {
      debugPrint("Initialization error $e");
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final respose =
          await Supabase.instance.client.from("category_items").select();

      return (respose as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint("Error in fetching data from category table $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final kheight = MediaQuery.of(context).size.height;
    final kwidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: kheight * 0.065,
      child: FutureBuilder(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            debugPrint("error");
            return SizedBox.shrink();
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  splashColor: Colors.orangeAccent.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    setState(() {
                      ref.read(selectedCategoryProvider.notifier).state =
                          category.name;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color:
                            ref.watch(selectedCategoryProvider) == category.name
                                ? Colors.red
                                : grey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)),
                            height: 30,
                            width: 30,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: category.image,
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.fastfood),
                                )),
                          ),
                          Text(
                            category.name,
                            style: TextStyle(
                              color: ref.watch(selectedCategoryProvider) ==
                                      category.name
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
