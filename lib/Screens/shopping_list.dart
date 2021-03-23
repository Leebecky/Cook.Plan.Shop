import 'package:cook_plan_shop/Models/shoppingList_model.dart';
import 'package:flutter/material.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //~ Shopping List
        FutureBuilder<List<Map<String, ShoppingListItem>>>(
            future: getShoppingList(),
            builder: (context,
                AsyncSnapshot<List<Map<String, ShoppingListItem>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return (snapshot.data.isEmpty)
                    ? Center(
                        child: Text("Nothing in your shopping list yet..."),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              //~ Variables
                              String itemName = snapshot.data[i].keys.first;
                              ShoppingListItem item =
                                  snapshot.data[i].values.first;
                              bool _bought = item.isChecked;

                              return Dismissible(
                                key: Key(itemName),
                                onDismissed: (direction) => setState(() {
                                  snapshot.data[i].values.toList().removeAt(i);
                                }),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.red,
                                ),
                                child: CheckboxListTile(
                                    title: Text(itemName),
                                    isThreeLine: true,
                                    subtitle: Text(
                                        "${item.amount} ${item.unit} \nNotes: ${item.notes}"),
                                    value: _bought,
                                    onChanged: (check) => setState(() {
                                          _bought = check;
                                        })),
                              );
                            }));
              }

              return CircularProgressIndicator();
            }),
        //~ Add New Item button
        FloatingActionButton(
            child: Icon(Icons.add),
            foregroundColor:
                Theme.of(context).floatingActionButtonTheme.foregroundColor,
            onPressed: () {
              final snackBar = SnackBar(content: Text("Ping!"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            })
      ],
    );
  }
}
