
import 'package:docdoc/core/utils/colors.dart';
import 'package:docdoc/core/utils/txt.dart';
import 'package:docdoc/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import '../../../data/notifications_model.dart';
import '../../widgets/home_widgets/notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  final List<NotificationsModel> notifications;

  const NotificationsScreen({super.key, required this.notifications});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<NotificationsModel> notifications;

  @override
  void initState() {
    super.initState();
    notifications = List.from(widget.notifications);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final todayNotifications = notifications.take(3).toList();
    final yesterdayNotifications = notifications.skip(3).toList();

    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(width * 0.016, 60, width * 0.016, 0),
        child: Column(
          children: [
            TopBar(
              text: Txt.notifyTxt,
              color: ColorsManager.black,
              trailing: Container(
                width: 51,
                height: 27,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: ColorsManager.blue,
                ),
                child: Center(
                  child: Text(
                    "${notifications.where((n) => !n.isRead).length} New",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.white,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 16),

            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  width * 0.016,
                  0,
                  width * 0.016,
                  0,
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.lightGrey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            for (var notification in notifications) {
                              notification.isRead = true;
                            }
                          });
                        },
                        child: Text(
                          "Mark all as read",
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorsManager.blue,
                          ),
                        ),
                      ),
                    ],
                  ),

                  ...todayNotifications
                      .map(
                        (notification) =>
                        NotificationItem(notification: notification),
                  )
                      .toList(),

                  SizedBox(height: 16),

                  Text(
                    "Yesterday",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.lightGrey,
                    ),
                  ),

                  SizedBox(height: 16),

                  ...yesterdayNotifications
                      .map(
                        (notification) =>
                        NotificationItem(notification: notification),
                  )
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}