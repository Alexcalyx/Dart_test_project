
import 'package:flutter/material.dart';

class Person {
  String name;
  String gender;
  int age;
  double height;
  double weight;
  int muscleMass;

  Person({
    required this.name,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.muscleMass,
  });

  int heightScoreCalculator() {
    int heightScore;
    if (height >= 5.5 && height < 6.5)
      heightScore = 5;
    else if ((height >= 6.5 && height < 7) || (height <= 5.4 && height >= 5))
      heightScore = 4;
    else
      heightScore = 3;

    return heightScore;
  }

  int weightScoreCalculator() {
    int weightScore;
    if (weight >= 60 && weight < 80)
      weightScore = 5;
    else if ((weight >= 80 && weight < 90) || (weight < 80 && weight >= 70))
      weightScore = 4;
    else
      weightScore = 3;

    return weightScore;
  }

  int ageScoreCalculator() {
    int ageScore;
    if (age >= 18 && age < 24)
      ageScore = 5;
    else if (age >= 24 && age < 30)
      ageScore = 4;
    else if (age >= 30 && age < 34)
      ageScore = 3;
    else if (age >= 34)
      ageScore = 2;
    else
      ageScore = 1;

    return ageScore;
  }

  int muscleMassScoreCalculator() {
    int muscleMassScore;
    if (muscleMass >= 3)
      muscleMassScore = 5;
    else if (muscleMass == 2)
      muscleMassScore = 4;
    else
      muscleMassScore = 3;

    return muscleMassScore;
  }

  int totalScoreCalculator() {
    int total = heightScoreCalculator() + weightScoreCalculator() + ageScoreCalculator() + muscleMassScoreCalculator();
    return total;
  }

  String get attractivenessMessage {
    int totalScore = totalScoreCalculator();
    String message;

    if (gender.toLowerCase() == 'female') {
      if (totalScore >= 15)
        message = "You're beautiful";
      else if (totalScore < 14 && totalScore >= 12)
        message = "You're pretty";
      else
        message = "You're average";
    } else if (gender.toLowerCase() == 'male') {
      if (totalScore >= 18)
        message = "You're handsome";
      else if (totalScore < 18 && totalScore > 15)
        message = "You're charming ";
      else
        message = "You're average";
    } else {
      message = "Invalid gender";
    }

    return message;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attractiveness Indicator',
      theme: ThemeData(
        fontFamily: 'customFont', colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  String? genderValue;
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController muscleMassController = TextEditingController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attractiveness Indicator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name (名前)',
                  prefixIcon: Icon(Icons.person, color: Colors.redAccent),
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: genderValue,
                items: [
                  DropdownMenuItem<String>(
                    value: 'Male',
                    child: Text('Male (男性)'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Female',
                    child: Text('Female (女性)'),
                  ),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    genderValue = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Gender (性別)',
                  prefixIcon: Icon(Icons.accessibility_new, color: Colors.redAccent),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age (年齢)',
                  prefixIcon: Icon(Icons.calendar_today, color: Colors.redAccent),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (身長)',
                  prefixIcon: Icon(Icons.height, color: Colors.redAccent),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (体重)',
                  prefixIcon: Icon(Icons.line_weight, color: Colors.redAccent),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: muscleMassController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Fitness (健康)',
                  hintText: 'Rate yourself on a scale of 1 to 5',
                  prefixIcon: Icon(Icons.fitness_center, color: Colors.redAccent),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      _calculateAttractiveness();
                    },
                    child: Text('Calculate'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      elevation: 3,
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _calculateAttractiveness() {
    errorMessage = '';

    if (!_validateName(nameController.text)) {
      errorMessage = 'Invalid Name, enter again';
    } else if (genderValue == null) {
      errorMessage = 'Select your Gender';
    } else if (!_validateAge(ageController.text)) {
      errorMessage = 'Invalid Age, should be between 10 and 50';
    } else if (!_validateHeight(heightController.text)) {
      errorMessage = 'Invalid Height, should be between 4 and 8';
    } else if (!_validateWeight(weightController.text)) {
      errorMessage = 'Invalid Weight, should be between 40 and 120';
    } else if (!_validateMuscleMass(muscleMassController.text)) {
      errorMessage = 'Invalid input';
    } else {
      var person = Person(
        name: nameController.text,
        gender: genderValue!.toLowerCase(), // Corrected line
        age: int.parse(ageController.text),
        height: double.parse(heightController.text),
        weight: double.parse(weightController.text),
        muscleMass: int.parse(muscleMassController.text),
      );

      _showResultDialog(person.attractivenessMessage);
    }

    setState(() {});
  }

  bool _validateName(String name) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(name);
  }

  bool _validateAge(String age) {
    int? ageValue = int.tryParse(age);
    return ageValue != null && ageValue >= 10 && ageValue <= 50;
  }

  bool _validateHeight(String height) {
    double? heightValue = double.tryParse(height);
    return heightValue != null && heightValue >= 4 && heightValue <= 8;
  }

  bool _validateWeight(String weight) {
    int? weightValue = int.tryParse(weight);
    return weightValue != null && weightValue >= 40 && weightValue <= 120;
  }

  bool _validateMuscleMass(String muscleMass) {
    int? muscleMassValue = int.tryParse(muscleMass);
    return muscleMassValue != null && muscleMassValue >= 1 && muscleMassValue <= 5;
  }

  void _showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Attractiveness Result'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        );
      },
    );
  }
}
