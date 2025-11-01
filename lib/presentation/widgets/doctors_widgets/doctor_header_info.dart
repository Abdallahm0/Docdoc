import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/utils/colors.dart';
import '../../../data/doctor_model.dart';

class DoctorHeaderInfo extends StatefulWidget {
  final DoctorModel doctor;
  final bool showMessageIcon;

  const DoctorHeaderInfo({
    super.key,
    required this.doctor,
    this.showMessageIcon = false,
  });

  @override
  State<DoctorHeaderInfo> createState() => _DoctorHeaderInfoState();
}

class _DoctorHeaderInfoState extends State<DoctorHeaderInfo> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: widget.showMessageIcon
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.doctor.photo,
                height: 74,
                width: 74,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 74,
                    width: 74,
                    color: Colors.grey[200],
                    child: Icon(Icons.person, color: Colors.grey),
                  );
                },
              ),
            ),
            SizedBox(width: size.width * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doctor.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: size.height * 0.004),
                Text(
                  widget.doctor.specialization!.name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.grey,
                  ),
                ),
                SizedBox(height: size.height * 0.004),
                Text(
                  widget.doctor.gender,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.lightGrey,
                  ),
                ),
                SizedBox(height: size.height * 0.004),

                Row(
                  children: [

                    Text(
                      widget.doctor.degree,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.lightGrey,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset("assets/logos/star.svg", height: 14),

                  ],
                ),
                SizedBox(height: size.height * 0.004),
                Text(
                  '${widget.doctor.city!.name}, ${widget.doctor.city!.governrate!.name}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.lightGrey,
                  ),
                ),
                SizedBox(height: size.height * 0.004),
                Text(
                  'Price : ${widget.doctor.appointPrice} EGP',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.lightGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
        if (widget.showMessageIcon)
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/message-text.svg"),
          ),
      ],
    );
  }
}