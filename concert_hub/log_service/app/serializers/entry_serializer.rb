class EntrySerializer < ActiveModel::Serializer
  attributes :ticket_id, :fio, :date_time, :entry_type, :status

  def date_time
    object.created_at
  end
end
