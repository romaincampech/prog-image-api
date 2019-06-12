FactoryBot.define do
  factory :image_transformation do
    original
    file { File.open('spec/support/assets/bcgdv-logo.jpg') }
    specs do
      {
        format: 'png',
        resize: '100x100',
        rotate: '90',
      }
    end
  end
end
