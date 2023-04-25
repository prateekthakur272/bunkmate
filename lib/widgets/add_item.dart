import 'package:bunkmate/constants_methods.dart';
import 'package:bunkmate/repository/database.dart';
import 'package:bunkmate/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _title = TextEditingController();
final _total = TextEditingController();
final _attended = TextEditingController();

class AddItem extends StatefulWidget {
  final void Function() onAdded;
  const AddItem({super.key, required this.onAdded});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  bool _addEnabled = _title.text.trim().isNotEmpty;
  @override
  Widget build(BuildContext context) {
    return Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      TextInput(
                          hint: 'Title',
                          inputType: TextInputType.text,
                          icon: FontAwesomeIcons.book,
                          controller: _title,
                          onChange: (newValue) {
                            setState(() {
                              _addEnabled = newValue.isNotEmpty;
                            });
                          },
                        ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextInput(
                          hint: 'Total lectures',
                          inputType: TextInputType.number,
                          icon: Icons.numbers,
                          controller: _total,
                        ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextInput(
                          hint: 'Attended lectures',
                          inputType: TextInputType.number,
                          icon: Icons.numbers,
                          controller: _attended,
                        ),
                      const SizedBox(
                        height: 16,
                      ),
                      
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: !_addEnabled?null:() async {
                                showLoader(context);
                                Database.addItem(_title.text.trim(), int.tryParse(_total.text.trim())??0,int.tryParse(_attended.text.trim())??0).then((value){
                                  Navigator.popUntil(context, (route) => route.isFirst);
                                  _title.clear();
                                  _total.clear();
                                  _attended.clear();
                                  widget.onAdded();
                                }).onError((error, stackTrace){
                                  Navigator.popUntil(context, (route) => route.isFirst);
                                  showErrorSnackbar(context, error.toString());
                                });
                              },
                              child: const Text('Add item to track'))),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade300),
                            child: const Text('Cancel'),
                          )),
                    ],
                  ),
                );
  }
}