import 'package:book_indian_talents_app/components/custom_radio_button.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/custom_text_widget.dart';
import '../helper/constants.dart';

class ChooseLanguageScreen extends StatefulWidget {
  static const String id = 'choose_language_screen';

  const ChooseLanguageScreen({super.key});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  String _selectedValue = '';
  List<String> languagelist = [
    'Hindi',
    'English',
    'Punjabi',
    'Hariyanvi',
    'Bhajpuri'
  ];
  List<String>selectedlist=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          title: CustomTextWidget(
            text: 'Choose Language ',
            textColor: Theme.of(context).primaryColorLight,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: AlignedGridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          itemCount: languagelist.length,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemBuilder: (context, index) {
            return NeumorphismWidget(
              padding: EdgeInsets.symmetric(horizontal: 5,vertical:5),
              child: CustomRadioButton(
                radius: 50,
                label: languagelist[index],
                value:
                selectedlist.contains(languagelist[index]),
                onChanged: (value) {
                  setState(() {
                    if(selectedlist.contains(languagelist[index])){
                      selectedlist.remove(languagelist[index]);
                    }else{
                      selectedlist.add(languagelist[index]);
                    }
                   // _selectedValue=languagelist[index];
                  });
                },
              ),
            );
          },
        ));
  }
}
