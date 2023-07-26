import '../Constants/constants.dart';

void loginvalidation() {
  if (loginFormKey.currentState!.validate()) {
    print("Ok");
  } else {
    print("Error");
  }
}

void signupvalidation() {
  if (signupformKey.currentState!.validate()) {
    print("Ok");
  } else {
    print("Error");
  }
}
