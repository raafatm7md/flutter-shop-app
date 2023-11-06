import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/views/register/register_cubit.dart';

import '../services/shared.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            if (state.registerModel.status == true) {
              CacheHelper.saveData('token', state.registerModel.data?.token)
                  .then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                    (route) => false);
              });
            } else {
              Fluttertoast.showToast(
                  msg: state.registerModel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, state) {
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
                        'REGISTER',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        'register now to browse our offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
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
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter your name";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    label: Text("Name"),
                                    prefixIcon: Icon(Icons.person)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
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
                                obscureText:
                                    RegisterCubit.get(context).password,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "password is too short";
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (value) {},
                                decoration: InputDecoration(
                                    label: const Text("Password"),
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          RegisterCubit.get(context).suffix),
                                      onPressed: () {
                                        RegisterCubit.get(context)
                                            .changePasswordVisibility();
                                      },
                                    )),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter your phone number";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    label: Text("Phone"),
                                    prefixIcon: Icon(Icons.phone)),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              state is RegisterLoading
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
                                            RegisterCubit.get(context)
                                                .userRegister(
                                                    nameController.text,
                                                    emailController.text,
                                                    passwordController.text,
                                                    phoneController.text);
                                          }
                                        },
                                        child: const Text(
                                          'REGISTER',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
