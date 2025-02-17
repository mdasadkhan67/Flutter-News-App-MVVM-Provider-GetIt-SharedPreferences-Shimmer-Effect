import 'package:flutter/material.dart';
import 'package:news_app/model/login_model.dart';
import '../../model/login_response_model.dart';
import '../../repo/auth_repository.dart';
import '../../services/shared_preferences.dart';

class LoginProviderViewModel with ChangeNotifier {
  AuthRepository authRepository;
  LoginProviderViewModel({required this.authRepository});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

  void submitForm() {
    if (formKey.currentState!.validate()) {
      isFormValid = true;
      notifyListeners();
    } else {
      isFormValid = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailTEC.dispose();
    passwordTEC.dispose();
    super.dispose();
  }

  //sharepref initialization
  final spref = SharedPreferenceHelper();

  //Password Visible and Hide
  var _isPassword = true;
  bool get isPassword => _isPassword;
  void setPassword() {
    _isPassword = !_isPassword;
    notifyListeners();
  }

  //Login API Call
  Future<LoginResponseModel> userLogin(LoginModel data) async {
    try {
      final response = await authRepository.postLoginApi(data.toJson());
      await spref.setString('token', response['token']);
      return LoginResponseModel.fromJson(response);
    } catch (error) {
      throw Exception(error);
    }
  }

  void clearForm() {
    emailTEC = TextEditingController(text: "");
    passwordTEC = TextEditingController(text: "");
  }
}
