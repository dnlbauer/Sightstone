Gem::Specification.new do |s|
  s.name = 'sightstone'
  s.version = '1.4.4'
  s.date  = '2014-03-17'
  s.summary = 'Ruby wrapper for riots league of legends api'
  s.description = s.summary
  s.authors = ["Daniel Bauer"]
  s.email = 'danijob88@googlemail.com'
  s.files = Dir["lib/**/*"]
  s.homepage = 'https://github.com/danijoo/Sightstone'
  s.license = 'MIT'
  s.add_runtime_dependency 'rest-client'
#  s.add_runtime_dependency 'json'
end
