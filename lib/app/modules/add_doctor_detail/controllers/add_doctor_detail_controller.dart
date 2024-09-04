import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_category.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_model.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/views/pages/edit_image_page.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_category_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';

class AddDoctorDetailController extends GetxController
    with StateMixin<List<DoctorCategory>> {
  //TODO: Implement AddDoctorDetailController

  final count = 0.obs;

  var formkey = GlobalKey<FormState>();
  var doctorName = ''.obs;
  var doctorHospital = ''.obs;
  var shortBiography = ''.obs;

  var certification = ''.obs;
  var yearOfExprience = ''.obs;
  var coachingPhilosophy = ''.obs;
  var days = ''.obs;
  var time = ''.obs;
  var feesPerSession = ''.obs;
  var languageSpoken = ''.obs;
  var personalWebLink = ''.obs;

  DoctorCategory? doctorCategory;
  // Availability? availability;
  Doctor? doctor = Get.arguments;
  var profilePicUrl = ''.obs;
  bool isEdit = false;
  bool isSaveClick = false;

  bool isSportsSelected = false;
  bool isMusicSelected = false;
  bool isCookingSelected = false;
  bool isSelfSelected = false;
  bool ischildSelected = false;
  List interestArea = [];
  List enrollingFor = [];

  RxList coachingStyle = [
    "Virtual",
    "In-person",
    "Both drop down",
  ].obs;

  @override
  void onInit() {
    super.onInit();
    if (doctor != null) {
      isEdit = true;
      profilePicUrl.value = doctor!.doctorPicture!;
      doctorName.value = doctor?.doctorName ?? "";
      doctorHospital.value = doctor?.doctorHospital ?? "";
      shortBiography.value = doctor?.doctorShortBiography ?? "";
      certification.value = doctor?.certification ?? "";
      yearOfExprience.value = doctor?.yearOfExperience ?? "";
      coachingPhilosophy.value = doctor?.coachingPhilosophy ?? "";
      feesPerSession.value = doctor?.feesPerSession ?? "";
      languageSpoken.value = doctor?.languageSpoken ?? "";
      personalWebLink.value = doctor?.personalWebLink ?? "";
      doctorCategory = doctor!.doctorCategory!;
      days.value = doctor?.availability?.days ?? "";
      time.value = doctor?.availability?.times ?? "";
      interestArea = doctor?.interestArea ?? [""];
      update();
    }
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void updateProfilePic(File filePath) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    UserService().updatePhoto(filePath).then((imgUrl) {
      profilePicUrl.value = imgUrl;
      Get.back();
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void toEditProfilePic() {
    Get.to(() => EditImagePage());
  }

  void initDoctorCategory() {
    DoctorCategoryService().getListDoctorCategory().then((doctorCategory) {
      change(doctorCategory, status: RxStatus.success());
    });
  }

  void saveDoctorDetail() async {
    if (formkey.currentState!.validate() && doctorCategory != null) {
      formkey.currentState!.save();
      EasyLoading.show(
          status: 'loading...'.tr, maskType: EasyLoadingMaskType.black);
      try {
        if (isSportsSelected) {
          interestArea.add("Sports");
        }
        if (isMusicSelected) {
          interestArea.add("Music");
        }
        if (isCookingSelected) {
          interestArea.add("Cooking");
        }
        await DoctorService().saveDoctorDetail(
          doctorName: doctorName.value,
          hospital: doctorHospital.value,
          shortBiography: shortBiography.value,
          pictureUrl: profilePicUrl.value,
          doctorCategory: doctorCategory!,
          isUpdate: isEdit,
          certification: certification.value,
          coachingPhilosophy: coachingPhilosophy.value,
          days: days.value,
          feesPerSession: feesPerSession.value,
          interestArea: interestArea,
          languageSpoken: languageSpoken.value,
          personalWebLink: personalWebLink.value,
          time: time.value,
          yearOfExperience: yearOfExprience.value,
        );
        Get.offNamed('/dashboard');
        EasyLoading.dismiss();
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        EasyLoading.dismiss();
      }
    }
  }
}
