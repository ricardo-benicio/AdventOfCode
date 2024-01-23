# frozen_string_literal: true

require 'lib/app_note/manager'
require 'lib/app_note/note'

module Application
  def self.run
    menu = Menu.new
    loop do
      puts ' Simple Note Application '.center(50, '#')
      puts 'a) Add'
      puts 'b) Edit'
      puts 'c) Delete'
      puts 'd) Show All'
      puts 'q) Quit'
      print 'Select: '
      choice = gets.chomp

      case choice
      when 'a' then menu.add
      when 'b' then menu.edit
      when 'c' then menu.delete
      when 'd' then menu.show_all
      end

      break unless choice != 'q'
    end
  end

  class Menu
    def initialize
      @manager = Manager.new
    end

    def add
      print 'Note: '
      text = gets.chomp
      note = Note.new(text)
      @manager.store(note)
    end

    def show_all
      @manager.show_all
    end

    def edit
      @manager.show_all
      entries = @manager.get_all
      if entries.length.positive?
        print 'Enter index number to edit: '
        index = gets.chomp.to_i
        note = entries.fetch(index - 1)
        print 'Note: '
        text = gets.chomp
        note.set_text(text)
        @manager.store(note)
        puts 'Entry Updated'.center(50, '*')
      end
    rescue Exception
      puts 'Invalid input'.center(50, '-')
    end

    def delete
      @manager.show_all
      entries = @manager.get_all
      if entries.length.positive?
        print 'Enter index number to delete: '
        index = gets.chomp.to_i
        note = entries.fetch(index - 1)
        @manager.delete(note)
        puts 'Entry Deleted'.center(50, '*')
      end
    rescue Exception
      puts 'Invalid input'.center(50, '-')
    end
  end
end
