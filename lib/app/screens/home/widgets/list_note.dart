import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projet/app/modules/home/model/note_model.dart';

class ListNote extends StatelessWidget {
  const ListNote({required this.element});

  final Note element;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                //'Titre',
                element.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                  //'date',
                  '${element.dateTime.day}/${element.dateTime.month + 1}/${element.dateTime.year}',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text(
                //'Contexte',
                element.contenu.toString(),
                style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
              /*
              Image.asset(
                (element.path),
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),*/

              Container(
                child: Hero(
                  tag: element.path,
                  child: Image.file(
                    File(element.path),
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
