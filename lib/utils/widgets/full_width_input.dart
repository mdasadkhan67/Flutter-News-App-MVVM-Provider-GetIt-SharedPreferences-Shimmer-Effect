import 'package:flutter/material.dart';
import 'package:news_app/view_model/register_view_model/register_view_model.dart';
import 'package:provider/provider.dart';

class InputTextFullWidthWidget extends StatefulWidget {
  final String labelText;
  final Icon prefIconName;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;

  const InputTextFullWidthWidget({
    super.key,
    required this.labelText,
    required this.prefIconName,
    required this.controller,
    required this.keyboardType,
    this.isPassword = false,
  });

  @override
  State<InputTextFullWidthWidget> createState() =>
      _InputTextFullWidthWidgetState();
}

class _InputTextFullWidthWidgetState extends State<InputTextFullWidthWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvideViewModel>(
      builder: (context, registerProvider, child) => TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? registerProvider.isPassword : false,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: widget.prefIconName,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(registerProvider.isPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    registerProvider
                        .setPassword(); // Toggle password visibility
                  },
                )
              : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }

          // Email Validation
          if (widget.keyboardType == TextInputType.emailAddress) {
            final emailRegExp = RegExp(
              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
            );
            if (!emailRegExp.hasMatch(value)) {
              return 'Please enter a valid email address';
            }
          }

          // Password Validation
          if (widget.isPassword) {
            // Example: password should be at least 6 characters long
            if (value.length < 6) {
              return 'Password should be at least 6 characters';
            }
            // Additional password checks (e.g., include a digit, special character) can be added here
          }

          return null; // If validation passes
        },
      ),
    );
  }
}
