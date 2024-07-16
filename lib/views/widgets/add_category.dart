import 'package:spos_retail/views/widgets/export.dart';

class AddCategory extends StatefulWidget {
  AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  CategoryController categoryController = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    categoryController.fetchCategories();
    deleteButtonClicked = false;
    setState(() {});
  }

  bool deleteButtonClicked = false;
  var deleteindex, category_id;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: 
    Scaffold(
        body: GetBuilder<CategoryController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: headingTitle(context, "Category"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(runSpacing: 15, spacing: 15, children: [
                Container(
                  height: 80,
                  width: screenWidth(context, dividedBy: 3.6),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                    color: Theme.of(context).focusColor,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      deleteButtonClicked
                          ? Get.to(AddCategoryForm(
                              categoryclick: true,
                              category: categoryController
                                  .itemnameUpdatecontroller
                                  .toString(),
                              description: categoryController
                                  .itemDescriptionController
                                  .toString(),
                            ))
                          : Get.to(AddCategoryForm(
                              categoryclick: false,
                              category: "",
                              description: "",
                            ));
                    },
                    child: Icon(
                      deleteButtonClicked ? Icons.update : Icons.add,
                      color: Theme.of(context).primaryColor,
                      size: 50.0,
                    ),
                  ),
                ),
                ...categoryController.menu.asMap().entries.map((category) {
                  final index = category.key;
                  return GestureDetector(
                    onTap: () {
                      deleteButtonClicked = false;
                      deleteindex = -1;
                      print(category.value.categoryId.toString());
                      Get.to(AddItems(
                        itemsInCategory: category.value.items!,
                        categoryID: category.value.categoryId!,
                      ));
                      setState(() {});
                    },
                    onLongPress: () {
                      deleteButtonClicked = true;
                      deleteindex = index;
                      category_id = category.value.categoryId.toString();
                      controller.itemnameUpdatecontroller =
                          category.value.categoryName!.obs;
                      controller.itemId = category.value.categoryId!.obs;
                      // controller.itemDescriptionController =
                      //     category.value.descirption!.obs;

                      setState(() {});
                    },
                    child: Container(
                      height: 80,
                      width: screenWidth(context, dividedBy: 3.6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: deleteindex == index
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).highlightColor,
                        ),
                        color: Theme.of(context).focusColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              category.value.categoryName.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              
                                fontSize: 16,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${category.value.items!.length} Items"
                                  .padRight(10),
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .highlightColor
                                    .withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ]),
            ),
            //Spacer(),
            deleteButtonClicked
                ? SizedBox(
                    width: 200.0,
                    child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).highlightColor,
                        ),
                        onPressed: () {
                          categoryController.deleteCategory(category_id);
                          categoryController.fetchCategories();
                          setState(() {});
                          // categoryController.postCategory(
                          //     nameController.text.toString(),
                          //     priceController.text.toString());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).hoverColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        label: Text(
                          "Delete",
                          style: TextStyle(
                              color: Theme.of(context).highlightColor),
                        )),
                  )
                : SizedBox.shrink()
          ],
        ),
      );
    })),
    onWillPop: () async {
        
        Get.to(BottomNav());
        return false;
      },
    );
  }
}
