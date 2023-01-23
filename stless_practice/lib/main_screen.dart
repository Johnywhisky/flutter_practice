import 'package:flutter/material.dart';
import 'package:flutter_practice/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  // life cycle method
  // 1. 화면이 열릴 때 호출 되는 함수
  @override
  void initState() {
    super.initState();

    loadController();
  }

  // 2. 화면이 닫힐 때 호출 되는 함수
  @override
  void dispose() {
    // saveController();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future saveController() async {
    final height = double.parse(_heightController.text);
    final weight = double.parse(_weightController.text);
    print('height: $height & weight: $weight');

    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('height', height);
    prefs.setDouble('weight', weight);
  }

  Future loadController() async {
    final prefs = await SharedPreferences.getInstance();
    final double? height = prefs.getDouble('height');
    final double? weight = prefs.getDouble('weight');
    print('키: $height, 몸무게: $weight');

    if (height != null && weight != null) {
      _heightController.text = height.toString();
      _weightController.text = weight.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('비만도 계산기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '키',
                ),
                keyboardType: TextInputType.number,
                validator: (String? val) {
                  if (val == null || val.isEmpty) {
                    return '키를 입력하세요';
                  }
                  // validator 결과에 에러가 없을 시 null을 리턴한다.
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '몸무게',
                ),
                keyboardType: TextInputType.number,
                validator: (String? val) {
                  if (val == null || val.isEmpty) {
                    return '몸무게를 입력하세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == false) {
                    return ;
                  }
                  saveController();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        height: double.parse(_heightController.text),
                        weight: double.parse(_weightController.text),
                      ),
                    ),
                  );
                },
                child: const Text('결과'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

