import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:ui';


void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class Event {
  String title;
  bool complete;
  Event(this.title, this.complete);


  @override
  String toString() => title;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyApp>{
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime today = DateTime.now();


  Map<DateTime,dynamic> eventSource = {
    DateTime(2023,4,3) : [Event('5분 기도하기',false),Event('교회 가서 인증샷 찍기',true),Event('QT하기',true),Event('셀 모임하기',false),],
    DateTime(2023,4,5) : [Event('5분 기도하기',false),Event('치킨 먹기',true),Event('QT하기',true),Event('셀 모임하기',false),],
    DateTime(2023,4,7) : [Event('5분 기도하기',false),Event('용재 술 먹이기',true),Event('QT하기',false),Event('셀 모임하기',false),],
    DateTime(2023,4,11) : [Event('5분 기도하기',false),Event('가족과 저녁식사 하기',true),Event('QT하기',true)],
    DateTime(2023,4,13) : [Event('5분 기도하기',false),Event('교회 가서 인증샷 찍기',true),Event('QT하기',false),Event('셀 모임하기',false),],
    DateTime(2023,4,15) : [Event('5분 기도하기',false),Event('치킨 먹기',false),Event('QT하기',true),Event('셀 모임하기',false),],
    DateTime(2023,4,18) : [Event('5분 기도하기',false),Event('자기 셀카 올리기',true),Event('QT하기',false),Event('셀 모임하기',false),],
    DateTime(2023,4,20) : [Event('5분 기도하기',true),Event('자기 셀카 올리기',true),Event('QT하기',true),Event('셀 모임하기',true),],
    DateTime(2023,4,21) : [Event('5분 기도하기',false),Event('가족과 저녁식사 하기',true),Event('QT하기',false)]
  };


  late final events = LinkedHashMap(
    equals: isSameDay,
  )..addAll(eventSource);

  void OnDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
    });
  }

  List<Event> getEventForDay(DateTime day){
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth;
    final title='sad';
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(

          ),
          body: Row(

            children: [
              Flexible(
                flex:5,

                child: Container(
                  margin: EdgeInsets.fromLTRB(50, 0, 20, 0),

                  child: Column(
                    children: [
                      Expanded(
                          child: SizedBox(
                            width: 500,
                            height: 400,
                            child: TableCalendar(
                              shouldFillViewport: true,
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: today,
                              availableGestures: AvailableGestures.all,
                              locale: 'ko-KR',
                              calendarFormat: calendarFormat,
                              selectedDayPredicate: (day) => isSameDay(day, today),
                              headerStyle: HeaderStyle(
                                titleCentered: true,
                                formatButtonVisible: false,
                              ),
                              onPageChanged: (focusedDay){
                                today = focusedDay;
                              },
                              onDaySelected: OnDaySelected,
                              eventLoader: (day) => getEventForDay(DateTime(day.year,day.month,day.day)),
                              calendarStyle: CalendarStyle(
                                markerSize: 5,
                                markerDecoration: const BoxDecoration(
                                    color: Color(0xFF000000),
                                    shape: BoxShape.circle
                                ),
                                weekendTextStyle: TextStyle(color: Color(
                                    0xC5FF3131)),
                                isTodayHighlighted: false,
                              ),
                            ),
                          )
                      ),

                      Container(
                        height: 500,
                        child: Column(
                          children: [
                            ElevatedButton(
                            onPressed: () {_showInputs();
                              }, child: Text('할일 추가'), )
                          ],
                        ),
                        // child: ListView.builder(
                        //     itemCount: 100,
                        //     itemBuilder: (BuildContext ctx, int idx) {
                        //       return Text('Content Number ${idx}');
                        //     }
                        // )

                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex:3,
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 50, 0),
                  color: Color(0xFFFFFFF),
                  child: Row(
                    children: [

                    ],
                  ),
                ),
              ),

            ],
          )
      ),
    );
  }
}

