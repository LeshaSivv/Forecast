DAY_TIME = { 0 => 'ночь', 1 => 'утро', 2 => 'день', 3 => 'вечер'}.freeze
CLOUD = { -1 => 'туман', 0 => 'ясно', 1 => 'малооблачно', 2 => 'облачно', 3 => 'пасмурно' }.freeze

def forecast_output(forecast, doc)
  cloud = CLOUD[forecast.elements['PHENOMENA'].attributes['cloudiness'].to_i]
  day_time = DAY_TIME[forecast.attributes['tod'].to_i]
  max_temp = forecast.elements['TEMPERATURE'].attributes['max']
  min_temp = forecast.elements['TEMPERATURE'].attributes['min']
  max_wet = forecast.elements['RELWET'].attributes['max']
  min_wet = forecast.elements['RELWET'].attributes['min']
  if Time.now.strftime('%d').to_s == forecast.attributes['day'].to_s
    time = 'Сегодня'
  else
    time = 'Завтра'
  end
  puts "#{time}: #{day_time}"
  puts
  puts "Температура от #{min_temp} до #{max_temp}"
  puts "Влажность от #{min_wet} до #{max_wet}"
  puts "Облачность: #{cloud}"
  puts
end