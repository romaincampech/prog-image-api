describe ImageTransformationsController, type: :controller do
  describe '#create - POST /images/:id/transform' do
    context 'when the original Image is not found' do
      it 'returns a :not_found 404' do
        post '/images/:id/transform', id: '00000'

        expect(response.status).to eq(404)
        expect(json_response).to eq({
          'error' => 'NOT_FOUND',
          'type' => 'not_found',
        })
      end
    end

    # context 'when a new ImageTransformation is created' do
    #   let(:image) { create(:image) }
    #   let(:specs) do
    #     { format: 'png' }
    #   end

    #   before do
    #     allow(MiniMagick::Image).to receive(:open).and_wrap_original do |original_method, a, b|
    #       original_method.call('spec/support/assets/bcgdv-logo.jpg')
    #     end
    #   end

    #   it 'returns a :created 201' do
    #     post '/images/:id/transform', id: image.id, specs: specs

    #     last_created_image_transformation = ImageTransformation.order(created_at: :desc).first
    #     expect(response.status).to eq(201)
    #     expect(json_response).to eq({
    #       'image' => {
    #         'id' => last_created_image_transformation.id,
    #         'filename' => last_created_image_transformation.file.original_filename,
    #         'url' => last_created_image_transformation.file.url,
    #         'size_bytes' => last_created_image_transformation.file.size,
    #         'height' => last_created_image_transformation.file.height,
    #         'width' => last_created_image_transformation.file.width,
    #         'extension' => last_created_image_transformation.file.extension,
    #         'mime_type' => last_created_image_transformation.file.mime_type,
    #       },
    #       'original_id' => image.id,
    #       'specs' => specs,
    #       'transformations' => [],
    #     })
    #   end
    # end
  end
end
