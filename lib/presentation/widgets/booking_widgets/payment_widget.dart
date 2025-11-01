import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/colors.dart';

class PaymentWidget extends StatefulWidget {
  final Function(String method, String? option) onSelectionChanged;

  const PaymentWidget({
    super.key,
    required this.onSelectionChanged,
  });

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  String selectedMainMethod = "Credit Card";
  String? selectedCardOption;

  final List<Map<String, dynamic>> paymentMethods = [
    {
      "label": "Credit Card",
      "icon": "assets/icons/card.svg",
      "options": [
        {"label": "Master Card", "icon": "assets/icons/mastercard.svg"},
        {"label": "American Express", "icon": "assets/icons/ae.svg"},
        {"label": "Capital One", "icon": "assets/icons/capone.svg"},
        {"label": "Barclays", "icon": "assets/icons/bar.svg"},
      ],
    },
    {
      "label": "Bank Transfer",
      "icon": "assets/icons/bank.svg",
      "options": [],
    },
    {
      "label": "PayPal",
      "icon": "assets/icons/paypal.svg",
      "options": [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: paymentMethods.map((method) {
          bool isSelected = selectedMainMethod == method['label'];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedMainMethod = method['label'];
                    selectedCardOption = null;
                  });
                  widget.onSelectionChanged(
                    selectedMainMethod,
                    selectedCardOption,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 9,
                    horizontal: 1,
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(method['icon'], height: 28),
                      const SizedBox(width: 12),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? ColorsManager.blue
                                : ColorsManager.grey,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Center(
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorsManager.blue,
                            ),
                          ),
                        )
                            : null,
                      ),
                      SizedBox(width: size.width * 0.02),
                      Expanded(
                        child: Text(
                          method['label'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isSelected && method['options'].isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 6),
                  child: Column(
                    children:
                    (method['options'] as List<Map<String, String>>)
                        .map((option) {
                      bool isCardSelected =
                          selectedCardOption == option['label'];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCardOption = option['label'];
                          });
                          widget.onSelectionChanged(
                            selectedMainMethod,
                            selectedCardOption,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 12,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(option['icon']!, height: 24),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  option['label']!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: ColorsManager.black,
                                  ),
                                ),
                              ),
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isCardSelected
                                        ? ColorsManager.blue
                                        : ColorsManager.grey,
                                    width: 2,
                                  ),
                                ),
                                child: isCardSelected
                                    ? Center(
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorsManager.blue,
                                    ),
                                  ),
                                )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}