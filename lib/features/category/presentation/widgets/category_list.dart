import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/category/domain/category_model.dart';
import 'package:traveltales/features/category/presentation/controller/category_controller.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(CategoryNotifierProvider);
    final categoryList = ref.read(CategoryNotifierProvider.notifier).categories;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Color(0xffD9D9D9),
            child: customCategoryBar(context,
                categoryOption: categoryList[index],
                isSelected: selectedCategory.id == categoryList[index].id),
          );
        });
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
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Text(
              categoryOption.name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onSecondary
                      : Colors.grey),
            )),
      );
    });
  }
}
