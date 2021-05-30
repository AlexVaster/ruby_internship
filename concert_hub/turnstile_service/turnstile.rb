require 'uri'
require 'net/http'
require 'sinatra'
require 'json'

set :bind, '0.0.0.0'

TURNSTILE_CATEGORY = ARGV[0].to_i
LOG_SERVICE_URL = 'http://log:8180'
TICKETS_SERVICE_URL = 'http://tickets:8170'

before do
  content_type :json
end

get '/enter' do
  ticket_number = params[:id].to_i

  get_tickets = "#{TICKETS_SERVICE_URL}/tickets/#{ticket_number}"
  get_entries = "#{LOG_SERVICE_URL}/check?ticket_id=#{ticket_number}"
  post_entries = ''

  uri = URI(get_tickets)
  response = Net::HTTP.get_response(uri)
  ticket_content = JSON.parse(response.body) # билет может быть не найден

  uri = URI(get_entries)
  response = Net::HTTP.get_response(uri)
  entry_content = JSON.parse(response.body)

  content = {
    category: ticket_content['ticket_category'], # 1 or 2
    status: ticket_content['status'], #  'free', 'booked', 'purchased' or 'blocked'
    entry_type: entry_content['entry_type'] # 'exit' or 'entry'
  } # todo: добавить проверку даты мероприятия

  response = {}

  if content[:category] != TURNSTILE_CATEGORY
    response[:error] = "The turnstile doesn't accept tickets of this category"
  elsif content[:status] == 'blocked'
    response[:error] = "Ticket is blocked"
  elsif content[:entry_type] != 'exit'
    response[:error] = "You cant't enter twice"
  end

  response[:result] = response[:error].nil?

  # todo: фиксация попытки входа

  return response.to_json

=begin
  if content[:blocked] == false && content[:category] == TURNSTILE_CATEGORY
    ticket_params = {
      id: ticket_number,
      date_time: Time.now,
     #first_name: content[:first_name],
     # middle_name: content[:middle_name],
     # last_name: content[:last_name],
      enter_type: 'entry',
      is_blocked: false
    }
    #uri = URI.parse(get_entries)
    #response = Net::HTTP.get_response(uri)
    #content = response.body
    if content[:enter_type] == 'exit'
      #uri = URI.parse(post_entries)
      #response = Net::HTTP.post_form(uri, parameters)
      return "true(enter)#{ticket_number}"
    end
    return "false(enter)#{ticket_number}"
  else
    return 'false(stop)#{ticket_number}'
  end
=end
end