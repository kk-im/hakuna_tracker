require 'faker'

puts 'creating seed'

User.destroy_all
puts "destroying all users and its dependants projects and timelapses"

4.times do
  @new_user = User.create!(
    email: Faker::Internet.email,
    password: '123456'
  )
  10.times do
    @new_project = Project.create!(
      name: Faker::Name.name,
      client: Faker::TvShows::SiliconValley.company,
      user: @new_user,
      rate: rand(1..19),
      cost: rand(100..500),
      deadline: Date.today + (rand * 30),
      expected_time: rand(20..80),
      completed: [true, false].sample,
      within_deadline:[true, false].sample
    )
    3.times do
      fake_time = DateTime.now + (rand * 1)
      @new_timelapse = Timelapse.create!(
        start_time: fake_time,
        end_time: fake_time + (rand * 1),
        description: Faker::TvShows::SiliconValley.invention,
        project: @new_project
      )
      @new_timelapse.update(duration: TimeDifference.between(@new_timelapse.start_time, @new_timelapse.end_time).in_minutes)
      # new_timelapse.duration = TimeDifference.between(new_timelapse.start_time, new_timelapse.end_time).in_minutes
    end
  end
end

puts 'done'
