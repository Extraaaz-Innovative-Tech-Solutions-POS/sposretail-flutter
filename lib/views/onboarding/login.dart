import 'dart:ui';

import 'package:spos_retail/views/widgets/export.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final name = TextEditingController();
  final authController = Get.put(AuthController());
  final _emailController = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool obsucre = true;

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
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Container(
                      color: Theme.of(context).highlightColor,
                      child: Image.asset(
                        Images.logoAsset,
                        width: size.width,
                      ),
                    ),
                    const SizedBox(height: 80),
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
                                        color: Theme.of(context).focusColor,
                                      ),
                                      children: <TextSpan>[
                                        const TextSpan(text: 'Welcome To '),
                                        TextSpan(
                                            text: "BHARAT POS",
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
                              // icondata, size, width: 400.0
                              Container(
                                  width: size.width > 400 ? 400 : size.width,
                                  margin: const EdgeInsets.only(
                                      left: 30, top: 10.0, bottom: 4.0),
                                  child: customText("email".tr,
                                      color: Theme.of(context).focusColor)),

                              emailForm(size, _emailController, "email".tr,
                                  Icons.email, () {}),

                              //! Password Field----------->
                              Container(
                                width: size.width > 400 ? 400 : size.width,
                                margin: const EdgeInsets.only(
                                    left: 30, top: 10.0, bottom: 4.0),
                                child: customText("password".tr,
                                    color: Theme.of(context).focusColor),
                              ),

                              textField(
                                context,
                                "password".tr,
                                _passwordcontroller,
                                Icons.password_rounded,
                                size,
                                obscure: obsucre,
                                suffixicon: obsucre
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                onTap: () {
                                  if (obsucre == true) {
                                    obsucre = false;
                                    setState(() {});
                                  } else {
                                    obsucre = true;
                                    setState(() {});
                                  }
                                },
                              ),

                              Center(
                                child: Container(
                                  height: 45.0,
                                  width: 200.0,
                                  margin: const EdgeInsets.only(
                                      top: 40.0, bottom: 20.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                    onPressed: () async {
                                      if (_emailController.text.isEmpty ||
                                          _passwordcontroller.text.isEmpty) {
                                        //Get.to(BottomNav());
                                        // Show alert dialog if either field is empty
                                        showAlertDialog(
                                          context: context,
                                          title: "Oops!",
                                          description:
                                              "Please enter both email and password.",
                                        );
                                      } else {
                                        // Get.to(BottomNav());
                                        //Call login method if both fields are not emrpty
                                        authController.login(
                                          _emailController.text,
                                          _passwordcontroller.text,
                                        );
                                      }
                                    },
                                    child: customText(
                                      "login".tr,
                                      color: Theme.of(context).focusColor,
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                width: size.width > 400 ? 400 : size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: TextButton(
                                  onPressed: () {
                                    Get.offAll((const Register()));
                                  },
                                  child: customText(
                                    "create_an_account".tr,
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
      IconData icondata, void Function()? onPressed) {
    return textField(context, title, contoller, icondata, size, width: 400.0);
  }

  Widget emailForm(size, TextEditingController contoller, String title,
      IconData icondata, void Function()? onPressed) {
    return noObscureTextField(context, title, contoller, icondata, size,
        width: MediaQuery.of(context).size.width,
        keyboardType: TextInputType.emailAddress);
  }
}
