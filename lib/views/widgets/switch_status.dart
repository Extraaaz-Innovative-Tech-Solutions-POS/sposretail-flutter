import 'package:spos_retail/controllers/settings_controller.dart';
import 'package:spos_retail/views/widgets/export.dart';

class KOTstatus extends StatefulWidget {
  const KOTstatus({super.key});

  @override
  State<KOTstatus> createState() => _KOTstatusState();
}

class _KOTstatusState extends State<KOTstatus> {
  var switchclick, kotSwitchClick;
  var statusclick, kotStatusClick;

  final themeController = Get.put(ThemeController());
  final settingController = Get.put(SettingsController());

  @override
  void initState() {
    super.initState();
    _statusbool(); //* For checking the customer details getprefrence
    _checkBool(); //* For checking the customer and KOT bools value
    _kotcheckBool();
    _kotstatusbool(); //* For checking the status of the KOT bool value
  }

//* KOT and CustomerDetailsBool placed here------------------>
  Future<void> _checkBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        "CustomerDetailsBool", switchclick ?? false); // Save switch state
    setState(() {});
  }

  Future<void> _kotcheckBool() async {
    //switchclick ??= false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("KOTBoolStatus", kotSwitchClick); // Save switch state
    setState(() {});
  }

  //* Customer details Status Bool--------------(Get Sharedprefrence Called here)----------->
  Future<void> _statusbool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    statusclick = prefs.getBool("CustomerDetailsBool");

    if (statusclick != null) {
      switchclick = statusclick;
      setState(() {});
    }
  }

  //* Kot Status Bool--------------(Get Sharedprefrence Called here)----------->
  Future<void> _kotstatusbool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    kotStatusClick = prefs.getBool("KOTBoolStatus");

    if (kotStatusClick != null) {
      kotSwitchClick = kotStatusClick;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(children: [
          // switchButton("KOT", kotSwitchClick == null ? false : kotSwitchClick,
          //     onChange: (value) {
          //   _kotcheckBool();
          //   _kotstatusbool();
          //   setState(() {
          //     kotSwitchClick = value;
          //   });
          // }),

          
          switchButton("Client Info", switchclick ?? false,
              onChange: (value) {
            _checkBool();
            _statusbool();
            setState(() {
              switchclick = value;
            });
          }),

          switchButton("Whatsapp Billing", settingController.whatsappBilling.value ,
              onChange: (value) {
            setState(() {
              settingController.whatsappBilling.value = value;
            });
          }),

          switchButton("Print Preview", settingController.printPreview.value ,
              onChange: (value) {
            setState(() {
              settingController.printPreview.value = value;
            });
          }),


          
          
          switchButton("Light Theme", themeController.lightTheme,
              onChange: (value) {
            setState(() {
              themeController.toggleTheme(value);
            });
          }),
        ]));
  }

  Widget switchButton(title, value, {onChange}) {
    return SwitchListTile(
        activeColor: Theme.of(context).primaryColor,
        value: value,
        onChanged: onChange,
        title: switchTitle(title));
  }

  Widget switchTitle(title) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: customText(title,
              color: Colors.black, weight: FontWeight.bold, font: 15.0),
        )
      ],
    );
  }
}
