import 'dart:async';
import 'package:breakq/data/models/my_order.dart';
import 'package:breakq/data/repositories/order_repository.dart';
import 'package:breakq/blocs/base_bloc.dart';
import 'package:flutter/material.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends BaseBloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitialState());

  @override
  Stream<OrdersState> mapEventToState(OrdersEvent event) async* {
    if (event is LoadOrdersEvent) {
      yield* _mapLoadBillsEventToState(event);
    } else if (event is OrderSelectedQSEvent) {
      yield* _mapSelectBillQSEventToState(event);
    }
  }

  Stream<OrdersState> _mapLoadBillsEventToState(LoadOrdersEvent event) async* {
    /// Load all the orders:
    final List<Order> _orders = await MyOrderRepository().getMyOrders();

    if (_orders == null) {
      yield OrdersLoadFailureState();
    } else {
      yield OrdersLoadedState(
        orders: _orders,
      );
    }
  }

  Stream<OrdersState> _mapSelectBillQSEventToState(
      OrderSelectedQSEvent event) async* {
    if (state is OrdersLoadedState) {
      // TODO:
    }
  }
}
