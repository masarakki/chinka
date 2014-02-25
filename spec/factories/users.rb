# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    nick "MyString"
    uid "MyString"
    access_token "MyString"
    secret_token "MyString"
  end
end
