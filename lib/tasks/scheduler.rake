require_relative 'crawler.rb'

namespace :crawler do
  desc 'Starting Crawler'
  task start: :environment do
    crawler = Crawler.new
    # time = 4
    # while(true)
    puts '[+] Realizando Busqueda Taller de Empleabilidad Practica II'
    crawler.start_crawler
    # puts "[...] Waiting #{time} hours"
    #  sleep(time.hours)
    # end
  end
end
