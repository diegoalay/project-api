class User < ApplicationRecord
  validates :email, presence: true,  uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  before_create :initialize_user
  
  def initialize_user
    self.email = (self.email||"").downcase
  end

  def name
    return [
      first_name,
      last_name
    ].join(" ")
  end
  
  enum gender: {
    male: 'male',
    female: 'female'
  }
  
  def self.index 
    User.all.select(
      :id,
      :first_name,
      :last_name,
      :email,
      :username,
      :status
    )
  end
  
  def self.quantify_characters
    result = {}

    User.all.select("
      upper(users.username) as username
    ").each do |user|
      username = user.username
      username = username&.gsub(/[^a-z]/i, '')&.gsub(/\s+/, "")     # remove special characters from string
        
      characters = username&.split("")
      
      characters.each do |character|
        result[character] = {count: 0} if result[character].blank?
        
        result[character][:count] += 1
      end
      
    end
    
    result = result.sort_by(&:count)
    
    result.map do |key, value|
      {
        "#{key}": value[:count]
      }
    end
  end
  
  # Policy: 
  # 1. same domain and a word is included in other emails excluding special characters
  def self.duplicated_emails    
    users = ActiveRecord::Base.connection.exec_query("
      select regexp_replace(
        users.email_indentifier,
        '[^a-z]',
        ''
      ) as email_parsed,
      split_part(users.email_domain, '.', 1) as domain,
      users.email,
      users.id
      from (
        select 
          split_part(users.email, '@', 1) as email_indentifier,
          split_part(users.email, '@', 2) as email_domain,
          users.email,
          users.id
        from users
      ) as users;
    ")
    
    duplicated_emails = []
    
    users.each do |user_main|
      duplicated = false 
            
      users.each do |user|
        if (user_main["id"] != user["id"])            
          if ((user["email_parsed"].include? user_main["email_parsed"]) && 
            (user["domain"] == user_main["domain"])
          )
            duplicated_emails.push(user["email"]) if not duplicated_emails.include? user["email"]
            
            duplicated = true
          end
        end
      end
      
      if duplicated 
        duplicated_emails.push(user_main["email"])
      end
    end
    
    duplicated_emails
  end
end