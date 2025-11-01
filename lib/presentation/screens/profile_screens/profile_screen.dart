import 'package:docdoc/core/utils/colors.dart';
import 'package:docdoc/logic/user/get/cubit.dart';
import 'package:docdoc/logic/user/get/state.dart';
import 'package:docdoc/presentation/widgets/profile_widgets/info_widget.dart';
import 'package:docdoc/presentation/widgets/profile_widgets/my_appoint_widget.dart';
import 'package:docdoc/presentation/widgets/profile_widgets/profile_options_list.dart';
import 'package:docdoc/presentation/widgets/profile_widgets/profile_pic.dart';
import 'package:docdoc/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../settings_screens/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserCubit userCubit;

  @override
  void initState() {
    super.initState();
    userCubit = UserCubit()..fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: userCubit,
      child: Scaffold(
        backgroundColor: ColorsManager.blue,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                width * 0.05,
                height * 0.07,
                width * 0.05,
                0,
              ),
              child: Column(
                children: [
                  TopBar(
                    showBack: false,
                    text: "Profile",
                    color: ColorsManager.white,
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.settings, color: ColorsManager.white),
                    ),
                  ),
                  SizedBox(height: height * 0.15),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Column(
                        children: [
                          BlocBuilder<UserCubit, UserStates>(
                            builder: (context, state) {
                              if (state is UserLoadingState) {
                                return const CircularProgressIndicator();
                              } else if (state is UserSuccessState) {
                                return InfoWidget(user: state.user);
                              } else if (state is UserErrorState) {
                                return Text(state.errorMessage);
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          SizedBox(height: height * 0.035),
                          const MyAppointWidget(),
                          SizedBox(height: height * 0.001),
                          ProfileOptionsList(),
                        ],
                      ),
                    ),
                  ),
                  const ProfilePic(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}