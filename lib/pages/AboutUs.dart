import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:roomandu/pages/contributors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';

class AboutUs extends StatefulWidget {
  static const String routeName = '/about-us';

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  final String number = '9823326868';
  final String email = 'SujanLamichhane742@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.only(left: 5, top: 20),
            child: Card(
              color: const Color(0xFFF3F5F7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10.0,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Welcome to the Roomandu Application. Hope you will find room as per the need.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    child: Container(
                      color: const Color(0xFFF3F5F7),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.call),
                              const Text('Call Us ')
                            ],
                          ),
                          Text('$number'),
                        ],
                      ),
                    ),
                    onTap: () => _service.call(number),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Container(
                      color: const Color(0xFFF3F5F7),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.message),
                              const Text('Message Us ')
                            ],
                          ),
                          Text('$number'),
                        ],
                      ),
                    ),
                    onTap: () => _service.sendSms(number),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Container(
                      color: const Color(0xFFF3F5F7),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.mail),
                              const Text('Send Mail ')
                            ],
                          ),
                          Text('$email'),
                        ],
                      ),
                    ),
                    onTap: () => _service.sendEmail(email),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: const Color(0xFFF3F5F7),
                    child: Text(
                      'Contributers',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                      height: 300.0,
                      child: ListView.builder(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          itemCount: Contributors.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Contributor contributor = Contributors[index];
                            return Stack(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      40.0, 5.0, 20.0, 5.0),
                                  height: 170.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        100.0, 20.0, 20.0, 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 120.0,
                                              child: Text(
                                                contributor.name,
                                                style: TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          contributor.description,
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Positioned(
                                    left: 20.0,
                                    top: 15.0,
                                    bottom: 15.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image(
                                        width: 110.0,
                                        image: AssetImage(contributor.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ))
                              ],
                            );
                          })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}

class CallsAndMessagesService {
  void call(String number) => launch('tel:$number');

  void sendSms(String number) => launch('sms:$number');

  void sendEmail(String email) => launch('mailto:$email');
}
