import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(child:  MyHomePage())
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc incrementBloc = IncrementBloc();

    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc"),
      ),
      body: Center(
        child: StreamBuilder(
            stream: incrementBloc.output,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot){
              return Text("Tapped ${snapshot.data} times");
            }),
      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            incrementBloc.increment.add(null);
          }),
    );
  }
}



// bloc pattern
class IncrementBloc implements BlocBase{
  int _counter = 0;

//  streams for the counter
  StreamController<int> _counterController = StreamController<int>();
  StreamSink<int> get _add => _counterController.sink;
  Stream<int> get output => _counterController.stream;

//  stream for events
  StreamController _eventController = StreamController();
  StreamSink get increment => _eventController.sink;

  IncrementBloc(){
    _counter = 0;
    _eventController.stream.listen(_onData);
  }


  void _onData(event) {
    _counter += 1;
    _add.add(_counter);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _eventController.close();
    _counterController.close();
  }




  @override
  void addListener(listener) {
    // TODO: implement addListener
  }


  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }


}