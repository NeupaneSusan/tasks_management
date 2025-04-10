import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmgt/core/constant/app_color.dart';
import 'package:taskmgt/core/constant/input_decoration.dart';
import 'package:taskmgt/core/constant/text_style.dart';
import 'package:taskmgt/core/utils/get_date.dart';
import 'package:taskmgt/model/status.dart';
import 'package:taskmgt/model/task_model.dart';
import 'package:taskmgt/model/user_model.dart';
import 'package:taskmgt/provider/auth_provider.dart';
import 'package:taskmgt/provider/task_provider.dart';
import 'package:taskmgt/widget/button.dart';
import 'package:taskmgt/widget/common_text_field.dart';
import 'package:taskmgt/widget/radio_button.dart';

class CreateTaskPage extends StatefulWidget {
  final TaskModel? task;
  const CreateTaskPage({super.key, this.task});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _titleEditingController = TextEditingController();
  final _noteEditingController = TextEditingController();
  final _dateEditingController = TextEditingController();
  final _startTimeEditingController = TextEditingController();
  final _endTimeEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  ValueNotifier<Status> _selectedStatus = ValueNotifier(Status.pending);

  final ValueNotifier<UserModel?> _userSelected = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthsProvider>().getAllUser();
    });
    if (widget.task != null) {
      _titleEditingController.text = widget.task!.title;
      _noteEditingController.text = widget.task!.note;
      _dateEditingController.text = widget.task!.date;
      _startTimeEditingController.text = widget.task!.startTime;
      _endTimeEditingController.text = widget.task!.endTime;
      _selectedStatus = ValueNotifier(widget.task!.status);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight - 20,
        leadingWidth: 50,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Text(widget.task != null ? 'Edit Task' : 'Add Task', style: AppTextStyle.font18W6),
            SizedBox(height: 10),
            CommonTextField(
              hintText: 'Enter your title',
              title: 'Title',
              textEditingController: _titleEditingController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter title';
                }
                return null;
              },
            ),
            CommonTextField(
              hintText: 'Enter your Note',
              title: 'Note',
              textEditingController: _noteEditingController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter title';
                }
                return null;
              },
            ),
            CommonTextField(
              onTap: () {
                showDate();
              },
              readOnly: true,
              hintText: '10/10/2015',
              title: 'Date',
              textEditingController: _dateEditingController,
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_month, color: Colors.grey.shade600),
                onPressed: () {
                  showDate();
                },
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Date';
                }
                return null;
              },
            ),
            Row(
              children: [
                Flexible(
                  child: CommonTextField(
                    readOnly: true,
                    onTap: () {
                      showTime(true);
                    },
                    hintText: '9:30 Am',
                    title: 'Start Time',
                    textEditingController: _startTimeEditingController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Start Time';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(Icons.access_time, color: Colors.grey.shade600),
                      onPressed: () {
                        showTime(true);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                Flexible(
                  child: CommonTextField(
                    readOnly: true,
                    onTap: () {
                      showTime(false);
                    },
                    hintText: '10:00 Am',
                    title: 'End Time',
                    textEditingController: _endTimeEditingController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter End Time';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(Icons.access_time, color: Colors.grey.shade600),
                      onPressed: () {
                        showTime(false);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Column(
              spacing: 8.0,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Assign To', style: AppTextStyle.font15W5),
                Consumer<AuthsProvider>(
                  builder: (context, data, child) {
                    if (data.userList.isNotEmpty && widget.task != null) {
                      final userModel = data.userList.firstWhere((e) => e.userId == widget.task!.assignedTo);
                      _userSelected.value = userModel;
                    }
                    return ValueListenableBuilder(
                      valueListenable: _userSelected,
                      builder: (context, value, child) {
                        return DropdownButtonFormField<UserModel>(
                          hint: Text('Select a user'),
                          value: value,
                          decoration: inputDecoration(hintText: 'Select a user'),
                          onChanged: (UserModel? newUser) {
                            _userSelected.value = newUser;
                          },
                          items:
                              data.userList.map((user) {
                                return DropdownMenuItem<UserModel>(value: user, child: Text(user.fullName));
                              }).toList(),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ValueListenableBuilder<Status>(
              valueListenable: _selectedStatus,
              builder: (context, data, child) {
                return StatusRadioButton(
                  selectedStatus: data,
                  onChanged: (s) {
                    if (s != null) {
                      _selectedStatus.value = s;
                    }
                  },
                );
              },
            ),

            SizedBox(height: 20),

            Consumer<TaskProvider>(
              builder: (context, data, child) {
                return CommonButton(
                  title:
                      data.isLoading
                          ? 'Loading...'
                          : widget.task != null
                          ? 'Edit Task'
                          : 'Add Task',
                  onTap:
                      data.isLoading
                          ? () {}
                          : () {
                            if (_formKey.currentState!.validate()) {
                              final id = widget.task != null ? widget.task!.id : DateTime.now().millisecondsSinceEpoch.toString();
                              final userId = FirebaseAuth.instance.currentUser!.uid;
                              final body = TaskModel(
                                id: id,
                                title: _titleEditingController.text,
                                note: _noteEditingController.text,
                                date: _dateEditingController.text,
                                startTime: _startTimeEditingController.text,
                                endTime: _endTimeEditingController.text,
                                createdBy: userId,
                                assignedTo: _userSelected.value?.userId ?? userId,
                                status: _selectedStatus.value,
                              );
                              if (widget.task != null) {
                                context.read<TaskProvider>().updateTask(body);
                                return;
                              }
                              context.read<TaskProvider>().createTask(body);
                            }
                          },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future showDate() async {
    FocusScope.of(context).unfocus();
    DateTime? intialDate = _dateEditingController.text.isEmpty ? null : DateTime.parse(_dateEditingController.text);
    DateTime? dateTime = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: const TextTheme(bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor,
              // onPrimary: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2121),
      initialDate: intialDate,
    );

    if (dateTime != null) {
      _dateEditingController.text = DateFormatter().fullDate(dateTime);
    }
  }

  Future showTime(bool isStart) async {
    FocusScope.of(context).unfocus();
    TimeOfDay? initial;

    if (isStart && _startTimeEditingController.text.isNotEmpty) {
      final [hour, mintue] = DateFormatter().getTimeOfDay(_startTimeEditingController.text);
      initial = TimeOfDay(hour: hour, minute: mintue);
    }
    if (!isStart && _endTimeEditingController.text.isNotEmpty) {
      final [hour, mintue] = DateFormatter().getTimeOfDay(_endTimeEditingController.text);
      initial = TimeOfDay(hour: hour, minute: mintue);
    }

    TimeOfDay? time = await showTimePicker(
      initialTime: initial ?? TimeOfDay.now(),
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: const TextTheme(bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            colorScheme: ColorScheme.light(primary: AppColor.primaryColor),
            textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400))),
          ),
          child: child!,
        );
      },
    );
    if (time != null && mounted) {
      if (isStart) {
        return _startTimeEditingController.text = time.format(context);
      }
      return _endTimeEditingController.text = time.format(context);
    }
  }
}
