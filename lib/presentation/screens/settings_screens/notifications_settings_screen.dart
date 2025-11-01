import 'package:docdoc/presentation/widgets/custom_switch.dart';
import 'package:docdoc/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/colors.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  final List<Map<String, dynamic>> settingsItems = [
    { "title": "Notification from DocNow", "value" : true},
    { "title": "Sound", "value" : true},
    { "title": "Vibrate", "value" : true},
    { "title": "App Updates", "value" : false},
    { "title": "Special Offers", "value" : true},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
            const TopBar(text: "Notifications"),
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

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      item["title"]!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    trailing: CustomSwitch(value: item["value"],
                        onChanged: (bool newValue) {
                        setState(() {
                          item["value"] = newValue;
                        },);
                      },
                  ),
                        );
                },
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey.withOpacity(0.2),
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}