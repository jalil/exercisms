class Player
	attr_accessor :pnum

	def initialize(pnum)
		@pnum = pnum
	end

	def playturn!(tictactoe)
		puts "Hello player #{self.pnum}!\n The board is as follows!"
		tictactoe.printBoard()
		while 1
			puts "Give me a row!"
			row = gets.chomp()
			row = row.to_i
			puts "Give me a col!"
			col = gets.chomp()
			col = col.to_i
			if tictactoe.empty?(row,col) == 0
				puts "That cell is occupied. Try again!"
			else 
				tictactoe.placeVal!(row,col,self.pnum)
				break
			end
		end
	end
end

class Game
	attr_accessor :turn, :p1, :p2, :game

	def initialize(pnum1, pnum2)
		@game = TicTacToe.new()
		@p1 = Player.new(pnum1)
		@p2 = Player.new(pnum2)
		@turn = 1
	end

	def play!()
		while 1
			if self.turn % 2 == 1
				self.p1.playturn!(self.game)
			else
				self.p2.playturn!(self.game)
			end

			if self.game.isOver?() != 0 or self.game.isfull?() == 1
				print "Player #{self.game.isOver?()} has won!"
				break
			end
		
			self.turn += 1
		end
	end			
end

class TicTacToe
	attr_accessor :board
	
	def initialize()

		@board = [[0,0,0],[0,0,0],[0,0,0]]
	end

	def empty?(i,j)
		if self.board[i][j] == 0
			return 1
		else
			return 0
		end
	end
	
	def isfull?()
		for i in (0..2)
			for j in (0..2)
				if self.board[i][j] == 0
					return 0
				end
			end
		end
		return 1
	end

	def placeVal!(i,j, pnum)
		self.board[i][j] = pnum
	end	

	def printBoard()
		for i in (0..2)
			outStr = "|"
			for j in (0..2)
				if self.board[i][j] == 0
					outStr = outStr + "   |"
				elsif self.board[i][j] == 1
					outStr = outStr + " X |"
				elsif self.board[i][j] == 2
					outStr = outStr + " O |"
				end
			end
			puts "-" * 13
			puts "#{outStr}"
		end
		puts "-" * 13
	end
	
	def isOver?()
		outcomes = [0,0,0]
		outcomes[0] = self.vertVic?()
		outcomes[1] = self.horVic?()
		outcomes[2] = self.diagVic?()
		
		for i in (0..2)
			#puts "The outcome of #{i}  is #{outcomes[i]}"
			if outcomes[i] != 0
				return outcomes[i]
			end
		end
		return 0
	end	

	def vertVic?()
		for j in (0..2)
			base = self.board[0][j]
			for i in (0..2)
				if self.board[i][j] != base or base == 0
					break
				elsif self.board[i][j] == base and i == 2
					return base
				end
			end
		end
		return 0
	end
	
	def horVic?()
		for i in (0..2)
			base = self.board[i][0]
			for j in (0..2)
				if self.board[i][j] != base or base == 0
					break
				elsif self.board[i][j] == base and j == 2
					return base
				end
			end
		end
		return 0
	end

	def diagVic?()
		base = self.board[0][0]
		if base == 0
			return 0
		end

		for i in (0..2)
			if self.board[i][i] != base or base == 0
				break
			elsif self.board[i][i] == base and i == 2
				return base
			end
		end
		
		base = self.board[0][2]
		if base == 0
			return 0
		end

		for i in (0..2)
			if self.board[i][2 - i] != base or base == 0
				break
			elsif self.board[i][2 - i] == base and i ==2
				return base
			end
		end
		return 0	
	end
end


agame = Game.new(1,2)
agame.play!()

