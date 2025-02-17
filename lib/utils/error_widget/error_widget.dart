import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorWidget extends StatefulWidget {
  final String errorMessage;
  const ErrorWidget({super.key, required this.errorMessage});

  @override
  State<ErrorWidget> createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<ErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Error Illustration
              Image.asset(
                "assets/images/error.png", // Add an error image in assets
                height: 200,
              ),
              const SizedBox(height: 20),

              // Error Title
              const Text(
                "Oops! Something went wrong",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Error Message
              Text(
                widget.errorMessage.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Retry Button
              ElevatedButton(
                onPressed: () {
                  context.pop(); // Go back to previous screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  "Try Again",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
