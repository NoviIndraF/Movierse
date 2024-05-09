import 'package:flutter/material.dart';
import 'package:movierse/core/styles/colors.dart';
import 'package:movierse/core/styles/texts.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              bgCard,
              bgDark,
            ], begin: Alignment.topCenter, end: Alignment.center)),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: height / 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/profile.jpeg'),
                            radius: height / 10,
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                          Text(
                            'Novi Indra Fanani',
                            style: titleText,
                          ),
                          Text(
                            'Mobile Developer',
                            style: subtitleText,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height / 2.2),
                    child: Container(
                      color: primaryColor,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: height / 2.6, left: 12, right: 12),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: bgCard,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.all(width / 30),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  HeaderChild(
                                    header: 'Experience',
                                    value: '3+',
                                  ),
                                  HeaderChild(header: 'Project', value: '10+'),
                                  HeaderChild(header: 'IPR', value: '5'),
                                ]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height / 20),
                          child: Column(
                            children: [
                              InfoChild(
                                  width: width,
                                  icon: Icons.email,
                                  data: 'novi.indra1453@gmail.com'),
                              InfoChild(
                                  width: width,
                                  icon: Icons.call,
                                  data: '087721511105'),
                              InfoChild(
                                  width: width,
                                  icon: Icons.link,
                                  data: 'linkedin.com/in/novi-indra-fanani/'),
                              InfoChild(
                                  width: width,
                                  icon: Icons.catching_pokemon,
                                  data: 'github.com/NoviIndraF'),
                              InfoChild(
                                  width: width,
                                  icon: Icons.portrait_outlined,
                                  data: 'intip.in/PortofolioMobileApps'),
                              Padding(
                                padding: EdgeInsets.only(top: height / 30),
                                child: Container(
                                  width: width / 3,
                                  height: height / 20,
                                  decoration: BoxDecoration(
                                    color: accentColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height / 40)),
                                  ),
                                  child: Center(
                                    child: Text('FOLLOW ME',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderChild extends StatelessWidget {
  final String? header;
  final String? value;

  HeaderChild({required this.header, required this.value});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          header ?? '',
          style: subtitleText.copyWith(),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          value ?? '',
          style: titleText.copyWith(
            color: accentColor,
          ),
        )
      ],
    ));
  }
}

class InfoChild extends StatelessWidget {
  final double width;
  final IconData icon;
  final String data;

  InfoChild({required this.width, required this.icon, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 36.0,
            ),
            SizedBox(
              width: width / 20,
            ),
            Text(
              data,
              style: subtitleText,
            )
          ],
        ),
      ),
    );
  }
}
