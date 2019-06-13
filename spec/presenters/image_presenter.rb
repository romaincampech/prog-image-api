describe ImagePresenter do
  it 'responds to to_json' do
    expect(described_class).to respond_to(:as_json)
  end
end
