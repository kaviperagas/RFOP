import 'package:flutter/material.dart';

import 'package:rfop/models/meal.dart';

class Meals with ChangeNotifier {
  final List<Meal> _meals = [
    Meal(
        id: 't1',
        name: 'Nasi Lemak',
        price: '5.00',
        imageUrl:
            'https://tasteasianfood.com/wp-content/uploads/2019/11/Nasi-Lemak-featured-image.jpeg',
        category: 'meals'),
    Meal(
        id: 't2',
        name: 'Fried Noodles',
        price: '6.00',
        imageUrl: 'https://resepichenom.com/media/mee_goreng.jpg',
        category: 'meals'),
    Meal(
      id: 't3',
      name: 'Chicken Rice',
      price: '7.00',
      imageUrl:
          'http://kawanfood.com/wp-content/uploads/2018/04/Nasi-Ayamwhole-tomato-Optimized.jpg',
        category: 'meals'
    ),
    Meal(
      id: 't4',
      name: 'Fried Rice',
      price: '6.00',
      imageUrl:
          'https://www.seriouseats.com/thmb/1-lucdS7A6rTh5TUsCFNtV0Eh_I=/2100x1181/smart/filters:no_upscale()/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__2019__06__20190604-nasi-goreng-fried-rice-vicky-wasik-7-617f5404fb49463a8b37e02df7d78def.jpg',
        category: 'meals'
    ),
    Meal(
      id: 't5',
      name: 'Barli',
      price: '5.00',
      imageUrl:
          'https://cdn.keluarga.my/2020/06/85444332-7428-4c80-97c9-69b2d0f11532-12_14_100856.jpeg',
        category: 'drinks'
    ),
    Meal(
      id: 't6',
      name: 'Limau Asam Boi',
      price: '6.00',
      imageUrl: 'https://www.newmalaysiankitchen.com/wp-content/uploads/2018/03/CALAMANSI-SOUR-PLUM-JUICE-LIMAU-ASAM-BOI-%E6%A1%94%E5%AD%90%E9%85%B8%E6%A2%85.jpg',
        category: 'drinks'
    ),
    Meal(
      id: 't7',
      name: 'Teh Tarik',
      price: '7.00',
      imageUrl:
          'https://travelfoodatlas.com/wp-content/uploads/2022/04/Teh-Tarik-720x540.jpg',
        category: 'drinks'
    ),
    Meal(
      id: 't8',
      name: 'Carrot Juice',
      price: '6.00',
      imageUrl:
          'https://www.acouplecooks.com/wp-content/uploads/2020/07/Carrot-Juice-001.jpg',
        category: 'drinks'
    ),
    Meal(
      id: 't9',
      name: 'Curly Fries',
      price: '5.00',
      imageUrl:
          'https://www.tastingtable.com/img/gallery/the-clever-hack-to-get-curly-fries-without-a-spiralizer/l-intro-1649691299.jpg',
        category: 'snacks'
    ),
    Meal(
      id: 't10',
      name: 'Nugget',
      price: '6.00',
      imageUrl: 'https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/9D900DB3-435D-4AE4-9375-B152D2813750/Derivates/199C60FC-C264-43A3-B822-88AA5E50E954.jpg',
        category: 'snacks'
    ),
    Meal(
      id: 't11',
      name: 'Hotdog',
      price: '7.00',
      imageUrl:
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/delish-fried-cheese-hot-dogs-still003-1558450799.jpg',
        category: 'snacks'
    ),
    Meal(
      id: 't12',
      name: 'Popcorn Chicken',
      price: '6.00',
      imageUrl:
          'https://www.inspiredtaste.net/wp-content/uploads/2020/04/Easy-Popcorn-Chicken-Recipe-2-1200.jpg',
        category: 'snacks'
    ),
    Meal(
      id: 't13',
      name: 'Maggi Sup',
      price: '6.00',
      imageUrl:
          'https://i.ytimg.com/vi/bDyBTUy59xk/maxresdefault.jpg',
        category: 'meals'
    ),
    Meal(
      id: 't14',
      name: 'Maggi Goreng',
      price: '5.00',
      imageUrl:
          'https://www.newmalaysiankitchen.com/wp-content/uploads/2017/05/Easy-Maggi-Goreng-5-Ingredients.jpg',
        category: 'meals'
    ),
    Meal(
      id: 't15',
      name: 'Char Kuey Teow',
      price: '6.00',
      imageUrl: 'https://www.tasteasianfood.com/wp-content/uploads/2018/07/Char-Kuey-Teow-featured.jpg',
        category: 'meals'
    ),
    Meal(
      id: 't16',
      name: 'Nasi Pattaya',
      price: '7.00',
      imageUrl:
          'https://i0.wp.com/resepibonda.my/wp-content/uploads/2015/03/nasi-goreng-pattaya.jpg?ssl=1',
        category: 'meals'
    ),
    Meal(
      id: 't17',
      name: 'Kopi Tarik',
      price: '6.00',
      imageUrl:
          'https://media.travelingyuk.com/wp-content/uploads/2018/05/Kopi-Tarik-Nikmat.jpg',
        category: 'drinks'
    ),
    Meal(
      id: 't18',
      name: 'Milo',
      price: '6.00',
      imageUrl:
          'https://d3avoj45mekucs.cloudfront.net/rojakdaily/media/hanafis/milo-2.jpg?ext=.jpg',
        category: 'drinks'
    ),
    Meal(
      id: 't19',
      name: 'Soya Bean',
      price: '5.00',
      imageUrl:
          'https://airbalang.com/wp-content/uploads/2018/09/air-soya-popular.jpg',
        category: 'drinks'
    ),
    Meal(
      id: 't20',
      name: 'Fresh Orange',
      price: '6.00',
      imageUrl: 'https://www.alphafoodie.com/wp-content/uploads/2020/11/Orange-Ginger-Juice-1-of-1.jpeg',
        category: 'drinks'
    ),
    Meal(
      id: 't21',
      name: 'Cheesy Wedges',
      price: '7.00',
      imageUrl:
          'https://magazine.foodpanda.my/wp-content/uploads/sites/12/2019/09/cropped-Cheezy-Wedges.jpg',
        category: 'snacks'
    ),
    Meal(
      id: 't22',
      name: 'French Fries',
      price: '6.00',
      imageUrl:
          'https://www.thespruceeats.com/thmb/IHKuXcx3uUI1IWkM_cnnQdFH-zQ=/3485x2323/filters:fill(auto,1)/how-to-make-homemade-french-fries-2215971-hero-01-02f62a016f3e4aa4b41d0c27539885c3.jpg',
        category: 'snacks'
    )
  ];

  List<Meal> get meal_meals {
    return _meals.where((meal) => meal.category == 'meals').toList();
  }

  List<Meal> get drink_meals {
    return _meals.where((meal) => meal.category == 'drinks').toList();
  }

  List<Meal> get snack_meals {
    return _meals.where((meal) => meal.category == 'snacks').toList();
  }

  List<Meal> get meals {
    return [..._meals];
  }

  void addMeal() {
    notifyListeners();
  }
}
