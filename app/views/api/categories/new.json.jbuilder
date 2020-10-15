json.select @select_parent, :id, :name, :ancestry
json.array @categories, :id, :name, :ancestry