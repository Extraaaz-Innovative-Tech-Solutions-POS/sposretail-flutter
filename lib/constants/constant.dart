// ignore_for_file: non_constant_identifier_names

import 'package:spos_retail/views/widgets/export.dart';

//update the quantity from bills
var updateQuantity = "update-quantity";

var roundedShape = const RoundedRectangleBorder(
  side: BorderSide(color: Colors.white, width: 1.0),
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(44),
    topRight: Radius.circular(44),
  ),
);

highlightBorderDecor(context, {color}) {
  return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(06)),
      border:
          Border.all(color: Theme.of(context).highlightColor.withOpacity(0.7)));
}

gradient(List<Color> colors) {
  return LinearGradient(
    colors: colors,
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.bottomEnd,
  );
}

var bgImageDecor = BoxDecoration(
  image: DecorationImage(
    fit: BoxFit.cover,
    image: AssetImage(Images.bg),
  ),
);

customCardDecor(context) {
  return BoxDecoration(
    color: Theme.of(context).focusColor,
    border: Border.all(
      color: Theme.of(context)
          .highlightColor, // Set your desired border color here.
      width: 1.0, // Set the width of the border.
    ),
  );
}

customText(title, {color, font, weight, alignment, spacing}) {
  return Text(
    title.toString(),
    textAlign: alignment,
    maxLines: 2,
    style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: color,
        fontSize: font,
        fontWeight: weight,
        letterSpacing: spacing),
  );
}

cardBorder(context) {
  return BoxDecoration(
    color: Theme.of(context).focusColor,
    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    border: Border.all(color: Theme.of(context).highlightColor),
  );
}

snackBar(title, msg) {
  return Get.snackbar(
    title,
    msg,
    colorText: Colors.black,
    backgroundColor: Color.fromARGB(255, 14, 93, 154),
  );
}

snackBarBottom(title, msg, context) {
  return Get.snackbar(title, msg,
      colorText: Theme.of(context).highlightColor,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      snackPosition: SnackPosition.BOTTOM);
}

String getFloorNumber({required int number, bool short = false}) {
  if (!(number >= 0 && number <= 100)) {
    throw Exception('Invalid number');
  }

  if (number >= 11 && number <= 13) {
    return short == true ? '$number' : '${number}th';
  }

  switch (number % 10) {
    case 0:
      return short == true ? 'G' : 'Ground';
    case 1:
      return short == true ? '1' : '${number}st';
    case 2:
      return short == true ? '2' : '${number}nd';
    case 3:
      return short == true ? '3' : '${number}rd';
    default:
      return short == true ? '$number' : '${number}th';
  }
}

void openURL(String url) async {
  try {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}
