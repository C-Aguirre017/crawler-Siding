require 'nokogiri'
require 'rest-client'

require_relative 'methods.rb'

class Crawler < Methods

  $host = "https://intrawww.ing.puc.cl"
  $xpath = "//p[text()='Práctica II']/following-sibling::table"
  $available_practice = false

  def start_crawler
    begin

      #Iniciar para Obtener Cookies
      Post($host + '/siding/index.phtml','', 'Primera', {'login' => ENV['SECRET_USER'], 'passwd' => ENV['SECRET_PASSWORD']} , 1)

      res = Get($host + '/siding/dirdoc/actividades/inscripciones/inscripcion/usuario/index.phtml', 'Segunda', 1)

      get_info(res,2)
      print_result()

      return $available_practice

    rescue Exception => e
      puts "[!] Error al intentar hacer consulta: " + e.to_s
      exit
    end

  end

  def print_result
    puts "\n\n\n"
    puts '##################'
    if $available_practice
      puts '#######' + $available_practice.to_s + '#######'
    else
      puts '######' + $available_practice.to_s + '#######'
    end
    puts '##################'
    puts "\n\n\n"
  end


  def get_info(res,count)
    tab = ""
    count.times { tab += "\t " }

    doc = Nokogiri::HTML(res)
    table = doc.xpath($xpath)

    if table.size > 0
      table[0..-1].each_with_index do |table,i|
        begin
          table.xpath('tr')[2..-1].each do |tr|
            rows = tab
            tr.xpath("td").each_with_index do |td,column|
              rows += td.content.strip + "\t"
              if column == 3  &&  td.content.strip.to_i > 0
                $available_practice = true
              end
            end
            puts rows
          end

        rescue Exception => e
          puts "[!] Error adentro: " + e.to_s
        end
      end
    end

    return $available_practice
  end

end

puts "[+] Realizando Busqueda Taller de Empleabilidad Practica II"
crawler = Crawler.new
crawler.start_crawler()
