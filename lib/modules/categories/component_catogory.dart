import 'package:flutter/material.dart';

import '../../models/category_model.dart';


Widget buildCategoriesScreen(DataListModel dataList) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image.network(
          "${dataList.image}",
          width: 150.0,
          height: 150.0,
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Text(
            "${dataList.name}",
            // maxLines: 1,
            // overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );
}
