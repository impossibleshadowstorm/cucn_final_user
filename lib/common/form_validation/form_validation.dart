class FormValidation {
  static String? emptyValidatorFunction(value) {
    if (value!.isEmpty) {
      return "Please enter correct value";
    }
    return null;
  }

  static String? uidValidatorFunction(value) {
    if (value.length != 10) {
      return 'Invalid UID';
    }

    if (!RegExp(r'^[2][3-3]\b').hasMatch(value.substring(0, 2))) {
      return 'Invalid UID';
    }

    if (!['MCA', 'MCC', 'MCI', 'BCA', 'BCU', 'BSC']
        .contains(value.substring(2, 5).toString().toUpperCase())) {
      return 'Invalid UID';
    }

    if (!RegExp(r'^[0-9]{5}$').hasMatch(value.substring(5, 10))) {
      return 'Invalid UID';
    }

    return null;
  }

  static String? passwordValidatorFunction(value) {
    /*
    * r'^
      (?=.*[A-Z])       // should contain at least one upper case
      (?=.*[a-z])       // should contain at least one lower case
      (?=.*?[0-9])      // should contain at least one digit
      (?=.*?[!@#\$&*~]) // should contain at least one Special character
      .{8,}             // Must be at least 8 characters in length
    $
    * */
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return "Password Field is Empty";
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }
}
