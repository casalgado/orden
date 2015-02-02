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

  describe "by day scope" do

    it "ON returns correct tasks" do
      task_today     = FactoryGirl.create(:task)
      task_today.update(due_date: "2015-02-09 10:00:00")
      task_tomorrow  = FactoryGirl.create(:task)
      task_tomorrow.update(due_date: "2015-02-10 10:00:00")
      task_tomorrow2 = FactoryGirl.create(:task)
      task_tomorrow2.update(due_date: "2015-02-10 11:00:00")
      expect(Task.by_day(Date.new(2015, 2, 10))).to eq([task_tomorrow, task_tomorrow2])
    end

  end

  describe "status methods" do

    describe "ON same day" do

      before :each do 
        @task = FactoryGirl.create(:task)
      end

        it "status" do
          expect(@task.status).to eq(0)
        end

        it "status_class" do
          expect(@task.status_class).to eq (nil)
        end
    end

    describe "ON one day delay " do

      before :each do 
        @task = FactoryGirl.create(:task)
        Timecop.travel(Time.local(2015, 2, 10, 10, 00, 00))
      end

      after :each do 
        Timecop.travel(Time.local(2015, 2, 9, 10, 00, 00))
      end

        it "status" do
          expect(@task.status).to eq(1)
        end

        it "status_class" do
          expect(@task.status_class).to eq ("info")
        end
    end

    describe "ON two days delay " do

      before :each do 
        @task = FactoryGirl.create(:task)
        Timecop.travel(Time.local(2015, 2, 11, 10, 00, 00))
      end

      after :each do 
        Timecop.travel(Time.local(2015, 2, 9, 10, 00, 00))
      end

        it "status" do
          expect(@task.status).to eq(2)
        end

        it "status_class" do
          expect(@task.status_class).to eq ("warning")
        end
    end

    describe "ON three days delay " do

      before :each do 
        @task = FactoryGirl.create(:task)
        Timecop.travel(Time.local(2015, 2, 12, 10, 00, 00))
      end

      after :each do 
        Timecop.travel(Time.local(2015, 2, 9, 10, 00, 00))
      end

        it "status" do
          expect(@task.status).to eq(3)
        end

        it "status_class" do
          expect(@task.status_class).to eq ("danger")
        end
    end

    describe "ON four days delay " do

      before :each do 
        @task = FactoryGirl.create(:task)
        Timecop.travel(Time.local(2015, 2, 13, 10, 00, 00))
      end

      after :each do 
        Timecop.travel(Time.local(2015, 2, 9, 10, 00, 00))
      end

        it "status" do
          expect(@task.status).to eq(4)
        end

        it "status_class" do
          expect(@task.status_class).to eq ("danger")
        end
    end
  end


end
