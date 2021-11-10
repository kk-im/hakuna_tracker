require 'faker'

puts 'creating seed'

4.times do
  new_user = User.create!(
    email: Faker::Internet.email,
    password: '123456'
  )
  10.times do
    new_project = Project.create!(
      name: Faker::TvShows::SiliconValley.app,
      client: Faker::TvShows::SiliconValley.company,
      user_id: new_user.id
    )
    3.times do
      Timelapse.create!(

        start_time: DateTime.now + (rand * 1),
        end_time: start_time + (rand * 1),
        description:
      )
    end
  end

end

puts 'done'
