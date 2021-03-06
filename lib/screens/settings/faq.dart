import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carty/cubit/home/homeCubit.dart';
import 'package:carty/cubit/home/homeStates.dart';
import 'package:carty/model/settings/faqModel.dart';
import 'package:carty/style/theme.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var theme = Theme.of(context);

        return Scaffold(
          body: state is HomeSuccessState
              ? Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 70, 0, 25),
                          child: Row(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () => Navigator.pop(context),
                                child: Icon(Icons.arrow_back_ios_outlined),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Frequently Asked',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Questions:',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: accentColor,
                          ),
                        ),
                        SizedBox(height: 40),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cubit.faqModel!.data!.data.length,
                          itemBuilder: (context, index) => questuinTile(
                            context,
                            cubit.faqModel!.data!.data[index],
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              Padding(padding: EdgeInsets.all(10)),
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: accentColor,
                  ),
                ),
        );
      },
    );
  }

  Theme questuinTile(BuildContext context, QuestionData questionData) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        unselectedWidgetColor: Color(0xff656565),
      ),
      child: ListTileTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: Theme.of(context).brightness == Brightness.light
            ? Color(0xffF2F2F2)
            : Color(0xff252A34),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.only(right: 50, top: 20),
          title: Text(
            questionData.question!,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Color(0xff656565)
                  : Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Color(0xffFAFAFA)
                    : Color(0x80252A34),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                questionData.answer!,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Color(0xffAEAEAE)
                      : Colors.white70,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
