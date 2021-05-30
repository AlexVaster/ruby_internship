class EntriesController < ApplicationController
  rescue_from RuntimeError do
    render json: { 'error': 'Ошибка авторизации' }
  end

  # prevent CSRF attacks, use :null_session for APIs
  protect_from_forgery with: :null_session

  def index
    LoginService.check_authorization(session) # доступ только для админа
    @entries = EntryService.new(params).filter
    render json: @entries, each_serializer: EntrySerializer
  end

  def create
    @entry = Entry.new(entry_params)
    raise Error::EntryInvalid, @entry.errors.messages unless @entry.valid?

    @entry.save

    render json: @entry, each_serializer: EntrySerializer, status: :created
  end

  def check
    @entry = Entry.where(ticket_id: params[:ticket_id].to_i).last # nil if not found
    raise Error::EntryNotFound, params[:ticket_id].to_i unless @entry

    render json: { entry_type: @entry.entry_type }, status: :ok
  end

  private

  # only allow a list of trusted parameters through
  def entry_params
    params.require(:entry).permit(:ticket_id, :fio, :entry_type, :status)
  end
end
