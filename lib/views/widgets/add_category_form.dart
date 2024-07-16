import 'export.dart';

class AddCategoryForm extends StatefulWidget {
  bool categoryclick;
  String description;
  String category;
  AddCategoryForm({
    Key? key,
    required this.categoryclick,
    required this.description,
    required this.category,
  }) : super(key: key);

  @override
  State<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  late final nameController;
  late final priceController;

  final CategoryController categoryController = Get.put(CategoryController());
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _descriptionKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: widget.categoryclick ? widget.category : "");
    priceController = TextEditingController(
        text: widget.categoryclick ? widget.description : "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Add Category", ""),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            itemForms(context, "Category Name", "Enter Category", false,
                nameController,
                key: _nameKey),
            itemForms(context, "Description", "Enter Description", false,
                priceController,
                key: _descriptionKey),
            const SizedBox(
              height: 20.0,
            ),
            widget.categoryclick
                ? ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          priceController.text.isNotEmpty) {
                        categoryController.updateCategory(
                            categoryController.itemId.value.toString(),
                            nameController.text.toString(),
                            priceController.text.toString(), context);
                      } else {
                        snackBarBottom("Error", "Please enter the required feild", context);  
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    child: Text(
                      "Update Category",
                      style: TextStyle(color: Theme.of(context).highlightColor),
                    ))
                : ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          priceController.text.isNotEmpty) {
                        categoryController.postCategory(
                            nameController.text.toString(),
                            priceController.text.toString());
                      } else {
                        snackBarBottom("Error", "Enter the required field", context);  
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    child: Text(
                      "Add Category",
                      style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ))
          ],
        ),
      ),
    );
  }
}
