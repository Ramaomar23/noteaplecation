import 'package:noteaplecation/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _DB;

  Future<Database> get database async {
    if (_DB != null) return _DB!;

    String path = join(await getDatabasesPath(), 'Note.DB');
    _DB = await openDatabase(
      path,
      version: 1,
      onCreate: (_DB, version) async {
        await _DB.execute(
            '''CREATE TABLE Notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT
          )'''
        );
      },
    );
    return _DB!;}
// Insert Notes
  Future <int> InsertNote (Note note) async{
    final DB = await database ;
    return await DB.insert('Notes', note.toMap());
  }
  //Update Notes
   Future <int> UpdateNote (Note note)async {
    final DB = await database;
    return await DB.update('Notes', note.toMap(),
    where: 'id=?' ,whereArgs: [note.id]
    );
   }
 // Delete Notes
Future<int> DeleteNote(int id) async{
  final DB =await database;
  return await DB.delete(
    'Notes',
    where: 'id=?' ,
    whereArgs:[id],
  );
  }
  //get all notes
Future<List<Note>> GetAllNotes()async {
    final DB=await database;
    final result = await DB.query('Notes');
    return  result.map((e)=> Note.fromMap(e)).toList();
  }
}

