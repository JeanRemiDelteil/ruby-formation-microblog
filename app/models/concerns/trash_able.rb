module TrashAble
  extend ActiveSupport::Concern

  # Logical delete
  included do
    default_scope { where(is_trashed: false) }
  end

  def destroy
    update!(is_trashed: true)
  end

  def restore
    update!(is_trashed: true)
  end
end
