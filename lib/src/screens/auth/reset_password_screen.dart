import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:one_aviation/src/common/validator/validators.dart';
import 'package:one_aviation/src/common/widgets/buttons/pink_rounded_button.dart';
import 'package:one_aviation/src/common/widgets/images/bottom_rounded_image.dart';
import 'package:one_aviation/src/common/widgets/text/error_message.dart';
import 'package:one_aviation/src/common/widgets/text_fields/rounded_text_field.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';
import 'package:one_aviation/src/screens/auth/bloc/auth_bloc.dart';

String? userEmail;

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();

  bool _isPressed = false;
  bool _isLoading = false;

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
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              if (state is VerifyEmailLoading) {
                setState(() => _isLoading = true);
              } else {
                setState(() => _isLoading = false);
              }

              if (state is VerifyEmailSuccessful) {
                userEmail = _emailController.text;
                setState(() => _showError = false);
                _emailController.clear();
                Navigator.pushNamed(context, '/new_password');
              } else if (state is VerifyEmailUnsuccessful) {
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
                    key: _formkey,
                    child: _isLoading
                        ? Center(child: CupertinoActivityIndicator())
                        : Padding(
                            padding: paddingHorizontal40,
                            child: Column(
                              children: [
                                RoundedTextField(
                                  hintText: 'email',
                                  icon: Icons.email,
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: MultiValidator([
                                    requiredValidator,
                                    emailValidator,
                                  ]),
                                ),
                                _showError
                                    ? ErrorMessage(errorMessage: _errorMessage)
                                    : SizedBox(),
                                SizedBox(height: _showError ? 0 : 20),
                                PinkRoundedButton(
                                  title: 'Send activation code',
                                  onTap: _isPressed
                                      ? null
                                      : () {
                                          setState(() => _isPressed = true);

                                          if (_formkey.currentState!
                                              .validate()) {
                                            FocusScope.of(context).unfocus();
                                            context.read<AuthBloc>().add(
                                                VerifyEmail(
                                                    email:
                                                        _emailController.text));
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
