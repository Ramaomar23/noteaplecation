class Note{
  // iny? انه ال
  // id
  // اله ما اله قيمة
  final int? id;
  final String title;
  final String content;

  Note ({
    this.id , required this.title , required this.content});

       Map<String , dynamic> toMap(){
      return {
        'id': id,
       'title': title,
       'content':content,
  };
  }
  //take the map from the data base and retrieve map object
  factory Note.fromMap (Map <String , dynamic>map){
     return Note(
       id:map ['id'],
        title:map['title'],
       content: map['content'],
     );
  }
}