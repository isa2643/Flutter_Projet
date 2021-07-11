
import 'package:projet/app/modules/home/data/provider/note_db_provider.dart';
import 'package:projet/app/modules/home/model/note_model.dart';

class NoteRepository {
 final dbProvider = NoteDbProvider();

saveNote(Note n) async {
    await dbProvider.insert(n.toJson());
  }

  Future<List<Note>> retrieve() async {
    final List<Map<String, dynamic>> noteList = await dbProvider.query();
    List<Note> newNoteLists =
        noteList.map((e) => Note.fromJson(e)).toList();
    return newNoteLists;
  }

  Future update(Note n) async {
    await dbProvider.update(n.toJson());
  }

  Future supp(int id) async{
    await dbProvider.delete(id);
  }

}
