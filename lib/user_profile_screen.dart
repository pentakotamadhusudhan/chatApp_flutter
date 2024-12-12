import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samplevarun/repo/imageuploadrepo.dart';
import 'package:samplevarun/repo/userrepo.dart';
import 'package:samplevarun/util/base_url.dart';
import 'package:samplevarun/util/custome_text_styles.dart';
import 'package:samplevarun/util/custome_widget.dart';
import 'package:samplevarun/util/staticrepo.dart';

import 'model/getallfriendsmodel.dart';

class UserProfileScreen extends StatefulWidget {
  int friendId;
  UserProfileScreen({required this.friendId, super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Datum? friendData;
  Future<void> getFriendDetails() async {
    friendData = await UserRepo().getFriendByIDRepo(friendID: widget.friendId);
    setState(() {
      friendData;
    });
  }

  @override
  void initState() {
    getFriendDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: friendData == null
          ? CustomWidget().customLoader()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 320,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/chatbg.jpeg"))),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: friendData!.profileImage == null
                                      ? const AssetImage(
                                          'assets/images/google.png')
                                      : NetworkImage(StaticUrl.baseUrl +
                                          friendData!.profileImage!),
                                )),
                            padding: const EdgeInsets.all(8),
                            // child: Image(
                            //   // http://192.168.2.82:8000/media/user_profile/240_F_427269107_D2l6CxNKPAYWIDENuVYJhFvUO12AxLE0.jpg
                            //   image: friendData!.profileImage == null
                            //       ? AssetImage('assets/images/google.png')
                            //       : NetworkImage(StaticUrl.baseUrl+friendData!.profileImage!),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                File? image;
                                // ImagePicker().pickImage(source: ImageSource.)
                                ImageUpload().pickImageRepo(
                                    source: ImageSource.gallery,
                                    id: friendData!.id ?? 0);
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(
                                    color: Colors.grey, shape: BoxShape.circle),
                                child: const Center(
                                    child: Icon(
                                  Icons.edit,
                                  size: 15,
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        '${friendData!.firstName} ${friendData!.lastName}',
                        style: ConstTextStyles.firstNameTextStyle,
                      ),
                      Text(
                        '@${friendData!.username}',
                        style: ConstTextStyles.userNameTextStyle,
                      ),
                      // Text('${friendData!.email}',style: ConstTextStyles.userName,),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'About Me',
                        style: ConstTextStyles.firstNameTextStyle
                            .copyWith(color: Colors.blue, fontSize: 16),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            size: 20,
                          ))
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      '${friendData!.bio}',
                      style: ConstTextStyles.bioTextStyle
                          .copyWith(color: Colors.black),
                    )),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date of Birth',
                        style: ConstTextStyles.firstNameTextStyle
                            .copyWith(color: Colors.blue, fontSize: 16),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            size: 20,
                          ))
                    ],
                  ),
                ),
                // date of birth dob
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      '${StaticReepo().ISTDateFormat(friendData!.dob == null ? "--/--/----" : friendData!.dob!.toString())}',
                      style: ConstTextStyles.bioTextStyle
                          .copyWith(color: Colors.black),
                    )),
              ],
            ),
    );
  }
}
