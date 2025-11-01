import 'package:docdoc/presentation/screens/home_screens/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/const/images_paths.dart';
import '../../../core/utils/colors.dart';
import '../../../data/notifications_model.dart';
import '../../../logic/user/get/cubit.dart';
import '../../../logic/user/get/state.dart';

class HomeTopWidget extends StatefulWidget {
  const HomeTopWidget({super.key});

  @override
  State<HomeTopWidget> createState() => _HomeTopWidgetState();
}

class _HomeTopWidgetState extends State<HomeTopWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<UserCubit, UserStates>(
              builder: (context, state) {
                final rawName = (state is UserSuccessState)
                    ? state.user.name
                    : '';
                final name = rawName.trim();
                final greeting = name.isEmpty
                    ? 'Hi!\n'
                    : (name.length > 1
                          ? 'Hi ${name[0].toUpperCase()}${name.substring(1)}!\n'
                          : 'Hi ${name.toUpperCase()}!\n');

                return RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: width * 0.045,
                      color: ColorsManager.black,
                    ),
                    children: [
                      TextSpan(text: greeting),
                      TextSpan(
                        text: "How are you today?",
                        style: TextStyle(
                          fontSize: width * 0.03,
                          fontWeight: FontWeight.w400,
                          color: ColorsManager.grey2,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Container(
              width: width * 0.12,
              height: width * 0.12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsManager.white2,
              ),
              child: InkWell(
                onTap: () {
                  List<NotificationsModel> notifications = [
                    NotificationsModel(
                      iconPath: "assets/icons/appoint_ic.svg",
                      type: NotificationType.successed,
                      title: 'Appointment Success',
                      description:
                          'Congratulations - your appointment is confirmed! Were looking forward to meeting with you and helping you achieve your goals.',
                      time: '1h',
                    ),
                    NotificationsModel(
                      iconPath: "assets/icons/calendar_ic.svg",
                      type: NotificationType.changed,
                      title: 'Schedule Changed',
                      description:
                          'You have successfully changed your appointment with Dr. Randy Wigham. Don’t forget to active your reminder.',
                      time: '5h',
                    ),
                    NotificationsModel(
                      iconPath: "assets/icons/vid_ic.svg",
                      type: NotificationType.changed,
                      title: 'Video Call Appointment',
                      description:
                          'Well send you a link to join the call at the booking details, so all you need is a computer or mobile device with a camera and an internet connection.',
                      time: '7h',
                    ),
                    NotificationsModel(
                      iconPath: "assets/icons/appoint_ic.svg",
                      type: NotificationType.cancelled,
                      title: 'Appointment Cancelled ',
                      description:
                          'You have successfully canceled your appointment  with Dr. Randy Wigham. 50% of the funds will be returned to your account.',
                      time: '7h',
                    ),
                    NotificationsModel(
                      iconPath: "assets/icons/wallet_ic.svg",
                      type: NotificationType.changed,
                      title: 'New Payment Added!',
                      description:
                          'Your payment has been successfully linked with Docdoc.',
                      time: '1d',
                    ),
                  ];

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          NotificationsScreen(notifications: notifications),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    ImagesPaths.notification,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
