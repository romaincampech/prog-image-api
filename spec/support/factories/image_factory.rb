FactoryBot.define do
  factory :image, aliases: [:original] do
    file { File.open('spec/support/assets/bcgdv-logo.jpg') }
  end
end
