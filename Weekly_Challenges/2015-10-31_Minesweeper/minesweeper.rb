# minesweeper.rb

class ValueError < StandardError
end

class Board

  def self.update_space(space)
    if space == ' '
      space = '1'
    elsif space.to_i != 0
      space = (space.to_i + 1).to_s
    end
  end

  def self.update_spaces(input, mine_x, mine_y)
    spaces_to_change = [[-1, -1], [0, -1], [1, -1],
      [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]]

    spaces_to_change.each do |coordinates|
      x = mine_x + coordinates[0]
      y = mine_y + coordinates[1]
      if x >= 0 && x < input[0].length && y >= 0 && y < input.length 
        input[y][x] = update_space(input[y][x]) if !update_space(input[y][x]).nil?
      else
        break
      end
    end
  end

  def self.transform(input)
    test_different_len(input)
    test_faulty_border(input)
    test_invalid_char(input)

    y_counter = 0

    input.each do |string|
      x_counter = 0

      string.split('').each do |char|
        if char == '*'
          update_spaces(input, x_counter, y_counter)
        end
        x_counter += 1
      end
      y_counter += 1 
    end
    input
  end

  def self.test_different_len(input)
    test_row_length = input[0].length
    input.each do |row|
      raise ValueError.new("Invalid Board Size") unless row.length == test_row_length
    end
  end

  def self.test_faulty_border(input)
    row_number = 0

    input.each do |row|
      row.split('').each do |space|
        if row_number == 0 || row_number == input.length - 1
          unless space == '-' || space == '+'
            raise ValueError.new('Invalid Border Character(s)')
          end
        end
      end

      unless row_number == 0 || row_number == input.length - 1
        unless row[0] == '|' && row[row.length - 1] == '|'
          raise ValueError.new('Invalid Border Character(s)')
        end
      end

      row_number += 1
    end
  end

  def self.test_invalid_char(input)
    input.join('').split('').each do |char|
      unless char == ' ' || char == '*' || char == '-' || char == '|' || char == '+'
        raise ValueError.new('Invalid Character(s)')
      end
    end
  end
end
