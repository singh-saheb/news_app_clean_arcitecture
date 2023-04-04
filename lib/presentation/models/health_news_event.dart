import 'package:equatable/equatable.dart';

abstract class HealthNewsEvent extends Equatable {
  const HealthNewsEvent();

  @override
  List<Object> get props => [];
}

class FetchHealthNewsEvent extends HealthNewsEvent {}
