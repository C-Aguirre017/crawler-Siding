require 'nokogiri'

require_relative 'methods.rb'

class Crawler < Methods

  $host = "https://intrawww.ing.puc.cl"
  $xpath = "//p[text()='Práctica II']/following-sibling::table"
  $available_practice = false

  def start_crawler
    begin

      user = ENV['SECRET_USER'] || ''
      pass = ENV['SECRET_PASSWORD'] || ''

      #Iniciar para Obtener Cookies
      Post($host + '/siding/index.phtml','', 'Primera', {'login' => user, 'passwd' => pass} , 1)

      res = Get($host + '/siding/dirdoc/actividades/inscripciones/inscripcion/usuario/index.phtml', 'Segunda', 1)

      get_info(res,2)
      print_result()
      puts '[!] Realizado con Exito'
      
    rescue Exception => e
      puts "[!] Error al intentar hacer consulta: " + e.to_s
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
    message = ''

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
            message += "\t" +  rows + "\n"
            puts rows
          end

        rescue Exception => e
          puts "[!] Error adentro: " + e.to_s
        end
      end
    end

    send_notice(message)
    if $available_practice
      send_emails(message)
    end

  end

  def send_emails(message)
    User.all.each do |user|
      if !user.is_sent
        begin
          UserMailer.practice_email(user,message).deliver_now
          user.update_attributes(is_sent: true)
        rescue Exception => e
          puts "[!] Error: " + e.to_s
        end
      end
    end
  end

  def send_notice(message)
    begin
      UserMailer.notice_email(User.first,message).deliver_now
    rescue Exception => e
      puts "[!] Error: " + e.to_s
    end
  end

end
