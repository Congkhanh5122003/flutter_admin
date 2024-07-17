import 'package:flutteradmin/const/const.dart';
import 'package:flutteradmin/view/widgets/text_style.dart';

Widget productImages({required label,onPress}){
  return  "$label".text.bold.color(fontGrey).size(16).makeCentered().box.color(lightGrey).size(100, 100).roundedSM.make(

  );
}