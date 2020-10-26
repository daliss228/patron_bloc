import 'package:flutter/material.dart';
import 'package:patron_bloc/Empleado.dart';
import 'package:patron_bloc/EmpleadoBloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final EmpleadoBloc _empleadoBloc = EmpleadoBloc();

  @override
  void dispose() { 
    _empleadoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: _empleadoBloc.empleadoListStream,
          builder: (BuildContext context, AsyncSnapshot<List<Empleado>> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget> [
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Text('${snapshot.data[index].id}'),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${snapshot.data[index].nombre}'),
                            Text('${snapshot.data[index].salario}'),
                          ],
                        )
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.thumb_up),
                          onPressed: () {
                            _empleadoBloc.empleadoSalarioIncrement.add(
                              snapshot.data[index]
                            );
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.thumb_down),
                          onPressed: () {
                            _empleadoBloc.empleadoSalarioDecrementar.add(
                              snapshot.data[index]
                            );
                          }
                        ),
                      ),
                    ]
                  ),
                );
              }
            );
          }
        ),
      ),
    );
  }
}