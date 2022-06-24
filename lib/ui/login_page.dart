import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suitmedia_test_flutter_dev/helper/palindrome_check_helper.dart';
import 'package:suitmedia_test_flutter_dev/helper/simple_alert_dialog.dart';
import 'package:suitmedia_test_flutter_dev/ui/home_page.dart';
import 'package:suitmedia_test_flutter_dev/ui/widget/primary_button.dart';
import 'package:suitmedia_test_flutter_dev/ui/widget/primary_textfield.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController(text: '');
  final TextEditingController _palindromeController =
      TextEditingController(text: '');
  final ValueNotifier<bool> _isNameEmpty = ValueNotifier(false);
  final ValueNotifier<bool> _isPalindromeEmpty = ValueNotifier(false);

  bool _validation(String input) {
    if (input.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/images/login_bacground.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 116,
                height: 116,
                decoration: BoxDecoration(
                    color: Colors.grey[300], shape: BoxShape.circle),
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/ic_photo.png'),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.transparent,
                  child: PrimaryTextField(
                    hintText: 'Name',
                    textEditingController: _nameController,
                    onChanged: (value){
                      if (value.isEmpty) {
                        _isNameEmpty.value = true;
                      } else {
                         _isNameEmpty.value = false;
                      }
                    },
                  ),),
              ValueListenableBuilder(
                  valueListenable: _isNameEmpty,
                  builder: (context, bool value, _) {
                    if (value) {
                      return Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(top: 5),
                        child: const Text(
                          'Name is required',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontStyle: FontStyle.italic),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.transparent,
                  child: PrimaryTextField(
                    hintText: 'Palindrome',
                    textEditingController: _palindromeController,
                    onChanged: (value){
                      if (value.isEmpty) {
                         _isPalindromeEmpty.value = true;
                      } else {
                         _isPalindromeEmpty.value = false;
                      }
                    },
                  )),
                   ValueListenableBuilder(
                  valueListenable: _isPalindromeEmpty,
                  builder: (context, bool value, _) {
                    if (value) {
                      return Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(top: 5),
                        child: const Text(
                          'Palindrome is required',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontStyle: FontStyle.italic),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.transparent,
                  child: PrimaryButton(
                      text: 'CHECK',
                      fontSize: 14,
                      onPressed: () {
                        if (_validation(_palindromeController.text)) {
                           _isPalindromeEmpty.value = false;
                          if (PalindromeCheckHelper.checkPalindrome(
                              _palindromeController.text)) {
                            SimpleAlertDialog.showSimpleAlertDialog(
                                context,
                                'Message',
                                'isPalindrome', () {
                              Navigator.pop(context);
                            });
                          } else {
                            SimpleAlertDialog.showSimpleAlertDialog(
                                context,
                                'Message',
                                'not Palindrome', () {
                              Navigator.pop(context);
                            });
                          }
                        } else {
                          _isPalindromeEmpty.value = true;
                        }
                      })),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.transparent,
                  child: PrimaryButton(
                      text: 'NEXT',
                      fontSize: 14,
                      onPressed: () {
                        if (_validation(_nameController.text)) {
                          _isNameEmpty.value = false;
                          Navigator.pushNamed(context, HomePage.routeName,
                              arguments: _nameController.text);
                        } else {
                          // SimpleAlertDialog.showSimpleAlertDialog(
                          //     context, 'Message', 'Name is required', () {
                          //   Navigator.pop(context);
                          // });
                          _isNameEmpty.value = true;
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
