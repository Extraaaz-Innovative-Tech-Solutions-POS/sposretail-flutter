import 'package:spos_retail/views/widgets/export.dart';

class RestaurantUpdate extends StatefulWidget {
  const RestaurantUpdate({super.key});

  @override
  State<RestaurantUpdate> createState() => _RestaurantUpdateState();
}

class _RestaurantUpdateState extends State<RestaurantUpdate> {
  final GlobalKey<FormState> _restaurantnameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _restaurantAddressKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _restaurantStateKey = GlobalKey<FormState>();
  late TextEditingController _restaursantNameController;
  late TextEditingController _restaursantAddressController;

  late final TextEditingController _stateController;
  final UpdateRestaurantController _updateRestaurantController =
      Get.put(UpdateRestaurantController());
  var restaurantid;
  var restaurantName;
  var restaurantAddress;
  var restaurantState;

  @override
  void initState() {
    super.initState();
    getSharedPrefrence();
  }

  getSharedPrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    restaurantid = pref.getInt("RestaurantId");
    restaurantName = pref.getString("RestaurantName");
    restaurantAddress = pref.getString("Address");

    // print("TEXT =======${_restaursantNameController.text}");
    _restaursantNameController =
        TextEditingController(text: restaurantName ?? "Name");
    _restaursantAddressController =
        TextEditingController(text: restaurantAddress ?? "address");
    _stateController = TextEditingController(text: restaurantState ?? "");

    print("ID ====== ${restaurantid}");
    print("Name=====  ${restaurantName}");
    print("Address ===== ${restaurantAddress}");
    print("State====${restaurantState}");

    setState(() {
      // _restaursantNameController.text = restaurantName ?? "";
      // _restaursantAddressController.text = restaurantAddress ?? "";
    });
  }

  sharedPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('RestaurantName', _restaursantNameController.text);
    pref.setString("Address", _restaursantAddressController.text);
    pref.setString('State', _stateController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Retailer Details", ""),
      body: Column(
        children: [
          _buildTextFieldWithHeading(
              _restaurantnameKey,
              "Retailer Name",
              context,
              _restaursantNameController,
              "Retailer Name",
              TextInputType.name),
          const SizedBox(height: 5),
          _buildTextFieldWithHeading(
              _restaurantAddressKey,
              "Retailer Address",
              context,
              _restaursantAddressController,
              "Retailer Address",
              TextInputType.name),
          const SizedBox(height: 5),
          _buildTextFieldWithHeading(_restaurantStateKey, "State", context,
              _stateController, "State", TextInputType.name),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () {
                    if (_restaursantNameController.text.isNotEmpty &&
                        _restaursantAddressController.text.isNotEmpty &&
                        _stateController.text.isNotEmpty) {
                      sharedPreference();
                      _updateRestaurantController.updaterestaurantController(
                          _restaursantNameController.text.toString(),
                          _restaursantAddressController.text.toString(),
                          _stateController.text.toString(),
                          restaurantid);
                    } else {
                      snackBarBottom(
                          "Error", "Enter the required field", context);
                    }
                  },
                  child: customText('Update Restaurant',
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildTextFieldWithHeading(
      key,
      String heading,
      BuildContext context,
      TextEditingController controller,
      String hinttext,
      TextInputType keyboardtype) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: customText(heading,
                font: 16.0,
                weight: FontWeight.bold,
                color: Theme.of(context).primaryColor)),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: key,
            child: SizedBox(
              height: 55,
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardtype,
                style: TextStyle(color: Theme.of(context).highlightColor),
                decoration: InputDecoration(
                  hintText: hinttext,
                  border: const OutlineInputBorder(
                    // Set consistent border for all states
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0), // Set border color and width
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    //gapPadding: 5.0,
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                ),
                validator: (value) {
                  if (value == "") {
                    return 'Please Enter $heading';
                  }
                  return null; // Return null if the input is valid
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
