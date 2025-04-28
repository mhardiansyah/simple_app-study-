import 'package:app_simple/core/Routing/App_route.dart';
import 'package:app_simple/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f2f2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset('assets/img/traver.png', height: 50),
            Text(
              'Create Account',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(height: 40),
            // TextField(
            //   controller: name,
            //   decoration: InputDecoration(
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.green),
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //     labelText: 'name',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //   ),
            // ),
            SizedBox(height: 16),
            TextField(
              controller: email,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 16),
            // TextField(
            //   controller: confirmPassword,
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.green),
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //     labelText: 'Confirm Password',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                print("register");
                AuthService().register(
                  context,
                  email.text,
                  password.text,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.goNamed(Routes.login),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Text(
                    'Back to Login',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
