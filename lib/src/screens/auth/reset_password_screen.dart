import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:one_aviation/src/common/validator/validators.dart';
import 'package:one_aviation/src/common/widgets/buttons/pink_rounded_button.dart';
import 'package:one_aviation/src/common/widgets/images/bottom_rounded_image.dart';
import 'package:one_aviation/src/common/widgets/text_fields/rounded_text_field.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final emailController = TextEditingController();

  bool _isPressed = false;
  bool _isLoading = false;
  // bool _notConnected = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              BottomRoundedImage(),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 2),
                child: Center(
                  child: Text(
                    'Forgot your password?',
                    textAlign: TextAlign.center,
                    style: MyTextStyle.googleFontWrapper(
                      MyTextStyle.OrangeTitleTextStyle,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Center(
                  child: Text(
                    'Enter your email!',
                    textAlign: TextAlign.center,
                    style: MyTextStyle.googleFontWrapper(
                      MyTextStyle.TitleTextStyle,
                    ),
                  ),
                ),
              ),
              Form(
                key: formkey,
                child: _isLoading
                    ? Center(child: CupertinoActivityIndicator())
                    : Padding(
                        padding: paddingHorizontal40,
                        child: Column(
                          children: [
                            RoundedTextField(
                              hintText: 'email',
                              icon: Icons.email,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: MultiValidator([
                                requiredValidator,
                                emailValidator,
                              ]),
                            ),
                            SizedBox(height: 20),
                            PinkRoundedButton(
                              title: 'Send activation code',
                              onTap: _isPressed
                                  ? null
                                  : () {
                                      setState(() {
                                        _isPressed = true;
                                      });

                                      if (formkey.currentState!.validate()) {
                                        FocusScope.of(context).unfocus();
                                      }
                                      setState(() {
                                        _isPressed = false;
                                      });
                                      Navigator.pushNamed(
                                        context,
                                        '/new_password',
                                      );
                                    },
                            ),
                            SizedBox(height: 70),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
