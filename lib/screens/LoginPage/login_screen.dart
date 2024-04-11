import 'package:admin/Routes/routes.dart';
import 'package:admin/Utils/Widgets/common_textfield.dart';
import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/LoginPage/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.find();

  @override
  void initState() {
    checkLoginStatuse();
    // TODO: implement initState
    super.initState();
  }

  checkLoginStatuse() async {
    String loginEmail = await GetStorage().read('loginEmail') ?? '';
    print('-----------------');
    print(loginEmail);
    print('-----------------');
    if (loginEmail.isNotEmpty) {
      Get.offAllNamed(Routes.mainScreen);
      print('asdas');
    }
    print('Noasdnon');
  }

  @override
  void dispose() {
    // EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    // Calculate the desired font size based on the screen width and height
    final fontSize = width *
        0.05 *
        scaleFactor; // Adjust the multiplication factor as needed
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Container(
        child: Row(
          children: [
            if (!Responsive.isMobile(context))
              Container(
                width: width * 0.45,
                height: height,
                decoration: BoxDecoration(color: lightBlueColor),
                child: Image.asset(Assets.imagesLoginBgImg),
              ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(color: secondaryColor),
                child: SingleChildScrollView(
                  child: Form(
                    key: loginController.loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            Assets.iconsAppIcon,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextWidget(
                            'Investtor\nAdmin Login',
                            fontWeight: FontWeight.w600,
                            color: darkBlueColor,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextWidget(
                          'Please fill in your unique admin login details below',
                          fontWeight: FontWeight.w400,
                          color: textColor,
                          textAlign: TextAlign.start,
                          fontSize: 17,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          label: 'Email address',
                          hint: 'type here',
                          controller: loginController.adminUsernameController,
                          validator: (v) {
                            if (v!.isEmpty || !GetUtils.isEmail(v)) {
                              return 'Please Enter Correct Email.';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          label: 'Password',
                          // suffixIcon: InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding: EdgeInsets.all(defaultPadding * 0.6),
                          //     margin: EdgeInsets.symmetric(
                          //         horizontal: defaultPadding / 2),
                          //     child: Icon(
                          //       Icons.remove_red_eye,
                          //       color: textColor,
                          //     ),
                          //   ),
                          // ),
                          controller: loginController.adminPasswordController,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Please Enter Password.';
                            }
                            return null;
                          },
                        ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: TextWidget(
                        //     'forgot password ?  ',
                        //     fontWeight: FontWeight.w400,
                        //     color: textColor,
                        //     textAlign: TextAlign.start,
                        //     fontSize: 16,
                        //   ),
                        // ),
                        SizedBox(
                          height: 50,
                        ),
                        CustomButton(
                          onBtnPress: () {
                            loginController.signInUser();
                          },
                          buttonText: 'Sign In',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
