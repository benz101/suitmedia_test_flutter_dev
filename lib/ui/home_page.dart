import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_test_flutter_dev/bloc/handle_local/user_choosed_bloc.dart';
import 'package:suitmedia_test_flutter_dev/helper/color_helper.dart';
import 'package:suitmedia_test_flutter_dev/model/user_choosed.dart';
import 'package:suitmedia_test_flutter_dev/ui/user_list_page.dart';
import 'package:suitmedia_test_flutter_dev/ui/webview_page.dart';
import 'package:suitmedia_test_flutter_dev/ui/widget/primary_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';
  final String name;
  const HomePage({Key? key, required this.name}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserChoosedBloc, UserChoosed>(builder: (context, state) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: GestureDetector(
              child: SvgPicture.asset('assets/images/ic_arrow_left.svg',
                 ),
              onTap: () {
                Navigator.of(context).pop();
              }),
          middle: state.id == 0 && state.firstName!.isEmpty
              ? const Text(
                  'Home',
                  style: TextStyle(
                      color: ColorHelper.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )
              : const Text(''),
        ),
        child: SafeArea(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: BlocBuilder<UserChoosedBloc, UserChoosed>(
                  builder: (context, state) {
                if (state.id == 0 && state.firstName!.isEmpty) {
                  return _emptyUser();
                } else {
                  return _selectedUser(state);
                }
              })),
        ),
      );
    });
  }

  Widget _emptyUser() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          color: Colors.transparent,
          child: const Text(
            'Welcome',
            style: TextStyle(fontSize: 12),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.transparent,
          child: Text(widget.name,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        Expanded(
            child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Container(
                width: 164,
                height: 164,
                decoration: BoxDecoration(
                    color: Colors.grey[300], shape: BoxShape.circle),
                child: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('assets/images/empty_user.png'),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                color: Colors.transparent,
                child: const Text('Select user to show the pofile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff808080))),
              ),
            ],
          ),
        )),
        Container(
            width: double.infinity,
            height: 50,
            color: Colors.transparent,
            child: PrimaryButton(
                text: 'Choose a User',
                fontSize: 14,
                onPressed: () {
                  Navigator.pushNamed(context, UserListPage.routeName);
                })),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget _selectedUser(UserChoosed state) {
    String? valueImage = state.avatar;
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          color: Colors.transparent,
          child: const Text(
            'Welcome',
            style: TextStyle(fontSize: 12),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.transparent,
          child: Text(widget.name,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        Expanded(
            child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Container(
                width: 164,
                height: 164,
                decoration: BoxDecoration(
                    color: Colors.grey[300], shape: BoxShape.circle),
                child: valueImage != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(valueImage),
                      )
                    : Container(),
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                color: Colors.transparent,
                child: Text(state.firstName! + ' ' + state.lastName!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff626166))),
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                color: Colors.transparent,
                child: Text(state.email!.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff626166))),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, WebViewPage.routeName);
                  },
                  child: const Text('website',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: ColorHelper.primary,
                          decoration: TextDecoration.underline)),
                ),
              ),
            ],
          ),
        )),
        Container(
            width: double.infinity,
            height: 50,
            color: Colors.transparent,
            child: PrimaryButton(
                text: 'Choose a User',
                fontSize: 14,
                onPressed: () {
                  Navigator.pushNamed(context, UserListPage.routeName);
                })),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
