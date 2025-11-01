import 'package:intl/intl.dart';
import '../core/helpers/dio_helper.dart';
import 'doctor_model.dart';
import 'user_model.dart';

enum AppointmentStatus { pending, upcoming, completed, cancelled }

AppointmentStatus appointmentStatusFromString(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return AppointmentStatus.pending;
    case 'upcoming':
      return AppointmentStatus.upcoming;
    case 'completed':
      return AppointmentStatus.completed;
    case 'cancelled':
      return AppointmentStatus.cancelled;
    default:
      return AppointmentStatus.pending;
  }
}

String appointmentStatusToString(AppointmentStatus status) {
  return status.toString().split('.').last;
}

class AppointmentModel {
  final int id;
  final DoctorModel doctor;
  final UserModel patient;
  final DateTime appointmentTime;
  final DateTime appointmentEndTime;
  final AppointmentStatus status;
  final String notes;
  final int appointmentPrice;

  AppointmentModel({
    required this.id,
    required this.doctor,
    required this.patient,
    required this.appointmentTime,
    required this.appointmentEndTime,
    required this.status,
    required this.notes,
    required this.appointmentPrice,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] ?? 0,
      doctor: DoctorModel.fromJson(json['doctor']),
      patient: UserModel.fromJson(json['patient']),
      appointmentTime: DateFormat("EEEE, MMMM d, y h:mm a", "en_US").parse(json['appointment_time']),
      appointmentEndTime: DateFormat("EEEE, MMMM d, y h:mm a", "en_US").parse(json['appointment_end_time']),
      status: appointmentStatusFromString(json['status'] ?? 'pending'),
      notes: json['notes'] ?? '',
      appointmentPrice: json['appointment_price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctor_id': doctor.id,
      'patient_id': patient.id,
      'appointment_time': DioHelper.formatAppointment(appointmentTime),
      'appointment_end_time': DioHelper.formatAppointment(appointmentEndTime),
      'notes': notes,
      'appointment_price': appointmentPrice,
    };
  }

}

class AppointmentsResponse {
  final String message;
  final List<AppointmentModel> data;
  final bool status;
  final int code;

  AppointmentsResponse({
    required this.message,
    required this.data,
    required this.status,
    required this.code,
  });

  factory AppointmentsResponse.fromJson(Map<String, dynamic> json) {
    var list = (json['data'] as List?) ?? [];
    List<AppointmentModel> appointmentsList =
    list.map((e) => AppointmentModel.fromJson(e)).toList();

    return AppointmentsResponse(
      message: json['message'] ?? '',
      data: appointmentsList,
      status: json['status'] ?? false,
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
      'status': status,
      'code': code,
    };
  }
}

class CreateAppointmentResponse {
  final String message;
  final AppointmentModel? data;
  final bool status;
  final int code;

  CreateAppointmentResponse({
    required this.message,
    this.data,
    required this.status,
    required this.code,
  });

  factory CreateAppointmentResponse.fromJson(Map<String, dynamic> json) {
    return CreateAppointmentResponse(
      message: json['message'] ?? '',
      data: json['data'] != null
          ? AppointmentModel.fromJson(json['data'])
          : null,
      status: json['status'] ?? false,
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data?.toJson(),
      'status': status,
      'code': code,
    };
  }
}