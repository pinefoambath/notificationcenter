json.array! @notifications do |notification|
  json.extract! notification, :id, :title, :description, :date, :created_at
end