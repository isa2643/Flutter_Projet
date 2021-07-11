import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:projet/app/modules/home/data/repository/note_repository.dart';
import 'package:projet/app/modules/home/model/note_model.dart';
import 'package:projet/app/screens/home/dialog/camera_dialog.dart';
import 'package:projet/app/screens/home/widgets/list_note.dart';
import 'package:projet/app_routes.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _titreController = TextEditingController();
  final _contenuController = TextEditingController();

  String photo = '';

  List<Note> noteList = [];

  final noteRepository = new NoteRepository();
/*
  final List<Note> noteList = [
    Note(
        title: 'Cours Flutter #33',
        dateTime: DateTime.now(),
        contenu:
            'Ce cours est créé et conçu pour les nouveaux développeurs Flutter! Nous allons expliquer tous les widgets de base dans Flutter et Dart et vous serez en mesure de créer votre propre application à la fin. Ce cours est très facile à comprendre pour les nouveaux programmeurs et il est spécialement conçu à cet effet. Je suis sûr que vous aimerez Flutter et Dart! ',
        path: 'assets/images/owl.jpg'),
    Note(
        title: 'Cours Java #32',
        dateTime: DateTime.now(),
        contenu:
            'Il ne présuppose pas de connaissance préalable. Les aspects plus avancés (programmation orientée objet) sont donnés dans un cours suivant, «Introduction à la programmation orientée objet (en Java)». Il s appuie  sur de nombreux éléments pédagogiques : vidéos sous-titrées, quizz dans et hors vidéos, exercices, devoirs notés automatiquement, notes de cours',
        path: 'assets/images/fox.jpg'),
  ];*/

  navigateToDetails({required Note arguments, required int position}) {
    Navigator.pushNamed(context, kHomeDetailRoute, arguments: arguments);
  }

  @override
  void initState() {
    super.initState();
    derniereNoteAjoutee();
  }

  derniereNoteAjoutee() async {
    var noteListDB = await noteRepository.retrieve();
    setState(() {
      noteList = noteListDB;
    });
  }

  void ajouterNote() async {

    await Future.delayed(const Duration(seconds: 3), () => "3");

    Note nSave = new Note(
      title: _titreController.text,
      dateTime: DateTime.now(),
      contenu: _contenuController.text,
      path: photo,
    );

    print(nSave.toJson().toString());

    noteRepository.saveNote(nSave);

    noteList.add(nSave);

    derniereNoteAjoutee();

  }

  Future _showMyDialog() async {
    XFile? res = await showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: CircleBorder(),
          child: Padding(
              padding: const EdgeInsets.all(8.0), child: CameraDialog()),
        );
      },
    );
    if (res != null) {
      print(res.path);
      print("PHOTO");
      photo = res.path;
      dernierePhoto(p: res.path);
    }
  }

  dernierePhoto({String p = ""}) {
    print(p);
    setState(() {
      photo = p;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            'MES NOTES',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'NOUVELLE NOTE',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _titreController,
                      decoration: InputDecoration(
                        labelText: 'Titre',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _contenuController,
                      decoration: InputDecoration(
                        labelText: 'Contenu',
                        border: const OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.grey.shade800,
                        shape: BeveledRectangleBorder(),
                      ),
                      onPressed: photo.isEmpty ? _showMyDialog : dernierePhoto,
                      child: Text(
                        photo.isEmpty
                            ? 'Ajouter une image'
                            : 'Supprimer l\'image',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: OutlinedButton(
                        child: Text(' AJOUTER MA NOTE '),
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.grey.shade800,
                          shape: BeveledRectangleBorder(),
                        ),
                        onPressed: ajouterNote),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MES NOTES SAUVEGARDEES',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: noteList.length,
                    itemBuilder: (context, position) {
                      return InkWell(
                        onTap: () => navigateToDetails(
                            arguments: noteList[position], position: position),
                        child: Row(
                          children: [
                            Expanded(
                                child: ListNote(element: noteList[position])),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int position) =>
                        Divider(color: Colors.black, height: 5)),
              ),
            ],
          )
        ]),
      ),
    ));
  }
}
