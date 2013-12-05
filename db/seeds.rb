def load_yaml_file(*files)
  files.each do |file|
    file = File.join(File.dirname(__FILE__), file)
    return YAML.load_file(file) if File.exist?(file)
  end
end

users = load_yaml_file('users.yml', 'users.example.yml')
users = users.map do |name, email|
  User.create!(:name => name, :email => email)
end

Dir[File.join(File.dirname(__FILE__), 'seeds', '*')].each do |folder|
  name = File.basename(folder)
  description, *examples = File.read(File.join(folder, 'spec.js')).lines

  user = users.sample
  function = user.functions.create!({
    :name => name,
    :description => description.sub(/^\/\/\s*/, ''),
    :example => examples.join
  })

  potential_authors = users.dup

  Dir[File.join(folder, '*.js')].grep(/\d+/).each do |file|
    author = potential_authors.sample
    code = File.read(file)

    implementation = function.implementations.create!({
      :user => author,
      :source => code
    })

    potential_authors.delete(author)
  end
end
