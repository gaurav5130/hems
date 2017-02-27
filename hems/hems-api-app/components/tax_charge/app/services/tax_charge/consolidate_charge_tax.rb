module TaxCharge
	class ConsolidateChargeTax < Core::BaseService
		def initialize(charge_list, tax_list)
			@charge_list = charge_list
			@tax_list = tax_list
		end

		def validate()
			#TODO - Put validations
			unless (true)
				return false
			end
			return true
		end
		
		def process()
			charge1_list=[]
			tax1_list=[]
			k=0
			l=0
			flag=false
			for i in 0..@charge_list.size-1
				for j in 0..charge1_list.size
					if(i%5==0 && charge1_list[j]==@charge_list[i])
						charge1_list[j+3]=charge1_list[j+3].to_i+@charge_list[i+3].to_i
						flag=true 
						break
					else
						flag=false
					end
				end
				if(flag==false && i%5==0)
					charge1_list[k]=@charge_list[i]
					k=k+1
					charge1_list[k]=@charge_list[i+1]
					k=k+1
					charge1_list[k]=@charge_list[i+2]
					k=k+1
					charge1_list[k]=@charge_list[i+3]
					k=k+1
					charge1_list[k]=@charge_list[i+4]
					k=k+1
				end
			end
			for i in 0..@tax_list.size-1
				for j in 0..tax1_list.size
					if(i%5==0 && tax1_list[j]==@tax_list[i])
						tax1_list[j+3]=tax1_list[j+3].to_f+@tax_list[i+3].to_f
						flag=true 
						break
					else
						flag=false
					end
				end
				if(flag==false && i%5==0)
					tax1_list[k]=@tax_list[i]
					k=k+1
					tax1_list[k]=@tax_list[i+1]
					k=k+1
					tax1_list[k]=@tax_list[i+2]
					k=k+1
					tax1_list[k]=@tax_list[i+3]
					k=k+1
					tax1_list[k]=@tax_list[i+4]
					k=k+1
				end
			end
			#p tax1_list.size
			#p charge1_list
			return charge1_list,tax1_list
		end
	end
end