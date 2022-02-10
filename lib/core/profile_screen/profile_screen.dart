import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstnameController = TextEditingController();

  final TextEditingController _lastnameController = TextEditingController();

  final TextEditingController _emailidController = TextEditingController();

  final TextEditingController _dobController = TextEditingController();

  final TextEditingController _mnoController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    print("Profile screen");
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode()); //remove focus
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 Container(
                   decoration: BoxDecoration(
                     border: Border.all(width: 2.0,color: Colors.black),
                     shape: BoxShape.circle,
                   ),
                   child: Container(
                     height: 80.0.h,
                      width: 80.0.w,
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        "assets/images/circle_avatar.png"
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                 ),
                SizedBox(height: 20.0.h,),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'First Name',
                        controller: _firstnameController,
                      ),
                    ),
                    Expanded(
                    child: CustomTextField(
                      hintText: 'Last Name',
                      controller: _lastnameController,
                    ),),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Email id',
                        controller: _emailidController,
                      ),),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'DOB',
                        readonly: true,
                        onTap: (){
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              //which date will display when user open the picker
                              firstDate: DateTime(1950),
                              //what will be the previous supported year in picker
                              lastDate: DateTime
                                  .now()) //what will be the up to supported date in picker
                              .then((pickedDate) {
                            //then usually do the future job
                            if (pickedDate == null) {
                              //if user tap cancel then this function will stop
                              return;
                            }
                            setState(() {
                              //for rebuilding the ui
                              _dobController.text = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                            });
                          });
                        },
                        controller: _dobController,
                      ),),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Mobile number',
                        controller: _mnoController,
                      ),),
                  ],
                ),
                SizedBox(height: 10.0.h,),
                Container(
                  margin: EdgeInsets.only(left: 40.0.w,right: 40.0.w),
                    child: ElevatedButton(
                        onPressed: (){},
                        child: Text('Save',style: TextStyle(fontSize: 18.0.sp),)
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.hintText, required this.controller, this.readonly = false, this.onTap
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  bool readonly;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0.sp),
        child: TextField(
          controller: controller,
          readOnly: readonly,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        )
    );
  }
}