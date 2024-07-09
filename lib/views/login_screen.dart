import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/services/shared.dart';
import 'package:shop_app/views/login/login_cubit.dart';
import 'package:shop_app/views/register_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
          if (state is LoginSuccess) {
            if (state.loginModel.status == true) {
              CacheHelper.saveData('token', state.loginModel.data?.token)
                  .then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              });
            } else {
              Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        'login now to browse our offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter your email";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    label: Text("Email"),
                                    prefixIcon: Icon(Icons.email_outlined)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: LoginCubit.get(context).password,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "password is too short";
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (value) {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        emailController.text,
                                        passwordController.text);
                                  }
                                },
                                decoration: InputDecoration(
                                    label: const Text("Password"),
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    suffixIcon: IconButton(
                                      icon:
                                          Icon(LoginCubit.get(context).suffix),
                                      onPressed: () {
                                        LoginCubit.get(context)
                                            .changePasswordVisibility();
                                      },
                                    )),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              state is LoginLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Container(
                                      width: double.infinity,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          3.0,
                                        ),
                                        color: Colors.blue,
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            LoginCubit.get(context).userLogin(
                                                emailController.text,
                                                passwordController.text);
                                          }
                                        },
                                        child: const Text(
                                          'LOGIN',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Don\'t have an account?'),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterScreen(),
                                            ));
                                      },
                                      child: const Text('REGISTER')),
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
