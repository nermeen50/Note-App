import 'package:note_app/constant.dart';
import 'package:note_app/models/noteModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._(); //empty constractor
  static final databaseHelper = DatabaseHelper._();
  static Database? _database;
  Future<Database?> get dataBase async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    final path = join(await getDatabasesPath(), 'noteDatabase.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int versin) async {
      await db.execute('''
      CREATE TABLE $tableName (
          $columID  INTEGER PRIMARY KEY  AUTOINCREMENT ,
       $columTitle TEXT NOT NULL,
       $columcontent TEXT NOT NULL
      )
      ''');
    });
  }

  Future insert(NoteModel noteModel) async {
    var client = await dataBase;
    await client!.insert(tableName, noteModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //get  only all row
  Future<List<NoteModel>?> readAllNotes() async {
    var dbClient = await dataBase;
    List<Map> map = await dbClient!.query(tableName);
    List<NoteModel> listUser =
        map.isNotEmpty ? map.map((e) => NoteModel.formJson(e)).toList() : [];

    return listUser;
  }

  Future<void> updateUser(NoteModel noteModel) async {
    var dbClient = await dataBase;
    await dbClient!.update(tableName, noteModel.toJson(),
        where: '$columID = ?', whereArgs: [noteModel.id]);
  }

  Future<void> deleteUser(int id) async {
    var dbClient = await dataBase;
    await dbClient!.delete(tableName, where: '$columID = ?', whereArgs: [id]);
  }
}
