import 'package:docdoc/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../data/notifications_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationsModel notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.fromLTRB(12, 12, 12, 20),
      decoration: BoxDecoration(
        color: notification.isRead ? ColorsManager.white : ColorsManager.white2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // ignore: deprecated_member_use
                  color: notification.iconColor.withOpacity(0.15),
                ),
                child: SvgPicture.asset(
                  notification.iconPath,
                  // ignore: deprecated_member_use
                  color: notification.iconColor,
                ),
              ),

              SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      notification.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 32),
            ],
          ),

          Positioned(
            top: 0,
            right: 0,
            child: Text(
              notification.time,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),

          if (!notification.isRead)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: ColorsManager.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}