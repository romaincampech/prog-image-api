describe ImagesController, type: :controller do
  describe '#show - GET /images/:id' do
    let(:image) { create(:image) }

    context 'when an Image is found' do
      it 'returns a success 200' do
        get '/images/:id', id: image.id

        expect(response.status).to eq(200)
        expect(json_response).to eq({
          'image' => {
            'id' => image.id,
            'filename' => image.file.original_filename,
            'url' => image.file.url,
            'size_bytes' => image.file.size,
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
end
