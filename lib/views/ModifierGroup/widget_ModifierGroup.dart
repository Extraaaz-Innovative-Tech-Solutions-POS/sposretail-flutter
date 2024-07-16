import 'package:spos_retail/views/widgets/export.dart';

Widget basicinfo(context) {
  return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(
      padding: const EdgeInsets.all(8),
      height: 50,
      alignment: Alignment.centerLeft,
      child: customText(
        "Modifiers",
        font: 16.0,
        color: Theme.of(context).highlightColor,
      ),
    ),
    const Padding(padding: EdgeInsets.all(8.0)),
    buildTextFieldWithHeading("Title", context),
    const SizedBox(height: 5),
    buildTextFieldWithHeading("Modifier Group Type", context),
    const SizedBox(height: 5),
    description("Description", context),
    const SizedBox(height: 60),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 100,
            //  alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5.0),
              color: Theme.of(context).primaryColor,
            ),
            child: TextButton(
              child: customText(
                'Save',
                color: Theme.of(context).highlightColor,
              ),
              onPressed: () {
                Get.to(const AllModifierGroupUI());
              },
            ),
          ),
          const SizedBox(width: 20),
          Container(
            height: 40,
            width: 100,
            //  alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5.0),
              // color: Theme.of(context).primaryColor,
            ),
            child: TextButton(
              child: customText(
                'Cancel',
                color: Theme.of(context).highlightColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    ),
  ]));
}

Widget buildTextFieldWithHeading(String heading, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          heading,
          style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
        ),
      ),
      Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 50,
            color: Theme.of(context).focusColor,
            child: TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(color: Theme.of(context).highlightColor),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                  hintText: '$heading...',
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
          )),
    ],
  );
}

Widget description(String heading, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          heading,
          style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 100,
          width: 378,
          decoration: BoxDecoration(
              color: Theme.of(context).focusColor,
              border: Border.all(color: Theme.of(context).highlightColor),
              borderRadius: BorderRadius.circular(5)),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(color: Theme.of(context).highlightColor),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                hintText: 'Enter $heading...',
                hintStyle: const TextStyle(color: Colors.grey)),
          ),
        ),
      ),
    ],
  );
}
