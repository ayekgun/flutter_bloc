/*
  YANG MENGURUS KONEKSI KE URL API
*/

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_bloc/src/models/todoModels.dart';
import 'dart:async';

class TodoApiProvider {
  //MEMAANGGIL FUNGSI CLIENT DARI RXDART
  Client client = Client();

  // MEMBUAT VARIABLE _URL YG ISINYA ALAMAT API
  final _url = "http://127.0.0.1:3000/api/";

  // BIKIN FUNGSI  fetchTodoList() BERTIPE FUTURE YG NGE-RETURN TIPE DATA LIST YAITU  <List<Todo>> DARI MODELS
  Future<List<Todo>> fetchTodoList() async {
    print("masuk");

    //BIKIN VARIABLE RESPONSE ISINYA NUNGGU URL DI PROSES
    final response = await client.get(_url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return compute(todoFromJson, response.body);
    } else {
      throw Exception("failed to load");
    }
  }

  Future addTodo(title) async {
    final response = await client.post("$_url/create", body: {'name': title});
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('failed to load');
    }
  }

  Future updateTodo(ids, dons) async {
    print('iniadalah $dons');
    bool _tes = !dons;
    print(_tes);
    final response =
        await client.put("$_url$ids/update", body: {'done': '$_tes'});

    if (response.statusCode == 200) {
      print('update bisa');
      return response;
    } else {
      throw Exception('failed to update');
    }
  }
}
