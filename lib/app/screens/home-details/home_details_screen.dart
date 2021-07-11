import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projet/app/modules/home/model/note_model.dart';

class HomeScreenDetails extends StatelessWidget {
  const HomeScreenDetails({this.imagePath});
  final imagePath;

  @override
  Widget build(BuildContext context) {
    final Note arguments = ModalRoute.of(context)!.settings.arguments as Note;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        title: Text(
          'MES NOTES',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(arguments.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(arguments.dateTime.toString(),
                style: TextStyle(color: Colors.grey, fontSize: 15)),

            // pour faire de l'espace entre 2 containers
            SizedBox(height: 30),

            Text(arguments.contenu, style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15)),

            SizedBox(height: 30),

            /*
                      Image.asset(
                        (arguments.path),
                          width: 150,
                          height: 150,
                          fit: BoxFit.fill,
                      ),
                         */

            Container(
              child: Hero(
                tag: arguments.path,
                child: Image.file(
                  File(arguments.path),
                  width: 350,
                  height: 250,
                  fit: BoxFit.fill,
                ),
              ),
            ),

          ]),
        ),
      ),
    );
  }
}
