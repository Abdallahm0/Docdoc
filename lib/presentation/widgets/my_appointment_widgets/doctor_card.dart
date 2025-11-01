import 'package:flutter/material.dart';
import '../../../core/utils/colors.dart';

class DoctorAppointmentCard extends StatelessWidget {
  final String doctorName;
  final String specialization;
  final String degree;
  final String city;
  final double price;
  final String imageUrl;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;

  const DoctorAppointmentCard({
    super.key,
    required this.doctorName,
    required this.specialization,
    required this.degree,
    required this.city,
    required this.price,
    this.imageUrl = "https://via.placeholder.com/150",
    this.onEdit,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.02),
      padding: EdgeInsets.symmetric(horizontal:  width * 0.001,vertical: width * 0.02),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  height: height * 0.12,
                  width: height * 0.12,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: height * 0.12,
                      width: height * 0.12,
                      color: Colors.grey[300],
                      child: Icon(Icons.person, size: height * 0.06),
                    );
                  },
                ),
              ),
              SizedBox(width: width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: ColorsManager.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      specialization,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: height * 0.008),
                    Text(
                      '$degree • $city',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.grey,
                      ),
                    ),
                    SizedBox(height: height * 0.008),
                    Text(
                      'Price: $price EGP',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.lightGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.more_vert, size: width * 0.06),
            ],
          ),
          SizedBox(height: height * 0.02),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onCancel ?? () {},
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: height * 0.007),
                    decoration: BoxDecoration(
                      color: ColorsManager.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: ColorsManager.blue),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Cancel Appointment",
                      style: TextStyle(
                        color: ColorsManager.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: width * 0.03),
              Expanded(
                child: InkWell(
                  onTap: onEdit ?? () {},
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: height * 0.007),
                    decoration: BoxDecoration(
                      color: ColorsManager.blue,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Reschedule",
                      style: TextStyle(
                        color: ColorsManager.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}