FactoryGirl.define do
  factory :profile do
    first_name "First"
    last_name "Last"
    experience
  end

  factory :profile_with_upic, :parent => :profile do
    avatar { Rack::Test::UploadedFile.new("spec/fixtures/files/upic_default.jpg", 'image/jpg') }
  end
end
