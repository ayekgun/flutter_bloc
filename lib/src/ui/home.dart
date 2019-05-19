
import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/blocs/todoBloc.dart';
import 'package:flutter_bloc/src/models/todoModels.dart';
import 'package:flutter_bloc/src/ui/create.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool val = false;
  @override
  void initState() {
    bloc.fetchAllTodo();
    super.initState();
  }
  dispose(){
    bloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Todo List"),
      ),
      body: StreamBuilder(
        stream: bloc.allTodo,
        builder: (context, AsyncSnapshot<List<Todo>> snapshot){
          if(snapshot.hasData){
            return buildList(snapshot);
          }else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          } return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>Create()
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Widget buildList(AsyncSnapshot<List<Todo>> snapshot){
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index){
        return CheckboxListTile(
          value: snapshot.data[index].done,
          title: Text(snapshot.data[index].name),
          subtitle: Text(snapshot.data[index].id),
          // selected: false,
          onChanged: (bool isChecked)async{
            bloc.getID(snapshot.data[index].id.toString());
            bloc.getDone(snapshot.data[index].done);
            bloc.updateTodo();
            await Future.delayed(const Duration(milliseconds: 200));
            bloc.fetchAllTodo();
          },
        );
      },
    );
  }
}