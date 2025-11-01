import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/app_text_styles.dart';

class PaymentInformationWidget extends StatelessWidget {
  final String method;
  final String? info;
  final String total;
  final String iconPath;

  const PaymentInformationWidget({
    super.key,
    required this.method,
    required this.info,
    required this.total,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    double totalAmount = double.tryParse(total) ?? 0;
    double tax = totalAmount * 0.1;
    double subtotal = totalAmount - tax;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSelectedMethodRow(context),
          const SizedBox(height: 60),

         Text("Payment Info",
         style: TextStyle(
           fontSize: 14,
           fontWeight: FontWeight.w600,
           color: ColorsManager.black,
         ),),

           SizedBox(height: 20),

          _buildSimpleInfoRow(
            label: 'Subtotal',
            value: '\$${subtotal.toStringAsFixed(2)}',
            isLightLabel: true,
          ),
           SizedBox(height: 6),

          _buildSimpleInfoRow(
            label: 'Tax',
            value: '\$${tax.toStringAsFixed(2)}',
            isLightLabel: true,
          ),
           SizedBox(height: 20),

          _buildSimpleInfoRow(
            label: 'Payment Total',
            value: '\$${totalAmount.toStringAsFixed(2)}',
            isLightLabel: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedMethodRow(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconPath, height: 36, width: 36),
        const SizedBox(width: 12),
        Text(
          method,
          style: AppTextStyles.title.copyWith(fontSize: 14),
        ),
        const Spacer(),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 80,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(48),
              border: Border.all(
                color: ColorsManager.blue,
                width: 1,
              ),
            ),
            child:  Center(
              child: Text(
                'Change',
                style: TextStyle(
                  color: ColorsManager.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleInfoRow({
    required String label,
    required String value,
    required bool isLightLabel,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.title.copyWith(
            fontSize: 14,
            color: isLightLabel ? ColorsManager.lightGrey : ColorsManager.black,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}