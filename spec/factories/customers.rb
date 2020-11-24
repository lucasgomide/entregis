FactoryBot.define do
  factory :customer do
    name { 'Magic Buzz' }
    sequence(:document) { |x| "00#{x}x" }
  end
end
