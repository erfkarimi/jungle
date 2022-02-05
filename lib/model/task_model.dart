class TaskModel{
  String? title;
  bool isCompleted;
  bool isDeleted;

  TaskModel({
    this.title, 
    this.isCompleted = false,
    this.isDeleted = false});
}