# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    sequence(:street) { |n| "#{n}#{n}#{n} #{n.ordinalize} Street" }
    city { "Lafayette" }
    zip { 94549 }
    state { "CA" }
  end
end
