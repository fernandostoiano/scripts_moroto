require 'mysql'

def get_connection
	conn = Mysql.new('localhost', 'root', 'Fsg@250583', 'test')
end


def create_new_table(conn)

	conn.query("CREATE TABLE IF NOT EXISTS \
        Writers(Id INT PRIMARY KEY AUTO_INCREMENT, Name VARCHAR(25))")
    conn.query("INSERT INTO Writers(Name) VALUES('Jack London')")
    conn.query("INSERT INTO Writers(Name) VALUES('Honore de Balzac')")
    conn.query("INSERT INTO Writers(Name) VALUES('Lion Feuchtwanger')")
    conn.query("INSERT INTO Writers(Name) VALUES('Emile Zola')")
    conn.query("INSERT INTO Writers(Name) VALUES('Truman Capote')")   
end

conn = get_connection
create_new_table(conn)