import 'package:flutter/material.dart';
import 'package:news_app/model/register_model.dart';
import 'package:news_app/repo/auth_repository.dart';
import '../../model/register_response_model.dart';
import '../../services/shared_preferences.dart';

class RegisterProvideViewModel with ChangeNotifier {
  AuthRepository authRepository;

  RegisterProvideViewModel({required this.authRepository});

  //SharePreference Instance
  final spref = SharedPreferenceHelper();

  //Password Visibility
  var _isPassword = true;
  bool get isPassword => _isPassword;

  void setPassword() {
    _isPassword = !_isPassword;
    notifyListeners();
  }

  //Form Validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

  void submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      isFormValid = true;
      notifyListeners();
    } else {
      isFormValid = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailTEC.text = "";
    passwordTEC.text = "";
    emailTEC.dispose();
    passwordTEC.dispose();
    super.dispose();
  }

  Future<RegisterResponseModel> userRegister(RegisterModel data) async {
    try {
      final response = await authRepository.postRegisterApi(data.toJson());
      await SharedPreferenceHelper()
          .setInt('id', RegisterResponseModel.fromJson(response).id);
      await SharedPreferenceHelper().setString(
          'token', RegisterResponseModel.fromJson(response).token.toString());
      return RegisterResponseModel.fromJson(response);
    } catch (error) {
      throw Exception(error);
    }
  }
}
