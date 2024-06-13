import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ManageuserprofileWidget extends StatefulWidget {
  @override
  _ManageuserprofileWidgetState createState() => _ManageuserprofileWidgetState();
}

class _ManageuserprofileWidgetState extends State<ManageuserprofileWidget> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator ManageuserprofileWidget - FRAME

    return Container(
        width: 360,
        height: 800,
        decoration: BoxDecoration(
          color : Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Stack(
            children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(

                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: <Widget>[Container(
                          width: 320,
                          height: 24,
                          decoration: BoxDecoration(

                          ),
                          child: Stack(
                              children: <Widget>[
                                Positioned(
                                    top: 5.333353042602539,
                                    left: 1.1621277332305908,
                                    child:  //Mask holder Template
                                    Container(
                                        width: 316.18145751953125,
                                        height: 13.333351135253906,
                                        child: null
                                    )
                                ),
                              ]
                          )
                      ),
                      ],
                    ),
                  )
              ),Positioned(
                  top: 57,
                  left: 26,
                  child: Text('Profile', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Roboto',
                      fontSize: 30,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),)
              ),Positioned(
                  top: 189,
                  left: 27,
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(38),
                          topRight: Radius.circular(38),
                          bottomLeft: Radius.circular(38),
                          bottomRight: Radius.circular(38),
                        ),
                      ),
                      child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color : Color.fromRGBO(217, 217, 217, 1),
                                      borderRadius : BorderRadius.all(Radius.elliptical(40, 40)),
                                    )
                                )
                            ),Positioned(
                                top: 3.637978807091713e-12,
                                left: 0,
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius : BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40),
                                        bottomLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40),
                                      ),
                                      image : DecorationImage(
                                          image: AssetImage('assets/svgbutton/Keanu1.png'),
                                          fit: BoxFit.fitWidth
                                      ),
                                    )
                                )
                            ),
                          ]
                      )
                  )
              ),Positioned(
                  top: 193,
                  left: 86,
                  child: Container(
                      width: 175,
                      height: 36,

                      child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Text('Keanu', textAlign: TextAlign.left, style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontFamily: 'Roboto',
                                    fontSize: 15,
                                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1
                                ),)
                            ),Positioned(
                                top: 19,
                                left: 0,
                                child: Text('Show Profile', textAlign: TextAlign.left, style: TextStyle(
                                    color: Color.fromRGBO(118, 118, 118, 1),
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1
                                ),)
                            ),
                          ]
                      )
                  )
              ),Positioned(
                  top: 238,
                  left: 14,
                  child: Container(
                      width: 331,
                      height: 0.000013463109098665882,

                      child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Divider(
                                    color: Color.fromRGBO(34, 34, 34, 1),
                                    thickness: 1
                                )

                            ),
                          ]
                      )
                  )
              ),Positioned(
                  top: 238,
                  left: 14,
                  child: Container(
                      width: 331,
                      height: 0.000013463109098665882,

                      child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Divider(
                                    color: Color.fromRGBO(34, 34, 34, 1),
                                    thickness: 1
                                )

                            ),
                          ]
                      )
                  )
              ),Positioned(
                  top: 176,
                  left: 15,
                  child: Container(
                      width: 331,
                      height: 0.000013463109098665882,

                      child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Divider(
                                    color: Color.fromRGBO(34, 34, 34, 1),
                                    thickness: 1
                                )

                            ),
                          ]
                      )
                  )
              ),Positioned(
                  top: 541,
                  left: 20,
                  child: Text('Log out?', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(98, 91, 91, 1),
                      fontFamily: 'Roboto',
                      fontSize: 10,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),)
              ),Positioned(
                  top: 267,
                  left: 14,
                  child: Container(
                      width: 332,
                      height: 256.8938293457031,

                      child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: 0,
                                left: 8,
                                child: Text('Settings', textAlign: TextAlign.left, style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1
                                ),)
                            ),Positioned(
                                top: 56,
                                left: 1,
                                child: Container(
                                    width: 331,
                                    height: 34.89388656616211,

                                    child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                              top: 34.89387130737305,
                                              left: 0,
                                              child: Container(
                                                  width: 331,
                                                  height: 0.000013463109098665882,

                                                  child: Stack(
                                                      children: <Widget>[
                                                        Positioned(
                                                            top: 0,
                                                            left: 0,
                                                            child: Divider(
                                                                color: Color.fromRGBO(34, 34, 34, 1),
                                                                thickness: 1
                                                            )

                                                        ),
                                                      ]
                                                  )
                                              )
                                          ),Positioned(
                                              top: 0,
                                              left: 13,
                                              child: Container(
                                                  width: 313.0769348144531,
                                                  height: 24,

                                                  child: Stack(
                                                      children: <Widget>[
                                                        Positioned(
                                                            top: 0,
                                                            left: 0,
                                                            child:  //Mask holder Template
                                                            Container(
                                                                width: 22.696834564208984,
                                                                height: 24,
                                                                child: null
                                                            )
                                                        ),Positioned(
                                                            top: 2.11328125,
                                                            left: 36,
                                                            child: Text('Personal Information', textAlign: TextAlign.left, style: TextStyle(
                                                                color: Color.fromRGBO(0, 0, 0, 1),
                                                                fontFamily: 'Roboto',
                                                                fontSize: 15,
                                                                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                                                fontWeight: FontWeight.normal,
                                                                height: 1
                                                            ),)
                                                        ),Positioned(
                                                            top: 2.11328125,
                                                            left: 297,
                                                            child:  //Mask holder Template
                                                            Container(
                                                                width: 16.076923370361328,
                                                                height: 17,
                                                                child: null
                                                            )
                                                        ),
                                                      ]
                                                  )
                                              )
                                          ),
                                        ]
                                    )
                                )
                            ),Positioned(
                                top: 113,
                                left: 1,
                                child: Container(
                                    width: 331,
                                    height: 35.953033447265625,

                                    child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                              top: 0,
                                              left: 13,
                                              child:  //Mask holder Template
                                              Container(
                                                  width: 22.696834564208984,
                                                  height: 24,
                                                  child: null
                                              )
                                          ),Positioned(
                                              top: 3.173828125,
                                              left: 0,
                                              child: Container(
                                                  width: 331,
                                                  height: 32.779205322265625,

                                                  child: Stack(
                                                      children: <Widget>[
                                                        Positioned(
                                                            top: 32.77919387817383,
                                                            left: 0,
                                                            child: Container(
                                                                width: 331,
                                                                height: 0.000013463109098665882,

                                                                child: Stack(
                                                                    children: <Widget>[
                                                                      Positioned(
                                                                          top: 0,
                                                                          left: 0,
                                                                          child: Divider(
                                                                              color: Color.fromRGBO(34, 34, 34, 1),
                                                                              thickness: 1
                                                                          )

                                                                      ),
                                                                    ]
                                                                )
                                                            )
                                                        ),Positioned(
                                                            top: 0,
                                                            left: 49,
                                                            child: Text('Login & Security', textAlign: TextAlign.left, style: TextStyle(
                                                                color: Color.fromRGBO(0, 0, 0, 1),
                                                                fontFamily: 'Roboto',
                                                                fontSize: 15,
                                                                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                                                fontWeight: FontWeight.normal,
                                                                height: 1
                                                            ),)
                                                        ),Positioned(
                                                            top: 0,
                                                            left: 310,
                                                            child:  //Mask holder Template
                                                            Container(
                                                                width: 16.076923370361328,
                                                                height: 17,
                                                                child: null
                                                            )
                                                        ),
                                                      ]
                                                  )
                                              )
                                          ),
                                        ]
                                    )
                                )
                            ),Positioned(
                                top: 167,
                                left: 1,
                                child: Container(
                                    width: 331,
                                    height: 35.952415466308594,

                                    child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                              top: 0,
                                              left: 13,
                                              child:  //Mask holder Template
                                              Container(
                                                  width: 22.696834564208984,
                                                  height: 24,
                                                  child: null
                                              )
                                          ),Positioned(
                                              top: 3.171875,
                                              left: 0,
                                              child: Container(
                                                  width: 331,
                                                  height: 32.780540466308594,

                                                  child: Stack(
                                                      children: <Widget>[
                                                        Positioned(
                                                            top: 32.78052520751953,
                                                            left: 0,
                                                            child: Container(
                                                                width: 331,
                                                                height: 0.000013463109098665882,

                                                                child: Stack(
                                                                    children: <Widget>[
                                                                      Positioned(
                                                                          top: 0,
                                                                          left: 0,
                                                                          child: Divider(
                                                                              color: Color.fromRGBO(34, 34, 34, 1),
                                                                              thickness: 1
                                                                          )

                                                                      ),
                                                                    ]
                                                                )
                                                            )
                                                        ),Positioned(
                                                            top: 0.000008190927474061027,
                                                            left: 49,
                                                            child: Text('Notifications', textAlign: TextAlign.left, style: TextStyle(
                                                                color: Color.fromRGBO(0, 0, 0, 1),
                                                                fontFamily: 'Roboto',
                                                                fontSize: 15,
                                                                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                                                fontWeight: FontWeight.normal,
                                                                height: 1
                                                            ),)
                                                        ),Positioned(
                                                            top: 0,
                                                            left: 310,
                                                            child:  //Mask holder Template
                                                            Container(
                                                                width: 16.076923370361328,
                                                                height: 17,
                                                                child: null
                                                            )
                                                        ),
                                                      ]
                                                  )
                                              )
                                          ),
                                        ]
                                    )
                                )
                            ),Positioned(
                                top: 218,
                                left: 0,
                                child: Container(
                                    width: 331,
                                    height: 38.893821716308594,

                                    child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                              top: 38.89380645751953,
                                              left: 0,
                                              child: Container(
                                                  width: 331,
                                                  height: 0.000013463109098665882,

                                                  child: Stack(
                                                      children: <Widget>[
                                                        Positioned(
                                                            top: 0,
                                                            left: 0,
                                                            child: Divider(
                                                                color: Color.fromRGBO(34, 34, 34, 1),
                                                                thickness: 1
                                                            )

                                                        ),
                                                      ]
                                                  )
                                              )
                                          ),Positioned(
                                              top: 0,
                                              left: 14,
                                              child: Container(
                                                  width: 313.0769348144531,
                                                  height: 24,

                                                  child: Stack(
                                                      children: <Widget>[
                                                        Positioned(
                                                            top: 0,
                                                            left: 0,
                                                            child:  //Mask holder Template
                                                            Container(
                                                                width: 22.696834564208984,
                                                                height: 24,
                                                                child: null
                                                            )
                                                        ),Positioned(
                                                            top: 2.11328125,
                                                            left: 36,
                                                            child: Text('Payments', textAlign: TextAlign.left, style: TextStyle(
                                                                color: Color.fromRGBO(0, 0, 0, 1),
                                                                fontFamily: 'Roboto',
                                                                fontSize: 15,
                                                                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                                                fontWeight: FontWeight.normal,
                                                                height: 1
                                                            ),)
                                                        ),Positioned(
                                                            top: 2.11328125,
                                                            left: 297,
                                                            child:  //Mask holder Template
                                                            Container(
                                                                width: 16.076923370361328,
                                                                height: 17,
                                                                child: null
                                                            )
                                                        ),
                                                      ]
                                                  )
                                              )
                                          ),
                                        ]
                                    )
                                )
                            ),
                          ]
                      )
                  )
              ),Positioned(
                  top: 736,
                  left: 0,
                  child: Container(
                      width: 360,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        boxShadow : [BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0,0),
                            blurRadius: 4
                        )],
                        color : Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: 14,
                                left: 262,
                                child: Container(
                                    width: 82,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius : BorderRadius.only(
                                        topLeft: Radius.circular(18),
                                        topRight: Radius.circular(18),
                                        bottomLeft: Radius.circular(18),
                                        bottomRight: Radius.circular(18),
                                      ),
                                      color : Color.fromRGBO(46, 130, 255, 0.10000000149011612),
                                    )
                                )
                            ),Positioned(
                                top: 20,
                                left: 45,
                                child: Container(
                                    width: 246,
                                    height: 24,

                                    child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                              top: 0,
                                              left: 0,
                                              child: Container(
                                                  width: 246,
                                                  height: 24,

                                                  child: Stack(
                                                      children: <Widget>[
                                                        Positioned(
                                                            top: 0,
                                                            left: 82,
                                                            child:  //Mask holder Template
                                                            Container(
                                                                width: 24,
                                                                height: 24,
                                                                child: null
                                                            )
                                                        ),Positioned(
                                                            top: 0,
                                                            left: 222,
                                                            child:  //Mask holder Template
                                                            Container(
                                                                width: 24,
                                                                height: 24,
                                                                child: null
                                                            )
                                                        ),Positioned(
                                                            top: 0,
                                                            left: 164,
                                                            child:  //Mask holder Template
                                                            Container(
                                                                width: 24,
                                                                height: 24,
                                                                child: null
                                                            )
                                                        ),Positioned(
                                                            top: 0,
                                                            left: 0,
                                                            child:  //Mask holder Template
                                                            Container(
                                                                width: 24,
                                                                height: 24,
                                                                child: null
                                                            )
                                                        ),
                                                      ]
                                                  )
                                              )
                                          ),
                                        ]
                                    )
                                )
                            ),Positioned(
                                top: 26,
                                left: 296,
                                child: Text('Profile', textAlign: TextAlign.left, style: TextStyle(
                                    color: Color.fromRGBO(65, 105, 225, 1),
                                    fontFamily: 'SF Pro Display',
                                    fontSize: 11,
                                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1
                                ),)
                            ),
                          ]
                      )
                  )
              ),
            ]
        )
    );
  }
}
