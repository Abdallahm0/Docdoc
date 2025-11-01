import 'package:docdoc/core/helpers/shared_prefs_helper.dart';
import 'package:docdoc/logic/login/cubit.dart';
import 'package:docdoc/presentation/screens/settings_screens/notifications_settings_screen.dart';
import 'package:docdoc/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<Map<String, dynamic>> settingsItems = [
    {
      "icon": "assets/icons/notification.svg",
      "title": "Notifications",
      "screen": NotificationsSettingsScreen()
    },
    {"icon": "assets/icons/faq.svg", "title": "FAQ",},
    {"icon": "assets/icons/lock.svg", "title": "Security"},
    {"icon": "assets/icons/language-square.svg", "title": "Language"},
    {"icon": "assets/icons/logout.svg", "title": "Logout",},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: ColorsManager.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.04,
            size.height * 0.06,
            size.width * 0.04,
            size.height * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(text: "Settings"),
              SizedBox(height: size.height * 0.02),

              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.02,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: settingsItems.length,
                  itemBuilder: (context, index) {
                    final item = settingsItems[index];
                    final isLogout = item["title"] == "Logout";

                    return ListTile(

                      contentPadding: EdgeInsets.zero,
                      leading: SvgPicture.asset(
                        item["icon"]!,
                        width: 24,
                        height: 24,
                        color: isLogout ? Colors.red : ColorsManager.black,
                      ),
                      title: Text(
                        item["title"]!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: isLogout ? Colors.red : Colors.black,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: ColorsManager.black,
                      ),
                      onTap: () async {
                        if (isLogout) {
                          context.read<LoginCubit>().logout();
                          await SharedPrefsHelper().clearRegistrationToken();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/signIn',
                                (route) => false,
                          );
                        } else if (item["screen"] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => item["screen"],
                            ),
                          );
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) =>
                      Divider(
                        color: Colors.grey.withOpacity(0.2),
                        height: 1,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}