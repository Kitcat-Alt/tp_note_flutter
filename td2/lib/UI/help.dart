import 'package:flutter/material.dart';
import 'package:td2/api/myApi.dart';

class help extends StatelessWidget{
  help({super.key});

  final MyAPI myAPI = MyAPI();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myAPI.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if(snapshot.data != null){
            return ListView.builder(
                itemCount: snapshot.data?.length??0,
                itemBuilder: (BuildContext context, index){
                  return Card(
                    color: Colors.white,
                    elevation: 7,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.lightBlue,
                        child:  Text(snapshot.data?[index].id.toString()??""
                        ),
                      ),
                      title: Text(snapshot.data?[index].title??""),
                      subtitle: Text(snapshot.data?[index].description??""),

                    ),
                  );
                }
            );
          }
          return Container();
        }
    );
  }
}