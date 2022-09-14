import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mealapp/layout/cubit/cubit.dart';
import 'package:mealapp/models/category_model.dart';
import 'package:mealapp/models/home_page.dart';
import 'package:mealapp/style/colors.dart';

Widget homePageShop(
    {required BuildContext context, required HomePageModels model, required CategoryModel dataList}) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data!.banners
              .map(
                (e) => Image(
              image: NetworkImage(
                "${e.image}",
              ),
            ),
          )
              .toList(),
          options: CarouselOptions(
            height: 250.0,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(
              seconds: 1,
            ),
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayInterval: const Duration(
              seconds: 3,
            ),
            reverse: false,
            enableInfiniteScroll: true,
            pauseAutoPlayInFiniteScroll: true,
            viewportFraction: 1.0,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Text(
          "Categories",
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 15.0,
        ),
        //Category
        SizedBox(
          width: double.infinity,
          height: 100.0,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                buildCategoriesPage(dataList.data!.data![index]),
            separatorBuilder: (context, index) => const SizedBox(
              width: 10.0,
            ),
            itemCount: dataList.data!.data!.length,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        const Text(
          "New products",
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 20.0,
        ),
        //Product
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1 / 1.54,
            crossAxisCount: 2,
            children: List.generate(
              model.data!.product.length,
                  (index) => showProductGrid(context: context,product:model.data!.product[index]),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildCategoriesPage(DataListModel dataList) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image.network(
        "${dataList.image}",
        width: 150.0,
        height: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        width: 150.0,
        color: Colors.black.withOpacity(.8),
        child: Text(
          "${dataList.name}",
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}




Widget showProductGrid({required BuildContext context, required Product product}) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(alignment: AlignmentDirectional.bottomEnd, children: [
          Image.network(
            "${product.image}",
            height: 200.0,
            width: double.infinity,
          ),
          if (product.discount != 0)
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("${product.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                      fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text("${product.price}",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: defaultColor,
                      )),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if (product.discount != 0)
                    Text("${product.oldPrice}",
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
                      ShopAppCubit.get(context).changeFavorite(productId: product.id!);

                    },
                    icon:  CircleAvatar(
                      backgroundColor:ShopAppCubit.get(context).favorite[product.id]==true ?Colors.red : Colors.grey,
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
  );
}