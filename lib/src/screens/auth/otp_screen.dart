import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_aviation/src/common/validator/validators.dart';
import 'package:one_aviation/src/common/widgets/buttons/pink_rounded_button.dart';
import 'package:one_aviation/src/common/widgets/images/bottom_rounded_image.dart';
import 'package:one_aviation/src/common/widgets/text/error_message.dart';
import 'package:one_aviation/src/common/widgets/text_fields/rounded_text_field.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _otpController = TextEditingController();

  bool _isPressed = false;

  bool _showError = false;
  String _errorMessage = '';
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
                      'Check your email',
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
                      'Enter the OTP code!',
                      textAlign: TextAlign.center,
                      style: MyTextStyle.googleFontWrapper(
                        MyTextStyle.TitleTextStyle,
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formkey,
                  child: Padding(
                    padding: paddingHorizontal40,
                    child: Column(
                      children: [
                        RoundedTextField(
                          hintText: 'Enter otp',
                          icon: Icons.email,
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          validator: MultiValidator([
                            requiredValidator,
                          ]),
                        ),
                        _showError
                            ? ErrorMessage(errorMessage: _errorMessage)
                            : SizedBox(),
                        SizedBox(height: _showError ? 0 : 20),
                        PinkRoundedButton(
                          title: 'Check the OTP code',
                          onTap: _isPressed
                              ? null
                              : () {
                                  setState(() => _isPressed = true);

                                  if (_formkey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    var box = Hive.box('tokens');

                                    if (_otpController.text.trim() ==
                                        box.get('otp')) {
                                      setState(() => _showError = false);
                                      _otpController.clear();
                                      Navigator.pushNamed(
                                          context, '/profile/new_password');
                                    } else {
                                      setState(() {
                                        _showError = true;
                                        _errorMessage =
                                            'The OTP is not correct!';
                                      });
                                    }
                                  }

                                  setState(() => _isPressed = false);
                                },
                        ),
                        SizedBox(height: 70),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
