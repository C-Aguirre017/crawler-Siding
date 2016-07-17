require_relative 'crawler.rb'

namespace :crawler do

  desc "Starting Crawler"
  task start: :environment do
    crawler = Crawler.new
    puts "[+] Realizando Busqueda Taller de Empleabilidad Practica II"
    crawler.start_crawler(user.to_s,pass.to_s)
  end

end
