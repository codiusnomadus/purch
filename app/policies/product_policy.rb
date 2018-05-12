class ProductPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    super
  end

  def create?
    user.has_role?(:admin) || user.has_role?(:editor)
  end

  def new?
    user.has_role?(:admin) || user.has_role?(:editor)
  end

  def update?
    (user.has_role?(:admin) || (user.has_role?(:editor) && record.user == user)) && record.present?
  end

  def edit?
    if user.present?
      user.has_role?(:admin) || (user.has_role?(:editor) && record.user == user) && record.present?
    end
  end

  def destroy?
    if user.present?
      user.has_role?(:admin) || (user.has_role?(:editor) && record.user == user) && record.present?
    end
  end
end
