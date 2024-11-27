import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sad_project/user_repository/repository.dart';// Import the UserRepository

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserRepository userRepository = UserRepository();

  // Controllers to handle user input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6FF),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 80,
                height: 100,
                child: Image(image: AssetImage('images/Logo2.png')),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Login here',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF7440F8),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Welcome back, you\'ve been missed!',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 25.0),
              Formvalidation(
                emailController: _emailController,
                passwordController: _passwordController,
                userRepository: userRepository,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Formvalidation extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final UserRepository userRepository;

  const Formvalidation({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.userRepository,
  });

  @override
  FormValidationState createState() => FormValidationState();
}

class FormValidationState extends State<Formvalidation> {
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            width: 330.h,
            child: Column(
              children: [
                TextFormField(
                  controller: widget.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: widget.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  obscureText: !_passwordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15.0),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Forgot Password?',
              textAlign: TextAlign.right,
              style: GoogleFonts.roboto(
                fontSize: 15,
                color: const Color(0xcc7440F8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 25.0),
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    var user = await widget.userRepository.loginUser(
                      widget.emailController.text,
                      widget.passwordController.text,
                    );

                    if (user != null) {
                      Navigator.pushReplacementNamed(context, '/Main');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid credentials')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7440F8),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Login',
                style: GoogleFonts.roboto(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/Register');
            },
            child: Text(
              'Create new account',
              style: GoogleFonts.roboto(
                color: const Color(0xffb5b5b5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
