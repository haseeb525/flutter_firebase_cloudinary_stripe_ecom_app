import 'package:ecommerce_admin_app/controllers/auth_service.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sign Up",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                    ),
                    const Text("Create a new Account and get started"),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .9,
                      child: TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? "Please enter email" : null,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          label: Text("Email"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: TextFormField(
                  validator: (value) => value!.length < 8
                      ? "Password must have 8 or more characters"
                      : null,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text("Password"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * .9,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AuthService()
                          .createAccountWithEmail(
                              _emailController.text, _passwordController.text)
                          .then((value) {
                        if (value == "Account Created") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Account Created")));
                          Navigator.restorablePushNamedAndRemoveUntil(
                              context, "/home", (route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              value,
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red.shade400,
                          ));
                        }
                      });
                    }
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Login"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
