// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../provider/user.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '', password = '', name = '', age = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Color(0x00181920),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<UserProvider>(builder: (context, value, _) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Create new account!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'please fill in the form to continue',
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) return 'name required';
                          }
                        },
                        onChanged: (value) => name = value,
                        decoration: InputDecoration(
                          fillColor: Colors.grey,
                          border: InputBorder.none,
                          hintText: 'Full Name',
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) return 'Email required';
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Invalid Email';
                            }
                            if (value.length < 5) return 'Invalid Email Length';
                          }
                        },
                        onChanged: (value) => email = value,
                        decoration: const InputDecoration(
                          fillColor: Colors.grey,
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) return 'Phone Number required';
                            if (value.length < 4) {
                              return 'phone number should be a minimum of 4 characters';
                            }
                          }
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey,
                          border: InputBorder.none,
                          hintText: 'Phone Number ',
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) return 'Password required';
                            if (value.length < 4) {
                              return 'Password should be a minimum of 4 characters';
                            }
                          }
                        },
                        obscureText: true,
                        onChanged: (value) => password = value,
                        decoration: const InputDecoration(
                            fillColor: Colors.grey,
                            border: InputBorder.none,
                            hintText: 'Password'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        value.register(context,
                            email: email,
                            password: password,
                            name: name,
                            age: 20);
                      }
                    },
                    child: Ink(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      " have an Account?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    TextButton(
                      child: Text(
                        '  Sign In',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    ));
  }
}
