# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

NUM_USERS = 50
NUM_COURSES = 10
NUM_ASSIGNMENTS = 40
NUM_COURSEASSIGNMENTS = 10
NUM_COURSEBLOCKS = 40
NUM_SUBMISSIONS = 5
NUM_ATTENDANCES = 40

PASSWORD = "codecore"

Submission.delete_all
Attendance.delete_all
CourseBlock.delete_all
CourseAssignment.delete_all
CourseRole.delete_all
User.delete_all
Course.delete_all
Program.delete_all
Assignment.delete_all


["bootcamp", "diploma"].each do |program|
  Program.create(
    name: program
  )
end

super_user = User.create(
  first_name: "ian",
  last_name: "mckinnon",
  email: "admin@codecore.ca",
  status: "active",
  password: PASSWORD,
  is_admin: true
)

student_user = User.create(
  first_name: "student",
  last_name: "mcstudent",
  email: "student@codecore.ca",
  status: "active",
  password: PASSWORD,
  is_admin: false
)

instructor_user = User.create(
  first_name: "instructor",
  last_name: "mcinstructor",
  email: "instructor@codecore.ca",
  status: "active",
  password: PASSWORD,
  is_admin: false
)

programs = Program.all

NUM_COURSES.times do
  name = Faker::Book.title
  description = Faker::Quote.famous_last_words
  start_date = Faker::Date.between(from: 30.days.ago, to: Date.today)
  end_date = Faker::Date.forward(days: 90) 
  course = Course.create(
    name: name,
    description: description,
    status:  ["active", "inactive"].sample,
    start_date: start_date,
    end_date: end_date,
    program_id: Program.all.sample.id,
    is_archived: [true, false].sample,
  )

end

CourseRole.create(
    role: "student",
    user_id: student_user.id,
    course_id: Course.all.sample.id,  
    is_archived: false
)

CourseRole.create(
    role: "instructor",
    user_id: instructor_user.id,
    course_id: Course.all.sample.id,  
    is_archived: false
)

courses = Course.all

NUM_USERS.times do
  first_name =  Faker::Name.first_name
  last_name = Faker::Name.last_name
  user = User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@codecore.ca",
    password: "codecore"
  )

  cr = CourseRole.create(
    role: ["student", "instructor"].sample,
    user_id: user.id,
    course_id: Course.all.sample.id,  
    is_archived: false
  )
  
end

users = User.all


NUM_ASSIGNMENTS.times do
  name = Faker::Books::CultureSeries.book
  description = Faker::Books::Lovecraft.sentence
  Assignment.create(
    name: name,
    description: description, 
  )
end

assignments = Assignment.all

course_assignments = CourseAssignment.all

NUM_COURSEBLOCKS.times do |index|
  
  CourseBlock.create(
    course_id: Course.all.sample.id,
    date: Time.now + index.day,
    course_block_type: ["Morning", "Afternoon", "Evening"].shuffle.first,
    course_role_id: CourseRole.where(role: "instructor").sample.id
  )
end

course_blocks = CourseBlock.all

submissions = Submission.all

courses.each do |course|
  NUM_COURSEASSIGNMENTS.times do
    assign_date = Faker::Date.between(from: 30.days.ago, to: Date.today)
    due_date = Faker::Date.between(from: Date.today, to: 30.days.from_now)
    CourseAssignment.create(
      assign_date: assign_date,
      due_date: due_date,
      is_active: [true, false].sample,
      assignment_id: Assignment.all.sample.id,
      course_id: course.id,
      course_role_assigner_id: CourseRole.where(role: "instructor").sample.id,
      maximum_score: rand(10..100)
    )
  end
end

NUM_ATTENDANCES.times do
  Attendance.create(
    is_present:[true, false].shuffle.first,
    course_block_id: CourseBlock.all.sample.id,
    course_role_id: CourseRole.where(role: "instructor").sample.id

  )
end

attendances = Attendance.all

course_assignments.each do |ca|
  NUM_SUBMISSIONS.times do
    submission_date = Faker::Date.between(from: 2.days.ago, to: DateTime.now) 
    feedback = Faker::Quote.matz
    Submission.create(
      score: rand(0..ca.maximum_score),
      submission_date: submission_date,
      feedback: feedback,
      course_assignment_id: ca.id,
      course_role_submitter_id: CourseRole.where(role: "student").sample.id,
      course_role_marker_id: CourseRole.where(role: "instructor").sample.id,
      submission_url: ["http://github.com/jivison/s-cool", "http://drive.google.com/u/sanjfsla"].sample
    )
  end
end


puts Cowsay.say("Generated #{users.count} users", :stegosaurus)
puts Cowsay.say("Generated #{courses.count} courses", :frogs)
puts Cowsay.say("Generated #{assignments.count} assignments", :frogs)
puts Cowsay.say("Generated #{course_assignments.count} course_assignments", :frogs)
puts Cowsay.say("Generated #{course_blocks.count} course_blocks", :frogs)
puts Cowsay.say("Generated #{submissions.count} submissions", :frogs)
puts Cowsay.say("Generated #{attendances.count} attendances", :frogs)
puts Cowsay.say("Generated #{CourseRole.count} course_roles", :cheese)


puts "Login with #{super_user.email} and password: #{PASSWORD}"




