import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:one_aviation/src/common/validator/validators.dart';
import 'package:one_aviation/src/common/widgets/buttons/pink_rounded_button.dart';
import 'package:one_aviation/src/common/widgets/images/bottom_rounded_image.dart';
import 'package:one_aviation/src/common/widgets/text_fields/rounded_text_field.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isPressed = false;
  bool _isLoading = false;
  // bool _notConnected = false;
  bool _isObscure = true;
  bool _confirmIsObscure = true;
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
                    'Create Account,',
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
                    'sign up to get started!',
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
                              hintText: 'first name',
                              icon: Icons.person,
                              controller: firstNameController,
                              validator: MultiValidator([
                                requiredValidator,
                              ]),
                            ),
                            RoundedTextField(
                              hintText: 'last name',
                              icon: Icons.person,
                              controller: lastNameController,
                              validator: MultiValidator([
                                requiredValidator,
                              ]),
                            ),
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
                            RoundedTextField(
                              hintText: 'phone number',
                              icon: Icons.phone,
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              validator: MultiValidator([
                                requiredValidator,
                                phoneValidator,
                              ]),
                            ),
                            RoundedTextField(
                              hintText: 'password',
                              icon: Icons.lock_rounded,
                              controller: passwordController,
                              isObscure: _isObscure,
                              validator: MultiValidator([
                                requiredValidator,
                                minLengthValidator,
                                maxLengthValidator,
                              ]),
                              suffix: Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: CupertinoButton(
                                  onPressed: () {
                                    setState(() => _isObscure = !_isObscure);
                                  },
                                  padding: EdgeInsets.zero,
                                  child: Icon(
                                    _isObscure
                                        ? CupertinoIcons.eye
                                        : CupertinoIcons.eye_slash,
                                    color: PlaceholderIconColor,
                                  ),
                                ),
                              ),
                            ),
                            RoundedTextField(
                              hintText: 'confirm password',
                              icon: Icons.lock_rounded,
                              controller: confirmPasswordController,
                              isObscure: _confirmIsObscure,
                              validator: MultiValidator([
                                requiredValidator,
                                minLengthValidator,
                                maxLengthValidator,
                              ]),
                              suffix: Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: CupertinoButton(
                                  onPressed: () {
                                    setState(() =>
                                        _confirmIsObscure = !_confirmIsObscure);
                                  },
                                  padding: EdgeInsets.zero,
                                  child: Icon(
                                    _confirmIsObscure
                                        ? CupertinoIcons.eye
                                        : CupertinoIcons.eye_slash,
                                    color: PlaceholderIconColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            PinkRoundedButton(
                              title: 'SIGN UP',
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
