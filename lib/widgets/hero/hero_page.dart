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
  List<String> _imgPathList = ['assets/ic_hero.jpg'];

  late TextEditingController _inputFormController;
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

    // 上传图片
    handleUploadImage(_imgPathList[0]);
  }

  @override
  void dispose() {
    super.dispose();
    _inputFormController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('B')),
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(child: _buildContent())),
        ],
      ),
    );
  }

  /// 页面内容
  _buildContent() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 11),
              Text('1'),
              SizedBox(height: 10),
              // 照片
              _buildPhotos(),
              SizedBox(height: 5),
              // 照片提示语
              Opacity(
                opacity: _showPhotoPrompt ? 1 : 0,
                child: Text(
                  '2',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xfff92f30),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 14),
              // 灰色间隔, 因父widget有padding限制, 使用OverflowBox突破限制
              Container(
                width: double.infinity,
                height: 10.0,
                child: OverflowBox(
                  maxWidth: MediaQuery.of(context).size.width,
                  child: Container(width: double.infinity, color: Colors.black26),
                ),
              ),
              SizedBox(height: 11),
              // 金额
              Text('3'),
              SizedBox(height: 10),
              // 金额输入框
              _buildInputForm(),
              SizedBox(height: 5),
              // 金额提示语
              Opacity(
                opacity: _showAmountPrompt ? 1 : 0,
                child: Text(
                  '4',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xfff92f30),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
        SizedBox(height: 31),
        // 下一步按钮
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            gradient: LinearGradient(
              colors: [Color(0xFF1EB6FD), Color(0xFF178FFE)],
            ),
          ),
          child: TextButton(
            style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
            onPressed: _onPressedNext,
            child: Text(
              '5',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 下一步按钮点击事件
  void _onPressedNext() async {
    // 校验表单
    _showPhotoPrompt = _imgPathList.length <= 1;
    _showAmountPrompt = _inputFormController.text.isEmpty;
    if (_showPhotoPrompt || _showAmountPrompt) {
      setState(() {});
      return;
    }

    // 考虑上传失败的情况, 检查图片是否都已上传, 如存在未上传的, 不能创建订单
    if (_uploadImageMap.length != _imgPathList.length - 1) {
      return;
    }

    double totalAmount = 0.0;
    try {
      // 单位转换成分
      totalAmount *= 100;
      totalAmount = totalAmount.roundToDouble();
    } catch (e) {
      debugPrint("totalAmount error: $e");
      return;
    }

    if (totalAmount <= 0) {
      return;
    }
  }

  /// 照片区域
  _buildPhotos() {
    return Container(
      constraints: BoxConstraints.loose(
          Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.4)),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12.0,
        ),
        itemCount: _imgPathList.length,
        itemBuilder: (context, index) {
          return _buildPhotosItem(_imgPathList[index]);
        },
      ),
    );
  }

  /// 照片区域子widget
  _buildPhotosItem(String path) {
    // 添加按钮
    if (path.startsWith("assets")) {
      return GestureDetector(
        onTap: _addPhotoOnTap,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xfff4f4f4),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.all(37),
          child: Hero(tag: 'tag', child: Icon(Icons.clear)),
        ),
      );
    }

    // 照片Item
    return Stack(
      fit: StackFit.expand,
      children: [
        // 照片
        Container(
          decoration: BoxDecoration(
            color: Color(0xfff4f4f4),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Hero(tag: 'tag', child: Image.asset('assets/ic_hero.jpg', fit: BoxFit.contain)),
        ),
        // 删除按钮
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => _deletePhotoOnTap(path),
            child: Icon(Icons.clear),
          ),
        ),
        _getUploadImageStateWidget(path),
      ],
    );
  }

  /// 图片中间状态widget
  Widget _getUploadImageStateWidget(String path) {
    // 已上传
    if (_uploadImageMap.containsKey(path)) {
      return Container();
    }

    // 上传失败
    if (_uploadImageFailList.contains(path)) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 4),
            Text('6', style: TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
      );
    }

    // 上传中loading
    return Center(child: Container(width: 20, height: 20, child: CircularProgressIndicator()));
  }

  /// 添加照片点击事件
  void _addPhotoOnTap() {
    MyRouter.to(
      context,
      Routes.hero_page,
      arguments: {
        "take_photo_call_back": (path) {
          // 接收新增照片, 刷新UI
          addPath(path, refresh: true);
          // 上传图片
          handleUploadImage(path);
        }
      },
    );
  }

  /// 删除照片点击事件
  void _deletePhotoOnTap(String path) {
    if (_isUploading) {
      return;
    }
    deletePath(path, refresh: true);
  }

  /// 添加照片
  void addPath(String path, {bool refresh = false}) {
    _imgPathList.insert(_imgPathList.length - 1, path);
    _showPhotoPrompt = false;
    if (refresh) {
      setState(() {});
    }
  }

  /// 删除照片
  void deletePath(String path, {bool refresh = false}) {
    _uploadImageMap.remove(path);
    _imgPathList.removeWhere((e) => e == path);
    if (refresh) {
      setState(() {});
    }
  }

  /// 金额输入框
  _buildInputForm() {
    return Column(
      children: [
        Row(
          children: [
            // 金额单位暂时固定

            Text(
              '',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _inputFormController,
                focusNode: _focusNode,
                maxLength: 19,
                autofocus: true,
                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter(
                    RegExp("[0-9]"),
                    allow: true,
                  ),
                ],
                decoration: null,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.teal,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 5),
        Container(height: 1, color: Colors.lightGreen),
      ],
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

  /// 处理创建订单
  void handleCreateOrder(double totalAmount) async {}

  /// 上传图片
  void handleUploadImage(String path) async {
    _isUploading = true;

    _isUploading = false;
    setState(() {});
  }

  //-----------
  // late TextEditingController _inputFormController = TextEditingController();
  // bool _showPhotoPrompt = false;
  // bool _showAmountPrompt = false;
  //
  // FocusNode? _focusNode = FocusNode();
  // Map<String, String> _uploadImageMap = {};
  // List<String> _uploadImageFailList = [];
  // bool _isUploading = false;
  // @override
  // void initState() {
  //   super.initState();
  //   initInputFormController();
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('B'),
  //     ),
  //     body: Column(
  //       children: [
  //         Expanded(
  //           child: Column(
  //             children: [
  //               Stack(
  //                 children: [
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       color: Color(0xfff4f4f4),
  //                       borderRadius: BorderRadius.circular(4),
  //                     ),
  //                     child: Hero(
  //                       tag: 'tag',
  //                       child: Image.asset(
  //                         'assets/ic_hero.jpg',
  //                         width: 100,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 30,
  //                   ),
  //                   Positioned(
  //                     top: 0,
  //                     right: 0,
  //                     child: Icon(
  //                       Icons.add,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               TextField(
  //                 controller: _inputFormController,
  //                 focusNode: _focusNode,
  //                 maxLength: 19,
  //                 autofocus: true,
  //                 keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
  //                 inputFormatters: [
  //                   FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),
  //                 ],
  //                 decoration: null,
  //                 style: const TextStyle(
  //                   fontSize: 22,
  //                   color: Colors.teal,
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // void initInputFormController() {
  //   _inputFormController = TextEditingController();
  //   _inputFormController.addListener(() {
  //     if (_showAmountPrompt) {
  //       _showAmountPrompt = _inputFormController.text.isEmpty;
  //       if (!_showAmountPrompt) {
  //         setState(() {});
  //       }
  //     }
  //   });
  // }
}
