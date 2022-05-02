class Validator {
  static String? validateName({required String? name}) {
    if (name!.isEmpty) {
      return "Name can't be empty.";
    }

    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return "Enter email first.";
    } else if (!regExp.hasMatch(email)) {
      return "Enter correct email.";
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password!.isEmpty) {
      return "Enter password.";
    } else if (password.length < 6) {
      return "password is too weak.";
    }

    return null;
  }

  static String? validateConfirmPassword(
      {required String? confirmPassword, required String? password}) {
    if (confirmPassword!.isEmpty) {
      return "Confirm your password.";
    }

    if (confirmPassword != password) {
      print(confirmPassword);
      print(password);
      print("Password does not match");
      return "Password does not match";
    }

    return null;
  }
}
