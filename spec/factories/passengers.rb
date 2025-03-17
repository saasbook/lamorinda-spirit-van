# frozen_string_literal: true

FactoryBot.define do
  factory :passenger do
    association :address
    sequence(:name) { |n| "#{n.humanize.titleize}y Mc#{n.humanize.titleize}son" }
    sequence(:phone)  { |n| "(#{n}#{n}#{n})-#{n}#{n}#{n}-#{n}#{n}#{n}#{n}" }
    sequence(:email)  { |n| "#{n.humanize}y_mc#{n.humanize}son@gmail.com" }
    race { 1 }
    hispanic { false }
    birthday { DateTime.now }
    date_registered { DateTime.now }
  end
end
