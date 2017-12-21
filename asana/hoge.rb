require "rubygems"
require "JSON"
require "net/https"
require "pry"

PERSONAL_ACCESS_TOKEN =
WORKSPACE_ID =
PROJECT_ID =
ROOT_URL = "https://app.asana.com"

# get project
uri = URI.parse("#{ROOT_URL}/api/1.0/projects/#{PROJECT_ID}")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER
header = {
 "Content-Type" => "application/json"
}
req = Net::HTTP::Get.new(uri.path, header)
req.basic_auth(PERSONAL_ACCESS_TOKEN, '')
res = http.start { |http| http.request(req) }

project_body = JSON.parse(res.body)
if project_body['errors'] then
  puts "Server returned an error: #{project_body['errors'][0]['message']}"
else
  puts "got project body: #{project_body['data']}"
end

# create another project
uri = URI.parse("#{ROOT_URL}/api/1.0/projects")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

header = {
 "Content-Type" => "application/json"
}

req = Net::HTTP::Post.new(uri.path, header)
req.basic_auth(PERSONAL_ACCESS_TOKEN, '')
req.body = {
 "data" => {
  "workspace" => WORKSPACE_ID,
  "name"=>project_body['data']['name'],
  "notes"=>project_body['data']['notes'],
  "layout" => "board"
 }
}.to_json()

res = http.start { |http| http.request(req) }

another_project_body = JSON.parse(res.body)
if another_project_body['errors'] then
     puts "Server returned an error: #{another_project_body['errors'][0]['message']}"
   else
 puts "Created project with id: #{another_project_body['data']['id']}"
      end

# get project tasks
uri = URI.parse("#{ROOT_URL}/api/1.0/projects/#{PROJECT_ID}/tasks")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

header = {
 "Content-Type" => "application/json"
}

req = Net::HTTP::Get.new(uri.path, header)
req.basic_auth(PERSONAL_ACCESS_TOKEN, '')

res = http.start { |http| http.request(req) }

body = JSON.parse(res.body)
if body['errors'] then
     puts "Server returned an error: #{body['errors'][0]['message']}"
   else
 puts "got project tasks: #{body['data']}"
 project_tasks = body
 task_ids = []
 project_tasks['data'].each do |task|
     task_ids << task['id']
   end
      end

# add project to each tasks
task_ids.each do |task_id|
    uri = URI.parse("https://app.asana.com/api/1.0/tasks/#{task_id}/addProject")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  
    # set up the request
    header = {
     "Content-Type" => "application/json"
    }
  
    req = Net::HTTP::Post.new(uri.path, header)
    req.basic_auth(PERSONAL_ACCESS_TOKEN, '')
    req.body = {
     "data" => {
      "project" => another_project_body['data']['id']
     }
    }.to_json()
  
    # issue the request
    res = http.start { |http| http.request(req) }
  
    # output
    body = JSON.parse(res.body)
    if body['errors'] then
      puts "Server returned an error: #{body['errors'][0]['message']}"
    else
     puts "add project to task: #{task_id}"
    end
end

# delete project
uri = URI.parse("#{ROOT_URL}/api/1.0/projects/#{PROJECT_ID}")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER
header = {
 "Content-Type" => "application/json"
}
req = Net::HTTP::Delete.new(uri.path, header)
req.basic_auth(PERSONAL_ACCESS_TOKEN, '')
res = http.start { |http| http.request(req) }

project_body = JSON.parse(res.body)
if project_body['errors'] then
  puts "Server returned an error: #{project_body['errors'][0]['message']}"
else
  puts "delete project with id: #{project_body['data']['id']}"
end
