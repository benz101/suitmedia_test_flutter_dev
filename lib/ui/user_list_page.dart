import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test_flutter_dev/bloc/event/choosing_user_event.dart';
import 'package:suitmedia_test_flutter_dev/bloc/event/user_event.dart';
import 'package:suitmedia_test_flutter_dev/bloc/handle_api/user_bloc.dart';
import 'package:suitmedia_test_flutter_dev/bloc/handle_local/user_choosed_bloc.dart';
import 'package:suitmedia_test_flutter_dev/bloc/state/user_state.dart';
import 'package:suitmedia_test_flutter_dev/helper/color_helper.dart';
import 'package:suitmedia_test_flutter_dev/helper/simple_alert_dialog.dart';
import 'package:suitmedia_test_flutter_dev/model/user.dart';
import 'package:suitmedia_test_flutter_dev/model/user_choosed.dart';
import 'package:suitmedia_test_flutter_dev/ui/widget/primary_button.dart';

class UserListPage extends StatefulWidget {
  static const routeName = '/userListPage';
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final List<DataUser> _listDataUser = [];
  final ScrollController _scrollController = ScrollController();
  bool _finishPage = false;
  int _currentPage = 1;
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserList());
    context.read<UserBloc>().page = 1;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // if (_finishPage) {
        //   print('false');
        // } else {
        _finishPage = true;
        _currentPage += 1;

        context.read<UserBloc>()
          ..page += 1
          ..add(GetMoreUserList());
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Users',
            style: TextStyle(
                color: ColorHelper.appBar,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
      ),
      child: SafeArea(
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserSuccess) {
              if (_listDataUser.isNotEmpty) {
                _listDataUser.clear();
                _listDataUser.addAll(state.user.data!);
              } else {
                _listDataUser.addAll(state.user.data!);
              }
            }

            if (state is UserMoreSuccess) {
              print('more:' + userToJson(state.user));
              if (state.user.data!.isNotEmpty) {
                _listDataUser.addAll(state.user.data!);
              } else {
                SimpleAlertDialog.showSimpleAlertDialog(
                    context, 'Meesage', 'You have reached the item limit', () {
                  Navigator.pop(context);
                });
              }
            } else {
              _finishPage = true;
            }
          },
          listenWhen: (context, state) {
            if (state is UserSuccess) {
              return true;
            } else if (state is UserMoreSuccess) {
              return true;
            } else {
              return false;
            }
          },
          child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorHelper.primary,),
              );
            } else if (state is UserSuccess ||
                state is UserMoreLoading ||
                state is UserMoreSuccess ||
                state is UserMoreError) {
              return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: _listUser(context, state));
            } else if (state is UserError) {
              return Center(
                child: PrimaryButton(
                    text: 'Try Again', fontSize: 12, onPressed: () {}),
              );
            } else {
              return Container();
            }
          }),
        ),
      ),
    );
  }

  Widget _listUser(
    BuildContext context,
    UserState state,
  ) {
    print('state: $state');
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: ListView.builder(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(15),
          itemCount: _listDataUser.length + 1,
          itemBuilder: (context, index) {
            if (index != _listDataUser.length) {
              String? valueAvatar = _listDataUser[index].avatar;
              return GestureDetector(
                onTap: () {
                  context.read<UserChoosedBloc>()
                    ..userChoosed = UserChoosed(
                        id: _listDataUser[index].id,
                        email: _listDataUser[index].email,
                        firstName: _listDataUser[index].firstName,
                        lastName: _listDataUser[index].lastName,
                        avatar: _listDataUser[index].avatar)
                    ..add(ChooseUser());
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.white,
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[300], shape: BoxShape.circle),
                          child: valueAvatar != null
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage: NetworkImage(valueAvatar),
                                )
                              : Container(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: Container(
                                      color: Colors.transparent,
                                      child: Text(
                                        _listDataUser[index].firstName! +
                                            ' ' +
                                            _listDataUser[index].lastName!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ))),
                              const SizedBox(
                                height: 5,
                              ),
                              Flexible(
                                  child: Container(
                                      color: Colors.transparent,
                                      child: Text(
                                        _listDataUser[index]
                                            .email!
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff686777)),
                                      )))
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              );
            } else {
              // if (state is UserMoreLoading) {
              //   return Container(
              //     width: double.infinity,
              //     height: 80,
              //     color: Colors.transparent,
              //     // child: const Center(
              //     //   child: CircularProgressIndicator(),
              //     // ),
              //   );
              // } else
              if (state is UserMoreError) {
                return Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.transparent,
                  child: PrimaryButton(
                      text: 'Try Again', fontSize: 12, onPressed: () {}),
                );
              } else {
                return Container();
              }
            }
          }),
    );
  }
}
