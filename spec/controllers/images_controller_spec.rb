describe ImagesController, type: :controller do
  describe '#show - GET /images/:id' do
    let(:image) { create(:image) }

    context 'when an Image is found' do
      it 'returns a :success 200' do
        get '/images/:id', id: image.id

        expect(response.status).to eq(200)
        expect(json_response).to eq({
          'image' => {
            'id' => image.id,
            'filename' => image.file.original_filename,
            'url' => image.file.url,
            'size_bytes' => image.file.size,
            'height' => image.file.height,
            'width' => image.file.width,
            'extension' => image.file.extension,
            'mime_type' => image.file.mime_type,
          },
          'original_id' => nil,
          'specs' => nil,
          'transformations' => [],
        })
      end
    end

    context 'when nothing is found' do
      it 'returns a not_found 404' do
        get '/images/:id', id: '00000'

        expect(response.status).to eq(404)
        expect(json_response).to eq({
          'error' => 'NOT_FOUND',
          'type' => 'not_found',
        })
      end
    end
  end

  describe '#create - POST /images' do
    context 'with valid params' do
      it 'returns a :created 201' do
        post '/images', file: File.open('spec/support/assets/bcgdv-logo.jpg')

        last_created_image = Image.order(created_at: :desc).first
        expect(response.status).to eq(201)
        expect(json_response).to eq({
          'image' => {
            'id' => last_created_image.id,
            'filename' => last_created_image.file.original_filename,
            'url' => last_created_image.file.url,
            'size_bytes' => last_created_image.file.size,
            'height' => last_created_image.file.height,
            'width' => last_created_image.file.width,
            'extension' => last_created_image.file.extension,
            'mime_type' => last_created_image.file.mime_type,
          },
          'original_id' => nil,
          'specs' => nil,
          'transformations' => [],
        })
      end
    end

    context 'with invalid params' do
      it 'returns an :unprocessable_entity 422' do
        post '/images', file: {}

        expect(response.status).to eq(422)
        expect(json_response).to eq({
          'error' => 'UNPROCESSABLE_ENTITY',
          'type' => 'unprocessable_entity',
        })
      end
    end
  end
end
