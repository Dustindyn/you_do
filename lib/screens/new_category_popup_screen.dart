import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../models/category.dart';
import '../providers/tasks.dart';

class NewCategoryPopupScreen extends StatefulWidget {
  @override
  _NewCategoryPopupScreenState createState() => _NewCategoryPopupScreenState();
}

class _NewCategoryPopupScreenState extends State<NewCategoryPopupScreen> {
  Color _color = Colors.black;
  final _form = GlobalKey<FormState>();
  var _editedCategory = Category(
    title: '',
    color: null,
    txtColor: null,
  );

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<Tasks>(context, listen: false).addCategory(_editedCategory);
    Navigator.of(context).pop();
  }


  void _changeColor(Color color) {
    setState(() {
      _color = color;
    });
    _editedCategory.color = _color;
    _editedCategory.txtColor = _color.withBlue(_color.blue-30).withGreen(_color.green-30).withRed(_color.red-30);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context, listen: false);
    final categoryNames = tasks.categories.map((role) => role.title).toList();
    final deviceSize = MediaQuery.of(context).size;

    return Center(
      child: Container(
        height: deviceSize.height * .6,
        width: deviceSize.width * .8,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 1.5),
              )
            ]),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Add a category!',
              style: Theme.of(context).textTheme.headline1.copyWith(
                    fontSize: 22,
                  ),
            ),
          ),
          body: Form(
            key: _form,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 16.0,
                    bottom: 16,
                  ),
                  child: TextFormField(
                    maxLength: 30,
                    initialValue: "",
                    decoration: InputDecoration(
                      labelText: 'Name your category',
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {},
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'You need to enter a name for your category.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedCategory = Category(
                        title: value,
                        color: _editedCategory.color,
                        txtColor: _editedCategory.txtColor,
                      );
                    },
                  ),
                ),
                Center(
                  child: Text('Pick a color!',
                      style: Theme.of(context).textTheme.headline1),
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 40),
                    height: 60,
                    width: 60,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: _color),
                  ),
                  onTap: () => showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: Colors.amber,
                          onColorChanged: _changeColor,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: _saveForm,
                  child: Container(
                    margin: const EdgeInsets.only(left: 70, right: 70, top: 50),
                    padding: const EdgeInsets.all(12),
                    width: deviceSize.width * .4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(
                        35,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Done!',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
