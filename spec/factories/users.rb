# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:nick) { |n| "nick_#{n}" }
    sequence(:uid)
    access_token 'MyString'
    secret_token 'MyString'
  end
end
