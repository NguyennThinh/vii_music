class LoginValidator {
  static String? emailValidator(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (email.isEmpty) {
      return "Không được trống";
    } else if (!emailValid) {
      return "Không đúng định dạng";
    } else {
      return null;
    }
  }

  static String? paswordValidator(String pass) {
    if (pass.isEmpty) {
      return "Không được trống";
    } else if (pass.length < 6) {
      return "Lớn hơn hoặc bằng 6 ký tự";
    } else {
      return null;
    }
  }
}
