import '../widgets/export.dart';

class ExtraaazPosUtlityUI extends StatefulWidget {
  const ExtraaazPosUtlityUI({super.key});

  @override
  State<ExtraaazPosUtlityUI> createState() => _ExtraaazPosUtlityUIState();
}

class _ExtraaazPosUtlityUIState extends State<ExtraaazPosUtlityUI> {
  final printerUtlityController = Get.put(PrinterController());
  final _printernameController = TextEditingController();
  //TextEditingController _kotprinternameController = TextEditingController();
  String? printername;
  // String? kotprintername;
  @override
  void initState() {
    super.initState();
    getSharedPrefrenceLocal();
    inchestype();
  }

  int _selectedValue = 0;
  printerNameLocal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("BillingPrinter", _printernameController.text).whenComplete(
      () {
        snackBarBottom("Sucess", "Printer Name Saved Sucessfully", context);
        getSharedPrefrenceLocal();
      },
    );
    setState(() {});
  }

  inchestype() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("InchesType", _selectedValue == 2 ? 1 : 0);
    setState(() {});
  }

  // kotprinterNameLocal() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref
  //       .setString(
  //           "KOTBillingPrinter",
  //           _kotprinternameController.text.isEmpty
  //               ? _printernameController.text
  //               : _kotprinternameController.text)
  //       .whenComplete(
  //     () {
  //       snackBarBottom("Sucess", "Printer Name Saved Sucessfully", context);
  //       getSharedPrefrenceLocal();
  //     },
  //   );
  //   setState(() {});
  // }

  getSharedPrefrenceLocal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    printername = pref.getString("BillingPrinter");
    //kotprintername = pref.getString("KOTBillingPrinter");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: commonAppBar(context, "Printer Utlity", ""),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                " Bill Printer Name",
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).primaryColor),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  color: Theme.of(context).focusColor,
                  child: TextField(
                    controller: _printernameController,
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
                          borderSide: BorderSide(
                              color: Theme.of(context).highlightColor),
                        ),
                        hintText: 'Enter Your Printer Name',
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                )),
            // const SizedBox(
            //   height: 20.0,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Text(
            //     " KOT Printer Name",
            //     style: TextStyle(
            //         fontSize: 16, color: Theme.of(context).primaryColor),
            //   ),
            // ),
            // Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: Container(
            //       height: 50,
            //       color: Theme.of(context).focusColor,
            //       child: TextField(
            //         controller: _kotprinternameController,
            //         keyboardType: TextInputType.text,
            //         style: TextStyle(color: Theme.of(context).highlightColor),
            //         decoration: InputDecoration(
            //             border: InputBorder.none,
            //             enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(
            //                 color: Theme.of(context).highlightColor,
            //               ),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //               borderSide: BorderSide(
            //                   color: Theme.of(context).highlightColor),
            //             ),
            //             hintText: 'Enter Your Printer Name',
            //             hintStyle: const TextStyle(color: Colors.grey)),
            //       ),
            //     )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 1,
                      activeColor: Theme.of(context).primaryColor,
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                        });
                       
                      },
                    ),
                    customText('2 Inches',
                        color: Theme.of(context).highlightColor)
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      activeColor: Theme.of(context).primaryColor,
                      value: 2,
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                        });
                        
                       
                      },
                    ),
                    customText('3 Inches',
                        color: Theme.of(context).highlightColor)
                  ],
                ),
              ],
            ),

            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_printernameController.text.isNotEmpty) {
                    printerNameLocal();
                    inchestype();
                    // kotprinterNameLocal();
                  }
                  // else if (_printernameController.text.isEmpty) {
                  //   kotprinterNameLocal();
                  // } else if (_kotprinternameController.text.isEmpty) {
                  //   printerNameLocal();
                  // }
                  else {
                    snackBarBottom(
                        "Error", "Please Enter Printer Name", context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side:
                            BorderSide(color: Theme.of(context).primaryColor))),
                child: Text(
                  "Save",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                "Printer Currently Connected".capitalizeFirst!,
                style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: 18.0,
                    letterSpacing: 2.0),
              ),
            ),
            GestureDetector(
              onLongPress: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove('BillingPrinter');

                snackBarBottom("Error", "Printer Remove Sucessfully", context);
                setState(() {});
              },
              child: Container(
                height: 40.0,
                width: double.infinity,
                margin:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).focusColor,
                    border:
                        Border.all(color: Theme.of(context).highlightColor)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                  child: Text(
                    printername ?? "Not Connected",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
            // GestureDetector(
            //   onLongPress: () async {
            //     SharedPreferences pref = await SharedPreferences.getInstance();
            //     pref.remove('KOTBillingPrinter');
            //     snackBarBottom("Error", "Printer Remove Sucessfully", context);
            //     setState(() {});
            //   },
            //   child: Container(
            //     height: 40.0,
            //     width: double.infinity,
            //     margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            //     decoration: BoxDecoration(
            //         color: Theme.of(context).focusColor,
            //         border:
            //             Border.all(color: Theme.of(context).highlightColor)),
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 20.0, top: 10.0),
            //       child: Text(
            //         kotprintername ?? "Not Connected",
            //         style: TextStyle(color: Theme.of(context).primaryColor),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ));
  }
}
