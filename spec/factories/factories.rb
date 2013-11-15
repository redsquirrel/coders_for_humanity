FactoryGirl.define do
  
  factory :account do
    name "John Doe"
    email "john.doe@email.com"
    organization "oliwi"
    location "Chicago"
  end

end

FactoryGirl.define do
  
  factory :developer do
    github_url "www.github.com"
    account
  end

  factory :project do
    title "Homeless street survey"
    description "Mobile app to facilitate a survey of the homeless in Chicago"
  end

end


FactoryGirl.define do
  
  factory :idea_owner do
    password "password"
    account
  end

end

FactoryGirl.define do
  factory :category do
    name "nonprofit"
  end
end

