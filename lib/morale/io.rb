module Morale
  module IO
    def say(message="", color=nil, force_new_line=(message.to_s !~ /( |\t)$/))
      message = message.to_s
      message = set_color(message, color) if color

      spaces = ""

      if force_new_line
        $stdout.puts(spaces + message)
      else
        $stdout.print(spaces + message)
      end
      $stdout.flush
    end
    
    def ask
      input = $stdin.gets
      input.strip! unless input.nil?
    end
    
    def ask_for_secret_on_windows
      require "Win32API"
      char = nil
      secret = ''

      while char = Win32API.new("crtdll", "_getch", [ ], "L").Call do
        break if char == 10 || char == 13 # received carriage return or newline
        if char == 127 || char == 8 # backspace and delete
          secret.slice!(-1, 1)
        else
          # windows might throw a -1 at us so make sure to handle RangeError
          (secret << char.chr) rescue RangeError
        end
      end
      puts
      return secret
    end

    def ask_for_secret
      echo_off
      secret = ask
      puts
      echo_on
      return secret
    end
    
    def echo_off
      system "stty -echo"
    end

    def echo_on
      system "stty echo"
    end
  end
end