part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {
  @override
  String toString() => '$runtimeType';
}

class SessionInitedProductEvent extends ProductEvent {
  SessionInitedProductEvent({this.category, this.offer});

  final CategoryModel category;
  final DealsModel offer;
}

class FilteredListRequestedProductEvent extends ProductEvent {}

class CategoryFilteredProductEvent extends ProductEvent {
  CategoryFilteredProductEvent({this.activeCategoryTab});

  final int activeCategoryTab;
}

class BrandFilteredProductEvent extends ProductEvent {
  BrandFilteredProductEvent({this.activeBrandTab});

  final String activeBrandTab;
}

class ListTypeChangedProductEvent extends ProductEvent {
  ListTypeChangedProductEvent(this.newListType);

  final ToolbarOptionModel newListType;
}

class SortOrderChangedProductEvent extends ProductEvent {
  SortOrderChangedProductEvent(this.newSort);

  final ToolbarOptionModel newSort;
}

class PriceFilterProductEvent extends ProductEvent {
  PriceFilterProductEvent({this.range});

  final RangeValues range;
}
