describe Images::Show do
  let(:image) { create(:image) }

  context 'when an Image is found' do
    let(:params) do
      { id: image.id }
    end

    it 'returns the Image' do
      result = described_class.run(params)

      expect(result).to be_a_success
      expect(result.value).to eq(image)
    end
  end

  context 'when an Image is not found' do
    let(:image_transformation) { create(:image_transformation) }

    let(:params) do
      { id: image_transformation.id }
    end

    it 'tries to find an ImageTransformation' do
      expect(ImageTransformation).to receive(:find_by)

      described_class.run(params)
    end

    context 'when an ImageTransformation is found' do
      it 'returns the ImageTransformation' do
        result = described_class.run(params)

        expect(result).to be_a_success
        expect(result.value).to eq(image_transformation)
      end
    end
  end

  context 'when nothing is found' do
    let(:params) do
      { id: nil }
    end

    it 'fails with :not_found' do
      result = described_class.run(params)

      expect(result).to fail_with(:not_found)
    end
  end
end
