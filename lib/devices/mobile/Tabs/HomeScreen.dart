import 'package:athelets/constants.dart';
import 'package:athelets/providers/user_provider.dart';
import 'package:athelets/widgets/CustomTxtField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../Utils/routes_names.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Search Available Users',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  onChanged: (val) {
                    user.setSearchTxt(val);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primary.withOpacity(0.5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primary.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primary.withOpacity(0.5)),
                      ),
                      hintText: 'Type here...',
                      hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                      suffixIcon: Icon(
                        Icons.search,
                        color: primary,
                        size: 20,
                      )),
                ),
              ),
              ListView.builder(
                  itemCount: user.usersList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return user.usersList[index].uid != user.user!.uid
                        ? user.searchTxt!.length < 1 ? GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.arrangeMeeting, arguments: user.usersList[index].uid);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      user.usersList[index]
                                          .profilePicture!),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${user.usersList[index].userName}',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight
                                                  .w600)),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      '${user.usersList[index].email}',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight
                                                  .w400)),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  '(${user.usersList[index].rating})',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: Colors
                                              .grey.shade500)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ) :  user.searchTxt!.length > 0 && user.usersList[index].userName!
                                    .contains(user.searchTxt!)
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, RouteName.arrangeMeeting, arguments: user.usersList[index].uid);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(bottom: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    user.usersList[index]
                                                        .profilePicture!),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${user.usersList[index].userName}',
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    '${user.usersList[index].email}',
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 20,
                                                color: Colors.amber,
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                '(${user.usersList[index].rating})',
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors
                                                            .grey.shade500)),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container()
                        : Container();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
