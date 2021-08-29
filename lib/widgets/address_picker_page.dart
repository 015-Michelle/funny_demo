import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:myproject/data/province_nm.dart';
import 'package:myproject/widgets/picker.dart';

class AddressPickerPage extends StatefulWidget {
  const AddressPickerPage({Key? key}) : super(key: key);

  @override
  _AddressPickerPageState createState() => _AddressPickerPageState();
}

class _AddressPickerPageState extends State<AddressPickerPage> {
  PickerItem showTypeAttr = PickerItem(name: '省+市+县', value: ShowType.pca);
  Result resultAttr = new Result();
  Result result = new Result();
  double barrierOpacityAttr = 0.5;
  bool barrierDismissibleAttr = false;
  bool customerMeta = true;
  PickerItem? themeAttr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('三级地址选择器'),
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: LocationSelector(
                target: Text("${resultAttr.provinceName ?? '省'}",
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                showType: ShowType.p,
                initResult: resultAttr,
                onConfirm: (Result result) {
                  if (result.provinceId != null) {
                    this.setState(() {
                      resultAttr = result;
                    });
                  }
                },
              ),
            ),
            RaisedButton(
              onPressed: () async {
                print("locationCode $resultAttr");
                Result? tempResult = await CityPickers.showFullPageCityPicker(
                    context: context,
                    theme: themeAttr?.value,
                    locationCode:
                        resultAttr.areaId ?? resultAttr.cityId ?? resultAttr.provinceId ?? "110000",
                    showType: showTypeAttr.value,
                    citiesData: citiesDataNm,
                    provincesData: provincesDataNm);
                if (tempResult == null) {
                  return;
                }
                this.setState(() {
                  result = tempResult;
                });
              },
              child: Text("展示city picker"),
            ),
            Text(result.toString() ),
          ],
        ),
      ),
    );
  }
}

class LocationSelector extends StatelessWidget {
  //触发对象
  final Widget target;
  //显示类型
  final ShowType showType;
  //确认
  final ValueChanged<Result> onConfirm;
  //initResult type[Result]
  final Result? initResult;
  LocationSelector(
      {this.showType = ShowType.pca,
      this.initResult,
      required this.target,
      required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        color: Colors.black12,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: target,
      ),
    );
  }
}
