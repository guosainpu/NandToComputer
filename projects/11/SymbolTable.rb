
class SymbolTable
	def initialize()
		@classTable = {}
		@subroutineTable = {}
		@symbolTableDic = {{"STATIC" => @classTable, "FIELD" => @classTable, "ARG" => @subroutineTable, "VAR" => @subroutineTable}}
		@symbolIndex = {"STATIC" => 0, "FIELD" => 0, "ARG" => 0, "VAR" => 0}
	end

	def startSubroutine()
		@subroutineTable = {} #清空subroutineTable，开始编译下一个方法
		@symbolIndex["ARG"] = 0
		@symbolIndex["VAR"] = 0
	end

	def define(name, type, kind)
		symbolTable = @symbolTableDic[kind]
		symbolTable[name] = [type, kind, @symbolIndex[kind])]
		@symbolIndex[kind] = @symbolIndex[kind] + 1
	end

	def varCount(kind)
		count = 0
		@classTable.each do |name, values|
			if values[1] == kind
				count = count + 1
			end
		end
		@subroutineTable.each do |name, values|
			if values[1] == kind
				count = count + 1
			end
		end
		return count
	end

	def kindOf(name)
		valus = self.findSymbol(name)
		return valus[1]
	end

	def typeOf(name)
		valus = self.findSymbol(name)
		return valus[0]
	end

	def indexOf(name)
		valus = self.findSymbol(name)
		return valus[2]
	end

	def findSymbol(name)
		if @subroutineTable.key?(name)
			return @subroutineTable[name]
		end

		if @classTable.key?(name)
			return @classTable[name]
		end

		return ["NONE", "NONE", "NONE", ]
	end
end



