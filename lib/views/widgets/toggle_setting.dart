import 'package:spos_retail/views/widgets/export.dart';

class ToggleSetting extends StatelessWidget {
  ToggleSetting({super.key});

  final themeController = Get.put(ThemeController());
  final settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    Widget switchButton(title, value, {onChange}) {
      return SwitchListTile(
          activeColor: Theme.of(context).primaryColor,
          value: value,
          onChanged: onChange,
          title: switchTitle(title, context));
    }

    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: GetBuilder<SettingsController>(builder: (c) {
          return Column(children: [
            switchButton("kot".tr, c.kotOption, onChange: (v) {
              settingsController.toggleKotoption(v);
            }),
            switchButton("client_info".tr, c.clientInfo, onChange: (v) {
              settingsController.toggleClientInfo(v);
            }),
            switchButton("whatsapp_bill".tr, c.whatsappBilling.value, onChange: (value) {
              settingsController.toggleWhatsapp(value);
            }),
            switchButton("order_billing".tr, c.orderBilling, onChange: (v) {
              settingsController.toggleOrderBilling(v);
            }),
            switchButton("print_preview".tr, c.printPreview.value, onChange: (v) {
              settingsController.togglePrintingPreview(v);
            }),
            switchButton("personal_whatsapp".tr, c.whatsappPersonal,
                onChange: (v) {
                settingsController.toggleWhatsappPersonal(v);
            }),
            switchButton("light_theme".tr, themeController.lightTheme,
                onChange: (v) {
              themeController.toggleTheme(v);
            }),
          ]);
        }));
  }

  Widget switchTitle(title, context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: customText(title,
              color: Theme.of(context).highlightColor, weight: FontWeight.bold, font: 15.0),
        )
      ],
    );
  }
}