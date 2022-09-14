import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mealapp/layout/cubit/cubit.dart';
import 'package:mealapp/models/boardingmodel.dart';
import 'package:mealapp/models/get_favorite_model.dart';
import 'package:mealapp/shared/network/cachehelper.dart';
import 'package:mealapp/style/colors.dart';

import '../../../modules/login/log in.dart';

Widget buildOnBoard(BoardingModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image: AssetImage(model.image)),
      ),
      const SizedBox(
        height: 20.0,
      ),
      Text(
        model.screenTitle,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
      Text(
        model.ScreenBody,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  );
}

TextFormField defaultTextForm({
  required Widget preIcon,
  Widget? suffixIcon,
  required Widget labelText,
  required TextInputType typeKeyboard,
  required TextEditingController controller,
  required String? Function(String?) validate,
   String? Function(String?)? submit,
  bool isPassword=false,
}) {
  return TextFormField(
    obscureText: isPassword,
    controller: controller,
    onFieldSubmitted: submit,
    validator: validate,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      prefixIcon: preIcon,
      label: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
      suffixIcon: suffixIcon,
    ),
    keyboardType: typeKeyboard,
  );
}

void submitBoarding({
  required BuildContext context,
}){

  CacheHelper.setData(key: 'isBoarding', value: true).then((value) {
    navigateAndReplace(
      context: context,
      page:  LogIn(),
    );
  });

}

Future<bool?> toastShow({
  required String text,
  required ToastState state,
}){
 return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state: state),
      textColor: Colors.white,
      fontSize: 16.0
  );

}

enum ToastState{SUCCESS,ERROR,WARNNING}

Color chooseToastColor( {
  required ToastState state,
}){
  Color color;
  switch (state){
    case ToastState.SUCCESS:
      color= Colors.green;
      break;
    case ToastState.ERROR:
      color= Colors.red;
      break;
    case ToastState.WARNNING:
      color= Colors.amber;
      break;
  }
  return color;
}


Widget defaultElevatedButton({
  required Function() pressed,
  required String text,
}) =>
    SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: pressed,
        child: Text(text.toUpperCase()),
      ),
    );

Future navigateAndReplace(
        {required BuildContext context, required Widget page}) =>
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));

Future navigateTo(
    {required BuildContext context, required Widget page}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));


Widget cardInSitting({
  required IconData prefixIcon,
  required String text,
}) {
  return SizedBox(
    width: double.infinity,
    height: 70,
    child: Card(
      color: Colors.grey[50],
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(
          color: Colors.grey
        )
      ),
      //Border.all(color: Colors.black, width: 2,style:BorderStyle.solid),
      child: Row(
        children:[
          const SizedBox(
            width: 5,
          ),
          Icon(prefixIcon),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              text ,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
Widget buildFavoriteAndSearchPage({
  required model,
  required BuildContext context,
  required bool isSearch,
}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(alignment: AlignmentDirectional.bottomEnd, children: [
            Image.network(
              model.image,
              height: 120.0,
              width: 120.0,
            ),
            if(!isSearch)
              if (model.discount != 0)
                Container(
                color: Colors.red,
                child: const Text(
                  "DISCOUNT",
                  style: TextStyle(
                    fontSize: 10,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
          ]),
          Expanded(
            child: Column(
              children: [
                Text(model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                Row(
                  children: [
                    Text("${model.price}",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: defaultColor,
                        )),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if(!isSearch)
                      if (model.discount != 0 &&!isSearch)
                        Text("${model.oldPrice}",
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 3.0,
                          )),
                    const Spacer(),
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        ShopAppCubit.get(context)
                            .changeFavorite(productId: model.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor: ShopAppCubit.get(context).favorite[model.id]==true ? Colors.red : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}