import 'dart:convert';

import 'package:timefly/models/habit.dart';

void main() {
  print("object");
  String listStr = '[{"name":"name1"},{"name":"name2"}]';

  var list = jsonDecode(listStr);
  List<Name> names = [];
  for (dynamic data in list) {
    Name name = Name.formJson(data);
    print(name.name);
    names.add(name);
  }

  print(list.length);
  String nameStrings = jsonEncode(names);
  print(nameStrings);
  String string = '["good","morning"]';

  var strings = jsonDecode(string);
  List<String> datas = [];
  for (dynamic data in strings) {
    datas.add(data);
  }

  print(jsonEncode(datas));

  List<String> times = ["18:11", "12:60"];
  List<HabitRecord> records = [];
  records.add(HabitRecord(time: 1111, content: "cidw"));
  Habit habit = Habit(
    id: "11",
    name: "name",
    iconPath: "adad",
    mainColor: 111,
    mark: "mark",
    remindTimes: times,
    period: 1,
    createTime: 111,
    modifyTime: 1111,
    completed: false,
  );

  Map<String, dynamic> map = habit.toJson();
  print(map["remindTimes"].runtimeType.toString());
  print(map["period"].runtimeType.toString());
  print(map["records"].runtimeType.toString());
  print(habit.toJson());
  print(habit.toString());

  for (int i = 1; i <= 12; i++) {
    int year = DateTime.now().year;

    int count = DateTime(year, i + 1, 0).day;

    print('$i 月天数为 $count');
  }
}

class Name {
  final String name;

  Name(this.name);

  static Name formJson(Map<String, dynamic> map) {
    return Name(map['name']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}

/// 如何确定今日已经打卡？
/// 添加字段 today-check List['时间戳']
///         total-check List['2020-12-12:时间戳,时间戳','2020-12-13:时间戳,时间戳]
/// 每次打开APP进行数据库数据整理
///     1.新建习惯，today-check为[], total-check为null
///     2.再次打开，若today-check为[]，则不需要合并到total-check
///                若today-check有值，取最后一个，判断值是否在今天，
///                                            若在今天，不合并，
///                                            若是新的一天，合并，并将today-check置为[]
///     3.先进行合并判断，再过滤当天需要显示的习惯
/// check 当前次数为today-check[]的size
///
///
/// create-time为 2020-12-12 22:10:12，取当天打卡时间，List['时间戳']
/// 判断是否在 2020-12-12 00:00:00 到 2020-12-12 23:59:59之间
///
/// 去除 todayCheck和totalCheck，添加records表，记录所有打卡历史
///   id
///   time 时间戳
///   habitId String
///   note String
///   获取一个习惯的所有打卡历史：根据babitId查找出所有，再根据time排序，按情况分组即可
///   获取一个习惯的当天打卡历史：根据babitId查找出所有，再根据time过滤排序
///   查找，增加，删除，修改，这样就简单了
/// 没有是否完成的评判标准，一天1次的也可一天打卡2次
/// 如何打卡：若是从今天进去，则显示周期内所有打卡历史
///          若是从其他天进去，则只显示当天打卡历史
///
/// 统计：统计打卡次数
/// 1. 一周/一月内，每个习惯打卡次数柱状图 //哪个打卡最多，完成最好
/// 2. 所有习惯在一周内完成总次数上升曲线图 //每天完成趋势
/// 3. 习惯A在一周内每天的打卡次数柱状图  // 单个习惯的完成度
///
