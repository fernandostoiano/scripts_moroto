require 'securerandom'
require 'mysql'

def get_connection
	con = Mysql.new('10.0.114.253', 'fernando.gonzale', 'Ab7aeakl', 'test')  
end

def get_buyer(cus_id, con)
	buyer_id = 0
	merchant_account_id = 0
	rs = con.query("select id, merchant_account_id from buyer where external_id = '#{cus_id}'")
	while row = rs.fetch_row do
		buyer_id = row[0]
		merchant_account_id = row[1]
   	end
   	return buyer_id, merchant_account_id
end

def get_mpa(account_id, con)
	mpa = ""
	rs = con.query("select external_id from account where id = '#{account_id}'")
	while row = rs.fetch_row do
		mpa = row[0]
	end
	mpa
end

def insert_customer_checkout(buyer_id, cus_id, mpa, con)
	id = 0
	rs = con.query("select max(id) from order_app.customer_checkout_token")
	while row = rs.fetch_row do
		id = row[0]
	end
	max_id = id.to_i + 1
	str_insert = get_insert_string(buyer_id, cus_id, mpa, max_id)
	con.query(str_insert)
	rs_confirm = con.query("select * from order_app.customer_checkout_token where id = '#{max_id}'")
	while row = rs_confirm.fetch_row do
		id_cadastrado = row[0]
		customer_id   = row[1]
		external_id   = row[2]
		mpa           = row[3]
		token         = row[4]
		puts id_cadastrado
		puts customer_id
		puts external_id
		puts mpa
		puts token
	end
end

def get_insert_string(buyer_id, cus_id, mpa, id)
	token = SecureRandom.uuid
	str = "insert into order_app.customer_checkout_token(id, customer_id, customer_external_id, mpa, checkout_token)
values(#{id}, '#{buyer_id}', '#{cus_id}', '#{mpa}', '#{token}');"
	tira_espaco(str)
end

def tira_espaco(str)
	str = str.gsub("\n","")
	str
end


counter = 1
con = get_connection
file = File.new("cus.txt", "r")
while (cus_id = file.gets)
	puts "Inicio"
    
    puts "#{counter}: #{cus_id}"
    
    var = get_buyer(tira_espaco(cus_id), con)
    buyer_id = var[0]
    account_id = var[1]
        
    mpa = get_mpa(tira_espaco(account_id), con)
        
    insert_customer_checkout(buyer_id, cus_id, mpa, con)
    
    counter = counter + 1
    
    puts "Fim"
end
file.close
con.close