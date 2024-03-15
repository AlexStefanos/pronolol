import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:pronolol/models/user_model.dart';
import 'package:pronolol/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var pin = ['', '', '', ''];
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();

  /*@override
  void initState() {
    super.initState();
    FocusScope.of(context).requestFocus(focusNode1);
    SystemChannels.textInput.invokeMethod("TextInput.show");
  }*/

  String encryptPassword(List<String> password) {
    var pinFinal = '';
    for (var elem in password) {
      pinFinal += elem;
    }
    final bytes = utf8.encode(pinFinal);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 64,
                        width: 68,
                        child: TextFormField(
                          focusNode: focusNode1,
                          autofocus: true,
                          onChanged: (value) {
                            if (value.length == 1) {
                              pin[0] = value;
                              FocusScope.of(context).requestFocus(focusNode2);
                            } else {
                              pin[0] = '';
                            }
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                          ),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                    SizedBox(
                        height: 64,
                        width: 68,
                        child: TextFormField(
                          focusNode: focusNode2,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              FocusScope.of(context).requestFocus(focusNode1);
                              pin[1] = '';
                            }
                            if (value.length == 1) {
                              FocusScope.of(context).requestFocus(focusNode3);
                              pin[1] = value;
                            }
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                          ),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                    SizedBox(
                        height: 64,
                        width: 68,
                        child: TextFormField(
                          focusNode: focusNode3,
                          onSaved: (pin3) {},
                          onChanged: (value) {
                            if (value.isEmpty) {
                              FocusScope.of(context).requestFocus(focusNode2);
                              pin[2] = '';
                            }
                            if (value.length == 1) {
                              FocusScope.of(context).requestFocus(focusNode4);
                              pin[2] = value;
                            }
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                          ),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                    SizedBox(
                        height: 64,
                        width: 68,
                        child: TextFormField(
                          focusNode: focusNode4,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              FocusScope.of(context).requestFocus(focusNode3);
                              pin[3] = '';
                            }
                            if (value.length == 1) {
                              FocusScope.of(context).unfocus();
                              pin[3] = value;
                            }
                            if (!pin.contains('')) {
                              await User.saveUserPin(encryptPassword(pin));
                              if (User.currentUser != null) {
                                if (context.mounted) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()));
                                }
                                setState(() {});
                              } else {
                                //Create account
                              }
                            }
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                          ),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                  ],
                ),
              ),
            ),
            IconButton.filled(
                onPressed: () async {
                  if (!pin.contains('')) {
                    await User.saveUserPin(encryptPassword(pin));
                    if (context.mounted) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    }
                  }
                },
                icon: const Icon(Icons.check))
          ],
        ));
  }
}
