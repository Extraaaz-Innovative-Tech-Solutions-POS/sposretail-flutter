import 'package:spos_retail/model/common_model.dart';
import 'package:spos_retail/views/widgets/export.dart';

extension StringExtensions on String {
  String firstcapitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class Addstaff extends StatefulWidget {
  String staffid;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? role;

  bool onclick;

  Addstaff(
      {Key? key,
      required this.staffid,
      required this.onclick,
      this.name,
      this.email,
      this.phone,
      this.password,
      this.role});

  // const Addstaff({Key? key}) : super(key: key);

  @override
  State<Addstaff> createState() => _AddstaffState();
}

class _AddstaffState extends State<Addstaff> {
  late TextEditingController namecontroller = TextEditingController();
  late TextEditingController emailcontroller = TextEditingController();
  late TextEditingController phonecontroller = TextEditingController();
  late TextEditingController passwordcontroller = TextEditingController();
  final StaffController controller = Get.put(StaffController());
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  late String? _selectedItem;

  var items = [
    "Manager",
    "Cashier",
    // "Waiter"
  ];

  @override
  void initState() {
    super.initState();

    namecontroller =
        TextEditingController(text: widget.onclick ? "" : widget.name);
    phonecontroller =
        TextEditingController(text: widget.onclick ? "" : widget.phone);
    emailcontroller =
        TextEditingController(text: widget.onclick ? "" : widget.email);
    passwordcontroller =
        TextEditingController(text: widget.onclick ? "" : widget.password);

    _selectedItem = (widget.role ?? "Manager").firstcapitalize();

    //    if (widget.role == null) {
    //   _selectedItem = "Manager";
    // } else {
    //   _selectedItem = widget.role;
    // }

    print("items: $items");
    print("selectedItem: $_selectedItem");
  }

  //  String? _selectedItem = "Manager";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          context, widget.onclick ? "Add Staff" : "Update Staff", ""),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),

            _buildTextFieldWithHeading(_nameKey, "Name", context,
                namecontroller, "Name", TextInputType.name),
            const SizedBox(height: 5),
            _buildTextFieldWithHeading(_emailKey, "Email Id", context,
                emailcontroller, "E-mail", TextInputType.emailAddress),
            const SizedBox(height: 5),
            _buildTextFieldWithHeading(_passwordKey, "Password", context,
                passwordcontroller, "Password", TextInputType.visiblePassword),
            const SizedBox(height: 5),
            _buildTextFieldWithHeading(_phoneKey, "Phone", context,
                phonecontroller, "PhoneNo.", TextInputType.number),
            const SizedBox(height: 5),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: customText("Role",
                    font: 16.0,
                    weight: FontWeight.bold,
                    color: Theme.of(context).primaryColor)),
            const SizedBox(height: 10),
            Container(
              //margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(left: 10, right: 10),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              width: screenWidth(context),
              decoration: highlightBorderDecor(context),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                value: _selectedItem,
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value;
                  });
                },
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: customText(value,
                        color: Theme.of(context).highlightColor),
                  );
                }).toList(),
              )),
            ),

            ////////////////
            const SizedBox(height: 20),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      if (namecontroller.text.isNotEmpty &&
                          emailcontroller.text.isNotEmpty &&
                          phonecontroller.text.isNotEmpty) {
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailcontroller.text);
                        final bool passwordValid =
                            phonecontroller.text.length == 10;
                        if (emailValid == true) {
                          AddStaff addStaff = AddStaff(
                              name: namecontroller.text,
                              email: emailcontroller.text,
                              password: passwordcontroller.text,
                              phone: phonecontroller.text,
                              role: _selectedItem.toString().toLowerCase());
                          widget.onclick
                              ? controller.createUser(addStaff)
                              : controller.updateUser(
                                  widget.staffid,
                                  namecontroller.text,
                                  emailcontroller.text,
                                  phonecontroller.text,
                                  _selectedItem.toString().toLowerCase(),
                                );
                        } else {
                          snackBarBottom("Error",
                              "Please enter the valid email id", context);
                        }
                      } else {
                        snackBarBottom(
                            "Error", "Enter the required field", context);
                      }
                    },
                    child: customText(
                        widget.onclick ? 'Add Staff' : 'Update Staff',
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ))
          ],
        ),
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
