// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      doctorId: json['doctorId'] as String?,
      doctorName: json['doctorName'] as String?,
      doctorPicture: json['doctorPicture'] as String?,
      doctorPrice: json['doctorBasePrice'] as int?,
      doctorShortBiography: json['doctorBiography'] as String?,
      certification: json['certification'] as String?,
      yearOfExperience: json['yearOfExperience'] as String?,
      coachingPhilosophy: json['coachingPhilosophy'] as String?,
      feesPerSession: json['feesPerSession'] as String?,
      languageSpoken: json['languageSpoken'] as String?,
      personalWebLink: json['personalWebLink'] as String?,
      availability: json["availability"] == null
          ? null
          : Availability.fromJson(json["availability"] as Map<String, dynamic>),
      doctorCategory: json['doctorCategory'] == null
          ? null
          : DoctorCategory.fromJson(
              json['doctorCategory'] as Map<String, dynamic>),
      doctorHospital: json['doctorHospital'] as String?,
      doctorBalance: json['balance'] as int?,
      accountStatus: json['accountStatus'] as String?,
      interestArea: json['interestArea'] as List?,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'doctorId': instance.doctorId,
      'doctorName': instance.doctorName,
      'doctorPicture': instance.doctorPicture,
      'doctorBasePrice': instance.doctorPrice,
      'doctorBiography': instance.doctorShortBiography,
      'certification': instance.certification,
      'yearOfExperience': instance.yearOfExperience,
      'coachingPhilosophy': instance.coachingPhilosophy,
      'doctorCategory': instance.doctorCategory,
      'availability': instance.availability,
      'doctorHospital': instance.doctorHospital,
      'balance': instance.doctorBalance,
      'accountStatus': instance.accountStatus,
      'feesPerSession': instance.feesPerSession,
      'languageSpoken': instance.languageSpoken,
      'personalWebLink': instance.personalWebLink,
      'interestArea': instance.interestArea,
    };
