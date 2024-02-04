import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/category/domain/category_model_new.dart';
import 'package:traveltales/features/category/presentation/controller/category_async_list_controller.dart';
import 'package:traveltales/features/category/presentation/controller/category_controller.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryList = ref.watch(categoryListProvider);
    return categoryList.when(
        data: (data) {
          final selectedCategory = ref.watch(CategoryNotifierProvider);
          final categories = [CategoryModel(name: "All"), ...data];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xffD9D9D9),
            ),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    //color: Color(0xffD9D9D9),
                    child: customCategoryBar(
                      context,
                      categoryOption: categories[index],
                      isSelected: selectedCategory!.id == categories[index].id,
                    ),
                  );
                }),
          );
        },
        error: ((error, stackTrace) => Center(
              child: Text(error.toString()),
            )),
        loading: () => Container());
  }

  Consumer customCategoryBar(BuildContext context,
      {required CategoryModel categoryOption, required bool isSelected}) {
    return Consumer(builder: (context, ref, child) {
      return GestureDetector(
        onTap: () {
          ref
              .read(CategoryNotifierProvider.notifier)
              .selectCategory(categoryOption);
        },
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Color(0xffD9D9D9),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Text(
              categoryOption.name!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Colors.grey),
            )),
      );
    });
  }
}
