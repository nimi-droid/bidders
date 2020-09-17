import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  final isLoadingBS = BehaviorSubject<bool>.seeded(false);
  final onErrorBS = BehaviorSubject<dynamic>();
  final onSuccessBS = BehaviorSubject<dynamic>();

  CompositeSubscription compositeSubscription = CompositeSubscription();

  Stream<bool> get isLoading => isLoadingBS.stream;

  Stream<dynamic> get onError => onErrorBS.stream;

  Stream<dynamic> get onSuccess => onSuccessBS.stream;

  void onDispose() {
    isLoadingBS.close();
    onErrorBS.close();
    onSuccessBS.close();
  }
}
