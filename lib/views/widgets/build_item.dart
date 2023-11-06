import 'package:flutter/material.dart';
import '../shop/shop_cubit.dart';

Widget buildItem(item, context, {bool isSearch = false}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: SizedBox(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(item.image!),
              width: 120.0,
              height: 120.0,
            ),
            if (item.discount != 0 && !isSearch)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(fontSize: 8, color: Colors.white),
                ),
              )
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '${item.price!.round()} \$',
                    style:
                    const TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (item.discount != 0 && !isSearch)
                    Text(
                      '${item.oldPrice!.round()}',
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  if (!isSearch) CircleAvatar(
                    radius: 15,
                    backgroundColor: ShopCubit.get(context)
                        .favorites[item.id] ==
                        true
                        ? Colors.blue
                        : Colors.grey,
                    child: IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .changeFavorites(item.id);
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 14,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
