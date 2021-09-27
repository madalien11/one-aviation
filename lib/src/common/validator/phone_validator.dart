import 'package:form_field_validator/form_field_validator.dart';

class PhoneValidator extends TextFieldValidator {
  PhoneValidator({String errorText = 'Enter a valid phone number'})
      : super(errorText);

  // return false if you want the validator to return error
  // message when the value is empty.
  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    return value == null || value.length < 1
        ? false
        : hasMatch(r'^(\+7|8)(7[0-9][0-9])([0-9]{7})$', value.trim());
  }
}
