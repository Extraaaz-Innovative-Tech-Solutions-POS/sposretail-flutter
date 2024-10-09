import 'dart:ui';
import 'package:spos_retail/views/widgets/export.dart';

class Login extends StatelessWidget {

  final authController = Get.put(AuthController());

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget emailForm(
        size, String title, IconData icondata, void Function()? onPressed,
        {onchange}) {
      return noObscureTextField(
        context,
        title,
        icondata,
        size,
        width: MediaQuery.of(context).size.width,
        keyboardType: TextInputType.emailAddress,
        onchanged: onchange,
      );
    }

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
                              Container(
                                  width: size.width > 400 ? 400 : size.width,
                                  margin: const EdgeInsets.only(
                                      left: 30, top: 10.0, bottom: 4.0),
                                  child: customText("email".tr,
                                      color: Theme.of(context).focusColor)),
                              emailForm(size, "email".tr, Icons.email, () {},
                                  onchange: (v) {
                                authController.emailLogin.value = v;
                              }),
                              Container(
                                width: size.width > 400 ? 400 : size.width,
                                margin: const EdgeInsets.only(
                                    left: 30, top: 10.0, bottom: 4.0),
                                child: customText("password".tr,
                                    color: Theme.of(context).focusColor),
                              ),
                              GetBuilder<AuthController>(builder: (c) {
                                return textField(
                                  onchanged: (v) {
                                    authController.passwordLogin.value = v;
                                  },
                                  context,
                                  "password".tr,
                                  Icons.password_rounded,
                                  size,
                                  obscure: c.passObscureLogin.value,
                                  suffixicon: c.passObscureLogin.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  onTap: () {
                                    c.passObscureLogin.value =
                                        !authController.passObscureLogin.value;
                                    c.update();
                                  },
                                );
                              }),
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
                                      if (authController
                                              .emailLogin.value.isEmpty ||
                                          authController
                                              .passwordLogin.value.isEmpty) {
                                        showAlertDialog(
                                          context: context,
                                          title: "Oops!",
                                          description:
                                              "Please enter both email and password.",
                                        );
                                      } else {
                                        authController.login(
                                          authController.emailLogin.value,
                                          authController.passwordLogin.value,
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
}
