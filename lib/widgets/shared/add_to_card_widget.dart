import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class AddToCardWidget extends ConsumerStatefulWidget {
  const AddToCardWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddToCardWidgetState();
}

class _AddToCardWidgetState extends ConsumerState<AddToCardWidget> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: CachedNetworkImage(
              imageUrl:
                  "https://tnotihdjodszypvogvrh.supabase.co/storage/v1/object/public/food-delivery-bucket//bacon_burger.png",
              width: 80,
              height: 80,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            title: Text("Cheese bugger"),
            subtitle: Text("rs 500"),
            trailing: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 40,
              width: 120,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        setState(() {
                          quantity > 1 ? quantity-- : 1;
                        });
                      },
                      child: Icon(
                        Icons.remove,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      quantity.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        setState(() {
                          quantity >= 1 ? quantity++ : 1;
                        });
                      },
                      child: Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
