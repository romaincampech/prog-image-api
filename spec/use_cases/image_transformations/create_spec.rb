describe ImageTransformations::Create do
  let(:image) { create(:image) }
  let!(:image_transformation) { create(:image_transformation, original: image) }

  context 'when the original Image is not found' do
    let(:params) do
      { id: nil }
    end

    it 'fails with :not_found' do
      result = described_class.run(params)

      expect(result).to fail_with(:not_found)
    end
  end

  context 'when an ImageTransformation with the same orignal and specs is found' do
    let(:params) do
      {
        id: image.id,
        specs:       {
          format: 'png',
          resize: '100x100',
          rotate: '90',
        },
      }
    end

    it 'returns the found ImageTransformation' do
      result = described_class.run(params)

      expect(result.value).to eq(image_transformation)
    end
  end

  context 'when no identical ImageTransformation is found' do
    let(:params) do
      {
        id: image.id,
        specs: { format: 'png' },
      }
    end

    before do
      allow(MiniMagick::Image).to receive(:open).and_wrap_original do |original_method, a, b|
        original_method.call('spec/support/assets/bcgdv-logo.jpg')
      end
    end

    it 'creates a new ImageTransformation' do
      expect {
        described_class.run(params)
      }.to change{ ImageTransformation.count }.by(1)
    end

    it 'links the new ImageTransformation to the original Image' do
      result = described_class.run(params)

      expect(result.value.original).to eq(image)
    end

    it 'attaches the file to the new ImageTransformation' do
      result = described_class.run(params)

      expect(result.value.file).to be_a(ImageUploader::UploadedFile)
    end

    it 'sets the right specs' do
      result = described_class.run(params)

      expect(result.value.specs).to eq(params[:specs].with_indifferent_access)
    end

    it 'returns the new ImageTransformation' do
      result = described_class.run(params)

      expect(result).to be_a_success

      last_created_image_transformation = ImageTransformation.order(created_at: :desc).first
      expect(result.value).to eq(last_created_image_transformation)
    end
  end
end
