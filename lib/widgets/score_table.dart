import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/utils.dart/utils.dart';
import 'package:flutter/material.dart';

class ScoreTable extends StatelessWidget {
  final String varient;
  ScoreTable(this.varient);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double portraitPadding = SizeConfig.blockSizeHorizontal * 10;
    double landscapePadding = SizeConfig.blockSizeVertical * 20;
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              '${varient[0].toUpperCase()}${varient.substring(1)}',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: DataTable(
            columnSpacing: 20.0,
            dataRowHeight: 30.0,
            columns: List.generate(
              Bid.iconList.length + 1,
              (i) => DataColumn(
                numeric: true,
                label: i != 0
                    ? Icon(
                        Bid.iconList[i - 1],
                        color: Bid.color[i - 1],
                      )
                    : Text(
                        'Tricks',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
              ),
            ),
            rows: List.generate(
              5,
              (index) => DataRow(
                cells: List.generate(
                  Bid.iconList.length + 1,
                  (i) => DataCell(
                    i != 0
                        ? Text(
                            '${varient == 'avondale' ? (40 + (index * 100)) + (i - 1) * 20 : (40 + (index * 20)) + (i - 1) * ((40 + (index * 20)))}',
                            style: Theme.of(context).textTheme.caption,
                          )
                        : Text(
                            '${index + 6}',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: MediaQuery.of(context).orientation == Orientation.portrait
              ? EdgeInsets.only(
                  left: portraitPadding,
                )
              : EdgeInsets.only(
                  left: landscapePadding,
                ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Slam          ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      '250 for contract below < 250',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
        ),
        Padding(
          padding: MediaQuery.of(context).orientation == Orientation.portrait
              ? EdgeInsets.only(
                  left: portraitPadding,
                )
              : EdgeInsets.only(
                  left: landscapePadding,
                ),
          child: Row(
            children: <Widget>[
              Text(
                'Misère (CM)            ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      '250',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
        ),
        Padding(
          padding: MediaQuery.of(context).orientation == Orientation.portrait
              ? EdgeInsets.only(
                  left: portraitPadding,
                )
              : EdgeInsets.only(
                  left: landscapePadding,
                ),
          child: Row(
            children: <Widget>[
              Text(
                'Open Misère (OM)',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      '500',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
        ),
        Padding(
          padding: MediaQuery.of(context).orientation == Orientation.portrait
              ? EdgeInsets.only(
                  left: portraitPadding,
                )
              : EdgeInsets.only(
                  left: landscapePadding,
                ),
          child: Row(
            children: <Widget>[
              Container(
                child: Text(
                  'Blind Misère (BM) ',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      '1000',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
