import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../model/register_model.dart';
import '../../routes/app_routes_name.dart';
import '../../utils/notification_utils.dart';
import '../../utils/widgets/full_width_btn.dart';
import '../../view_model/register_view_model/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final registerProvider =
        Provider.of<RegisterProvideViewModel>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 25.0), // Adjusted padding
          child: SingleChildScrollView(
            child: Form(
              key: registerProvider.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  // Modern icon
                  Icon(
                    Icons.account_circle_rounded,
                    size: 100,
                    color: Colors
                        .blue[700], // Slightly darker blue for professionalism
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 36, // Larger font size for better visibility
                      fontWeight: FontWeight
                          .w600, // Slightly lighter weight for elegance
                      color: Colors.blue[800], // Darker blue for maturity
                    ),
                  ),
                  SizedBox(height: 40),

                  // Email input field with modern design
                  Consumer<RegisterProvideViewModel>(
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
                              BorderRadius.circular(10), // Rounded corners
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
                  // Password input field with better design
                  Consumer<RegisterProvideViewModel>(
                    builder: (context, value, child) => TextFormField(
                      controller: value.passwordTEC,
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

                  // Register button with more modern design
                  Consumer<RegisterProvideViewModel>(
                    builder: (context, value, child) =>
                        CurveFullWidthButtonWidget(
                      btnText: "Register",
                      onPressed: () {
                        // Validate the form before making the register call
                        registerProvider.submitForm();
                        if (registerProvider.isFormValid) {
                          registerProvider
                              .userRegister(
                            RegisterModel(
                              email: value.emailTEC.text,
                              password: value.passwordTEC.text,
                            ),
                          )
                              .then((data) {
                            context.go(
                                AppRouteNames.home); // Navigate to home screen
                          }).catchError((error) {
                            NotificationUtils.showFlushbar(
                              context: context,
                              message: error.toString(),
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

                  // Login link with better design
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.black45),
                      ),
                      TextButton(
                        onPressed: () {
                          context.go(AppRouteNames.login);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[
                                800], // Slightly darker blue for professionalism
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
}
