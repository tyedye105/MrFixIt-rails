FactoryGirl.define do
  factory :worker do
    email "build1t@gmail.com"
    password "asdf"
  end
  factory :job do
    title "Finagle the Buffalo Door"
    description "We need to fix the door for our prized buffalo"
  end
end
