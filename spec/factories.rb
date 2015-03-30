FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |i| "Tester#{i}" }
    last_name 'Test'
    sequence(:email) { |i| "t#{i}@t.com" }
    password 'test'
    password_confirmation 'test'
    admin true
  end
end
