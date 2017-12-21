# ruby change_list_to_board.rb PERSONAL_ACCESS_TOKEN WORKSPACE_ID PROJECT_ID
# 動的にその人が入力した名前のworkspaceのidを取ってこれるようにしたい
# board to listも書きたい

require './network'

# get project tasks
PERSONAL_ACCESS_TOKEN =
WORKSPACE_ID =
PROJECT_ID =
ROOT_URL = "https://app.asana.com"

uri = URI.parse("#{ROOT_URL}/api/1.0/projects/#{PROJECT_ID}/tasks")
network = Network.new(Net::HTTP.new(uri.host, uri.port))

network.connect_secure_network

header = {
    "Content-Type" => "application/json"
}

req = Net::HTTP::Get.new(uri.path, header)
req.basic_auth(PERSONAL_ACCESS_TOKEN, '')

res = @@http.start { |http| http.request(req) }

body = JSON.parse(res.body)
if body['errors'] then
  puts "Server returned an error: #{body['errors'][0]['message']}"
else
  puts "got project tasks: #{body['data']}"
  project_tasks = body
end