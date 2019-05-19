

import 'package:flutter_bloc/src/models/todoModels.dart';
import 'package:flutter_bloc/src/resource/repository.dart';
import 'package:rxdart/rxdart.dart';

class TodoBloc{
  final _repository = Repository();
  final _todoFetcher = PublishSubject<List<Todo>>();
  final _title = BehaviorSubject<String>();
  final _id = BehaviorSubject<String>();
  final _done = BehaviorSubject<bool>();

  //ketika data baru ada dia tidak repalce semua tinggal nambahin yang ada
  Observable<List<Todo>> get allTodo => _todoFetcher.stream;

  Function(String) get updateTitle =>_title.sink.add;
  Function(String) get getID => _id.sink.add;
  Function(bool) get getDone => _done.sink.add;

  //untuk menampilkan semua data api
  fetchAllTodo() async{
    List<Todo> todo = await _repository.fetchAllTodo();

    //ketika ada data akan menambahkan ke list todo
    _todoFetcher.sink.add(todo);
  }

  addSaveTodo(){
    _repository.addSaveTodo(_title.value);
  }

  updateTodo(){
     print(_done.value);
    // bool _tes = !_done.value;
    // print(_tes);

    // _done.value != _done.value; 

    _repository.updateSaveTodo(_id.value, _done.value );


  }

  //biar ketika ini gak dipake lagi maka akan mematikan fungsinya
  dispose(){
    _todoFetcher.close();
    _title.close();
    _id.close();
    _done.close();
  }
}

final bloc = TodoBloc();