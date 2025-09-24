import 'package:flutter/material.dart';
import 'package:noteaplecation/serviec/database_helper.dart';

import '../models/note.dart';
class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final DB_Helper = DatabaseHelper();
  List<Note> notes=[];


  final Titlecontroller =TextEditingController();
  final Contactcontroller= TextEditingController();


  @override
  Future<void>_refreshNotes() async{
    final data =await DB_Helper.GetAllNotes();
    setState(() {
      notes=data;
    });
  }
  void initState(){
    super.initState();
    _refreshNotes();
  }


  Future<void> addNote() async{
    final note= Note(
      title: Titlecontroller.text,
      content: Contactcontroller.text
    );
    await DB_Helper.InsertNote(note);


    Titlecontroller.clear();
    Contactcontroller.clear();
    await _refreshNotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Note Application",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),
      body:Padding(padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            //ادخال البيانات
             TextField(
               controller: Titlecontroller,
               decoration: InputDecoration(
                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              
              label:Text('Title',style: TextStyle(fontSize: 25),),),),

            const SizedBox(height: 20,),
            TextField(
              controller: Contactcontroller,
              maxLines: 3,
              decoration: InputDecoration(

                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
               label: Text("Content",style: TextStyle(fontSize: 25,),
               ),
              prefixIcon: Icon(Icons.notes)),),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed:addNote,
                child:const Text("Add Note"),

            style: ElevatedButton.styleFrom(

                backgroundColor:
                Colors.greenAccent,
                minimumSize: const Size(double.infinity, 50)),),
            SizedBox(height: 10,),

            Expanded(
                child:notes.isEmpty ? const Center(
                  child: Text("No Notes Yet",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15),
                  ),
                )
               : ListView.builder(itemCount:notes.length,
                    itemBuilder:(context, index) {
                  final note =notes[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation:4,
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,vertical: 10),
                    title: Text(
                      note.title,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        fontWeight: FontWeight.bold),),
                    subtitle: Padding(padding: const EdgeInsets.only(top: 6.0),
                    child: Text(note.content,style: TextStyle(
                        color: Colors.grey,fontSize: 16),
                      ),
                    ),

                  trailing: IconButton(
                      onPressed: ()async{
                        await DB_Helper.DeleteNote(note.id!);
                        await _refreshNotes();
                      },
                      icon: Icon(Icons.delete,color: Colors.teal,)),
                  ),
                  );
                    },
                   )),
          ],
        ),
      ),
    );
  }
}
