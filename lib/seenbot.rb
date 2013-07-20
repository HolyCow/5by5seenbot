require 'date'
require 'cinch'
require 'data_mapper'
require 'dm-migrations'

DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://vagrant:vagrant@localhost/5by5seenbot')

class Users
  include DataMapper::Resource

  property :id,           Serial    # An auto-increment integer key
  property :user,         String    
  property :channel,      String    # A varchar type string, for short strings
  property :message,      Text      # A text block, for longer string data.
  property :updated_at,   DateTime  # A DateTime, for any date you might like.
end

DataMapper.finalize

DataMapper.auto_upgrade!

bot = Cinch::Bot.new do
  configure do |c|
    c.server   = 'irc.freenode.org'
    c.channels = ["#5by5", "#5by5bottest"]
    c.nick = 'haveyouseenbot'
  end

  # Only log channel messages
  on :channel do |m|
    user = Users.first_or_create(:user => m.user.nick.downcase)

    user.attributes = {
      :channel => m.channel,
      :message => m.message,
      :updated_at => m.time
    }

    user.save
  end

  on :private, /^!help/ do |m|
    m.reply "Hello, #{m.user.nick}.  I am a bot that tracks the last time a user said something.  To check for a user, issue the command '!seen <username>'.  I was created by _HolyCow (aka HolyCow) and my source code can be found at http://github.com/holycow/5by5seenbot."
  end

  on :message, /^!seen ([^ ]+)/ do |m, nick|
    if nick.downcase == bot.nick.downcase
      m.reply "That's my name dude!"
    elsif nick.downcase == m.user.nick.downcase
      m.reply "That's your name dude!"
    else
      user = Users.first(:user => nick.downcase)

      if user
        m.reply "[#{user.updated_at.to_s}] #{nick} was seen in #{user.channel} saying '#{user.message}'"
      else      
        m.reply "I haven't seen #{nick}"
      end
    end
  end
end

bot.start

