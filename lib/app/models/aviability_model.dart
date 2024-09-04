import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(ignoreUnannotated: true)
class Availability {
  String? id;
  @JsonKey(name: 'times')
  String? times;
  @JsonKey(name: 'days')
  String? days;
  @JsonKey(name: 'iconUrl')
  String? iconUrl;
  Availability({this.id});
  factory Availability.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityFromJson(json);
  Map<String, dynamic> toJson() => _$AvailabilityToJson(this);
  factory Availability.fromFirestore(DocumentSnapshot doc) =>
      Availability.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
}

Availability _$AvailabilityFromJson(Map<String, dynamic> json) => Availability()
  ..times = json['times'] as String?
  ..days = json['days'] as String?
  ..iconUrl = json['iconUrl'] as String?;

Map<String, dynamic> _$AvailabilityToJson(Availability instance) =>
    <String, dynamic>{
      'times': instance.times,
      'days': instance.days,
      'iconUrl': instance.iconUrl,
    };
