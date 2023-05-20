import 'package:flutter/material.dart';
import 'package:movies_app/presentation/actions/actions_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../app/localization/resources.dart';

class Faqs extends StatefulWidget {
  const Faqs({Key? key}) : super(key: key);

  @override
  State<Faqs> createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Resources.of(context).getResource("presentation.actions.faqsHeader"),
        ),
      ),
      body: Consumer<ActionsViewModel>(
        builder: (context, model, _) {
          return model.faqsList.questions.isEmpty
              ? const Center(
                  child: Text(
                    "No Questions Yet!",
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(2, 2),
                        blurRadius: 3,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      BoxShadow(
                        offset: const Offset(-2, -2),
                        blurRadius: 3,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ],
                    color: Theme.of(context).cardColor,
                  ),
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ExpansionPanelList(
                        elevation: 0,
                        expansionCallback: (index, isExpanded) {
                          setState(
                            () {
                              model.faqsIsExpanded[index] = !isExpanded;
                            },
                          );
                        },
                        children: List.generate(
                          model.faqsList.questions.length,
                          (index) => ExpansionPanel(
                            headerBuilder: (context, expanded) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                Resources.of(context).getResource(
                                    model.faqsList.questions[index].title),
                                style: model.faqsIsExpanded[index]
                                    ? TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)
                                    : null,
                              ),
                            ),
                            body: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(Resources.of(context).getResource(
                                  model.faqsList.questions[index].answer)),
                            ),
                            isExpanded: model.faqsIsExpanded[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
