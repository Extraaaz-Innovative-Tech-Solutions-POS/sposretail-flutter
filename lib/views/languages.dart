import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spos_retail/controllers/languages_controller.dart';


class Languages extends StatelessWidget {
  const Languages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LanguagesController languagesController = Get.put(LanguagesController());

    return Scaffold(
      appBar: AppBar(title: const Text("Languages")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  GetBuilder<LanguagesController>(
          builder: (contextt) {
            return ListView.builder(
              itemCount: languagesController.languages.length,
              itemBuilder: (context, index) {
                final language = languagesController.languages[index];
                final isSelected = languagesController.selectedLocale.value == language['locale'];
            
                return GestureDetector(
                  onTap: () {
                    languagesController.changeLanguage(language['locale']!, language['country']!);
                  },
                  child: Card(
                    color: isSelected ? Theme.of(context).secondaryHeaderColor.withOpacity(50) : Theme.of(context).scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        color: isSelected ? Theme.of(context).secondaryHeaderColor : Theme.of(context).hintColor,
                        width: isSelected ? 2.0 : 1.0,
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(
                        isSelected ? Icons.check_circle : Icons.circle_outlined,
                        color: isSelected ? Theme.of(context).secondaryHeaderColor : Theme.of(context).hintColor,
                      ),
                      title: Text(
                        language['name']!,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Theme.of(context).secondaryHeaderColor : Colors.black,
                        ),
                      ),
                      trailing: isSelected ? Icon(Icons.check, color: Theme.of(context).secondaryHeaderColor) : null,
                    ),
                  ),
                );
              },
            );
          }
        )
      ),
    );
  }
}















// class Languages extends StatelessWidget {
//   const Languages({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final LanguagesController languagesController = Get.put(LanguagesController());

//     return Scaffold(
//       appBar: AppBar(title: Text("Languages")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child:  GetBuilder<LanguagesController>(
//           builder: (contextt) {
//             return ListView(
//               children: [
//                 languagesCard("English", onpress: () {
//                    var locale = Locale('es', 'US');
//                    Get.updateLocale(locale);
//                 }),
//                  languagesCard("Hindi", onpress: () {
//                    var locale = Locale('hi', 'IN');
//                    Get.updateLocale(locale);
//                 }),
//                  languagesCard("Marathi", onpress: () {
//                    var locale = Locale('mr', 'IN');
//                    Get.updateLocale(locale);
//                 }),

//               ],

//             );

//           }
//         )
//       ),
//     );
//   }

//   languagesCard(name,{onpress}) {
//     return GestureDetector(
//                   onTap: onpress,
//                   child: Card(
//                    // color: isSelected ? Colors.blue[50] : Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       side: BorderSide(
//                         // color: isSelected ? Colors.blue : Colors.grey.shade300,
//                         // width: isSelected ? 2.0 : 1.0,
//                       ),
//                     ),
//                     child: ListTile(
//                       leading: Icon(
//                         // isSelected ? Icons.check_circle : 
//                         Icons.circle_outlined,
//                         // color: isSelected ? Colors.blue : Colors.grey,
//                       ),
//                       title: Text(
//                         name,
//                         style: TextStyle(
//                           // fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                           // color: isSelected ? Colors.blue : Colors.black,
//                         ),
//                       ),
//                      // trailing: isSelected ? Icon(Icons.check, color: Colors.blue) : null,
//                     ),
//                   ),
//                 );
//   }




// }