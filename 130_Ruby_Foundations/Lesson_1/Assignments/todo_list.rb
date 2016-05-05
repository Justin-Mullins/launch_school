# todo_list.rb
class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  #-------Adding to list--------

  def add(todo)
    if todo.class == Todo
      @todos << todo
    else
      raise TypeError.new("Can only add Todo objects")
    end
  end

  def <<(todo)
    if todo.class == Todo
      @todos << todo
    else
      raise TypeError.new("Can only add Todo objects")
    end
  end
 
  #-------Interogating the list-------

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  #--------Retriving Item in the List------

  def item_at(index)
    @todos[index]
  end

  #------Marking items done----------

  def mark_done_at(index)
    @todos[index].done!
  end

  def mark_undone_at(index)
    @todos[index].undone!
  end

  def mark_all_done
    @todos.each { |todo| todo.done! }
  end

  def mark_all_undone
    @todos.each { |todo| todo.undone! }
  end

  # marks the first Todo object that matches the argument as done.
  def mark_done(string)
    @todos.each do |todo|
      todo.done! if (todo.title =~ /#{string}/)
    end
  end

  #-------All Done?-------

  def done?
    counter = 0
    @todos.each { |todo| counter += 1 if todo.done? }
    counter == @todos.length
  end

  #-------Deleting from list-------

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    @todos.delete_at(index)
  end

  #------Iterating through list-----

  def each
    counter = 0
    while counter < @todos.length do
      yield(@todos[counter])
      counter += 1
    end
    self
  end

  #------Selecting elements in list-----

  def select
    counter = 0
    new_list = TodoList.new(title)

    while counter < @todos.length do
      if yield(@todos[counter])
        new_list << @todos[counter]
      end
      counter += 1
    end

    new_list
  end

  #----Changes Todos all to done/undone----

  def all_done
    select{ |todo| todo.done? }
  end

  def all_not_done
    select{ |todo| !todo.done? }
  end

  #-----Returns Todo that matches argument----

  def find_by_title(string)
    @todos.each do |todo|
      return todo if (todo.title =~ /#{string}/)
    end
    nil
  end


  #--------Conversion methods-----------

  def to_s
    @todos.each { |todo| puts todo }
  end

  def to_a
    @todos
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# add
list.add(todo1)
list.add(todo2)
list.add(todo3)


puts "Searching for Todo: #{list.find_by_title("ilk")}"

list.to_s
list.mark_done('gym')
puts ''

list.to_s
puts ''


list.all_done.to_s
