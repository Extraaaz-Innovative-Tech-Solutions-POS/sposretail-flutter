import 'package:flutter/material.dart';

Widget _menuCategoriesSelectorWidget(menu) {
  return ListView.builder(
    itemBuilder: (context, index) => Row(
      children: [
        ActionChip(
          disabledColor: Theme.of(context).highlightColor,
          onPressed: () {
            try {
              String categoryId = menu[index].id;
              GlobalObjectKey key = GlobalObjectKey(categoryId);
              BuildContext context = key.currentContext!;
              Scrollable.ensureVisible(
                context,
                curve: Curves.easeInOutCubic,
                duration: const Duration(milliseconds: 400),
                alignment: 0,
              );
            } catch (e) {
              debugPrint("$e");
            }
          },
          color: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 240, 235, 235)),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).highlightColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20)),
          elevation: 2,
          pressElevation: 2,
          label: Text(
            menu[index].id,
            style: const TextStyle(
              color: Color(0xFF717171),
              fontSize: 14,
            ),
          ),
          backgroundColor: const Color(0xFFF5F5F5),
        ),
        const SizedBox(width: 8),
      ],
    ),
    itemCount: menu.length,
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    physics: const ClampingScrollPhysics(),
  );
}
