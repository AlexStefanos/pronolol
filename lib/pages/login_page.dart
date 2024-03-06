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
                          autofocus: true,
                          onChanged: (value) {
                            if (value.length == 1) {
                              pin[0] = value;
                              FocusScope.of(context).nextFocus();
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
                          autofocus: true,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              FocusScope.of(context).previousFocus();
                              pin[1] = '';
                            }
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
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
                          autofocus: true,
                          onSaved: (pin3) {},
                          onChanged: (value) {
                            if (value.isEmpty) {
                              FocusScope.of(context).previousFocus();
                              pin[2] = '';
                            }
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
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
                          autofocus: true,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              FocusScope.of(context).previousFocus();
                              pin[3] = '';
                            }
                            if (value.length == 1) {
                              FocusScope.of(context).unfocus();
                              pin[3] = value;
                            }
                            if (!pin.contains('')) {
                              await User.saveUserPin(pin);
                              if (context.mounted) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));
                              }
                              setState(() {});
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
                    await User.saveUserPin(pin);
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
