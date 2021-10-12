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

import 'bloc/auth_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPressed = false;
  bool _isLoading = false;
  bool _showError = false;
  String _errorMessage = '';

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
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is RegistrationLoading) {
              setState(() => _isLoading = true);
            } else {
              setState(() => _isLoading = false);
            }

            if (state is RegistrationSuccessful) {
              _firstNameController.clear();
              _lastNameController.clear();
              _emailController.clear();
              _phoneController.clear();
              _passwordController.clear();
              _confirmPasswordController.clear();
              setState(() => _showError = false);
              Navigator.pop(context);
            } else if (state is RegistrationUnsuccessful) {
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
                                controller: _firstNameController,
                                validator: MultiValidator([
                                  requiredValidator,
                                ]),
                              ),
                              RoundedTextField(
                                hintText: 'last name',
                                icon: Icons.person,
                                controller: _lastNameController,
                                validator: MultiValidator([
                                  requiredValidator,
                                ]),
                              ),
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
                              RoundedTextField(
                                hintText: 'phone number',
                                icon: Icons.phone,
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                validator: MultiValidator([
                                  requiredValidator,
                                  phoneValidator,
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
                                title: 'SIGN UP',
                                onTap: _isPressed
                                    ? null
                                    : () {
                                        setState(() => _isPressed = true);

                                        if (formkey.currentState!.validate()) {
                                          if (_passwordController.text !=
                                              _confirmPasswordController.text) {
                                            setState(() {
                                              _showError = true;
                                              _errorMessage =
                                                  'Passwords are not the same';
                                            });
                                          } else {
                                            FocusScope.of(context).unfocus();
                                            context.read<AuthBloc>().add(
                                                  Register(
                                                    email:
                                                        _emailController.text,
                                                    firstName:
                                                        _firstNameController
                                                            .text,
                                                    lastName:
                                                        _lastNameController
                                                            .text,
                                                    password:
                                                        _passwordController
                                                            .text,
                                                    isMale: true,
                                                    phoneNumber:
                                                        _phoneController.text,
                                                  ),
                                                );
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
        ),
      ),
    );
  }
}
