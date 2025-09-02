import 'package:habo/model/category.dart';

/// Abstract repository interface for category-related database operations.
/// This interface defines the contract for all category data access operations.
abstract class CategoryRepository {
  /// Retrieves all categories from the database, ordered by title.
  /// 
  /// Returns a [Future] containing a [List] of [Category] objects.
  Future<List<Category>> getAllCategories();

  /// Creates a new category in the database.
  ///
  /// [category] The category to be created, including title and color.
  /// Returns a [Future] containing the ID of the newly created category.
  Future<int> createCategory(Category category);

  /// Updates an existing category in the database.
  ///
  /// [category] The category to be updated with new properties.
  /// Returns a [Future] that completes when the update is successful.
  Future<void> updateCategory(Category category);

  /// Deletes a category from the database.
  ///
  /// [id] The ID of the category to be deleted.
  /// This will also remove all habit-category associations.
  /// Returns a [Future] that completes when the deletion is successful.
  Future<void> deleteCategory(int id);

  /// Finds a specific category by its ID.
  ///
  /// [id] The ID of the category to find.
  /// Returns a [Future] containing the [Category] if found, null otherwise.
  Future<Category?> findCategoryById(int id);

  /// Gets all categories associated with a specific habit.
  ///
  /// [habitId] The ID of the habit.
  /// Returns a [Future] containing a [List] of [Category] objects.
  Future<List<Category>> getCategoriesForHabit(int habitId);

  /// Updates the categories associated with a habit.
  ///
  /// [habitId] The ID of the habit.
  /// [categories] The list of categories to associate with the habit.
  /// Returns a [Future] that completes when the update is successful.
  Future<void> updateHabitCategories(int habitId, List<Category> categories);

  /// Adds a habit to a category.
  ///
  /// [habitId] The ID of the habit.
  /// [categoryId] The ID of the category.
  /// Returns a [Future] that completes when the association is created.
  Future<void> addHabitToCategory(int habitId, int categoryId);

  /// Removes a habit from a category.
  ///
  /// [habitId] The ID of the habit.
  /// [categoryId] The ID of the category.
  /// Returns a [Future] that completes when the association is removed.
  Future<void> removeHabitFromCategory(int habitId, int categoryId);
}
