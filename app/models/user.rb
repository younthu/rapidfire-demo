class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :attempts, class_name: "Rapidfire::Attempt"

  Rapidfire::Survey.class_eval do
    acts_as_taggable
    puts "Rapidfire::Survey.class_eval executed"
  end

  Rapidfire::Attempt.class_eval do
    acts_as_taggable
    puts "Rapidfire::Attempt.class_eval executed"
  end

  Rapidfire::Questions::Radio.class_eval do
    acts_as_taggable
    puts "Rapidfire::Questions.Radio.class_eval executed"
  end
end
