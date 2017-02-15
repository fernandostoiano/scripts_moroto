require 'mysql'

def get_connection
	conn = Mysql.new('localhost', 'root', 'Fsg@250583', 'test')
end


def create_new_table(conn)

	conn.query("CREATE TABLE IF NOT EXISTS \
        Writers(Id INT PRIMARY KEY AUTO_INCREMENT, Name VARCHAR(25))")
end

def exec_script(script, conn)
	conn.query(script)
end

conn = get_connection
create_new_table(conn)

counter = 1
file = File.new("inserts.txt", "r")
while (script = file.gets)

	exec_script(script, conn)

	puts "inicio: #{counter}"

	counter = counter + 1
end
file.close
conn.close