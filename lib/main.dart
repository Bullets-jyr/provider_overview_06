import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_overview_06/models/babies.dart';
import 'package:provider_overview_06/models/dog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Dog>(
          create: (context) => Dog(name: 'dog06', breed: 'breed06', age: 3),
        ),
        FutureProvider<int>(
          initialData: 0,
          create: (context) {
            final int dogAge = context.read<Dog>().age;
            final babies = Babies(age: dogAge);
            return babies.getBabies();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Provider 06',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider 06'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // Column위젯의 사이즈의 Children들의 사이즈만큼만 차지하도록 MainAxisSize.min으로 설정하였습니다.
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '- name: ${context.watch<Dog>().name}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            BreedAndAge(),
          ],
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  const BreedAndAge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- breed: ${context.select<Dog, String>((Dog dog) => dog.breed)}',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        Age(),
      ],
    );
  }
}

class Age extends StatelessWidget {
  const Age({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- age: ${context.select<Dog, int>((Dog dog) => dog.age)}',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 10.0),
        Text(
          '- number of babies: ${context.watch<int>()}',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () => context.read<Dog>().grow(),
          child: Text(
            'Grow',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}
