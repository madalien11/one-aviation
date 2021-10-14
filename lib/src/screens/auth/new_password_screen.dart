import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:one_aviation/src/common/validator/validators.dart';
import 'package:one_aviation/src/common/widgets/buttons/pink_rounded_button.dart';
import 'package:one_aviation/src/common/widgets/images/bottom_rounded_image.dart';
import 'package:one_aviation/src/common/widgets/text/error_message.dart';
import 'package:one_aviation/src/common/widgets/text_fields/rounded_text_field.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';
import 'package:one_aviation/src/screens/auth/bloc/auth_bloc.dart';
import 'package:one_aviation/src/screens/auth/reset_password_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPressed = false;
  bool _isLoading = false;
  bool _showError = false;
  String _errorMessage = '';

  bool _isObscure = true;
  bool _confirmIsObscure = true;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              if (state is ResetPasswordLoading) {
                setState(() => _isLoading = true);
              } else {
                setState(() => _isLoading = false);
              }

              if (state is ResetPasswordSuccessful) {
                setState(() => _showError = false);
                Navigator.pop(context);
                Navigator.pop(context);
                _passwordController.clear();
                _confirmPasswordController.clear();
              } else if (state is ResetPasswordUnsuccessful) {
                setState(() {
                  _showError = true;
                  _errorMessage = state.errorMessage;
                });
              }
            },
            child: SafeArea(
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  BottomRoundedImage(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 24),
                    child: Center(
                      child: Text(
                        'Want to change your password?',
                        textAlign: TextAlign.center,
                        style: MyTextStyle.googleFontWrapper(
                          MyTextStyle.OrangeTitleTextStyle,
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formkey,
                    child: _isLoading
                        ? Center(child: CupertinoActivityIndicator())
                        : Padding(
                            padding: paddingHorizontal40,
                            child: Column(
                              children: [
                                RoundedTextField(
                                  hintText: 'new password',
                                  icon: Icons.lock_rounded,
                                  controller: _passwordController,
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
                                        setState(
                                            () => _isObscure = !_isObscure);
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
                                  controller: _confirmPasswordController,
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
                                        setState(() => _confirmIsObscure =
                                            !_confirmIsObscure);
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
                                _showError
                                    ? ErrorMessage(errorMessage: _errorMessage)
                                    : SizedBox(),
                                SizedBox(height: _showError ? 0 : 20),
                                PinkRoundedButton(
                                  title: 'Change password',
                                  onTap: _isPressed
                                      ? null
                                      : () {
                                          setState(() => _isPressed = true);

                                          if (_formkey.currentState!
                                              .validate()) {
                                            FocusScope.of(context).unfocus();
                                            if (_passwordController.text ==
                                                _confirmPasswordController
                                                    .text) {
                                              context
                                                  .read<AuthBloc>()
                                                  .add(ResetPassword(
                                                    email: userEmail ?? '',
                                                    password:
                                                        _passwordController
                                                            .text,
                                                  ));
                                            } else {
                                              setState(() {
                                                _showError = true;
                                                _errorMessage =
                                                    'Passwords are not the same';
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
            ),
          )),
    );
  }
}
