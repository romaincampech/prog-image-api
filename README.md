# ProgImage API
API to store images on AWS S3 ([Shrine](https://github.com/shrinerb/shrine)), retieve and transform them ([MiniMiagick](https://github.com/minimagick/minimagick)) built on [Ruby on Jets](https://github.com/tongueroo/jets) and deployed on AWS API Gateway and Lambda. 

You can either:
- clone this template and add your own ENV variables to tailor this microservice to your needs and deploy on your AWS account
- or use it directly from your app with the [ProgImage](https://rubygems.org/gems/progimage) gem!

## Getting Started

#### Install Ruby on Jets
```
gem install jets
```

#### Clone the repository
```
git clone https://github.com/Lacampe/prog-image-api.git
```

#### Set the ENV variables
```
# .env
ACCESS_KEY_ID=...
SECRET_ACCESS_KEY=...

S3_BUCKET=...

# .env.production
RDS_NAME=...
RDS_USERNAME=...
RDS_PASSWORD=...
RDS_HOSTNAME=...
RDS_URL=...
```

#### Set the your development DB & Start a server
```
JETS_ENV=development jets db:create db:migrate

jets server
```
You can then visit **http://localhost:8888/**

#### Deployment
##### Staging/Dev
```
JETS_ENV_REMOTE=1 jets db:create db:migrate
JETS_ENV_REMOTE=1 jets deploy
```
##### Production
```
JETS_ENV=production jets db:create db:migrate
JETS_ENV=production jets deploy production
```
This will generate a production endpoint.
You can then visit your AWS console and check API Gateway, Lambda, Cloudwatch, RDS...

## Using ProgImage gem

#### Add to your Gemfile
```
gem 'progimage'
```

#### Fetch an image by ID
```ruby
ProgImage::Client.fetch_image(id)
```

#### Upload an image
```ruby
# file
PorgImage::Client.upload_image(File.open(/path/to/file))

#remote_url
ProgImage::Client.upload_image('http://example.com/image.png')
```

#### Transform an image
```ruby
ProgImage.transform_image(id, {format: 'jpeg', rotate: '180', resize: '50x50'})
```

#### Response template
```json
{
  "image": {
    "id": "",
    "filename": "",
    "url": "",
    "size_bytes": "",
    "height": "",
    "width": "",
    "extension": "",
    "mime_type": "",
  },
  "original_id": "",
  "specs": "",
  "transformations": [],
}
```
