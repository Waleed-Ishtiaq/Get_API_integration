import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:second_api/models/Photos.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<Photos> photolist = [];
Future<List<Photos>> PhotosApi() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    for (var i in data) {
      photolist.add(Photos.fromJson(i));
    }
    return photolist;
  } else {
    return photolist;
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos Api Testing'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: PhotosApi(),
                builder: (context, Snapshot) {
                  return ListView.builder(
                      itemCount: photolist.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                Snapshot.data![index].url.toString()),
                          ),
                          title: Text(
                            Snapshot.data![index].title.toString(),
                          ),
                          subtitle:
                              Text(Snapshot.data![index].albumId.toString()),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
