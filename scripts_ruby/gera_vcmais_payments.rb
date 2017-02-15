require 'mysql'

def get_connection
	conn = Mysql.new('localhost', 'root', 'root', 'vcmais_payments')
end

def exec_script(script, conn)
	conn.query(script)
end

conn = get_connection
counter = 1
file = File.new("inserts.txt", "r")
while (script = file.gets)
	puts "inicio: #{counter}"

	exec_script(script, conn)

	counter = counter + 1
end
file.close
conn.close