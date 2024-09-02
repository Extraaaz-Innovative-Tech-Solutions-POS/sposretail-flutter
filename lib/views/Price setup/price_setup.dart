import 'package:spos_retail/controllers/price_setup/price_setup_controller.dart';
import 'package:spos_retail/views/widgets/export.dart';

class PriceSetup extends StatefulWidget {
  const PriceSetup({super.key});

  @override
  State<PriceSetup> createState() => _PriceSetupState();
}

class _PriceSetupState extends State<PriceSetup> {

  final priceseupController = Get.put(PriceSetupController());

  double currentJewelleryPrie = 0.0;
 
  //TextEditingController _kotprinternameController = TextEditingController();
 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
     appBar: commonAppBar(context, "Price Setup", ""),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Set Current Price",
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
                    onChanged: (v) {
                      priceseupController.jewelleryUnitPrice.value = double.parse(v);
                         print("price  setup ${priceseupController.jewelleryUnitPrice}");
                    },
                   // controller: _priceSetupController,
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
                        hintText: 'Enter Current Price',
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                )),



                   const SizedBox(
              height: 20.0,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async{
                  currentJewelleryPrie = priceseupController.jewelleryUnitPrice.value;
                  print("price :${currentJewelleryPrie}");
                   SharedPreferences pref = await SharedPreferences.getInstance();
                   pref.setDouble("jewellery_price",priceseupController.jewelleryUnitPrice.toDouble());
                   setState(() {});
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
        ],
        ),
    );
  }
}