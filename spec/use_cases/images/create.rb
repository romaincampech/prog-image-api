describe Images::Create do
  context 'when params[:file] is not a file or remote_url' do
    it 'fails with :unprocessable_entity' do
      [00000, {}, [], Date.today, 'test'].each do |param|
        result = described_class.run({ file: param })

        expect(result).to fail_with(:unprocessable_entity)
      end
    end
  end

  {
    file: File.open('spec/support/assets/bcgdv-logo.jpg'),
    remote_url: 'https://pbs.twimg.com/profile_images/956617771747442689/MPweHHe7.jpg',
  }.each do |type, param|
    context "when params[:file] is a #{type}" do
      before do
        param = File.open('spec/support/assets/bcgdv-logo.jpg') if param.is_a?(File)
      end

      it 'creates a new Image' do
        expect {
          described_class.run({ file: param })
        }.to change{ Image.count }.by(1)
      end

      it 'attaches the file to the new Image' do
        result = described_class.run({ file: param })

        expect(result.value.file).to be_a(ImageUploader::UploadedFile)
      end

      it 'returns the new Image' do
        result = described_class.run({ file: param })

        expect(result).to be_a_success

        last_created_image = Image.order(created_at: :desc).first
        expect(result.value).to eq(last_created_image)
      end
    end
  end
end
