// UNTUK MENGATUR DATA



import 'dart:async';
import 'package:flutter_bloc/src/models/todoModels.dart';
import 'package:flutter_bloc/src/resource/todoApiProvider.dart';

class Repository{
  //MEMMANGGIL APIPROVIDER
   final todoApiProvider = TodoApiProvider();
  
  // CONVERT MODEL YANG DIAMBIL
   Future <List<Todo>> fetchAllTodo() => todoApiProvider.fetchTodoList();

   Future addSaveTodo(String title) => todoApiProvider.addTodo(title);
   
   Future updateSaveTodo(String ids, bool dons) => todoApiProvider.updateTodo(ids, dons);
}