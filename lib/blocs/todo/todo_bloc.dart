
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:repository/repository.dart';
import 'package:todo_firebase/blocs/todo/todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState>{

  final TodoRepo _todoRepo;
  StreamSubscription _todoSubscription;

  TodoBloc({@required TodoRepo todoRepo})
  : assert(todoRepo != null),
  _todoRepo = todoRepo;

  @override
  TodoState get initialState => TodoLoading();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is LoadTodo){
      yield* _mapLoadTodoToState(event);
    } else if (event is AddTodo){
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateTodo){
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodo){
      yield* _mapDeleteTodoToState(event);
    } else if (event is TodosUpdated){
      yield* _mapTodosUpdatedToState(event);
    }
  }

  Stream<TodoState> _mapLoadTodoToState(LoadTodo event) async* {
   
    _todoSubscription?.cancel();
    _todoSubscription = _todoRepo.todos(event.userId).listen((data){
      dispatch(TodosUpdated(data, event.userId));
    });
  }

  Stream<TodoState> _mapAddTodoToState(AddTodo event) async* {
    _todoRepo.addNewToDo(event.todo, event.userId);
  }

  Stream<TodoState> _mapUpdateTodoToState(UpdateTodo event) async* {
    _todoRepo.updateTodo(event.updatedTodo, event.userId);
  }

  Stream<TodoState> _mapDeleteTodoToState(DeleteTodo event) async* {
    _todoRepo.deleteToDo(event.todo, event.userId);
  }

  Stream<TodoState> _mapTodosUpdatedToState(TodosUpdated event) async* {
    yield TodoLoaded(event.todos);
  }

  @override
  void dispose() {
    _todoSubscription?.cancel();
    super.dispose();
  }

}