abstract class IBaseLocalService<T> {
  Future<T?> insert(T entity);

  Future<bool> insertAll(List<T> entities);

  Future<T?> update(T entity);

  Future delete(String id);

  Future<T?> getById(String id);

  Future<List<T>> getAll();

  Future<bool> clear();
}
