class EntryService
  START_PAGE = 0 # начальная страница для отображения записей
  ENTRIES_PER_PAGE = 20 # количество записей на странице

  attr_reader :conditions, :page, :per_page

  def initialize(params)
    @conditions = {}
    @conditions[:fio] = params[:fio] if params[:fio]
    @conditions[:entry_type] = params[:entry_type].downcase if entry_type? params[:entry_type]
    @conditions[:status] = to_boolean(params[:status]) if boolean? params[:status]

    @page = [params[:page].to_i - 1, START_PAGE].max
    @per_page = params[:per_page] ? params[:per_page].to_i : ENTRIES_PER_PAGE
  end

  def filter
    Entry.where(conditions).limit(per_page).offset(page * per_page)
  end

  private

  def to_boolean(obj)
    obj.to_s.downcase == 'true'
  end

  def boolean?(obj)
    %w[true false].include? obj.to_s.downcase
  end

  def entry_type?(obj)
    %w[entry exit].include? obj.to_s.downcase
  end
end
