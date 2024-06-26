FROM ruby:3.0.2

ENV RAILS_ENV=production
ENV RACK_ENV=production

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
WORKDIR /app
RUN gem install bundler
COPY Gemfile Gemfile.lock ./

RUN bundle install 
COPY . .

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
