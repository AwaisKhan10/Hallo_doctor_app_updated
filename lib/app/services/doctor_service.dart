import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_doctor_app/app/collection/firebase_collection.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_category.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';

class DoctorService {
  //Get list of Doctor schedule base on doctor id
  static Doctor? doctor;
  set currentDoctor(Doctor? doctor) => DoctorService.doctor = doctor;

  Future<List<TimeSlot>> getDoctorTimeSlot(Doctor doctor) async {
    try {
      //List<TimeSlot> listTimeslot = [];
      QuerySnapshot doctorScheduleRef = await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .where('doctorId', isEqualTo: doctor.doctorId)
          .get();

      var listTimeslot = doctorScheduleRef.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['timeSlotId'] = doc.reference.id;
        TimeSlot timeSlot = TimeSlot.fromJson(data);

        return timeSlot;
      }).toList();
      if (doctorScheduleRef.docs.isEmpty) return [];
      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future saveDoctorDetail(
      {required String doctorName,
      required String hospital,
      required String shortBiography,
      required String pictureUrl,
      required DoctorCategory doctorCategory,
      required String certification,
      required String yearOfExperience,
      required String coachingPhilosophy,
      required String days,
      required String time,
      required String feesPerSession,
      required String languageSpoken,
      required String personalWebLink,
      required List interestArea,
      bool isUpdate = false}) async {
    try {
      CollectionReference doctors =
          FirebaseFirestore.instance.collection('Doctors');
      Map<String, dynamic> doctorsData = {
        'doctorName': doctorName,
        'doctorHospital': hospital,
        'doctorBiography': shortBiography,
        'doctorPicture': pictureUrl,
        'doctorCategory': {
          'categoryId': doctorCategory.categoryId,
          'categoryName': doctorCategory.categoryName,
        },
        "certification": certification,
        "yearOfExperience": yearOfExperience,
        "coachingPhilosophy": coachingPhilosophy,
        "feesPerSession": feesPerSession,
        "languageSpoken": languageSpoken,
        "personalWebLink": personalWebLink,
        "interestArea": interestArea,
        "availability": {
          "days": days,
          "times": time,
        },
      };

      if (isUpdate) {
        doctorsData['updatedAt'] = FieldValue.serverTimestamp();
        await doctors.doc(DoctorService.doctor!.doctorId).update(doctorsData);
        await getDoctor(forceGet: true);
      } else {
        doctorsData['doctorBasePrice'] = 10;
        doctorsData['accountStatus'] = 'nonactive';
        doctorsData['createdAt'] = FieldValue.serverTimestamp();
        doctorsData['updatedAt'] = FieldValue.serverTimestamp();
        var doctor = await doctors.add(doctorsData);
        await UserService().setDoctorId(doctor.id);
      }
    } catch (e) {
      print("----------- Data Not Add Errorr ----------- $e");
      return Future.error(e);
    }
  }

// Get doctor and all its property
  Future<Doctor> getDoctorDetail(String doctorId) async {
    // var doctorSnapshot = await FirebaseFirestore.instance
    //     .collection('Doctors')
    //     .doc(doctorId)
    //     .get();
    // Doctor doctor =
    //     Doctor.fromJson(doctorSnapshot.data() as Map<String, dynamic>);
    // doctor.doctorId = doctorId;
    var doctor = await FirebaseCollection().doctorCol.doc(doctorId).get();
    if (doctor.exists) {
      return doctor.data()!;
    } else {
      throw Exception('Doctor data is not found');
    }
  }

  Future<Doctor?> getDoctor({bool forceGet = false}) async {
    try {
      if (DoctorService.doctor != null && forceGet == false) {
        return DoctorService.doctor;
      }

      var doctorId = await UserService().getDoctorId();
      print('doctor id : ' + doctorId.toString());
      var doctorReference = await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(doctorId)
          .get();
      if (!doctorReference.exists) return null;
      print('data doctor : ' + doctorReference.data().toString());
      var data = doctorReference.data() as Map<String, dynamic>;
      data['doctorId'] = doctorId;
      Doctor doctor = Doctor.fromJson(data);
      DoctorService.doctor = doctor;
      DoctorService().currentDoctor = doctor;
      return doctor;
    } catch (e) {
      return null;
    }
  }

  Future<List<Doctor>> getListDoctorByCategory(
      DoctorCategory doctorCategory) async {
    try {
      List<Doctor> listDoctor = [];
      var listDoctorQuery = await FirebaseFirestore.instance
          .collection('Doctors')
          .where('doctorCategory.categoryId',
              isEqualTo: doctorCategory.categoryId)
          .where('accountStatus', isEqualTo: 'active')
          .get();

      if (listDoctorQuery.docs.isEmpty) return [];
      var list = listDoctorQuery.docs.map((doc) {
        var data = doc.data();
        data['doctorId'] = doc.reference.id;
        Doctor doctor = Doctor.fromJson(data);
        listDoctor.add(doctor);
      }).toList();
      print('list doctor : ' + list.toString());
      return listDoctor;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Doctor>> getTopRatedDoctor({int limit = 10}) async {
    try {
      var doctorRef = await FirebaseFirestore.instance
          .collection('Doctors')
          .where('topRated', isEqualTo: true)
          .get();
      print('length : ' + doctorRef.docs.length.toString());
      List<Doctor> listTopRatedDoctor = doctorRef.docs.map((doc) {
        var data = doc.data();
        data['doctorId'] = doc.reference.id;
        Doctor doctor = Doctor.fromJson(data);
        return doctor;
      }).toList();
      return listTopRatedDoctor;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Doctor>> searchDoctor(String doctorName) async {
    try {
      print('doctor name : ' + doctorName);
      if (doctorName.isEmpty) return [];
      var doctorRef = await FirebaseFirestore.instance
          .collection('Doctors')
          .where('doctorName',
              isGreaterThanOrEqualTo: doctorName,
              isLessThan: doctorName.substring(0, doctorName.length - 1) +
                  String.fromCharCode(
                      doctorName.codeUnitAt(doctorName.length - 1) + 1))
          .get();
      List<Doctor> listDoctor = doctorRef.docs.map((doc) {
        var data = doc.data();
        data['doctorId'] = doc.reference.id;
        Doctor doctor = Doctor.fromJson(data);
        return doctor;
      }).toList();
      listDoctor.removeWhere((element) => element.accountStatus != 'active');
      print('data searchnya : ' + listDoctor.toString());
      return listDoctor;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> getUserId(Doctor doctor) async {
    try {
      var user = await FirebaseFirestore.instance
          .collection('Users')
          .where('doctorId', isEqualTo: doctor.doctorId)
          .get();
      print('doc element' + user.docs.length.toString());
      if (user.docs.isEmpty) return '';
      return user.docs.elementAt(0).id;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future updateDoctorBasePrice(int basePrice) async {
    try {
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(doctor!.doctorId)
          .update({'doctorBasePrice': basePrice});
      doctor!.doctorPrice = basePrice;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
