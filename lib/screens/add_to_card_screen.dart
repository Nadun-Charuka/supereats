import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToCardScreen extends ConsumerStatefulWidget {
  const AddToCardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddToCardScreenState();
}

class _AddToCardScreenState extends ConsumerState<AddToCardScreen> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 245, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 231, 208),
        // automaticallyImplyLeading: false,
        title: Text("Your cart"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: CachedNetworkImage(
                imageUrl:
                    "https://tnotihdjodszypvogvrh.supabase.co/storage/v1/object/public/food-delivery-bucket//bacon_burger.png",
                width: 80,
                height: 80,
              ),
              title: Text("Cheese bugger"),
              subtitle: Text("rs 500"),
              trailing: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 40,
                width: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
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
                    GestureDetector(
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
            )
          ],
        ),
      ),
    );
  }
}
