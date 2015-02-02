

FactoryGirl.define do
  factory :task do
    user nil
		name "example task"
		due_date "2015-2-25 13:07:36"
		complete false
  end

end
