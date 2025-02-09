import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class Validators {
  static validationMobile(String data) {
    if (data.isEmpty || data == '') {
      return 'The phone number is required'.tr;
    } else if (data.length < 8) {
      return 'The phone number must be greater than 8 digits';
    }
  }

  static validationNull(String data, String name) {
    if (data.isEmpty || data == '') {
      return '$name is required'.tr;
    }
  }

  static isEmail(String? email) {
    if (GetUtils.isNull(email) || email!.isEmpty) {
      return 'The field is required.'.tr;
    }
    if (!GetUtils.isEmail(email)) {
      return 'mail is incorrect.'.tr;
    }
  }

  static isLinkUrl(String? email) {
    if (GetUtils.isNull(email) || email!.isEmpty) {
      return 'The field is required.'.tr;
    }
    if (!GetUtils.isURL(email)) {
      return 'Url is incorrect.'.tr;
    }
  }

  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 Characters long'),
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])',errorText: 'passwords must have at least one special character')
  ]);

  static final emaildValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Enter a valid email address'),
  ]);
}

class MultiValidator extends FieldValidator<String?> {
  final List<FieldValidator> validators;
  static String _errorText = '';

  MultiValidator(this.validators) : super(_errorText);

  @override
  bool isValid(value) {
    for (FieldValidator validator in validators) {
      if (validator.call(value) != null) {
        _errorText = validator.errorText;
        return false;
      }
    }
    return true;
  }

  @override
  String? call(dynamic value) {
    return isValid(value) ? null : _errorText;
  }
}
