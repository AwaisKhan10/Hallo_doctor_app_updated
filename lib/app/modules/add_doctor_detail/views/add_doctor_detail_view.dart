import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/controllers/add_doctor_detail_controller.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/views/pages/chose_doctor_category_page.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/views/widgets/display_image.dart';
import 'package:hallo_doctor_doctor_app/app/modules/login/views/widgets/submit_button.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';

class AddDoctorDetailView extends GetView<AddDoctorDetailController> {
  AddDoctorDetailController controller = Get.put(AddDoctorDetailController());
  List coachingStyle = [
    "Virtual",
    "In-person",
    "Both drop down",
  ];
  String? selectedValue;
  String? selectedValue2;
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Information'.tr),
        centerTitle: true,
        // actions: [
        //   controller.isEdit == false
        //       ? PopupMenuButton(
        //           icon: Icon(
        //               Icons.menu), //don't specify icon if you want 3 dot menu
        //           color: Colors.blue,
        //           itemBuilder: (context) => [
        //             PopupMenuItem<int>(
        //               value: 0,
        //               child: Text(
        //                 "Logout",
        //                 style: TextStyle(color: Colors.white),
        //               ),
        //             ),
        //           ],
        //           onSelected: (item) {
        //             ProfileController().logout();
        //           },
        //         )
        //       : SizedBox(),
        // ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.formkey,
          child: GetX<AddDoctorDetailController>(
            builder: (controller) => Column(
              children: [
                DisplayImage(
                    imagePath: controller.profilePicUrl.value,
                    onPressed: () {
                      controller.toEditProfilePic();
                    }),
                SizedBox(height: 20),
                // TextFormField(
                //   textInputAction: TextInputAction.next,
                //   onEditingComplete: () {
                //     node.nextFocus();
                //   },
                //   validator: ((value) {
                //     if (value!.length < 3) {
                //       return 'Name must be more than two characters'.tr;
                //     } else {
                //       return null;
                //     }
                //   }),
                //   initialValue: controller.doctor == null
                //       ? ''
                //       : controller.doctorName.value,
                //   onSaved: (name) {
                //     controller.doctorName.value = name!;
                //   },
                //   decoration: InputDecoration(
                //     hintText: 'Full Name'.tr,
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(width: 2),
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20),
                // TextFormField(
                //   textInputAction: TextInputAction.next,
                //   onEditingComplete: () {
                //     node.nextFocus();
                //   },
                //   initialValue: controller.doctor == null
                //       ? ""
                //       : controller.doctorHospital.value,
                //   onSaved: (hospital) {
                //     controller.doctorHospital.value = hospital!;
                //   },
                //   decoration: InputDecoration(
                //     hintText: 'Email Address'.tr,
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(width: 2),
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //     ),
                //   ),
                //   validator: (value) {
                //     if(value == null || value.isEmpty){
                //       return "Please Enter Valid Email";
                //     } else {
                //       return null;
                //     }
                //   },
                // ),
                // SizedBox(height: 20),
                // TextFormField(
                //   maxLines: null,
                //   textInputAction: TextInputAction.next,
                //   validator: (value) {
                //     if (value == null || value.trim().isEmpty) {
                //       return 'Enter Phone Number';
                //     }
                //     return null;
                //   },
                //   onEditingComplete: () {
                //     node.nextFocus();
                //   },
                //   onSaved: (shortBiography) {
                //     controller.shortBiography.value = shortBiography!;
                //   },
                //   initialValue: controller.doctor == null
                //       ? ""
                //       : controller.shortBiography.value,
                //   decoration: InputDecoration(
                //     hintText: 'Phone Number'.tr,

                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(width: 2),
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //     ),
                //   ),
                // ),
                SizedBox(height: 20),
                TextFormField(
                  maxLines: null,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter Age';
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  onSaved: (value) {
                    controller.certification.value = value!;
                  },
                  initialValue: controller.doctor == null
                      ? ""
                      : controller.certification.value,
                  decoration: InputDecoration(
                    hintText: 'Age'.tr,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  maxLines: null,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  onSaved: (value) {
                    controller.yearOfExprience.value = value ?? "";
                  },
                  initialValue: controller.doctor == null
                      ? ""
                      : controller.yearOfExprience.value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter Location';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Location (for selecting nearby coaches)'.tr,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  maxLines: null,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  onSaved: (value) {
                    controller.coachingPhilosophy.value = value ?? "";
                  },
                  initialValue: controller.doctor == null
                      ? null
                      : controller.coachingPhilosophy.value,
                  decoration: InputDecoration(
                    hintText: 'Previous Experience (optional)'.tr,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // TextFormField(
                //   maxLines: null,
                //   textInputAction: TextInputAction.next,
                //   onEditingComplete: () {
                //     node.nextFocus();
                //   },
                //   onSaved: (value) {
                //     controller.feesPerSession.value = value ?? "";
                //   },

                //   initialValue: controller.doctor == null
                //       ? ""
                //       : controller.feesPerSession.value,
                //   decoration: InputDecoration(
                //     hintText: 'Emergency Contact Information (optional)'.tr,
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(width: 2),
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Availability',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLines: null,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        onSaved: (value) {
                          controller.days.value = value ?? "";
                        },
                        initialValue: controller.doctor == null
                            ? ""
                            : controller.days.value,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter Days';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Days'.tr,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextFormField(
                        maxLines: null,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        onSaved: (value) {
                          controller.time.value = value ?? "";
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter Time';
                          }
                          return null;
                        },
                        initialValue: controller.doctor == null
                            ? ""
                            : controller.time.value,
                        decoration: InputDecoration(
                            hintText: 'Times'.tr,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Genre (s) of interest',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                controller.isSaveClick &&
                        (!controller.isCookingSelected ||
                            controller.isMusicSelected ||
                            !controller.isSportsSelected)
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Select minimum 1 Genre (s) of interest',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.red),
                        ))
                    : Container(),
                StatefulBuilder(builder: (context, setState) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '1. Sports',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Checkbox(
                              value: !controller.isEdit
                                  ? controller.isSportsSelected
                                  : controller.interestArea.contains("Sports"),
                              activeColor: Styles.primaryBlueColor,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.isSportsSelected = value;
                                  if (value) {
                                    controller.interestArea.add("Sports");
                                  } else {
                                    controller.interestArea.remove("Sports");
                                  }
                                }
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '2. Music',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Checkbox(
                              value: !controller.isEdit
                                  ? controller.isMusicSelected
                                  : controller.interestArea.contains("Music"),
                              activeColor: Styles.primaryBlueColor,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.isMusicSelected = value;
                                  if (value) {
                                    controller.interestArea.add("Music");
                                  } else {
                                    controller.interestArea.remove("Music");
                                  }
                                }
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '3. Cooking',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Checkbox(
                              value: !controller.isEdit
                                  ? controller.isCookingSelected
                                  : controller.interestArea.contains("Cooking"),
                              activeColor: Styles.primaryBlueColor,
                              onChanged: (value) {
                                controller.isCookingSelected = value ?? false;
                                if (value != null) {
                                  controller.isCookingSelected = value;
                                  if (value) {
                                    controller.interestArea.add("Cooking");
                                  } else {
                                    controller.interestArea.remove("Cooking");
                                  }
                                }
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enrolling for',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                controller.isSaveClick &&
                        (!controller.isCookingSelected ||
                            controller.isMusicSelected ||
                            !controller.isSportsSelected)
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Select minimum 1 Enrolling for',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.red),
                        ))
                    : Container(),
                StatefulBuilder(builder: (context, setState) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '1. Self',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Checkbox(
                              value: !controller.isEdit
                                  ? controller.isSelfSelected
                                  : controller.interestArea.contains("Self"),
                              activeColor: Styles.primaryBlueColor,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.isSelfSelected = value;
                                  if (value) {
                                    controller.interestArea.add("Self");
                                  } else {
                                    controller.interestArea.remove("Self");
                                  }
                                }
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '2. Child',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Checkbox(
                              value: !controller.isEdit
                                  ? controller.ischildSelected
                                  : controller.interestArea.contains("Child"),
                              activeColor: Styles.primaryBlueColor,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.ischildSelected = value;
                                  if (value) {
                                    controller.interestArea.add("Child");
                                  } else {
                                    controller.interestArea.remove("Child");
                                  }
                                }
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: [
                            DropdownMenuItem<String>(
                              value: 'Virtual',
                              child: Text('Virtual'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'In-person',
                              child: Text('In-person'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Both drop down',
                              child: Text('Both drop down'),
                            ),
                          ],
                          hint: Text("Mode of interaction"),
                          value: selectedValue,
                          onChanged: (value) {
                            selectedValue = value;
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: [
                            DropdownMenuItem<String>(
                              value: 'Beginner',
                              child: Text('Beginner'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Intermediate',
                              child: Text('Intermediate'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Advanced',
                              child: Text('Advanced'),
                            ),
                          ],
                          hint: Text("Select"),
                          value: selectedValue2,
                          onChanged: (value) {
                            selectedValue2 = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Color(0xFFF5F6F9),
                  ),
                  onPressed: () {
                    Get.to(
                      () => ChoseDoctorCategoryPage(),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          controller.doctorCategory == null
                              ? 'Chose Category'.tr
                              : controller.doctorCategory!.categoryName!,
                          style: TextStyle(color: Styles.primaryBlueColor),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Styles.primaryBlueColor,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 40,
                ),
                SubmitButton(
                  onTap: () {
                    controller.saveDoctorDetail();
                    // Get.offAll(()=> DashboardView());
                    // Get.offAllNamed('/dashboard');
                  },
                  text: 'Save'.tr,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
