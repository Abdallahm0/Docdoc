import 'doctor_model.dart';

class DoctorsResponse {
  final String message;
  final List<DoctorModel> data;

  DoctorsResponse({
    required this.message,
    required this.data,
  });

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) {
    return DoctorsResponse(
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DoctorModel.fromJson(e))
          .toList()
          ?? [],
    );
  }
}