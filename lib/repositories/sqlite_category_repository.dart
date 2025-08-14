import 'package:habo/model/category.dart';
import 'package:habo/model/habo_model.dart';
import 'category_repository.dart';

/// SQLite implementation of CategoryRepository.
/// Provides category data access operations using SQLite database.
class SQLiteCategoryRepository implements CategoryRepository {
  final HaboModel _haboModel;

  SQLiteCategoryRepository(this._haboModel);

  @override
  Future<List<Category>> getAllCategories() async {
    return await _haboModel.getAllCategories();
  }

  @override
  Future<int> createCategory(Category category) async {
    return await _haboModel.insertCategory(category);
  }

  @override
  Future<void> updateCategory(Category category) async {
    await _haboModel.updateCategory(category);
  }

  @override
  Future<void> deleteCategory(int id) async {
    await _haboModel.deleteCategory(id);
  }

  @override
  Future<Category?> findCategoryById(int id) async {
    final categories = await _haboModel.getAllCategories();
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Category>> getCategoriesForHabit(int habitId) async {
    return await _haboModel.getCategoriesForHabit(habitId);
  }

  @override
  Future<void> updateHabitCategories(int habitId, List<Category> categories) async {
    await _haboModel.updateHabitCategories(habitId, categories);
  }

  @override
  Future<void> addHabitToCategory(int habitId, int categoryId) async {
    await _haboModel.addHabitToCategory(habitId, categoryId);
  }

  @override
  Future<void> removeHabitFromCategory(int habitId, int categoryId) async {
    await _haboModel.removeHabitFromCategory(habitId, categoryId);
  }
}
