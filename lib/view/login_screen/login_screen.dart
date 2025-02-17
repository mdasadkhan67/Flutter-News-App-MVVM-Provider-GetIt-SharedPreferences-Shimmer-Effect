import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../model/login_model.dart';
import '../../utils/notification_utils.dart';
import '../../routes/app_routes_name.dart';
import '../../utils/widgets/full_width_btn.dart';
import '../../view_model/login_view_model/login_view_model.dart';
import '../../view_model/register_view_model/register_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loginProvider =
        Provider.of<LoginProviderViewModel>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 25.0), // Improved padding
          child: SingleChildScrollView(
            child: Form(
              key: loginProvider.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  // Use a more professional icon
                  Icon(
                    Icons.account_circle_rounded,
                    size: 100,
                    color: Colors
                        .blue[700], // Slightly darker blue for professionalism
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 36, // Increased font size for better visibility
                      fontWeight: FontWeight
                          .w600, // Slightly lighter weight for elegance
                      color: Colors
                          .blue[800], // Darker blue for a more mature look
                    ),
                  ),
                  SizedBox(height: 40),

                  // Email input field with updated design
                  Consumer<LoginProviderViewModel>(
                    builder: (context, value, child) => TextFormField(
                      controller: value.emailTEC,
                      keyboardType: TextInputType.emailAddress,
                      validator: (valvalue) {
                        final emailRegExp = RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                        );
                        if (valvalue == null || valvalue.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        if (!emailRegExp.hasMatch(valvalue)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.blue[600]),
                        prefixIcon: Icon(Icons.mail, color: Colors.blue[600]),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded borders
                          borderSide:
                              BorderSide(color: Colors.blue[300]!, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.blue[800]!, width: 2),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  // Password input field with updated design
                  Consumer<LoginProviderViewModel>(
                    builder: (context, value, child) => TextFormField(
                      controller: loginProvider.passwordTEC,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: value.isPassword ? true : false,
                      validator: (valValue) {
                        if (valValue == null || valValue.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        if (valValue.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.blue[600]),
                        prefixIcon: Icon(Icons.lock, color: Colors.blue[600]),
                        suffixIcon: IconButton(
                          icon: value.isPassword
                              ? Icon(Icons.visibility_off,
                                  color: Colors.blue[600])
                              : Icon(Icons.visibility, color: Colors.blue[600]),
                          onPressed: () {
                            value.setPassword();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.blue[300]!, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.blue[800]!, width: 2),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Login button with professional design
                  Consumer<LoginProviderViewModel>(
                    builder: (context, value, child) =>
                        CurveFullWidthButtonWidget(
                      btnText: "Login",
                      onPressed: () {
                        value.submitForm();
                        if (value.isFormValid) {
                          value
                              .userLogin(
                            LoginModel(
                              email: value.emailTEC.text,
                              password: value.passwordTEC.text,
                            ),
                          )
                              .then((data) {
                            value.clearForm();
                            context.go(AppRouteNames
                                .home); // Navigate to the home screen after successful login
                          }).catchError((error) {
                            NotificationUtils.showFlushbar(
                              context: context,
                              message: error
                                  .toString(), // Show error message in the flushbar
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              icon: Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                            );
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),

                  // Register link with improved text styling
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.black45),
                      ),
                      TextButton(
                        onPressed: () {
                          context.go(AppRouteNames.register);
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    final registerProvider =
        Provider.of<RegisterProvideViewModel>(context, listen: false);
    registerProvider.dispose();
  }
}
