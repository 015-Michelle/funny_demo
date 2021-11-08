import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myproject/router/my_router.dart';
import 'package:myproject/router/routers.dart';

class HeroPage extends StatefulWidget {
  const HeroPage({Key? key}) : super(key: key);

  @override
  _HeroPageState createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  late TextEditingController _inputFormController = TextEditingController();
  bool _showPhotoPrompt = false;
  bool _showAmountPrompt = false;

  FocusNode? _focusNode = FocusNode();
  Map<String, String> _uploadImageMap = {};
  List<String> _uploadImageFailList = [];
  bool _isUploading = false;
  @override
  void initState() {
    super.initState();
    initInputFormController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('B'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xfff4f4f4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Hero(
                        tag: 'tag',
                        child: Image.asset(
                          'assets/ic_hero.jpg',
                          width: 100,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onTap: () => MyRouter.to(context, Routes.hero_test),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: _inputFormController,
                  focusNode: _focusNode,
                  maxLength: 19,
                  autofocus: true,
                  keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),
                  ],
                  decoration: null,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void initInputFormController() {
    _inputFormController = TextEditingController();
    _inputFormController.addListener(() {
      if (_showAmountPrompt) {
        _showAmountPrompt = _inputFormController.text.isEmpty;
        if (!_showAmountPrompt) {
          setState(() {});
        }
      }
    });
  }
}
