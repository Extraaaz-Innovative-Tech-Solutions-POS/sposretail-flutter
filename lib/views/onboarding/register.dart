import 'dart:ui';

import 'package:spos_retail/controllers/register_controller.dart';
import 'package:spos_retail/views/widgets/export.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final name = TextEditingController();

  late Images images;

  final authController = Get.put(RegisterController());

  final _emailController = TextEditingController();

  final _namecontroller = TextEditingController();

  final _passwordcontroller = TextEditingController();

  final _phoneController = TextEditingController();

  final _restaurantController = TextEditingController();

  final _addressController = TextEditingController();

  final _stateController = TextEditingController();

  bool namefield = true;

  bool passwordfield = false;
  bool passwordfieldchecker = false;
  bool emailfield = false;
  bool emailfieldchecker = false;

  bool phonefield = false;
  bool phonefieldchecker = false;
  bool rolefield = false;
  bool rolefieldchecker = false;
  bool loginButton = false;
  bool obsucre = true;
  bool resturantname = false;
  bool restaurantnameChecker = false;
  bool address = false;
  bool addressChecker = false;

  bool state = false;
  bool statechecker = false;

  @override
  void initState() {
    super.initState();
    obsucre = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              width: size.width,
              decoration: bgImageDecor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Container(
                      color: Theme.of(context).highlightColor,
                      child:
                          Image.asset(Images.logoAsset, width: size.width / 2),
                    ),
                    ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(
                          // height: size.height / 1.5,
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                              top: 25.0, right: 10.0, left: 10.0),
                          decoration: BoxDecoration(
                            gradient: gradient(
                              [
                                Theme.of(context).focusColor,
                                Theme.of(context).focusColor.withOpacity(0.1),
                                Theme.of(context).focusColor.withOpacity(0.3)
                              ],
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              width: 1.5,
                              color: Theme.of(context)
                                  .highlightColor
                                  .withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        color: Theme.of(context).highlightColor,
                                      ),
                                      children: <TextSpan>[
                                        const TextSpan(text: 'Welcome To '),
                                        TextSpan(
                                            text: 'Spos +',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              //! Name Feild------------->
                              namefield
                                  ? Container(
                                      width:
                                          size.width > 400 ? 400 : size.width,
                                      margin: const EdgeInsets.only(
                                          left: 30, top: 10.0, bottom: 4.0),
                                      child: customText(
                                        "name".tr,
                                        color: Theme.of(context).highlightColor,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              namefield
                                  ? registerNoObscureForm(size, _namecontroller,
                                      "name".tr, Icons.person, () {
                                      if (_namecontroller.text.isNotEmpty &&
                                          _emailController.text.isNotEmpty &&
                                          _passwordcontroller.text.isNotEmpty &&
                                          _phoneController.text.isNotEmpty) {
                                        namefield = false;
                                        emailfield = false;
                                        passwordfield = false;
                                        rolefield = false;
                                        phonefield = false;
                                        setState(() {});
                                      } else if (_namecontroller.text.isEmpty) {
                                        snackBarBottom(
                                            "Error",
                                            "Name Field Shouldn't Empty",
                                            context);
                                      } else {
                                        emailfield = true;
                                        namefield = false;
                                        setState(() {});
                                      }
                                    })
                                  : GestureDetector(
                                      onTap: () {
                                        namefield = true;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 50.0,
                                        width: 270,
                                        margin: const EdgeInsets.only(
                                            top: 20.0, left: 20.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, top: 10.0),
                                            child: customText(
                                                _namecontroller.text.toString(),
                                                color: Theme.of(context)
                                                    .indicatorColor)),
                                      ),
                                    ),

                              //! Email Field--------->
                              emailfield
                                  ? Container(
                                      width:
                                          size.width > 400 ? 400 : size.width,
                                      margin: const EdgeInsets.only(
                                          left: 30, top: 10.0, bottom: 4.0),
                                      child: customText("email".tr,
                                          color:
                                              Theme.of(context).highlightColor),
                                    )
                                  : const SizedBox.shrink(),
                              emailfield
                                  ? registerNoObscureForm(
                                      size,
                                      _emailController,
                                      "email".tr,
                                      Icons.mail, () {
                                      if (_namecontroller.text.isNotEmpty &&
                                          _emailController.text.isNotEmpty &&
                                          _passwordcontroller.text.isNotEmpty &&
                                          _phoneController.text.isNotEmpty) {
                                        namefield = false;
                                        emailfield = false;
                                        passwordfield = false;
                                        rolefield = false;
                                        phonefield = false;
                                        setState(() {});
                                      } else if (_emailController
                                          .text.isEmpty) {
                                        snackBarBottom(
                                            "Error",
                                            "Email Field Shouldn't Empty",
                                            context);
                                      } else {
                                        emailfield = false;
                                        passwordfield = true;
                                        emailfieldchecker = true;
                                        setState(() {});
                                      }
                                    })
                                  : emailfieldchecker
                                      ? GestureDetector(
                                          onTap: () {
                                            emailfield = true;
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 50.0,
                                            width: 270,
                                            margin: const EdgeInsets.only(
                                                top: 20.0, left: 20.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, top: 10.0),
                                              child: Text(
                                                _emailController.text
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                              //! Password Field----------->
                              passwordfield
                                  ? Container(
                                      width:
                                          size.width > 400 ? 400 : size.width,
                                      margin: const EdgeInsets.only(
                                          left: 30, top: 10.0, bottom: 4.0),
                                      child: Text(
                                        "password".tr,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              passwordfield
                                  ? registerForm(size, _passwordcontroller,
                                      "password".tr, Icons.password_rounded,
                                      obscure: obsucre,
                                      suffixicon: obsucre
                                          ? Icons.visibility_off
                                          : Icons.visibility, onTap: () {
                                      if (obsucre == true) {
                                        obsucre = false;
                                        setState(() {});
                                      } else {
                                        obsucre = true;
                                        setState(() {});
                                      }
                                    }, () {
                                      if (_namecontroller.text.isNotEmpty &&
                                          _emailController.text.isNotEmpty &&
                                          _passwordcontroller.text.isNotEmpty &&
                                          _phoneController.text.isNotEmpty) {
                                        namefield = false;
                                        emailfield = false;
                                        passwordfield = false;
                                        rolefield = false;
                                        phonefield = false;
                                        setState(() {});
                                      } else if (_passwordcontroller
                                          .text.isEmpty) {
                                        snackBarBottom(
                                            "Error",
                                            "Password Field Shouldn't Empty",
                                            context);
                                      } else {
                                        passwordfield = false;
                                        phonefield = true;
                                        passwordfieldchecker = true;
                                        setState(() {});
                                      }
                                    })
                                  : passwordfieldchecker
                                      ? GestureDetector(
                                          onTap: () {
                                            passwordfield = true;
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 50.0,
                                            width: 270,
                                            margin: const EdgeInsets.only(
                                                top: 20.0, left: 20.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              // border: Border.all(
                                              //   color: Colors.grey,
                                              // )
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, top: 10.0),
                                              child: customText(
                                                obsucre == false
                                                    ? _passwordcontroller.text
                                                    : _passwordcontroller.text
                                                        .replaceAll(
                                                            RegExp(r"."), "*"),
                                                color: Theme.of(context)
                                                    .indicatorColor,
                                                font: 18.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                              //! Phone Field----------->
                              phonefield
                                  ? Container(
                                      width:
                                          size.width > 400 ? 400 : size.width,
                                      margin: const EdgeInsets.only(
                                          left: 30, top: 10.0, bottom: 4.0),
                                      child: customText(
                                        "phone".tr,
                                        color: Theme.of(context).highlightColor,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              phonefield
                                  ? registerNoObscureForm(
                                      size,
                                      _phoneController,
                                      "phone".tr,
                                      keyboardType: TextInputType.phone,
                                      Icons.phone, () {
                                      if (_namecontroller.text.isNotEmpty &&
                                          _emailController.text.isNotEmpty &&
                                          _passwordcontroller.text.isNotEmpty) {
                                        namefield = false;
                                        emailfield = false;
                                        passwordfield = false;
                                        phonefield = false;
                                        phonefieldchecker = true;
                                        resturantname = true;
                                        //loginButton = true;
                                        // rolefield = false;
                                        //  phonefield = false;
                                        setState(() {});
                                      } else if (_phoneController
                                          .text.isEmpty) {
                                        snackBarBottom(
                                            "Error",
                                            "Phone Field Shouldn't Empty",
                                            context);
                                      } else {
                                        phonefield = false;
                                        //rolefield = true;
                                        phonefieldchecker = true;
                                        // loginButton = true;
                                        setState(() {});
                                      }
                                    })
                                  : phonefieldchecker
                                      ? GestureDetector(
                                          onTap: () {
                                            phonefield = true;
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 50.0,
                                            width: 270,
                                            margin: const EdgeInsets.only(
                                                top: 20.0, left: 20.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, top: 10.0),
                                              child: Text(
                                                _phoneController.text
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                              //! Restaurant Name Field-------------------->
                              resturantname
                                  ? Container(
                                      width:
                                          size.width > 400 ? 400 : size.width,
                                      margin: const EdgeInsets.only(
                                          left: 30, top: 10.0, bottom: 4.0),
                                      child: Text(
                                        "retailer_name".tr,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              resturantname
                                  ? registerNoObscureForm(
                                      size,
                                      _restaurantController,
                                      "retailer_name".tr,
                                      keyboardType: TextInputType.name,
                                      Icons.apartment, () {
                                      if (_namecontroller.text.isNotEmpty &&
                                          _emailController.text.isNotEmpty &&
                                          _passwordcontroller.text.isNotEmpty &&
                                          _restaurantController
                                              .text.isNotEmpty) {
                                        namefield = false;
                                        emailfield = false;
                                        passwordfield = false;
                                        phonefield = false;
                                        phonefieldchecker = false;
                                        address = true;
                                        resturantname = false;
                                        restaurantnameChecker = true;

                                        // rolefield = false;
                                        //  phonefield = false;
                                        setState(() {});
                                      } else if (_restaurantController
                                          .text.isEmpty) {
                                        snackBarBottom(
                                            "Error",
                                            "Retailer Name Field Shouldn't Empty",
                                            context);
                                      } else {
                                        phonefield = false;
                                        //rolefield = true;
                                        restaurantnameChecker = true;
                                        loginButton = true;
                                        setState(() {});
                                      }
                                    })
                                  : restaurantnameChecker
                                      ? GestureDetector(
                                          onTap: () {
                                            resturantname = true;
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 50.0,
                                            width: 270,
                                            margin: EdgeInsets.only(
                                                top: 20.0, left: 20.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, top: 10.0),
                                              child: Text(
                                                _restaurantController.text
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),

                              //! Restaurant Address Field------------->
                              address
                                  ? Container(
                                      width:
                                          size.width > 400 ? 400 : size.width,
                                      margin: const EdgeInsets.only(
                                          left: 30, top: 10.0, bottom: 4.0),
                                      child: Text(
                                        "retailer_address".tr,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              address
                                  ? registerNoObscureForm(
                                      size,
                                      _addressController,
                                      "retailer_address".tr,
                                      keyboardType: TextInputType.streetAddress,
                                      Icons.location_history, () {
                                      if (_namecontroller.text.isNotEmpty &&
                                          _emailController.text.isNotEmpty &&
                                          _passwordcontroller.text.isNotEmpty &&
                                          _restaurantController
                                              .text.isNotEmpty &&
                                          _addressController.text.isNotEmpty) {
                                        namefield = false;
                                        emailfield = false;
                                        passwordfield = false;
                                        phonefield = false;
                                        phonefieldchecker = false;
                                        resturantname = false;

                                        address = false;
                                        addressChecker = true;
                                        state = true;
                                        // rolefield = false;
                                        //  phonefield = false;
                                        setState(() {});
                                      } else if (_addressController
                                          .text.isEmpty) {
                                        snackBarBottom(
                                            "Error",
                                            "Address Field Shouldn't Empty",
                                            context);
                                      } else {
                                        restaurantnameChecker = false;
                                        addressChecker = true;
                                        loginButton = true;
                                        setState(() {});
                                      }
                                    })
                                  : addressChecker
                                      ? GestureDetector(
                                          onTap: () {
                                            address = true;
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 50.0,
                                            width: 270,
                                            margin: const EdgeInsets.only(
                                                top: 20.0, left: 20.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              // border: Border.all(
                                              //   color: Colors.grey,
                                              // )
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, top: 10.0),
                                              child: Text(
                                                _addressController.text
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
//! State Controller---------------------->
                              state
                                  ? Container(
                                      width:
                                          size.width > 400 ? 400 : size.width,
                                      margin: const EdgeInsets.only(
                                          left: 30, top: 10.0, bottom: 4.0),
                                      child: customText(
                                        "retailer_address".tr,
                                        color: Theme.of(context).highlightColor,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              state
                                  ? registerNoObscureForm(
                                      size,
                                      _stateController,
                                      "State",
                                      keyboardType: TextInputType.streetAddress,
                                      Icons.location_history, () {
                                      if (_namecontroller.text.isNotEmpty &&
                                          _emailController.text.isNotEmpty &&
                                          _passwordcontroller.text.isNotEmpty &&
                                          _restaurantController
                                              .text.isNotEmpty &&
                                          _addressController.text.isNotEmpty &&
                                          _stateController.text.isNotEmpty) {
                                        namefield = false;
                                        emailfield = false;
                                        passwordfield = false;
                                        phonefield = false;
                                        phonefieldchecker = false;
                                        resturantname = false;

                                        address = false;
                                        state = false;
                                        //addressChecker = false;
                                        statechecker = true;
                                        loginButton = true;
                                        // rolefield = false;
                                        //  phonefield = false;
                                        setState(() {});
                                      } else if (_stateController
                                          .text.isEmpty) {
                                        snackBarBottom(
                                            "Error",
                                            "State Field Shouldn't be Empty",
                                            context);
                                      } else {
                                        restaurantnameChecker = false;
                                        addressChecker = true;
                                        loginButton = true;
                                        setState(() {});
                                      }
                                    })
                                  : statechecker
                                      ? GestureDetector(
                                          onTap: () {
                                            state = true;
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 50.0,
                                            width: 270,
                                            margin: const EdgeInsets.only(
                                                top: 20.0, left: 20.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              // border: Border.all(
                                              //   color: Colors.grey,
                                              // )
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, top: 10.0),
                                              child: Text(
                                                _stateController.text
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),

                              loginButton
                                  ? Center(
                                      child: Container(
                                        height: 45.0,
                                        width: 200.0,
                                        margin: const EdgeInsets.only(
                                            top: 40.0, bottom: 20.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                          onPressed: () async {
                                            // Check if email and password fields are empty
                                            if (_emailController.text.isEmpty ||
                                                _passwordcontroller
                                                    .text.isEmpty ||
                                                _namecontroller.text.isEmpty ||
                                                _passwordcontroller
                                                        .text.length ==
                                                    10) {
                                              // Show alert dialog if either field is empty
                                              showAlertDialog(
                                                context: context,
                                                title: "Oops!",
                                                description:
                                                    "Please enter both email and password.",
                                              );
                                            } else {
                                              // Call login method if both fields are not empty
                                              authController.register(
                                                  _emailController.text,
                                                  _passwordcontroller.text,
                                                  _namecontroller.text,
                                                  _phoneController.text,
                                                  _restaurantController.text,
                                                  _addressController.text,
                                                  _stateController.text);
                                              // resturantdetails = true;
                                              // setState(() {});
                                            }
                                          },
                                          child: Text(
                                            "SignUp",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .highlightColor),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),

                              Container(
                                width: size.width > 400 ? 400 : size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: TextButton(
                                  onPressed: () {
                                    Get.offAll(Login());
                                  },
                                  child: customText(
                                    "login".tr,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget registerForm(size, TextEditingController contoller, String title,
      IconData icondata, void Function()? onPressed,
      {IconData? suffixicon,
      void Function()? onTap,
      bool? obscure,
      double? width,
      TextInputType? keyboardType}) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: textField(context, title, icondata, size,
              width: 275.0,
              suffixicon: suffixicon,
              onTap: onTap,
              keyboardType: keyboardType,
              controller: contoller,
              obscure: obscure),
        ),
        //textField(title, contoller, icondata, size, width: 275.0),
        Expanded(
            flex: 0,
            child: IconButton(
                color: Theme.of(context).scaffoldBackgroundColor,
                onPressed: onPressed,
                icon: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).highlightColor,
                ))),
      ],
    );
  }

  Widget registerNoObscureForm(size, TextEditingController contoller,
      String title, IconData icondata, void Function()? onPressed,
      {IconData? suffixicon,
      void Function()? onTap,
      bool? obscure,
      double? width,
      TextInputType? keyboardType,
      bool forwardIconStatus = true}) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: noObscureTextField(context, title, icondata, size,
              width: 275.0,
              suffixicon: suffixicon,
              onTap: onTap,
              keyboardType: keyboardType, controller: contoller),
        ),
        //textField(title, contoller, icondata, size, width: 275.0),
        forwardIconStatus
            ? Expanded(
                flex: 0,
                child: IconButton(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    onPressed: onPressed,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).highlightColor,
                    )))
            : const SizedBox.shrink()
      ],
    );
  }
}
