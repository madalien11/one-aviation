import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:one_aviation/src/common/validator/validators.dart';
import 'package:one_aviation/src/common/widgets/buttons/pink_rounded_button.dart';
import 'package:one_aviation/src/common/widgets/images/bottom_rounded_image.dart';
import 'package:one_aviation/src/common/widgets/text_fields/rounded_text_field.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

import 'bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPressed = false;
  bool _isLoading = false;
  bool _isObscure = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is LoginLoading) {
              setState(() => _isLoading = true);
            } else {
              setState(() => _isLoading = false);
            }

            if (state is LoginSuccessful) {
              // Navigator.pushReplacementNamed(
              //   context,
              //   NavigationRoute,
              // );
              _usernameController.clear();
              _passwordController.clear();
              // setState(() => _showError = false);
            } else if (state is LoginUnsuccessful) {
              // setState(() {
              //   _showError = true;
              //   _errorMessage = state.errorMessage;
              // });
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
                      'Welcome,',
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
                      'sign in to continue!',
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
                                hintText: 'username',
                                icon: Icons.person,
                                controller: _usernameController,
                                keyboardType: TextInputType.emailAddress,
                                validator: MultiValidator([
                                  requiredValidator,
                                  phoneEmailValidator,
                                ]),
                              ),
                              RoundedTextField(
                                hintText: 'password',
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
                              SizedBox(height: 20),
                              PinkRoundedButton(
                                title: 'SIGN IN',
                                onTap: _isPressed
                                    ? null
                                    : () {
                                        setState(() {
                                          _isPressed = true;
                                        });

                                        if (formkey.currentState!.validate()) {
                                          FocusScope.of(context).unfocus();
                                          // context.read<AuthBloc>().add(
                                          //       Login(
                                          //         email: _firstController.text,
                                          //         password:
                                          //             _secondController.text,
                                          //       ),
                                          //     );

                                        }
                                        setState(() {
                                          _isPressed = false;
                                        });
                                      },
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/reset_password',
                                      );
                                    },
                                    child: Text(
                                      'Forgot password?',
                                      style: MyTextStyle.googleFontWrapper(
                                        MyTextStyle.TextButtonTextStyle,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/registration',
                                      );
                                    },
                                    child: Text(
                                      'SIGN UP',
                                      style: MyTextStyle.googleFontWrapper(
                                        MyTextStyle.TextButtonTextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
