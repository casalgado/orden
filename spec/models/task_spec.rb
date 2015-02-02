require 'rails_helper'

RSpec.describe Task, :type => :model do

  describe "interpret_string method" do

  	it "ON string without keys" do
  		task = FactoryGirl.create(:task)
  		expect(task.name).to eq("Example task")
  	end

  	it "ON string without only date key" do
  		task = FactoryGirl.create(:task, name: "example task .j")
  		expect(task.name).to eq("Example task")
  		expect(task.reload.due_date).to eq(Time.local(2015, 2, 12, 15, 00, 00))
  	end

  	it "ON string without only time key" do
  		task = FactoryGirl.create(:task, name: "example task .1230")
			expect(task.name).to eq("Example task")
			expect(task.reload.due_date).to eq(Time.local(2015, 2, 9, 12, 30, 00))
  	end

  	it "ON string without both keys" do
  		task = FactoryGirl.create(:task, name: "example task .v .1230")
			expect(task.name).to eq("Example task")
			expect(task.reload.due_date).to eq(Time.local(2015, 2, 13, 12, 30, 00))
  	end
  end

  describe "to_time method" do

  	it "ON two values" do
      task = FactoryGirl.create(:task)
  		expect(task.to_time(["ss", "1230"])).to eq(Time.local(2015, 2, 21, 12, 30, 00))
  	end

  end

  describe "key_to_date method" do

  	it "ON single letter after wday" do
      task = FactoryGirl.create(:task)
      expect(task.key_to_date("j")).to eq(Date.today + 3)
  	end

  	it "ON single letter before wday" do
      task = FactoryGirl.create(:task)
      expect(task.key_to_date("d")).to eq(Date.today + 6)
  	end

  	it "ON double letter after wday" do
      task = FactoryGirl.create(:task)
      expect(task.key_to_date("jj")).to eq(Date.today + 10)
  	end

  	it "ON double letter before wday" do
      task = FactoryGirl.create(:task)
      expect(task.key_to_date("ss")).to eq(Date.today + 12)
  	end
  	
  end


end
