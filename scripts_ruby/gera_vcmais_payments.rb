require 'mysql'

def get_connection
	conn = Mysql.new('dbhomol.brasilct.com', 'dbroot', 'l,8X2Ik22+4$p*&', 'vcmais_payment') #remote dev
	#conn = Mysql.new('localhost', 'root', 'root', 'vcmais_payment')
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